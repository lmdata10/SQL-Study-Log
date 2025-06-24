
-- Banking dataset tables:
select * from products;
select * from Employees;
select * from Customers;
select * from Accounts;
select * from Transactions;
select * from Customer_Accounts;


/*
Using the given Banking dataset, solve following problems:

1) Fetch the transaction id, date and amount of all debit transactions.
2) Fetch male employees who earn more than 5000 salary.
3) Fetch employees whose name starts with J or whose salary is greater than or equal to 70000.
4) Fetch accounts with balance in between 1000 to 3000
5) Using SQL, find out if a given number is even or odd ? (Given numbers are 432, 77)
6) Find customers who did not provide a phone no.
7) Find all the different products purchased by the customers.
8) Sort all the active accounts based on highest balance and based on the earliest opening date.
9) Fetch the oldest 5 transactions.
10) Find customers who are either from Bangalore/Chennai and their phone number is available OR those who were born before 1990.
11) Find total no of transactions in Feb 2023.
12) How total no of products purchased by customer "Satya Sharma".
13) Display the full names of all employees and customers.
14) Categorise accounts based on their balance.
[Below 1k is Low balance, between 1k to 2k is average balance, above 2k is high balance]
15) Find the total balance of all savings account.
16) Display the total account balance in all the current and savings account.
*/


--- SOLUTIONS ---

-- 1) Fetch the transaction id, date and amount of all debit transactions.

select transaction_id, transaction_date, transaction_amount
from Transactions
where credit_debit_flag = 'D';



-- 2) Fetch male employees who earn more than 5000 salary.

select *
from employees
where gender = 'M'
and salary > 5000;



-- 3) Fetch employees whose name starts with J or whose salary is greater than or equal to 70000.

select *
from employees
where emp_name like 'J%'
or salary >= 70000;



-- 4) Fetch accounts with balance in between 1000 to 3000

select *
from accounts
where balance between 1000 and 3000;

select *
from accounts
where balance >= 1000 and balance <= 3000;



-- 5) Using SQL, find out if a given number is even or odd ? (Given numbers are 432, 77)

select case when 77%2 = 0
				then 'Even'
			else 'Odd'
	   end even_odd_flag;

 

-- 6) Find customers who did not provide a phone no.

select * from Customers
where phone_no is null;



-- 7) Find all the different products purchased by the customers.

select distinct prod_id
from Customer_Accounts



-- 8) Sort all the active accounts based on highest balance and based on the earliest opening date.

select * from Accounts
where account_status='Active'
order by balance desc, date_of_opening;

--sample inserts to verify result:
insert into Accounts values (1100444107, 3300, 'Active', to_date('15-11-2022','dd-mm-yyyy'));
insert into Accounts values (1100444108, 3300, 'Active', to_date('01-11-2022','dd-mm-yyyy'));



-- 9) Fetch the oldest 5 transactions.

select * from Transactions 
order by transaction_date limit 5;



-- 10) Find customers who are either from Bangalore/Chennai and their phone number is available OR those who were born before 1990.

select * from Customers
where (address in ('Bangalore' , 'Chennai') and phone is not null)
or to_char(dob,'yyyy') < '1990';



-- 11) Find total no of transactions in Feb 2023.

select count(1) from Transactions 
where to_char(transaction_date,'Mon') = 'Feb'



-- 12) Find the total no of products purchased by customer "Satya Sharma".

select count(1) 
from Customer_Accounts ca 
join customers c on c.customer_id = ca.customer_id
where c.first_name||' '||c.last_name = 'Satya Sharma'



-- 13) Display the full names of all employees and customers.

select emp_name from Employees
union all 
select first_name||' '||last_name from customers;



-- 14) Categorise accounts based on their balance.
[Below 1k is Low balance, between 1k to 2k is average balance, above 2k is high balance]

select * 
, case when balance < 1000 then 'Low balance'
	   when balance between 1000 and 2000 then 'Average balance'
	   else 'High balance'
  end as category
from accounts;



-- 15) Find the total balance of all savings account.

select sum(a.balance) as tot_balance
from accounts a
join customer_accounts ca on ca.account_no=a.account_no
join products p on p.prod_id = ca.prod_id
where p.prod_name='Savings Account';



-- 16) Display the total account balance in all the current and savings account.

select prod_name, sum(balance) as balance
from accounts a
join customer_accounts ca on ca.account_no=a.account_no
join products p on p.prod_id = ca.prod_id
where p.prod_name in ('Savings Account', 'Current Account')
group by prod_name



