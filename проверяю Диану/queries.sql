/*
Задание 1:
Преподаватели, стаж которых >= среднего.
Обязательно написать скалярную функцию, которая возвращает стаж работы по id преподавателя и использовать ее
Отсортировать по стажу работы
*/
go
create FUNCTION experianceById(@id int)
RETURNS INT
AS
BEGIN
DECLARE @c INT
SET @c = (SELECT datediff(year, s.[Дата_найма], getdate())
		from [dbo].[Учителя] s
		where s.Код_учителя=@id)
RETURN (@c)
END

go
create view AvgExperiance as
select avg([dbo].experianceById(y.Код_учителя)) [СрзначОпыт]
from [dbo].[Учителя] y

go
select * from [dbo].[Учителя] y
where [dbo].experianceById(y.Код_учителя) > (select [СрзначОпыт] from AvgExperiance)

/*
Задание 2:
Преподаватели, стаж которых >= среднего.
Написать быстрый вариант запроса, который не использует скалярную функцию из 1 задания
*/
go 
create view AvgExperianceFast as
select avg(datediff(year, y.[Дата_найма], getdate())) [СрзначОпыт]
from [dbo].[Учителя] y

go
select y.[Фамилия], datediff(year, y.[Дата_найма], getdate()) [Стаж]
from [dbo].[Учителя] y
where datediff(year, y.[Дата_найма], getdate()) >= (select [СрзначОпыт] from AvgExperianceFast)
order by [Стаж]


/*
Задание 3:
Вывести всех учеников, являющимися отличниками
*/
go
alter view AverageMark as
select Оценки.Код_ученика, AVG(CAST(Оценки.Оценка as float)) [Средняя_оценка]
from Оценки
group by Оценки.Код_ученика

select * from AverageMark
left join Ученики on Ученики.Код_ученика=AverageMark.Код_ученика
 where Средняя_оценка = 5

 /*
Задание 4:
Средняя оценка по всем классам по каждому предмету
Пример:
11А Русский 5
11Б Русский 5
11А Математика 5
11Б Математика 5
*/
select Класс, Название from Предметы 
	left join
		(select y.Класс, o.Код_предмета, AVG(CAST(o.Оценка as float)) [Средняя_оценка]
		from [dbo].[Оценки] o inner join [dbo].[Ученики] y
		on o.Код_ученика = y.Код_ученика
		group by y.Класс, o.Код_предмета) t
	on Предметы.Код_предмета = t.Код_предмета
	order By Класс


/*
Задание 5:
Лучшие 5 учеников школы
Рейтинг ученика рассчитывается по формуле =  (средний балл за 1 семестр) + (количество посещенных мероприятий) * 2 / (общее количество мероприятий)
*/
create view StudentTop as
select y.Код_ученика, y.Фамилия, y.Класс, av.Средняя_оценка, 
(case when ec.Количество_мероприятий is NULL then 0 else ec.Количество_мероприятий end)[Количество_мероприятий]
from  [dbo].[Ученики] y 
left join 
	AverageMark av 
	on y.Код_ученика = av.Код_ученика
left Join 
	(select Код_ученика, count(*) [Количество_мероприятий]
	from [dbo].[Мероприятия_по_ученикам] group by Код_ученика ) ec
	on ec.Код_ученика=y.Код_ученика

go
select top(5) t.Код_ученика, t.Фамилия, t.Класс,
CAST(t.Количество_мероприятий as float) * 2.0 / (select COUNT(*) from [dbo].[Мероприятия]) + t.Средняя_оценка [Рейтинг]
from StudentTop t
order by Рейтинг desc

/*
Задание 6:
Вывести для каждого преподавателя
[Суммарное количество уроков, которые данный преподаватель читает за неделю],
[Количество мероприятий, за которые ответсвеннен данный преподаватель],
[Количество классов, у которых данный преподаватель является классным руководителем]

В таблице Предметы_по_классам указано количество уроков по каждому предмету ЗА НЕДЕЛЮ
*/

go
create view TeacherHour as
select y.Код_учителя, y.Фамилия, sum(p.Количество_уроков)[Часовая_нагрузка]
from [dbo].[Учителя] y left outer join [dbo].[Предметы_по_классам] p
on p.Код_учителя = y.Код_учителя
group by y.Код_учителя, y.Фамилия

go
create view TeacherEvent as
select y.Код_учителя, COUNT(m.Код_мероприятия)[Количество_мероприятий]
from [dbo].[Учителя] y left outer join [dbo].[Мероприятия] m
on y.Код_учителя = m.Ответственный_учитель
group by y.Код_учителя

go
create view TeacherClass as
select y.Код_учителя, COUNT(k.Название_класса)[Классное_руководство]
from [dbo].[Учителя] y left outer join [dbo].[Класс] k
on y.Код_учителя = k.[Код учителя]
group by y.Код_учителя

select * from TeacherHour

go
select k.Код_учителя, k.Фамилия, k.Часовая_нагрузка, e.Количество_мероприятий, c.Классное_руководство
from TeacherHour k 
left join TeacherClass c
	on k.Код_учителя = c.Код_учителя
left join TeacherEvent e
	on e.Код_учителя = k.Код_учителя
order by k.Часовая_нагрузка + e.Количество_мероприятий + c.Классное_руководство desc

