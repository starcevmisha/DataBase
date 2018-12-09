/*Возраст учителя должен быть больше 18 лет*/
CREATE TRIGGER TeacherAgeMustBeOver18 ON [dbo].[Учителя]
instead of INSERT, UPDATE
AS
	BEGIN
		insert into [dbo].[Учителя] 
			select * from inserted where datediff(year, inserted.Дата_рождения, getdate()) >= 18

		if (select count(*) from inserted where datediff(year, inserted.Дата_рождения, getdate()) < 18) > 0
			BEGIN
			  raiserror('Возраст учителя должен быть больше 18 лет', 16, 1)
			END
	END
GO

insert into [dbo].[Учителя]
	Values
	(200,'Старцев', 'Михаил', 'Денисович', 0, '2003-5-5', '2018-4-4'),
	(211,'Старцев', 'Михаил', 'Денисович', 0, '2000-5-5', '2018-4-4');
select * from [dbo].[Учителя]

/*Не у всех учителей в данной школе есть возможность брать классное руководство,
именно поэтому необходимо при добавлении нового класса проверять, что с классным руководителем все в порядке*/
go
Create TRIGGER ClassTeacherShouldHavePermission ON [dbo].[Класс]
instead of INSERT, UPDATE
AS
	BEGIN
			insert into [dbo].[Класс]
			select [Название_класса],[Код учителя] from inserted
				left join [dbo].[Учителя] on inserted.[Код учителя] = [dbo].[Учителя].[Код_учителя]
				where [Классное_руководство]=1
			
			if (select count(*) from inserted
				left join [dbo].[Учителя] on inserted.[Код учителя] = [dbo].[Учителя].[Код_учителя]
				where [Классное_руководство]=0) > 0
			BEGIN
			  raiserror('Учитель должен иметь статус классного руководителя, что бы иметь класс', 16, 1)
			END

	END
GO
insert into [dbo].[Класс] Values
('13В', 4),
('10Г', 8)


/*Оценку можно ставить только по тому предмету, который есть в учебном плане
И оценка должна варьироваться от 1 до 5*/

GO
ALTER TRIGGER markTrigger ON [dbo].[Оценки]
instead of INSERT, UPDATE
AS
	BEGIN
		insert into [dbo].[Оценки]
			select i.[Код_ученика],i.Код_предмета, i.период, i.оценка from inserted i right join [dbo].[Ученики] y
			on i.[Код_ученика] = y.[Код_ученика]
			where i.оценка >= 1 and i.оценка <= 5 and
			((select count(*) from [dbo].[Предметы_по_классам] p 
				where p.Класс = y.Класс and i.Код_предмета = p.Код_предмета) > 0)
	
		if (select Count(*) from inserted i inner join [dbo].[Ученики] y
			on i.[Код_ученика] = y.[Код_ученика]
			where  not (i.оценка >= 1 and i.оценка <= 5 and
			((select count(*) from [dbo].[Предметы_по_классам] p 
				where p.Класс = y.Класс and i.Код_предмета = p.Код_предмета) > 0))) >0
		BEGIN
			raiserror('Дичь в оценках', 16, 1)
		END	
	END

GO

insert into [dbo].[Оценки] Values
(1, 1, '1рf', 67),
(1, 1, '1рfaaaa', 4)

select * from [dbo].[Оценки] 