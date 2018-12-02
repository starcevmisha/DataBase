create view Total 
as
select A.КодСотрудника, sum(A.Стоимость) ВсегоПродал, year(ДатаИсполнения) Год from 
(select Сотрудники.КодСотрудника, Заказы.КодЗаказа, Заказы.ДатаИсполнения, (Заказано.Цена* Заказано.Количество)Стоимость ,
Заказано.КодТовара
from Сотрудники
left Join Заказы 
on Сотрудники.КодСотрудника = Заказы.КодСотрудника
left Join Заказано 
on Заказано.КодЗаказа = Заказы.КодЗаказа
left Join Товары
on Товары.КодТовара = Заказано.КодТовара) as A
group by КодСотрудника, year(ДатаИсполнения) having year(ДатаИсполнения) is not null

create view MaxYear as 
select Год, max(ВсегоПродал) ВсегоПродал
from Total
group by Год

select Total.КодСотрудника, Total.Год, Total.ВсегоПродал from Total
left Join MaxYear 
on Total.Год = MaxYear.Год
where Total.ВсегоПродал = MaxYear.ВсегоПродал

select * from Сотрудники