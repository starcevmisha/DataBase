drop trigger OneCommandPerChampionship

-- В одном чемпионате одна команада участвует один раз
CREATE TRIGGER OneCommandPerChampionship ON ChampionshipResults
AFTER INSERT, UPDATE
AS
	BEGIN
		IF EXISTS (select * from inserted 
					left join ChampionshipResults on 
					inserted.ChampionshipId = ChampionshipResults.ChampionshipId
					where inserted.TeamId = ChampionshipResults.TeamId
					)
		  begin
			  RAISERROR ('Нельзя добавить два раза команду в один чемпионат', 16, 1);  
			  ROLLBACK TRANSACTION;  
		  END; 
	END;
GO


select * from [dbo].[ChampionshipResults]
INSERT INTO [dbo].[ChampionshipResults]
VALUES 
	(1, 1, '00:10:56.32', Null)

----------------------------------------

--Одна машина может быть только в одной команде
drop trigger OneTeamPerCar
CREATE TRIGGER OneTeamPerCar ON Teams
AFTER INSERT, UPDATE
AS
	BEGIN
		IF EXISTS (select * from inserted 
					left join Teams on 
					inserted.Car = Teams.Car
					)
		  begin
			  RAISERROR ('Одна машина не может быть зарегистрована в разных командах', 16, 1);  
			  ROLLBACK TRANSACTION;  
		  END; 
	END;
GO


INSERT INTO [dbo].[Teams]
VALUES 
	(1, 1, 2),
	(1, 2, 1)

	

----------------------------------------

-- Водитель и штурман долны быть разными в команде
drop trigger DifferentDriverAndNavigator
CREATE TRIGGER DifferentDriverAndNavigator ON Teams
AFTER INSERT, UPDATE
AS
	BEGIN
		IF EXISTS (select * from inserted 
					where inserted.DriverId = inserted.Navigator
					)
		  begin
			  RAISERROR ('Водитель и штурман должгы быть разными', 16, 1);  
			  ROLLBACK TRANSACTION;  
		  END; 
	END;
GO


INSERT INTO [dbo].[Teams]
VALUES 
	(1, 1, 1)
	

-- Запрет на участие в гонке, если в предыдущем проходимвшем чемпионате команда набрала штрафных баллов больше 1000.

drop trigger StopDueToPenaltyScore
CREATE TRIGGER DifferentDriverAndNavigator ON ChampionshipResults
AFTER INSERT, UPDATE
AS
	BEGIN
		IF EXISTS (
					select * from inserted 
					left join Championship on Championship.Id = inserted.ChampionshipId-1
					
					)
		  begin
			  RAISERROR ('Водитель и штурман должгы быть разными', 16, 1);  
			  ROLLBACK TRANSACTION;  
		  END; 
	END;
GO


INSERT INTO [dbo].[ChampionshipResults]
VALUES 
	(3, 5, '7:19:30.00', 1500)

	INSERT INTO [dbo].[ChampionshipResults]
VALUES 
	(4, 5, '6:00:30.00', 0)
