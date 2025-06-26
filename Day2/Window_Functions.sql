-- Window functions:

drop table if exists employees;
create table employees
(
    id      int identity start 1 increment 1,
    name    varchar(30),
    dept    varchar(10),
    salary  int 
);
insert into employees values(default, 'Blake', 'IT', 300),
(default, 'Jamie', 'IT', 300),
(default, 'Taylor', 'IT', 300),
(default, 'Chris', 'IT', 500),
(default, 'Jordan', 'IT', 500),
(default, 'Ali', 'IT', 700),
(default, 'Avery', 'ADMIN', 500),
(default, 'Maria', 'ADMIN', 600),
(default, 'Alice', 'ADMIN', 600),
(default, 'Logan', 'ADMIN', 600),
(default, 'Sam', 'HR', 400),
(default, 'Casey', 'HR', 500),
(default, 'Riley', 'HR', 500),
(default, 'Morgan', 'HR', 600);

select * from employees;

-- row_number()
-- rank()
-- dense_rank()
-- lead()
-- lag() -- if their salary was higher or lower than the prev emp in same dept


