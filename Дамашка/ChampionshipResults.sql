USE [races]
GO

/****** Object:  Table [dbo].[Cars]    Script Date: 30.11.2018 22:25:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].ChampionshipResults(
	ID [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	ChampionshipId int FOREIGN KEY REFERENCES [dbo].[Championship](ID) Not Null,
	TeamId int FOREIGN KEY REFERENCES [dbo].[Championship](ID) NOT NULL,
	ResultTime time NOT NULL,
	PenaltyScores int NULL,
);
GO

Insert INTO [dbo].[ChampionshipResults]
Values 
	(1, 1, '00:10:56.32', Null),
	(1, 2, '00:8:30.00', Null),
	(1, 3, '00:15:00.00',100),
	
	(2, 1, '5:00:01.00', Null),
	(2, 3, '4:00:00.00', 500),

	(3, 3, '00:40:56.32', Null),
	(3, 2, '00:19:30.00', Null),
	(3, 1, '00:35:00.00',100),

	(4, 3, '00:45:01.00', NULL),
	(4, 2, '00:34:00.00', NUll),

	(5, 3, '8:40:56.32', Null),
	(5, 2, '7:19:30.00', 100),
	(5, 1, '10:35:00.00',Null)

GO


