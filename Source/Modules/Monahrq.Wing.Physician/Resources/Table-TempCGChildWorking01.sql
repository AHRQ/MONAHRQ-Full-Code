

--  Delete table if needed.
if(Object_id(N'Temp_CG_Child_Working_01')) is not null 
	drop table [Temp_CG_Child_Working_01]
go

/****** Object:  Table [dbo].[Temp_CG_Child_Working]    Script Date: 5/4/2016 11:52:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Temp_CG_Child_Working_01](
	[CGPracticeId] [varchar](50) NULL,
	[Child_Samp] [varchar](50) NULL,
	[CD_38_Rate] [decimal](23, 13) NULL,
	[CD_38_TOT] [int] NULL,
	[CD_38_DENOM] [int] NULL,
	[CD_39_Rate] [decimal](23, 13) NULL,
	[CD_39_TOT] [int] NULL,
	[CD_39_DENOM] [int] NULL,
	[CD_40_Rate] [decimal](23, 13) NULL,
	[CD_40_TOT] [int] NULL,
	[CD_40_DENOM] [int] NULL,
	[CD_41_Rate] [decimal](23, 13) NULL,
	[CD_41_TOT] [int] NULL,
	[CD_41_DENOM] [int] NULL,
	[CD_42_Rate] [decimal](23, 13) NULL,
	[CD_42_TOT] [int] NULL,
	[CD_42_DENOM] [int] NULL,
	[CD_43_Rate] [decimal](23, 13) NULL,
	[CD_43_TOT] [int] NULL,
	[CD_43_DENOM] [int] NULL,
	[CD_44_Rate] [decimal](23, 13) NULL,
	[CD_44_TOT] [int] NULL,
	[CD_44_DENOM] [int] NULL,
	[CD_45_Rate] [decimal](23, 13) NULL,
	[CD_45_TOT] [int] NULL,
	[CD_45_DENOM] [int] NULL,
	[CD_46_Rate] [decimal](23, 13) NULL,
	[CD_46_TOT] [int] NULL,
	[CD_46_DENOM] [int] NULL,
	[CD_47_Rate] [decimal](23, 13) NULL,
	[CD_47_TOT] [int] NULL,
	[CD_47_DENOM] [int] NULL,
	[CD_48_Rate] [decimal](23, 13) NULL,
	[CD_48_TOT] [int] NULL,
	[CD_48_DENOM] [int] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

