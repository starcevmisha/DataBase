/*������� ������� ������ ���� ������ 18 ���*/
CREATE TRIGGER TeacherAgeMustBeOver18 ON [dbo].[�������]
instead of INSERT, UPDATE
AS
	BEGIN
		insert into [dbo].[�������] 
			select * from inserted where datediff(year, inserted.����_��������, getdate()) >= 18

		if (select count(*) from inserted where datediff(year, inserted.����_��������, getdate()) < 18) > 0
			BEGIN
			  raiserror('������� ������� ������ ���� ������ 18 ���', 16, 1)
			END
	END
GO

insert into [dbo].[�������]
	Values
	(200,'�������', '������', '���������', 0, '2003-5-5', '2018-4-4'),
	(211,'�������', '������', '���������', 0, '2000-5-5', '2018-4-4');
select * from [dbo].[�������]

/*�� � ���� �������� � ������ ����� ���� ����������� ����� �������� �����������,
������ ������� ���������� ��� ���������� ������ ������ ���������, ��� � �������� ������������� ��� � �������*/
go
Create TRIGGER ClassTeacherShouldHavePermission ON [dbo].[�����]
instead of INSERT, UPDATE
AS
	BEGIN
			insert into [dbo].[�����]
			select [��������_������],[��� �������] from inserted
				left join [dbo].[�������] on inserted.[��� �������] = [dbo].[�������].[���_�������]
				where [��������_�����������]=1
			
			if (select count(*) from inserted
				left join [dbo].[�������] on inserted.[��� �������] = [dbo].[�������].[���_�������]
				where [��������_�����������]=0) > 0
			BEGIN
			  raiserror('������� ������ ����� ������ ��������� ������������, ��� �� ����� �����', 16, 1)
			END

	END
GO
insert into [dbo].[�����] Values
('13�', 4),
('10�', 8)


/*������ ����� ������� ������ �� ���� ��������, ������� ���� � ������� �����
� ������ ������ ������������� �� 1 �� 5*/

GO
ALTER TRIGGER markTrigger ON [dbo].[������]
instead of INSERT, UPDATE
AS
	BEGIN
		insert into [dbo].[������]
			select i.[���_�������],i.���_��������, i.������, i.������ from inserted i right join [dbo].[�������] y
			on i.[���_�������] = y.[���_�������]
			where i.������ >= 1 and i.������ <= 5 and
			((select count(*) from [dbo].[��������_��_�������] p 
				where p.����� = y.����� and i.���_�������� = p.���_��������) > 0)
	
		if (select Count(*) from inserted i inner join [dbo].[�������] y
			on i.[���_�������] = y.[���_�������]
			where  not (i.������ >= 1 and i.������ <= 5 and
			((select count(*) from [dbo].[��������_��_�������] p 
				where p.����� = y.����� and i.���_�������� = p.���_��������) > 0))) >0
		BEGIN
			raiserror('���� � �������', 16, 1)
		END	
	END

GO

insert into [dbo].[������] Values
(1, 1, '1�f', 67),
(1, 1, '1�faaaa', 4)

select * from [dbo].[������] 