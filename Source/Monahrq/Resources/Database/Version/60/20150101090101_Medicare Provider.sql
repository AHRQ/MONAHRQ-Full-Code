-- =============================================
-- Author:		Shafiul Alam
-- Project:		MONAHRQ 6.0
-- Create date: 12-20-2014
-- Description:	This is the update script from older MONAHRQ 5.0 Medicare Provider Charge Data Targets to the new 
--              MONAHRQ 6.0 Build 2 database schema.
--				'Medicare Provider Charge Data'
-- =============================================
BEGIN TRY

-- Disable nonclustered Index

IF OBJECT_ID('tempdb..#IndexList') IS NOT NULL
DROP TABLE #IndexList 

SELECT identity(INT,1,1) rownum,
	   i.name 	
	   INTO #IndexList 
 FROM sys.indexes i
WHERE i.[object_id]=OBJECT_ID('[dbo].[Targets_MedicareProviderChargeTargets]')
AND i.[type]=2

DECLARE @LoopIterator INT=1,
		@LoopCount INT= (SELECT COUNT(1) FROM #IndexList),
		@sql NVARCHAR(800)
		
WHILE (@LoopIterator<=@LoopCount)
BEGIN
	SELECT @sql='ALTER INDEX ['+i.name+'] ON .[dbo].[Targets_MedicareProviderChargeTargets] DISABLE'
	FROM #IndexList i
	WHERE rownum=@LoopIterator
	
	EXEC (@sql)
	SET @LoopIterator=@LoopIterator+1
END

IF NOT EXISTS (SELECT 1 FROM Wings_Datasets wt
WHERE wt.ContentType_Id= (SELECT id FROM Wings_Targets wt2
                          WHERE wt2.Name='Medicare Provider Charge Data') )
BEGIN

SET IDENTITY_INSERT dbo.Wings_Datasets ON

INSERT INTO dbo.Wings_Datasets
(
	id,
	SummaryData,
	[File],
	[Description],
	DateImported,
	ReportingQuarter,
	ReportingYear,
	DRGMDCMappingStatus,
	DRGMDCMappingStatusMessage,
	IsFinished,
	ContentType_Id
)
SELECT cir.Id, cisr.[Data],cir.[File],cir.[Description],cir.DateImported,cir.ReportingQuarter,
       cir.ReportingYear,cir.DRGMDCMappingStatus,cir.DRGMDCMappingStatusMessage,
       cir.IsFinished, (SELECT TOP(1) wt.Id FROM dbo.Wings_Targets wt
						WHERE LTRIM(RTRIM(wt.Name))=(SELECT LTRIM(RTRIM(ctr.Name))
                               FROM dbo.ContentTypeRecords ctr
                             WHERE id=cir.ContentType_Id))
  FROM dbo.ContentItemRecords cir
LEFT OUTER JOIN dbo.ContentItemSummaryRecords cisr
ON cisr.Id = cir.Summary_Id
INNER JOIN ContentTypeRecords ctr
ON cir.ContentType_Id=ctr.Id
WHERE  ctr.Name = 'Medicare Provider Charge Data';

SET IDENTITY_INSERT dbo.Wings_Datasets OFF

INSERT INTO [dbo].[Wings_DatasetTransactionRecords]
SELECT tr.[Code],
       tr.[Message],
       tr.[Extension],
       tr.[Data],
       tr.ContentItemRecord_Id
FROM   [dbo].[ContentPartTransactionRecords] tr
INNER JOIN dbo.ContentItemRecords cir
ON cir.Id = tr.ContentItemRecord_Id
INNER JOIN ContentTypeRecords ctr
ON cir.ContentType_Id=ctr.Id
WHERE  ctr.Name = 'Medicare Provider Charge Data';

END;

 IF OBJECT_ID('Targets_MedicareProviderChargeTargetsTempForUpgrade') IS NOT NULL
    DROP TABLE [dbo].[Targets_MedicareProviderChargeTargetsTempForUpgrade]
	
		
		SELECT [DRG_Id],
		       [DRG],
		       [Provider_Id],
		       [TotalDischarges],
		       [AverageCoveredCharges],
		       [AverageTotalPayments],
		       [ContentItemRecord_Id] Dataset_id
		INTO [dbo].[Targets_MedicareProviderChargeTargetsTempForUpgrade]
		FROM   [dbo].[Targets_MedicareProviderChargeTargets]


/*******************************************
 *  TRUNCATE table 
   
 *******************************************/

TRUNCATE TABLE [dbo].[Targets_MedicareProviderChargeTargets] 

 IF OBJECT_ID(N'FK_Targets_MedicareProviderChargeTargets_ContentITemRecord') IS NOT NULL
	ALTER TABLE [dbo].[Targets_MedicareProviderChargeTargets] DROP CONSTRAINT FK_Targets_MedicareProviderChargeTargets_ContentITemRecord;

ALTER TABLE [dbo].[Targets_MedicareProviderChargeTargets] ADD [Dataset_Id] INT NULL;
ALTER TABLE [dbo].[Targets_MedicareProviderChargeTargets] ADD CONSTRAINT [FK_TARGETS_MedicareProviderChargeTargets_DATASETS] FOREIGN KEY (Dataset_id) 
REFERENCES [dbo].[Wings_Datasets](Id)


INSERT INTO [dbo].[Targets_MedicareProviderChargeTargets]
(
	-- Id -- this column value is auto-generated
	DRG_Id,
	DRG,
	Provider_Id,
	TotalDischarges,
	AverageCoveredCharges,
	AverageTotalPayments,
	Dataset_Id
)
SELECT * FROM [dbo].[Targets_MedicareProviderChargeTargetsTempForUpgrade]

		
SET @LoopIterator=1		
WHILE (@LoopIterator<=@LoopCount)
BEGIN
	SELECT @sql='ALTER INDEX ['+i.name+'] ON [dbo].[Targets_MedicareProviderChargeTargets] REBUILD'
	FROM #IndexList i
	WHERE rownum=@LoopIterator
	
	EXEC (@sql)
	SET @LoopIterator=@LoopIterator+1
END


 IF OBJECT_ID('Targets_MedicareProviderChargeTargetsTempForUpgrade') IS NOT NULL
    DROP TABLE Targets_MedicareProviderChargeTargetsTempForUpgrade


SELECT 1;

END TRY
BEGIN CATCH
    DECLARE @ErrorMessage VARCHAR(5000);
    DECLARE @ErrorSeverity INT;
    DECLARE @ErrorState INT;

    SELECT @ErrorMessage = 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR(50)) +' Error: ' + ERROR_MESSAGE(),
           @ErrorSeverity = ERROR_SEVERITY(),
           @ErrorState = ERROR_STATE();

    RAISERROR (@ErrorMessage, -- Message text.
               @ErrorSeverity, -- Severity.
               @ErrorState -- State.
               );
END CATCH;