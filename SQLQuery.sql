use master
CREATE DATABASE Examination_DB
ON 
(
	NAME=Examination,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.ROQAIA1998\MSSQL\DATA\Examination_Df1.mdf',
	SIZE = 4,
	MAXSIZE = 15,
	FILEGROWTH = 2
),   
( 
	NAME = Examination_Df2, 
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.ROQAIA1998\MSSQL\DATA\Examination_Df2.ndf',
	SIZE = 4,
	MAXSIZE = 15,
	FILEGROWTH = 2
),
FILEGROUP SECONDARY_fg 
( 
	NAME = Examination_Df3,
	FILENAME ='C:\Program Files\Microsoft SQL Server\MSSQL15.ROQAIA1998\MSSQL\DATA\Examination_Df3.ndf',
	SIZE = 4,
	MAXSIZE = 10,
	FILEGROWTH = 2
),
( 
	NAME = Examination_Df4,
	FILENAME ='C:\Program Files\Microsoft SQL Server\MSSQL15.ROQAIA1998\MSSQL\DATA\Examination_Df4.ndf',
	SIZE = 4,
	MAXSIZE = 10,
	FILEGROWTH = 2
)
LOG ON
(
	NAME=Examination_log,
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.ROQAIA1998\MSSQL\DATA\Examination__log.ldf',
	SIZE = 4,
	MAXSIZE = 15,
	FILEGROWTH = 2
)


------------------------------------------------------------------------------------------
create schema Exam

create table Exam.student
(
	st_id int identity (1,1),
	name nvarchar(20) not null,
	class int not null,
	constraint student_PK primary key (st_id)
)

create table Exam.instructor
(
	ins_id int identity (1,1),
	name nvarchar(20) not null,
	course nvarchar(20) not null,
	constraint instructor_PK primary key (ins_id)
)

create table Exam.course
(
	co_id int identity (1,1),
	name nvarchar(20) not null,
	description nvarchar(50) null,
	max_deg int not null,
	min_deg int not null,
	ins_id int not null,
	constraint course_PK primary key (co_id),
	constraint In_FK foreign key (ins_id) references Exam.instructor(ins_id)
)

create table Exam.exam
(
	ex_id int identity (1,1),
	exam nvarchar(20)  null,
	corective nvarchar(50) null,
	total_time time not null,
	start_time datetime not null,
	end_time datetime not null,
	ins_id int not null,
	co_id int not null,
	constraint exam_PK primary key (ex_id),
	constraint ins_FK foreign key (ins_id) references Exam.instructor(ins_id),
	constraint Co_FK foreign key (co_id) references Exam.course(co_id)
)

create table Exam.student_course
(
	st_id int not null,
	co_id int not null,
	constraint student_course_PK primary key (st_id,co_id),
	constraint sn_FK foreign key (st_id) references Exam.student(st_id),
	constraint cor_FK foreign key (co_id) references Exam.course(co_id)	
)
create table Exam.student_exam
(
	st_id int not null,
	ex_id int not null,
	constraint student_exam_PK primary key (ex_id,st_id),
	constraint stud_FK foreign key (st_id) references Exam.student(st_id),
	constraint exa_FK foreign key (ex_id) references Exam.exam(ex_id)	
)
create table Exam.q_pool
(
	qu_id int identity (1,1),
	qustion nvarchar(100) not null,
	msq int  null,
	t_f int null,
	answer nvarchar(50) not null,
	corect_answer nvarchar(20) not null,
	co_id int not null,
	constraint Q_pool_PK primary key (qu_id),
	constraint Cors_FK foreign key (co_id) references Exam.course(co_id)
)
create table Exam.exam_qustion
(
	ex_id int ,
	qu_id int ,
	degree int not null,
	constraint exam_qustion_PK primary key (ex_id,qu_id),
	constraint qust_FK foreign key (qu_id) references Exam.q_pool(qu_id),
	constraint exam_FK foreign key (ex_id) references Exam.exam(ex_id)	
)

