-- Banking dataset tables:
SELECT * FROM products;
SELECT * FROM Employees;
SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Transactions;
SELECT * FROM Customer_Accounts;


--- SOLUTIONS ---

-- 1) Fetch the transaction id, date and amount of all debit transactions.

SELECT
    transaction_id
	,transaction_date
	,transaction_amount
FROM transactions
WHERE credit_debit_flag = 'D';

-- 2) Fetch male employees who earn more than 5000 salary.

SELECT * 
FROM employees 
WHERE gender = 'M' AND salary > 5000;

-- 3) Fetch employees whose name starts with J or whose salary is greater than or equal to 7000.

SELECT * 
FROM employees 
WHERE emp_name = 'J%' OR salary >= 7000;

-- 4) Fetch accounts with balance in between 1000 to 3000

SELECT * 
FROM accounts 
WHERE balance BETWEEN 1000 AND 3000;

-- second method
SELECT * 
FROM accounts 
WHERE balance >= 1000 AND balance <= 3000;

-- 5) Using SQL, find out if a given number is even or odd ? (Given numbers are 432, 77)

SELECT
    CASE
        WHEN 77 % 2 = 0 THEN 'Even'
        WHEN 432 % 2 = 0 THEN 'Even'
        ELSE 'Odd'
END AS even_odd_flag;

-- 6) Find customers who did not provide a phone no.

SELECT * 
FROM Customers 
WHERE phone_no IS NULL;

-- 7) Find all the different products purchased by the customers.

SELECT DISTINCT prod_id 
FROM Customer_Accounts

-- 8) Sort all the active accounts based on highest balance and based on the earliest opening date.

SELECT *
FROM Accounts
WHERE account_status = 'Active'
ORDER BY balance DESC, date_of_opening;

--sample inserts to verify result:
INSERT INTO Accounts
VALUES (
        1100444107,
        3300,
        'Active',
        to_date('15-11-2022', 'dd-mm-yyyy')
);

INSERT INTO Accounts
VALUES (
        1100444108,
        3300,
        'Active',
        to_date('01-11-2022', 'dd-mm-yyyy')
);

-- 9) Fetch the oldest 5 transactions.

SELECT * 
FROM Transactions 
ORDER BY transaction_date 
LIMIT 5;

-- 10) Find customers who are either from Bangalore/Chennai and their phone number is available OR those who were born before 1990.

SELECT *
FROM Customers
WHERE (
	address IN ('Bangalore', 'Chennai')
	AND phone IS NOT NULL
) 
OR to_char(dob, 'yyyy') < '1990';

-- 11) Find total no of transactions in Feb 2023.

SELECT count(1)
FROM Transactions
WHERE to_char(transaction_date, 'Mon') = 'Feb'

-- 12) Find the total no of products purchased by customer "Satya Sharma".

SELECT count(1)
FROM Customer_Accounts ca
JOIN customers c 
ON c.customer_id = ca.customer_id
WHERE c.first_name || ' ' || c.last_name = 'Satya Sharma'

-- 13) Display the full names of all employees and customers.

SELECT emp_name
FROM Employees
UNION ALL
SELECT first_name || ' ' || last_name
FROM customers;

-- 14) Categorise accounts based on their balance.
-- [Below 1k is Low balance, between 1k to 2k is average balance, above 2k is high balance]

SELECT 
	*
	,CASE
        WHEN balance < 1000 THEN 'Low balance'
        WHEN balance BETWEEN 1000 AND 2000  THEN 'Average balance'
        ELSE 'High balance'
    END AS category
FROM accounts;

-- 15) Find the total balance of all savings account.

SELECT sum(a.balance) AS tot_balance
FROM accounts a
JOIN customer_accounts ca ON ca.account_no = a.account_no
JOIN products p ON p.prod_id = ca.prod_id
WHERE p.prod_name = 'Savings Account';

-- 16) Display the total account balance in all the current and savings account.

SELECT prod_name, SUM(balance) AS balance
FROM accounts a
JOIN customer_accounts ca ON ca.account_no = a.account_no
JOIN products p ON p.prod_id = ca.prod_id
WHERE p.prod_name IN ('Savings Account', 'Current Account')
GROUP BY prod_name;