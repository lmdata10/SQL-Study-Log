-- Basic SQL Queries
-- A quick walkthrough of common data retrieval use cases.

-- 1. Fetch debit transactions
SELECT transaction_id, transaction_date, transaction_amount
FROM transactions
WHERE credit_debit_flag = 'D';

-- 2. Male employees with salary > 5000
SELECT *
FROM employees
WHERE gender = 'M' AND salary > 5000;

-- 3. Name starts with J OR salary ≥ 7000
SELECT *
FROM employees
WHERE emp_name LIKE 'J%' OR salary >= 7000;

-- 4. Accounts with balance 1000–3000
SELECT *
FROM accounts
WHERE balance BETWEEN 1000 AND 3000;

-- 5. Check if number is even or odd
SELECT CASE WHEN 432 % 2 = 0 THEN 'Even' ELSE 'Odd' END AS result;

-- 6. Customers with missing phone number
SELECT *
FROM customers
WHERE phone IS NULL;

-- 7. Distinct products purchased
SELECT DISTINCT prod_id
FROM customer_accounts;

-- 8. Active accounts sorted by balance + date
SELECT *
FROM accounts
WHERE account_status='Active'
ORDER BY balance DESC, date_of_opening ASC;

-- 9. Oldest 5 transactions
SELECT *
FROM transactions
ORDER BY transaction_date ASC
LIMIT 5;

-- 10. Customers from Bangalore/Chennai with phone OR DOB < 1990
SELECT *
FROM customers
WHERE (
    (address IN ('Bangalore', 'Chennai') AND phone IS NOT NULL)
    OR EXTRACT(YEAR FROM dob) < 1990
);

-- 11. Count transactions in Nov 2024
SELECT COUNT(*)
FROM transactions
WHERE TO_CHAR(transaction_date, 'YYYY-MM') = '2024-11';

-- 12. Total products purchased by "Satya Sharma"
SELECT COUNT(*)
FROM customers c
JOIN customer_accounts ca ON c.customer_id = ca.customer_id
WHERE CONCAT(first_name, ' ', last_name) = 'Satya Sharma';

-- 13. Full names of employees and customers
SELECT emp_name FROM employees
UNION ALL
SELECT CONCAT(first_name, ' ', last_name) FROM customers;
