**Session:** SQL Commands (DDL, DML, DCL, TCL DQL) + Basic SQL Queries

## **1. SQL Command Types with Examples**

---

### **✅ 1.1 DDL - Data Definition Language**

Commands that define or alter schema structures.

| **Command** | **Purpose**                       | **Example Query**                                                              |
| ----------- | --------------------------------- | ------------------------------------------------------------------------------ |
| CREATE      | Creates database objects          | `CREATE TABLE employees (id INT PRIMARY KEY, name VARCHAR(50), salary FLOAT);` |
| ALTER       | Modifies table structure          | `ALTER TABLE employees ADD gender CHAR(1);`                                    |
| DROP        | Deletes a table or database       | `DROP TABLE employees;`                                                        |
| TRUNCATE    | Removes all rows, keeps structure | `TRUNCATE TABLE employees;`                                                    |

> ⚠️ TRUNCATE is **faster** than DELETE but usually **cannot be rolled back**.

---

### **1.2 DML –** **Data Manipulation Language**

Used to manipulate data inside existing tables.

| Command | Purpose                     | **Example Query**                                                                                                                                                                                 |
| ------- | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| INSERT  | Adds new records            | `INSERT INTO employees (id, name, salary) VALUES (1, 'John Doe', 5000);`                                                                                                                          |
| UPDATE  | Modifies existing records   | `UPDATE employees SET salary = 5500 WHERE id = 1;`                                                                                                                                                |
| DELETE  | Deletes records             | `DELETE FROM employees WHERE id = 1;`                                                                                                                                                             |
| MERGE   | Merges data from two tables | `MERGE INTO employees e USING new_employees n ON (e.id = n.id) WHEN MATCHED THEN UPDATE SET e.salary = n.salary WHEN NOT MATCHED THEN INSERT (id, name, salary) VALUES (n.id, n.name, n.salary);` |


> 🧠 Always use WHERE with UPDATE and DELETE to avoid modifying all rows.

---

### **1.3 DCL –** **Data Control Language**

Used for access and permission management.

| **Command** | **Purpose**               | **Example Query**                             |
| ----------- | ------------------------- | --------------------------------------------- |
| GRANT       | Gives access to users     | `GRANT SELECT, INSERT ON employees TO user1;` |
| REVOKE      | Removes access from users | `REVOKE INSERT ON employees FROM user1;`      |

> 🔐 Always combine with **role-based access control (RBAC)** in production systems.

---

### **1.4 TCL – Transaction Control Language**

Used to manage the changes made by DML statements.

| **Command** | **Purpose**                         | **Example Query**                      |
| ----------- | ----------------------------------- | -------------------------------------- |
| BEGIN       | Starts a new transaction            | `BEGIN;`                               |
| COMMIT      | Saves all changes permanently       | `COMMIT;`                              |
| ROLLBACK    | Reverts to the last committed state | `ROLLBACK;`                            |
| SAVEPOINT   | Sets a point for partial rollback   | `SAVEPOINT sp1;`<br>`ROLLBACK TO sp1;` |

> 💡 Used especially in systems with **banking, finance, and inventory workflows** to ensure **atomicity**.

---

### **1.5 DQL – Data Query Language**

Primarily used to query data.

| **Command** | **Purpose**       | **Example Query**                                                        |
| ----------- | ----------------- | ------------------------------------------------------------------------ |
| SELECT      | Retrieves records | `SELECT id, name, salary`<br>`FROM employees `<br>`WHERE salary > 5000;` |

> 🧠 Most commonly used SQL command in **BI dashboards**, **ETL pipelines**, and **data analytics**.

---

> Tip
> - 🔁 Wrap complex multi-step DML operations inside BEGIN…COMMIT.
> - 📊 Leverage DQL for ad hoc reporting and exploratory data analysis.
> - 🔐 Secure data access with GRANT/REVOKE particularly in shared environments.

---
*Day 2 learning completed*