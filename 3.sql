use FT301_Starcev


drop view Average 

create view Average as
select КодТипа, avg(Всего) Среднее from (select КодТипа, F.КодТовара, F.Всего Всего from 
		(select КодТовара, sum(Цена*Количество) Всего from Заказано
				group by КодТовара) as F
				left join Товары
				on F.КодТовара = Товары.КодТовара
				) as E
				group by E.КодТипа
				

select * from Average

select * from Заказано

select T.КодТовара, T.Всего from(
	select Se.КодТипа, КодТовара, Среднее, Всего from(
		select КодТипа, F.КодТовара, F.Всего Всего from 
		(select КодТовара, sum(Цена*Количество) Всего from Заказано
				group by КодТовара) as F
				left join Товары
				on F.КодТовара = Товары.КодТовара) as Se
	left join Average
	on Average.КодТипа = Se.КодТипа
) As T
 where T.Всего > T.Среднее
		