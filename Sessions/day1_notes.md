# 📘 SQL Learning – Day 1

## **Introduction to SQL**

### **What is Data?**
- Raw facts and figures with no inherent meaning.
- Examples: numbers, text, dates, images.
- Becomes meaningful information when processed and organized.

### **What is a Database?**
- An organized collection of structured data.
- Stored electronically within a computer system.
- Enables efficient storage, retrieval, and management of data.

### **How is Data Stored in a Database?**
- Stored in **tables** (rows and columns).
- **Rows** = records/entities.
- **Columns** = attributes/fields.
- Related tables are linked using **relationships**.

### **What Database Are We Using?**
- **Relational Database Management System (RDBMS)**.
- Structured tables with predefined relationships.
- Examples: PostgreSQL, MySQL, SQL Server, Oracle.

  

### **What is SQL?**
- **Structured Query Language**.
- Standard language for managing relational databases.
- Used to **Create**, **Read**, **Update**, and **Delete** data (CRUD).

### **Why SQL?**
- Universal, standard language for databases.
- Easy to learn and widely adopted.
- Extremely powerful for data manipulation and analytics.

### **What is a Schema?**
- Logical structure that organizes the database.
- Contains tables, views, indexes, and relationships.
- Acts as the blueprint for database design.

### **Installing PostgreSQL**
- **Mac**: Use Homebrew or download from [postgresql.org](https://www.postgresql.org)
- **Windows**: Use graphical installer from [postgresql.org](https://www.postgresql.org)
- Follow the wizard and set a password for the default postgres user.

### **Installing PgAdmin**
- Download from [pgadmin.org](https://www.pgadmin.org) for all OS.
- GUI-based web interface for PostgreSQL.
- Supports database visualization, query execution, and user management.

### **Practice**

```sql
-- Create new database
CREATE DATABASE test_db;

-- Create new schema
CREATE SCHEMA test_schema;
```

---
## **What Are Databases?**

> “A software that organizes and stores your data correctly, allowing you to retrieve it in the format you need, whenever you need it.”

### **Key Uses of Databases**
1. **Data Storage**: Retains large volumes of data for easy access.
2. **Data Analysis**: Derive business insights and performance metrics.
3. **Record Keeping**: Maintain logs of transactions, users, inventories.
4. **Foundation for Web/Mobile Apps**: Enables dynamic content, user authentication, etc.

#### **CRUD Operations**
- **Create** – Add new records (e.g., register a user).
- **Retrieve** – Read or query data (e.g., login verification).
- **Update** – Modify existing records (e.g., change password).
- **Delete** – Remove data (e.g., delete account).

#### **Properties of an Ideal Database**
1. **Integrity** – Accuracy and consistency.
2. **Availability** – 24/7 uptime.
3. **Security** – Protect data from unauthorized access.
4. **Independence** – Supports multiple interfaces (web, mobile).
5. **Concurrency** – Handles many users simultaneously.

---
## **Types of Databases**

### **1. Relational Databases (SQL)**
- Tabular format with rows and columns.
- Uses SQL; most widely adopted.
- **Examples:** PostgreSQL, MySQL, SQL Server.
### **2. NoSQL Databases**
- Handles unstructured/semi-structured data (JSON, XML).
- **Example:** MongoDB.
### **3. Columnar Databases (Data Warehouses)**
- Stores data in columns.
- Optimized for analytics (OLAP).
- **Examples:** Redshift, BigQuery.
### **4. Graph Databases**
- Manages networks and relationships.
- **Examples:** Neo4j, Amazon Neptune.
### **5. Key-Value Databases**
- Simple, ultra-fast data retrieval.
- **Example:** Redis.
  
> 🔍 **No one-size-fits-all** – Choose based on use case.
---

## **🧾 Relational Database Concepts**

### **Key Terms**
- **Relation** = Table
- **Attribute** = Column
- **Tuple** = Row
- **Cardinality** = No. of rows
- **Degree** = No. of columns
- **Null** = Missing value
- **Domain** = Allowed values for an attribute

### **What is DBMS?**
- Software that manages the database.
- Facilitates user interaction, ensures integrity/security, handles storage.

**DBMS Responsibilities:**
- CRUD operations
- Data validation and constraints
- Transaction management (ACID)
- Backup and recovery
- User and access management

---
## **Keys in Databases**

| Key           | Meaning                                                             |
| :------------ | :------------------------------------------------------------------ |
| Super Key     | Any combination of columns that uniquely identifies a row.          |
| Candidate Key | A minimal Super Key; no redundant attributes.                       |
| Primary Key   | Chosen Candidate Key. Must be unique and NOT NULL.                  |
| Alternate Key | Candidate key not chosen as Primary.                                |
| Composite Key | Primary key formed by multiple columns.                             |
| Surrogate Key | Artificial column (e.g., ID) used when natural keys are unsuitable. |
| Foreign Key   | Primary Key of another table used to define relationships.          |

---
## **Cardinality of Relationships**

**1. One-to-One (1:1)**
- One record in A relates to one in B.
- _Example:_ Person ↔️ Driving License

**2. One-to-Many (1:N)**
- One record in A relates to many in B.
- _Example:_ Branch ↔️ Students

**3. Many-to-Many (M:N)**
- Many records in A relate to many in B.
- _Example:_ Students ↔️ Courses

> Uses a **junction table** to handle M:N relationships.

---
*Day 1 learning completed*