create table Exam.st_answer
(
	st_ans_id int identity (1,1),
	st_answer nvarchar(20) not null,
	result int not null,
	ex_id int not null,
	qu_id int not null,
	st_id int not null,
	constraint st_answer_PK primary key (st_ans_id,ex_id,qu_id,st_id),
	constraint examm_FK foreign key (ex_id) references Exam.exam(ex_id),
	constraint qustion_FK foreign key (qu_id) references Exam.q_pool(qu_id),
	constraint student_FK foreign key (st_id) references Exam.student(st_id),
)

create table Exam.result
(
	res_id int identity (1,1),
	final_result int  null,
	ex_id int not null,
	co_id int not null,
	st_id int not null,
	constraint result_PK primary key (res_id,ex_id,co_id,st_id),
	constraint exam_re_FK foreign key (ex_id) references Exam.exam (ex_id),
	constraint qustion_re_FK foreign key (co_id) references Exam.course (co_id),
	constraint student_res_FK foreign key (st_id) references Exam.student(st_id)
)

insert into [Exam].[student]
values('ahmed',7),
	('yassmen',5),
	('noha',5),
	('ali',4),
	('amr',8),
	('mohammed',8)
	---------------------------------------------------------------------

update [Exam].[student]
		set  [class]= 5
		where [class]=4

 delete from [Exam].[student]
 where [class]=5
 -----------------------------------------------------------------------------------
 ALTER TABLE [Exam].[instructor]
DROP COLUMN [course];

--------------------------------------------------------

 insert into [Exam].[instructor]
 values ('eman'),
		('ahmed'),
		('rana'),
		('shahd')


 insert into [Exam].[course]([name],[max_deg],[min_deg],[ins_id])
 values ('english',100,50,1),
		('arabic',100,50,2),
		('math',150,80,1),
		('Sciences',15,80,3),
		('physics',150,80,3)

----------------------------------------------------------------------------
insert into [Exam].[student_course]
values (2,1),
	   (2,2),
	   (3,1),
	   (3,4),
	   (3,5),
	   (7,1),
	   (7,6),
	   (7,3),
	   (8,2),
	   (8,3)

---------------------------------------------------------------------------
 ALTER TABLE [Exam].[exam]
DROP COLUMN [total_time];

ALTER TABLE [Exam].[exam] ADD total_time int null

--------------------------------------------------------------------------------------
 ALTER TABLE [Exam].[exam]
 ALTER COLUMN [exam] int 

 ALTER TABLE [Exam].[exam]
 ALTER COLUMN [corective] int 

 -----------------------------------------------------------------------------------------------------

insert into [Exam].[exam] ([exam],[corective],[start_time],[end_time],[ins_id],[co_id])
values  (1,0,'2020-02-21 10:00','2020-02-21 13:00',1,1),
		(0,1,'2020-02-21 10:00','2020-02-21 13:00',4,1),
		(1,0,'2020-02-22 09:30','2020-02-22 10:30',3,5)

insert into [Exam].[exam] ([exam],[corective],[start_time],[end_time],[ins_id],[co_id])
values  (1,0,'2020-02-21 10:00','2020-02-21 13:00',1,2)
---------------------------------------------------------------------------------------------------

insert into [Exam].[q_pool]([qustion],[msq],[t_f],[answer],[corect_answer],[co_id])
values ('..... tennis every Sunday morning?',1,0,'a-playing b-play c-am playing d-am play','b',2),
	   ('Dont make so much noise. Noriko ....... to study for her ESL test!?',1,0,'a-try b-tries c-tried d-is trying','d',2),
	   ('Jun-Sik ..... his teeth before breakfast every morning.?',1,0,'a-will cleaned b-is cleaning c-cleans d-clean','c',2),
	   ('Sorry, she cant come to the phone. She is having a bath!',0,1,'a-true b-false','a',2),
	   ('It snowed many times every winter in Frankfurt.',0,1,'a-true b-false','b',2)
-------------------------------------------------------------------------------------	 

