/*
 *      Name:           spUtilCountyInitializeMDC
 *      Used In:        InpatientReportGenerator.cs
 *		Description:    Add data from the IP tables for MDC to the intermediate temporary table
 */

-- UtilTypeID = DRG/MDC/DXCCS/PRCCS designation  (i.e. 1=DRG, 2=MDC, 3=DXCCS, 4=PRCCS)
-- UtilID = Actual DRG/MDC/DXCCS/PRCCS code/number  (i.e. 465 = DRG code 465)
-- CatID = Stratification grouping - 0 = totals/summary, 1 = Age, 2 = Sex, 3 = Payer, 4 = Race
-- CatVal = Stratification value - 1 = <18 years old for age, 2 = 18-44, etc.

IF EXISTS (
	SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_SCHEMA = N'dbo' AND SPECIFIC_NAME = N'spUtilCountyInitializeMDC' 
)
   DROP PROCEDURE dbo.spUtilCountyInitializeMDC
GO

CREATE PROCEDURE dbo.spUtilCountyInitializeMDC
	@ReportID uniqueidentifier, @ReportYear varchar(4), @IPDataset IDsTableType READONLY

AS
BEGIN
    SET NOCOUNT ON;

	INSERT INTO Temp_UtilCounty_Prep
	SELECT @ReportID AS Id,
		Counties.Id AS CountyID,
		CONVERT(int, IP.PatientStateCountyCode) AS StateCountyFIPS,

		2 as UtilTypeID,
		IP.MDC AS UtilID,
	
		IP.DischargeYear AS DischargeYear,
		CASE WHEN (IP.Age < 18) THEN 1
            WHEN (IP.Age >= 18 AND IP.Age <= 44) THEN 2
            WHEN (IP.Age >= 45 AND IP.Age <= 64) THEN 3
            WHEN (IP.Age >= 65) THEN 4
            ELSE 0
        END AS Age,
		ISNULL(Race.Id, 0) AS Race,
		Sex.Id AS Sex,
		ISNULL(Payer.Id, 0) AS PrimaryPayer,
		dbo.fnGetCostToChargeRatio(@ReportYear, Hosp.CMSProviderID) * IP.TotalCharge AS TotalCost
	FROM Targets_InpatientTargets AS IP
		LEFT JOIN Hospitals AS Hosp ON IP.LocalHospitalID = Hosp.LocalHospitalID AND Hosp.IsArchived=0 AND Hosp.IsDeleted=0
		LEFT JOIN Base_Races AS Race ON ISNULL(IP.Race, 0) = Race.Id
		LEFT JOIN Base_Sexes AS Sex ON IP.Sex = Sex.Id
		LEFT JOIN Base_Payers AS Payer ON ISNULL(IP.PrimaryPayer, 0) = Payer.Id
		LEFT JOIN Base_Counties AS Counties ON Counties.CountyFIPS =IP.PatientStateCountyCode
	WHERE IP.MDC IS NOT NULL AND
		IP.PatientStateCountyCode IS NOT NULL AND
		Counties.Id IS NOT NULL AND
		IP.Dataset_id IN (
			SELECT Id
			FROM @IPDataset
		);

	-- Special case to change MDC 0 to MDC 99
    UPDATE Temp_UtilCounty_Prep
    SET UtilID = 99
    WHERE ID = @ReportID AND UtilTypeID = 2 AND UtilID = 0
END
GO
