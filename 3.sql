use FT301_Starcev


drop view Average 

create view Average as
select �������, avg(�����) ������� from (select �������, F.���������, F.����� ����� from 
		(select ���������, sum(����*����������) ����� from ��������
				group by ���������) as F
				left join ������
				on F.��������� = ������.���������
				) as E
				group by E.�������
				

select * from Average

select * from ��������

select T.���������, T.����� from(
	select Se.�������, ���������, �������, ����� from(
		select �������, F.���������, F.����� ����� from 
		(select ���������, sum(����*����������) ����� from ��������
				group by ���������) as F
				left join ������
				on F.��������� = ������.���������) as Se
	left join Average
	on Average.������� = Se.�������
) As T
 where T.����� > T.�������
		