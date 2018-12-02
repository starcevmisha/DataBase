USE [races]
GO

CREATE TABLE [dbo].ChampionshipType(
	ID [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name [nvarchar](250) NOT NULL,
);
GO

Insert INTO [dbo].[ChampionshipType]
Values 
	('Rally'),
	('Formula 1'),
	('Drift'),
	('Dozor'),
	('CircleRace')

GO



