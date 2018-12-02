USE [races]
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


-------------------------------------

CREATE TABLE [dbo].Racers(
	ID [int] IDENTITY(1,1) NOT NULL,
	Name [nvarchar](250) NOT NULL,
	Class [nvarchar](50) NULL,
	Post nvarchar(50) Not Null
	
	CONSTRAINT [PK_Racers_ID] PRIMARY KEY(ID)
);
GO

Insert INTO [dbo].[Racers]
Values 
	('Старцев Михаил', 'A', 'Водитель'),
	('Волков Денис', 'B', 'Водитель'),
	('Жукова Ольга', 'A', 'Штурман'),
	('Женихов Даниил', 'C', 'Водитель'),
	('Михаэль Шумахер', 'AA', 'Штурман'),
	('Влад Еганов','A', 'Штурман')

GO

----------------------------------------
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

----------------------------------------
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

----------------------------------------

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

------------------------------------------------
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