------Вывести количество штрафных баллов для конкретной команды.
CREATE FUNCTION PenaltyScoreForTeam(@TeamId int)
returns @FinalResults table (PenaltyScore int)
AS
BEGIN
	insert into @FinalResults
		select Sum(PenaltyScores) from [dbo].[ChampionshipResults]
		where TeamId = @TeamId
	RETURN
END

go

select * from PenaltyScoreForTeam(1)

---Для каждого чемпионата - победителя
CREATE FUNCTION WinnersForChampionship(@ChampionshipId int)
returns @FinalResults table (TeamId int)
AS
BEGIN
	insert into @FinalResults
		select TeamId from ChampionshipResults
		right join 
			(select ChampionshipId, min(resultTime) BestTime from  ChampionshipResults
				group by ChampionshipId) BestTimeView 
		on BestTimeView.ChampionShipId = ChampionshipResults.ChampionShipId
		where BestTimeView.BestTime = ChampionshipResults.ResultTime and ChampionshipResults.ChampionshipId = @ChampionshipId
	RETURN
END

go

select * from WinnersForChampionship(1)


--Команда с наибольшим количеством побед и само количество побед
CREATE FUNCTION GetTopTeam()
returns @FinalResults table (TeamId int, count int)
AS
BEGIN
	insert into @FinalResults
		select Top(1) TeamId, Count(ChampionshipResults.ChampionShipId) count from ChampionshipResults
			right join 
				(select ChampionshipId, min(resultTime) BestTime from  ChampionshipResults
					group by ChampionshipId) BestTimeView 
			on BestTimeView.ChampionShipId = ChampionshipResults.ChampionShipId
			where BestTimeView.BestTime = ChampionshipResults.ResultTime
			group by TeamId
			order by count desc
	RETURN
END

go

select * from GetTopTeam()
	
-- показать все чемпионаты в которых участвовал человек
CREATE FUNCTION GetAllChampionatsForRacer(@RacerId int)
returns @FinalResults table (ChampionshipId int)
AS
BEGIN
	insert into @FinalResults
		select ChampionshipId from ChampionshipResults
			left join Teams on Teams.ID = TeamId
			where driverId = @RacerId or navigator=@RacerId

	RETURN
END

go

select * from GetAllChampionatsForRacer(1)


---Среднее время чемпионата---

CREATE FUNCTION GetAverageTimeForChampionship(@ChampionshipId int)
returns @FinalResults table (AvgTime time)
AS
BEGIN
	insert into @FinalResults
		select CONVERT(TIME, DATEADD(SECOND, AVG(DATEDIFF(SECOND, 0, ResultTime)), 0)) AvgTime from ChampionshipResults
		where ChampionshipResults.ChampionshipId = @ChampionshipId 
	RETURN
END

go

select * from GetAverageTimeForChampionship(1)	