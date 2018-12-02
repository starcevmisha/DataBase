USE [races]
GO

/****** Object:  Table [dbo].[Автомобили]    Script Date: 30.11.2018 21:58:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Cars](
	ID [int] IDENTITY(1,1) NOT NULL,
	manufacturer [nvarchar](100) NOT NULL,
	model [nchar](100) NULL,
	yearManufactred [date] NOT NULL,
	specifications [nvarchar](max) NULL,
	class [nvarchar](50) NULL
	CONSTRAINT PK_Cars_ID Primary KEY (ID)
) 
GO

Insert INTO [dbo].[Cars]
Values 
	('Hyundai', 'accent', '2005', '102 hp, 13 sec', 'A'),
	('Lada', 'kalina sport', '2010', '123 hp, 9 sec', 'A'),
	('Peugeot','206','2008', '250 hp, 6 sec, v8', 'RallyF')
GO

