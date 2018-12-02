drop trigger OneCommandPerChampionship
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