--add student and exam into [student_exam] table
create procedure addStudentExam(@class int)
as
begin 
	insert into [Exam].[student_exam]([st_id],[ex_id])
	select s.st_id,ex_id
	from [Exam].[student] s,[Exam].[student_course]sc,[Exam].[exam]e
	where s.class=7
	and s.st_id=sc.st_id
	and sc.co_id=e.co_id
end;

EXECUTE addStudentExam
@class=7;
----------------------------------------------------------------------------
--calculate total time for exam

alter procedure getTotalTime(@ex_id int)
as
begin
		
		declare @s_time datetime
		declare @end_time datetime
		select @s_time=[start_time] from [Exam].[exam]
		where [ex_id]=@ex_id
		
		select @end_time=[end_time]from [Exam].[exam]
		where [ex_id]=@ex_id

		declare @total_time int
		set @total_time=datediff(HH,@s_time,@end_time)
		update [Exam].[exam]
		set [total_time]=@total_time
		where [ex_id]=@ex_id
end

------------------------------------------------------------------------------
--calculate total time for all exam in exam table 

DECLARE @i INT = 1;
DECLARE @count INT
SELECT @count=  Count(*) FROM [Exam].[exam]

WHILE @i <= @count
BEGIN
	DECLARE @exam_id INT
		SELECT @exam_id= [ex_id] FROM [Exam].[exam]
		where [ex_id] =@i
	 EXECUTE getTotalTime 
	@ex_id=@exam_id;
	Set @i=@i+1
END

select * from [Exam].[exam]

-------------------------------------------------------------------------------------------
ALTER TABLE [Exam].[exam] ADD degree int null

-----------------------------------------------------
------------------------------------------------------------
-- create view for mcq qustion
create view mcqQustion
as
(
	select * from [Exam].[q_pool]
	where [msq]=1
)

----------------------------------------------------------------------------
-- create view for t&f qustion
create view t_fQustion
as
(
	select * from [Exam].[q_pool]
	where [t_f]=1
)

--------------------------------------------------------
--add exam qustion by inter number of qustion of mcq

alter procedure addExamQutionForMCQ(@exam_id int,@NumQus int)
as
begin 
declare @x int=1
	declare @mcq_id int 
	select TOP(1) @mcq_id = mcq.[qu_id]
	from [dbo].[mcqQustion] mcq
	WHILE @x <= @NumQus
	BEGIN
		insert into [Exam].[exam_qustion]
		select e.[ex_id],q.[qu_id],e.[degree]
		from [dbo].[mcqQustion] q,[Exam].[exam]e
		where e.[ex_id]=@exam_id
		and q.co_id=e.co_id 
		and [qu_id]=@mcq_id
		set @mcq_id=@mcq_id+1
		set @x=@x+1
	end
end

------------------------------------------------------------------------------------------------------------------
--add exam qustion by inter number of qustion of t&f
alter procedure addExamQutionForT_F(@exam_id int ,@NumQ int)
as
begin 
	declare @x int=1
	declare @TF_id int 
	select TOP(1) @TF_id = tf.[qu_id]
	from [dbo].[t_fQustion] tf
	WHILE @x <= @NumQ
	BEGIN
		insert into [Exam].[exam_qustion]  
		select e.[ex_id],q.[qu_id],e.[degree]
		from [dbo].[t_fQustion] q,[Exam].[exam]e
		where e.[ex_id]=@exam_id
		and q.co_id=e.co_id
		and [qu_id]=@TF_id
		set @x=@x+1
		set @TF_id=@TF_id+1
	end
end;
-------------------------------------------------------------------------------------------------------
--enter num for type of qustion to make exam 

EXECUTE addExamQutionForMCQ
@exam_id =5,
@NumQus =2

EXECUTE addExamQutionForT_F
@exam_id =5,
@NumQ =2

select * from [Exam].[exam_qustion]

---------------------------------------------------------------------------------------------------------
 ALTER TABLE [Exam].[st_answer]
 ALTER COLUMN [result] int 


-----------------------------------------------------------------------------------------------------
--check student answer if correct or not by chick student answer and true answer

