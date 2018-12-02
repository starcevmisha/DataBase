USE [races]
GO

/****** Object:  Table [dbo].[Cars]    Script Date: 30.11.2018 22:25:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

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


