/*
������� 1:
�������������, ���� ������� >= ��������.
����������� �������� ��������� �������, ������� ���������� ���� ������ �� id ������������� � ������������ ��
������������� �� ����� ������
*/
go
create FUNCTION experianceById(@id int)
RETURNS INT
AS
BEGIN
DECLARE @c INT
SET @c = (SELECT datediff(year, s.[����_�����], getdate())
		from [dbo].[�������] s
		where s.���_�������=@id)
RETURN (@c)
END

go
create view AvgExperiance as
select avg([dbo].experianceById(y.���_�������)) [����������]
from [dbo].[�������] y

go
select * from [dbo].[�������] y
where [dbo].experianceById(y.���_�������) > (select [����������] from AvgExperiance)

/*
������� 2:
�������������, ���� ������� >= ��������.
�������� ������� ������� �������, ������� �� ���������� ��������� ������� �� 1 �������
*/
go 
create view AvgExperianceFast as
select avg(datediff(year, y.[����_�����], getdate())) [����������]
from [dbo].[�������] y

go
select y.[�������], datediff(year, y.[����_�����], getdate()) [����]
from [dbo].[�������] y
where datediff(year, y.[����_�����], getdate()) >= (select [����������] from AvgExperianceFast)
order by [����]


/*
������� 3:
������� ���� ��������, ����������� �����������
*/
go
alter view AverageMark as
select ������.���_�������, AVG(CAST(������.������ as float)) [�������_������]
from ������
group by ������.���_�������

select * from AverageMark
left join ������� on �������.���_�������=AverageMark.���_�������
 where �������_������ = 5

 /*
������� 4:
������� ������ �� ���� ������� �� ������� ��������
������:
11� ������� 5
11� ������� 5
11� ���������� 5
11� ���������� 5
*/
select �����, �������� from �������� 
	left join
		(select y.�����, o.���_��������, AVG(CAST(o.������ as float)) [�������_������]
		from [dbo].[������] o inner join [dbo].[�������] y
		on o.���_������� = y.���_�������
		group by y.�����, o.���_��������) t
	on ��������.���_�������� = t.���_��������
	order By �����


/*
������� 5:
������ 5 �������� �����
������� ������� �������������� �� ������� =  (������� ���� �� 1 �������) + (���������� ���������� �����������) * 2 / (����� ���������� �����������)
*/
create view StudentTop as
select y.���_�������, y.�������, y.�����, av.�������_������, 
(case when ec.����������_����������� is NULL then 0 else ec.����������_����������� end)[����������_�����������]
from  [dbo].[�������] y 
left join 
	AverageMark av 
	on y.���_������� = av.���_�������
left Join 
	(select ���_�������, count(*) [����������_�����������]
	from [dbo].[�����������_��_��������] group by ���_������� ) ec
	on ec.���_�������=y.���_�������

go
select top(5) t.���_�������, t.�������, t.�����,
CAST(t.����������_����������� as float) * 2.0 / (select COUNT(*) from [dbo].[�����������]) + t.�������_������ [�������]
from StudentTop t
order by ������� desc

/*
������� 6:
������� ��� ������� �������������
[��������� ���������� ������, ������� ������ ������������� ������ �� ������],
[���������� �����������, �� ������� ������������ ������ �������������],
[���������� �������, � ������� ������ ������������� �������� �������� �������������]

� ������� ��������_��_������� ������� ���������� ������ �� ������� �������� �� ������
*/

go
create view TeacherHour as
select y.���_�������, y.�������, sum(p.����������_������)[�������_��������]
from [dbo].[�������] y left outer join [dbo].[��������_��_�������] p
on p.���_������� = y.���_�������
group by y.���_�������, y.�������

go
create view TeacherEvent as
select y.���_�������, COUNT(m.���_�����������)[����������_�����������]
from [dbo].[�������] y left outer join [dbo].[�����������] m
on y.���_������� = m.�������������_�������
group by y.���_�������

go
create view TeacherClass as
select y.���_�������, COUNT(k.��������_������)[��������_�����������]
from [dbo].[�������] y left outer join [dbo].[�����] k
on y.���_������� = k.[��� �������]
group by y.���_�������

select * from TeacherHour

go
select k.���_�������, k.�������, k.�������_��������, e.����������_�����������, c.��������_�����������
from TeacherHour k 
left join TeacherClass c
	on k.���_������� = c.���_�������
left join TeacherEvent e
	on e.���_������� = k.���_�������
order by k.�������_�������� + e.����������_����������� + c.��������_����������� desc