alter procedure studentAnswer(@S_ans_id int)
as 
begin 
	declare @Q_answer nvarchar(20)
	declare @st_answer nvarchar(20)

	select @Q_answer=qp.[corect_answer]
	from [Exam].[st_answer] sta,[Exam].[q_pool]qp
	where sta.[qu_id]=qp.[qu_id]
	and sta.[st_ans_id]=@S_ans_id

	select @st_answer= sta.[st_answer]
	from [Exam].[st_answer] sta,[Exam].[q_pool]qp
	where sta.[qu_id]=qp.[qu_id]
	and sta.[st_ans_id]=@S_ans_id
	if(@Q_answer = @st_answer)
		begin
			update [Exam].[st_answer]
			set [result]=1
			where [st_ans_id]=@S_ans_id
		end
	else
		begin
			update [Exam].[st_answer]
			set [result]=0
			where [st_ans_id]=@S_ans_id
		end
end
------------------------------------------------------------------------------------------
--chick answer for all student answer 

DECLARE @i INT = 1;
DECLARE @count INT
SELECT @count=  Count(*) FROM [Exam].[st_answer]

WHILE @i <= @count
BEGIN
	DECLARE @s_a_id INT
		SELECT @s_a_id= [st_ans_id] FROM [Exam].[st_answer]
		where  [st_ans_id]=@i
		EXECUTE studentAnswer
		@S_ans_id=@s_a_id
	Set @i=@i+1
END

-------------------------------------------------------------------------------------------

select * from [Exam].[st_answer]

--create view for student answer and correct answer 
create view studentAnswerAndCorecctAnswer
as
(
select sta.[st_answer] ,qp.[corect_answer]
from [Exam].[st_answer] sta,[Exam].[q_pool]qp
where sta.[qu_id]=qp.[qu_id]
)
select * from studentAnswerAndCorecctAnswer
--------------------------------------------------------------------------------------------------------------
--show exam to student in start time of exam
procedure showExamInAvelableTime(@St_id int)
as 
begin 

	select s.name as studentName,e.ex_id
	from [Exam].[exam]e,[Exam].[student_exam] st,[Exam].[student] s
	where s.st_id=#@St_id
	and s.st_id=st.st_id
	and ex_id=st.ex_id
	and e.start_time= GETDATE()
	 
end
-----------------------------------------------------------------------------------------------------------------------------------------------------

EXECUTE showExamInAvelableTime
@St_id=8 


