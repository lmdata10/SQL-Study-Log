
drop table if exists spring_fruits;
create table spring_fruits
(
    fruit   varchar(20)
);
insert into spring_fruits values('Apple');
insert into spring_fruits values('Cherries');
insert into spring_fruits values('Orange');

drop table if exists winter_fruits;
create table winter_fruits
(
    fruit   varchar(20)
);
insert into winter_fruits values('Orange');
insert into winter_fruits values('Strawberry');
insert into winter_fruits values('Apple');

drop table if exists summer_fruits;
create table summer_fruits
(
    fruit   varchar(20)
);
insert into summer_fruits values('Apple');
insert into summer_fruits values('Mango');
insert into summer_fruits values('Orange');


select * from summer_fruits;
select * from winter_fruits;
select * from spring_fruits;






-- SELF Join
drop table employee_master;
create table employee_master
(
    id          int,
    name        varchar(40),
    salary      int,
    manager_id  int
);

insert into employee_master values (1   ,'John Smith',  10000,  3);
insert into employee_master values (2   ,'Jane Anderson',   12000,  3);
insert into employee_master values (3   ,'Tom Lanon',   15000,  4);
insert into employee_master values (4   ,'Anne Connor', 20000,  null);
insert into employee_master values (5   ,'Jeremy York', 9000,   1);

select * from employee_master;

-- Write a query to display the employee name and their corresponding manager name.

select emp.name as employee, mng.name as manager
from employee_master emp
join employee_master mng on emp.manager_id = mng.id









