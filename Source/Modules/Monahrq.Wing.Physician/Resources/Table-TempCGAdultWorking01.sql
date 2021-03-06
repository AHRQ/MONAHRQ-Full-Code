

--  Delete table if needed.
if(Object_id(N'Temp_CG_Adult_Working_01')) is not null 
	drop table [Temp_CG_Adult_Working_01]
go

/****** Object:  Table [dbo].[Temp_CG_Adult_Working]    Script Date: 5/4/2016 11:52:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Temp_CG_Adult_Working_01](--[CG_adult_working](
	[CGPracticeId] [varchar](50) NULL,
	[Adult_Samp] [varchar](50) NULL,
	[AV_06_Rate] [decimal](23, 13) NULL,
	[AV_06_TOT] [int] NULL,
	[AV_06_DENOM] [int] NULL,
	[AV_06_NUM] [int] NULL,
	[AV_08_Rate] [decimal](23, 13) NULL,
	[AV_08_TOT] [int] NULL,
	[AV_08_DENOM] [int] NULL,
	[AV_08_NUM] [int] NULL,
	[AV_10_Rate] [decimal](23, 13) NULL,
	[AV_10_TOT] [int] NULL,
	[AV_10_DENOM] [int] NULL,
	[AV_10_NUM] [int] NULL,
	[AV_12_Rate] [decimal](23, 13) NULL,
	[AV_12_TOT] [int] NULL,
	[AV_12_DENOM] [int] NULL,
	[AV_12_NUM] [int] NULL,
	[AV_13_Rate] [decimal](23, 13) NULL,
	[AV_13_TOT] [int] NULL,
	[AV_13_DENOM] [int] NULL,
	[AV_13_NUM] [int] NULL,
	[AV_16_Rate] [decimal](23, 13) NULL,
	[AV_16_TOT] [int] NULL,
	[AV_16_DENOM] [int] NULL,
	[AV_16_NUM] [int] NULL,
	[AV_17_Rate] [decimal](23, 13) NULL,
	[AV_17_TOT] [int] NULL,
	[AV_17_DENOM] [int] NULL,
	[AV_17_NUM] [int] NULL,
	[AV_19_Rate] [decimal](23, 13) NULL,
	[AV_19_TOT] [int] NULL,
	[AV_19_DENOM] [int] NULL,
	[AV_19_NUM] [int] NULL,
	[AV_20_Rate] [decimal](23, 13) NULL,
	[AV_20_TOT] [int] NULL,
	[AV_20_DENOM] [int] NULL,
	[AV_20_NUM] [int] NULL,
	[AV_21_Rate] [decimal](23, 13) NULL,
	[AV_21_TOT] [int] NULL,
	[AV_21_DENOM] [int] NULL,
	[AV_21_NUM] [int] NULL,
	[AV_22_Rate] [decimal](23, 13) NULL,
	[AV_22_TOT] [int] NULL,
	[AV_22_DENOM] [int] NULL,
	[AV_22_NUM] [int] NULL,
	[AV_24_Rate] [decimal](23, 13) NULL,
	[AV_24_TOT] [int] NULL,
	[AV_24_DENOM] [int] NULL,
	[AV_24_NUM] [int] NULL,
	[AV_25_Rate] [decimal](23, 13) NULL,
	[AV_25_TOT] [int] NULL,
	[AV_25_DENOM] [int] NULL,
	[AV_25_NUM] [int] NULL,
	[AV_26_Rate] [decimal](23, 13) NULL,
	[AV_26_TOT] [int] NULL,
	[AV_26_DENOM] [int] NULL,
	[AV_26_NUM] [int] NULL,
	[AV_27_Rate] [decimal](23, 13) NULL,
	[AV_27_TOT] [int] NULL,
	[AV_27_DENOM] [int] NULL,
	[AV_27_NUM] [int] NULL,
	[AV_28_Rate] [decimal](23, 13) NULL,
	[AV_28_TOT] [int] NULL,
	[AV_28_DENOM] [int] NULL,
	[AV_28_NUM] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


