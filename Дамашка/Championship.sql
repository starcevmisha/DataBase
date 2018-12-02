USE [races]
GO

/****** Object:  Table [dbo].[Cars]    Script Date: 30.11.2018 22:25:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].Championship(
	ID [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name [nvarchar](250) NOT NULL,
	Date datetime NOT NULL,
	Type int FOREIGN KEY REFERENCES [dbo].[ChampionshipType](ID) Not Null
);
GO

Insert INTO [dbo].[Championship]
Values 
	('Чемпионат Урала по ралли Среди юниоров', '2010-4-5', 1),
	('Формула Е', '2013-6-6', 2),
	('Чемпионат Cвердловской области по дрифту 2013', '2013-6-6', 3),
	('Чемпионат Cвердловской области по дрифту 2014', '2014-6-6', 3),
	('Ночное ориентирование на спортивных автмобилях', '2015-6-6', 4),
	('Кольцевые гонки', '2017-6-6', 5)

GO