----------------------------------------------------------------------------------------------------------------------------------------
--create procedure that allow instructor delete qustion in his course only 
create procedure allowinstructorDeleteQustion(@In_id int,#Qu_id int)
as 
begin 
	declare @in_id_allow int
	select @in_id_allow= in_id 
	from[Exam].[q_pool]qp,[Exam].[course]c
	where qp.co_id=c.co_id
	and c.in_id=@In_id
	if(@in_id_allow=@In_id)
	begin
	delete from [Exam].[q_pool]
	where qu_id=#Qu_id
	end
	else 
	print "can not delete in this table"
	end
	 
end
----------------------------------------------------------------------------------
EXECUTE allowinstructorDeleteQustion
@In_id=1,
#Qu_id=5
-----------------------------------------------------------------------------------------
--create procedure that allow instructor update qustion in his course only
create procedure allowinstructorUpdateQustion(@In_id int,@Qu_id int,@newAnswer nvarchar(20))
as 
begin 
	declare @in_id_allow int
	select @in_id_allow= in_id 
	from[Exam].[q_pool]qp,[Exam].[course]c
	where qp.co_id=c.co_id
	and c.in_id=@In_id
	if(@in_id_allow=@In_id)
	begin
	update [Exam].[q_pool]
	set answer=@newAnswer
	where qu_id=#Qu_id
	end
	else 
	print "can not update in this table"
	end
	 
end

----------------------------------------------------------------------------------------------------------

EXECUTE allowinstructorUpdateQustion
@In_id=1,
@Qu_id=5,
@newAnswer='b'
-----------------------------------------------------------------------------------------------
--create procedure that allow instructor insert qustion in his course only
create procedure allowinstructorInsertQustion(@In_id int,@MCQ int ,@T_F int ,@corect_anser nvarchar(20) ,@Answer nvarchar(20),@Qustion nvarchar(20),@co_id int)
as 
begin 
	declare @in_id_allow int
	select @in_id_allow= in_id 
	from[Exam].[q_pool]qp,[Exam].[course]c
	where qp.co_id=c.co_id
	and c.in_id=@In_id
	if(@in_id_allow=@In_id)
	begin
	insert into [Exam].[q_pool]
	values(@MCQ,@T_F,@corect_anser,@Answer,@Qustion ,@co_id)
	end
	else 
	print "can not insert in this table"
	end
	 
end

----------------------------------------------------------------------------------------
execute allowinstructorInsertQustion
@MCQ=0,
@T_F=1,
@corect_anser='a',
@Answer='a:true b:falce',
@Qustion'ay 7agaaa' ,
@co_id=2
---------------------------------------------------------------------------------------------------
insert into [Exam].[st_answer]([st_answer],[ex_id],[qu_id],[st_id])
values  ('d',5,1,8),
		('a',5,2,8),
		('a',5,4,8),
		('b',5,5,8)

-----------------------------------------------------------------------------------------------------------------
-- error
begin try
	insert into [Exam].[course]([name]) values(14545) 
end try
begin catch
	select @@ERROR,ERROR_MESSAGE()
end catch

-----------------------------------------------------------------------------------------------------------------
---create tansaction
begin tran t1
	declare @r2 int, @r1 int
	update [Exam].[student] set Name='roqaia' where [st_id]=2
	save tran s1								
	update [Exam].[student] set Name='hassan' where [st_id]=3
save tran s2;
	update [Exam].[student] set Name='ali' where [st_id]=4
	set @r1=@@error                                 
	if @r1=0 
		begin
			commit tran
			select 'true'
		end
	else
		begin
			rollback tran s1		
			rollback tran s2	
			commit tran					
			select @r1
		end
------------------------------------------------------------------------------------------------
--make function to show student information
alter FUNCTION studentInfo (@Name nvarchar(50))
RETURNS table
AS
	RETURN 
	(
		
		SELECT s.[name] as student_name , s.[class] as student_class ,c.[name] as student_course
		FROM [Exam].[student] s , [Exam].[student_course] sc ,[Exam].[course] c
		where s.st_id=sc.st_id
		and c.co_id=sc.co_id
		and s.[name]=@Name
	)

SELECT * FROM studentInfo('roqaia')
---------------------------------------------------------------------------
--try if exists
if exists(select * FROM [Exam].[student] WHERE [st_id]=2)
begin
	update [Exam].[student]
	set [name]='sama'
	where [st_id]=2;
end
Else
	print 'Not Found';


-------------------------------------------------------------------------------------------------------
--create trigger to not allow any one delete form q_pool table
create trigger trgDeleteQ_pool
on  [Exam].[q_pool]
instead of delete
as 
begin
	print 'You can not delete from this table'
end

delete from [Exam].[q_pool]
where [qu_id]=1

drop trigger trgDeleteQ_pool
------------------------------------------------------------------------------------------------
select [name]
from [Exam].[course]
where [max_deg] =100

--------------------------------------------------------------------------------------
select max([max_deg]) as max_deggreCourse,min([max_deg]) as main_deggreCourse
from [Exam].[course]

----------------------------------------------------------------------------

select *  
from [Exam].[student]
where name like '%a%'

-------------------------------------------------
select * from [Exam].[course]
where [name] in ('english','arabic','math')

---------------------------------------------------------------------
select [co_id],[name],[max_deg]
from [Exam].[course]
where  [max_deg] >50 and [max_deg]<150

------------------------------------
select [co_id],[name],[max_deg]
from [Exam].[course]
where  [max_deg] between 100 and 200
------------------------------------------------------------------
select * from [Exam].[st_answer]
order by [result]

---------------------------------------------------------
select AVG([max_deg])
from [Exam].[course]

---------------------------------------------