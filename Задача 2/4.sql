drop view AverageCountry

create view SumCountry
as
select Страна, sum(Товары.Цена * Количество) as ПроданоЗаГод, year(Заказы.ДатаИсполнения) Год from Поставщики
left join Товары
on Поставщики.КодПоставщика = Товары.КодПоставщика
left join Заказано
on Товары.КодТовара = Заказано.КодТовара
left join Заказы
on Заказы.КодЗаказа = Заказано.КодЗаказа
where Заказы.ДатаИсполнения is not null
group by Страна, year(Заказы.ДатаИсполнения)


create view AverageCountry as
select avg(ПроданоЗаГод) СреденееЗаГод, Год from SumCountry
group by Год

create view Every as
select Страна, sum(Товары.Цена * Количество) as ПроданоЗаГод, year(Заказы.ДатаИсполнения) Год, count(Заказы.КодКлиента) КлиентовЗаГод from Поставщики
left join Товары
on Поставщики.КодПоставщика = Товары.КодПоставщика
left join Заказано
on Товары.КодТовара = Заказано.КодТовара
left join Заказы
on Заказы.КодЗаказа = Заказано.КодЗаказа
where Заказы.ДатаИсполнения is not null
group by Страна, year(Заказы.ДатаИсполнения)

select Every.Страна, Every.КлиентовЗаГод, Every.ПроданоЗаГод, Every.Год from Every
left join AverageCountry
on AverageCountry.Год = Every.Год
where AverageCountry.СреденееЗаГод <= Every.ПроданоЗаГод
order by Every.Год


