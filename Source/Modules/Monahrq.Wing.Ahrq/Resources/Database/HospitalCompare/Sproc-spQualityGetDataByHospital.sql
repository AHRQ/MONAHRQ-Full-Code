/*
 *      Name:           spQualityGetDataByHospital
 *      Version:        1.0
 *      Last Updated:   4/9/14
 *      Used In:        QualityReportGenerator.cs
 *      Description:    Used to get quality report data for all measures for one particular hospital.
 */

IF EXISTS (
	SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
	WHERE SPECIFIC_SCHEMA = N'dbo' AND SPECIFIC_NAME = N'spQualityGetDataByHospital' 
)
	DROP PROCEDURE dbo.spQualityGetDataByHospital
GO

CREATE PROCEDURE [dbo].[spQualityGetDataByHospital]
	@ReportID uniqueidentifier, @HospitalID int
AS
BEGIN
    SET NOCOUNT ON;

            SELECT MeasureID
                  ,HospitalID
                  ,CountyID
                  ,RegionID
                  ,ZipCode
                  ,HospitalType
                  ,RateAndCI
                  ,NatRating
                  ,NatFilled
                  ,PeerRating
                  ,PeerFilled
                  ,Col1
                  ,Col2
                  ,Col3
                  ,Col4
                  ,Col5
                  ,Col6
                  ,Col7
                  ,Col8
                  ,Col9
                  ,Col10
            FROM dbo.Temp_Quality
            WHERE HospitalID = @HospitalID AND ReportID = @ReportID
        
END
