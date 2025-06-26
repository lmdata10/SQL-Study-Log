
-- Interview problem 1
/* Find the date with the highest total energy consumption from the Meta/Facebook 
data centers.
Output the date along with the total energy consumption across all data centers.
If there are multiple days with same highest energy consumption then display both dates.
*/

select *
from fb_eu_energy;
select *
from fb_asia_energy;
select *
from fb_na_energy;

drop table if exists fb_eu_energy;
create table fb_eu_energy
(
	date date,
	consumption int
);

drop table if exists fb_asia_energy;
create table fb_asia_energy
(
	date date,
	consumption int
);

drop table if exists fb_na_energy;
create table fb_na_energy
(
	date date,
	consumption int
);

insert into fb_eu_energy
values
	('2020-01-01', 400);
insert into fb_eu_energy
values
	('2020-01-02', 350);
insert into fb_eu_energy
values
	('2020-01-03', 500);
insert into fb_eu_energy
values
	('2020-01-04', 500);
insert into fb_eu_energy
values
	('2020-01-07', 600);

insert into fb_asia_energy
values
	('2020-01-01', 400);
insert into fb_asia_energy
values
	('2020-01-02', 400);
insert into fb_asia_energy
values
	('2020-01-04', 675);
insert into fb_asia_energy
values
	('2020-01-05', 1200);
insert into fb_asia_energy
values
	('2020-01-06', 750);
insert into fb_asia_energy
values
	('2020-01-07', 400);

insert into fb_na_energy
values
	('2020-01-01', 250);
insert into fb_na_energy
values
	('2020-01-02', 375);
insert into fb_na_energy
values
	('2020-01-03', 600);
insert into fb_na_energy
values
	('2020-01-06', 500);
insert into fb_na_energy
values
	('2020-01-07', 250);



select *
from fb_eu_energy;
select *
from fb_asia_energy;
select *
from fb_na_energy;

with
	cte
	as
	(
							select *
			from fb_eu_energy
		union all
			select *
			from fb_asia_energy
		union all
			select *
			from fb_na_energy
	),
	cte_final
	as
	(
		select date, sum(consumption) as total_consumption
		, rank() over(order by sum(consumption) desc) as rnk
		from cte
		group by date
	)
select date, total_consumption
from cte_final
where rnk = 1;


with
	cte
	as
	(
							select *
			from fb_eu_energy
		union all
			select *
			from fb_asia_energy
		union all
			select *
			from fb_na_energy
	)
select date, total_consumption
from (
		select date, sum(consumption) as total_consumption
		, rank() over(order by sum(consumption) desc) as rnk
	from cte
	group by date) x
where rnk = 1;



-- Interview problem 2

-- From the students table, write a SQL query to interchange the adjacent student names.
-- Note: If there are no adjacent student then the student name should stay the same.

drop table students;
create table students
(
	id int primary key,
	student_name varchar(50) not null
);
insert into students
values
	(1, 'James'),
	(2, 'Michael'),
	(3, 'George'),
	(4, 'Stewart'),
	(5, 'Robin');

select *
from students;

-- LEAD(), LAG() window functions

select id
, case when id % 2 = 0 
			then lag(student_name,1) over(order by id) 
	   else lead(student_name,1,student_name) over(order by id)
  end as swapped_student_name
from students;




-- Interview problem 3

-- Write a SQL query to display numbers from 1 to 10 without using any inbuilt functions.

-- Recursive SQL

with recursive cte as
(
	select *
from -- base query -- This executes in the 1st iteration & executes just once.
	union / union all
select *
from cte join ... -- recursive part of the query -- This executes from the 
	where termincation  condition
-- 2nd iteration and can execute multiple times untill the termination condition is met
)
select *
from cte;



with recursive cte as
	(
		select 1 as num
union all
	select num + 1 as num
	from cte
	where num <= 9
	)
select *
from cte;

-- 1st Iteration
select 1 as num

-- 2nd Iteration
select num + 1 as num
from (select 1 as num) cte
where num < 10

-- 3rd Iteration
select num + 1 as num
from (select num + 1 as num
	from (select 1 as num) cte
	where num < 10) cte
where num < 10

-- 4th Iteration
select num + 1 as num
from (select num + 1 as num
	from (select num + 1 as num
		from (select 1 as num) cte
		where num < 10) cte
	where num < 10) cte
where num < 10

.
.
.
.
-- 11th Iteration
select num + 1 as num
from (select 10 as num) cte
where num < 10






-- Interview problem 4

-- 4) Find the hierarchy of employees under a given manager "Asha".

drop TABLE emp_details;
CREATE TABLE emp_details
(
	id int PRIMARY KEY,
	name varchar(100),
	manager_id int,
	salary int,
	designation varchar(100)
);
INSERT INTO emp_details
VALUES
	(1, 'Shripadh', NULL, 10000, 'CEO');
INSERT INTO emp_details
VALUES
	(2, 'Satya', 5, 1400, 'Software Engineer');
INSERT INTO emp_details
VALUES
	(3, 'Jia', 5, 500, 'Data Analyst');
INSERT INTO emp_details
VALUES
	(4, 'David', 5, 1800, 'Data Scientist');
INSERT INTO emp_details
VALUES
	(5, 'Michael', 7, 3000, 'Manager');
INSERT INTO emp_details
VALUES
	(6, 'Arvind', 7, 2400, 'Architect');
INSERT INTO emp_details
VALUES
	(7, 'Asha', 1, 4200, 'CTO');
INSERT INTO emp_details
VALUES
	(8, 'Maryam', 1, 3500, 'Manager');
