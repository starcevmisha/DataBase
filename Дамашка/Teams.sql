USE [races]
GO

/****** Object:  Table [dbo].[Автомобили]    Script Date: 30.11.2018 21:58:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].Teams(
	ID [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Car int FOREIGN KEY REFERENCES [dbo].[Cars](ID) NOT NULL,
	DriverID int FOREIGN KEY REFERENCES [dbo].[Racers](ID) NOT NULL,
	Navigator int FOREIGN KEY REFERENCES [dbo].[Racers](ID) NULL,
)
GO

Insert INTO [dbo].[Teams]
Values 
	(1,1,3),
	(2,2,5),
	(3,4, NULL)
GO