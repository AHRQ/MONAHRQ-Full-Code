

--  Delete table if needed.
if(Object_id(N'Temp_CG_Child_Working_02')) is not null 
	drop table [Temp_CG_Child_Working_02]
go

/****** Object:  Table [dbo].[Temp_CG_Child_Working_02]    Script Date: 5/4/2016 11:52:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Temp_CG_Child_Working_02](
	[CGPracticeId] [varchar](50) NULL,
	[Child_Samp] [varchar](50) NULL,
	[CD_38_Comp] [decimal](23, 13) NULL,
	[CD_39_Comp] [decimal](23, 13) NULL,
	[CD_40_Comp] [decimal](23, 13) NULL,
	[CD_41_Comp] [decimal](23, 13) NULL,
	[CD_44_Comp] [decimal](23, 13) NULL,
	[CD_47_Comp] [decimal](23, 13) NULL,
	[CD_42_Comp] [decimal](23, 13) NULL,
	[CD_43_Comp] [decimal](23, 13) NULL,
	[CD_45_Comp] [decimal](23, 13) NULL,
	[CD_46_Comp] [decimal](23, 13) NULL,
	[CD_48_Comp] [decimal](23, 13) NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