INSERT INTO emp_details
VALUES
	(9, 'Reshma', 8, 2000, 'Business Analyst');
INSERT INTO emp_details
VALUES
	(10, 'Akshay', 8, 2500, 'Java Developer');


select *
from emp_details;
-- Find the hierarchy of employees under a given manager "Asha".

with recursive cte as
	(
		select id, name, designation, 1 as iteration
	from emp_details
	where name = 'Asha'
union all
	select e.id, e.name, e.designation, (iteration+1) as iteration
	from cte
		join emp_details e on cte.id = e.manager_id
	)
select *
from cte;


-- 1st Iteration
select id, name, designation, 1 as iteration
from emp_details
where name = 'Asha'

-- 2nd Iteration
select e.id, e.name, e.designation, (iteration+1) as iteration
from (select id, name, designation, 1 as iteration
	from emp_details
	where name = 'Asha') cte
	join emp_details e on cte.id = e.manager_id


-- 3rd Iteration
select e.id, e.name, e.designation, (iteration+1) as iteration
from (select e.id, e.name, e.designation, (iteration+1) as iteration
	from (select id, name, designation, 1 as iteration
		from emp_details
		where name = 'Asha') cte
		join emp_details e on cte.id = e.manager_id) cte
	join emp_details e on cte.id = e.manager_id


-- 4th Iteration
select e.id, e.name, e.designation, (iteration+1) as iteration
from (select e.id, e.name, e.designation, (iteration+1) as iteration
	from (select e.id, e.name, e.designation, (iteration+1) as iteration
		from (select id, name, designation, 1 as iteration
			from emp_details
			where name = 'Asha') cte
			join emp_details e on cte.id = e.manager_id) cte
		join emp_details e on cte.id = e.manager_id) cte
	join emp_details e on cte.id = e.manager_id







-- Interview problem 5

-- Acceptance Rate By Date
-- What is the overall friend acceptance rate by date? 
-- Your output should have the rate of acceptances by the date the request was sent. 
-- Order by the earliest date to latest.
-- Assume that each friend request starts by a user sending (i.e., user_id_sender) 
-- a friend request to another user (i.e., user_id_receiver) that's logged in 
-- the table with action = 'sent'. If the request is accepted, the table 
-- logs action = 'accepted'. If the request is not accepted, no record of 
-- action = 'accepted' is logged.

select *
from fb_friend_requests;

create table fb_friend_requests
(
	user_id_sender varchar(20),
	user_id_receiver varchar(20),
	date date,
	action varchar(20)
);
insert into fb_friend_requests
values
	('ad4943sdz', '948ksx123d', '2020-01-04', 'sent');
insert into fb_friend_requests
values
	('ad4943sdz', '948ksx123d', '2020-01-06', 'accepted');
insert into fb_friend_requests
values
	('dfdfxf9483', '9djjjd9283', '2020-01-04', 'sent');
insert into fb_friend_requests
values
	('dfdfxf9483', '9djjjd9283', '2020-01-15', 'accepted');
insert into fb_friend_requests
values
	('ffdfff4234234', 'lpjzjdi4949', '2020-01-06', 'sent');
insert into fb_friend_requests
values
	('fffkfld9499', '993lsldidif', '2020-01-06', 'sent');
insert into fb_friend_requests
values
	('fffkfld9499', '993lsldidif', '2020-01-10', 'accepted');
insert into fb_friend_requests
values
	('fg503kdsdd', 'ofp049dkd', '2020-01-04', 'sent');
insert into fb_friend_requests
values
	('fg503kdsdd', 'ofp049dkd', '2020-01-10', 'accepted');
insert into fb_friend_requests
values
	('hh643dfert', '847jfkf203', '2020-01-04', 'sent');
insert into fb_friend_requests
values
	('r4gfgf2344', '234ddr4545', '2020-01-06', 'sent');
insert into fb_friend_requests
values
	('r4gfgf2344', '234ddr4545', '2020-01-11', 'accepted');



select *
from fb_friend_requests;

-- 1) Find the total request sent for each day
-- 2) Find the total accepted request for that day
-- 3) calculate the rate of acceptance ==> total accpeted req / total request

-- 2) Find the total accepted request for that day
--select sent.user_id_sender, sent.user_id_receiver, sent.date
select sent.date , count(1) as tot_accepted_req
from fb_friend_requests sent
	join fb_friend_requests accepted
	on sent.user_id_sender = accepted.user_id_sender
		and sent.user_id_receiver = accepted.user_id_receiver
where sent.action = 'sent'
	and accepted.action = 'accepted'
group by sent.date;

-- 1) Find the total request sent for each day
select date, count(1) as tot_req
from fb_friend_requests
where action = 'sent'
group by date;


-- 3) calculate the rate of acceptance ==> total accpeted req / total request

with
	accepted_req
	as
	(
		select sent.date , count(1) as tot_accepted_req
		from fb_friend_requests sent
			join fb_friend_requests accepted
			on sent.user_id_sender = accepted.user_id_sender
				and sent.user_id_receiver = accepted.user_id_receiver
		where sent.action = 'sent'
			and accepted.action = 'accepted'
		group by sent.date
	),
	tot_request
	as
	(
		select date, count(1) as tot_req
		from fb_friend_requests
		where action = 'sent'
		group by date
	)
select t.date
, concat((round(a.tot_accepted_req::decimal/t.tot_req::decimal,2) * 100)
::int,'%') as rate_of_acceptance
from accepted_req a
join tot_request t on t.date=a.date
order by t.date	





