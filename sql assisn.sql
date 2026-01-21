# Introduction to SQL and Advanced Functions

# Question 1 : Explain the fundamental differences between DDL, DML, and DQL
commands in SQL. Provide one example for each type of command.

# ans - DDL (Data Definition Language)
DDL commands are used to define or modify the structure (schema) of the database. Think of this as building the "blueprint" or the "container" where your data will live. These commands usually change the metadata of the database.
+1

Focus: Tables, indexes, and database schemas.

Auto-commit: Most DDL operations are "auto-committed," meaning they are saved permanently as soon as they are executed.

Example: CREATE TABLE

SQL

-- Creating a new table to store employee information
CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50)
);
 DML (Data Manipulation Language)
DML commands deal with the actual data stored inside the tables. Once the structure is defined by DDL, DML is used to add, change, or remove the records within that structure.

Focus: Rows/records within a table.

Transaction Control: These changes can often be "rolled back" (undone) if they haven't been committed yet.

Example: INSERT INTO

-- Adding a specific employee record into the table
INSERT INTO Employees (ID, Name, Department)
VALUES (1, 'Alice Johnson', 'Engineering');
 DQL (Data Query Language)
DQL is used exclusively for retrieving data from the database. It does not change the data or the structure; it simply allows you to view it based on specific criteria. While some categorizations group DQL under DML, it is often treated separately because its purpose is strictly "read-only."

Focus: Fetching and filtering data.

Impact: Has zero effect on the database state.

Example: SELECT

-- Fetching all names from the Employees table who work in Engineering
SELECT Name 
FROM Employees 
WHERE Department = 'Engineering';
# # Question 2 : What is the purpose of SQL constraints? Name and describe three common types
of constraints, providing a simple scenario where each would be useful.

# ans -
The primary purpose of SQL constraints is to enforce Data Integrity. They act as a set of rules applied to table columns to ensure that the data remains accurate, consistent, and reliable. If a user attempts to perform an action (like an INSERT or UPDATE) that violates a constraint, the database engine will reject the operation and return an error.

Three Common Types of SQL Constraints
1. PRIMARY KEY
The PRIMARY KEY constraint uniquely identifies each record in a table. It ensures that the column (or group of columns) contains unique values and cannot contain NULLs. A table can only have one primary key.

Scenario: In a Students table, the Student_ID would be the primary key. This ensures that no two students share the same ID and every student must have an ID to exist in the system.

2. FOREIGN KEY
A FOREIGN KEY is used to link two tables together. It is a field in one table that refers to the PRIMARY KEY in another table. This maintains Referential Integrity, ensuring you can’t have "orphaned" records.

Scenario: In an Orders table, a Customer_ID column would be a foreign key pointing to the Customer_ID in the Customers table. This prevents an order from being created for a customer who doesn't exist.

3. UNIQUE
The UNIQUE constraint ensures that all values in a column are distinct from one another. Unlike a primary key, a column with a UNIQUE constraint can accept one NULL value (in most SQL dialects), and you can have multiple unique constraints per table.

Scenario: In an Employees table, while Employee_ID is the primary key, the Email_Address column should be marked as UNIQUE. This ensures no two employees accidentally sign up with the same email, even if they have different IDs.

# Question 3 : Explain the difference between LIMIT and OFFSET clauses in SQL. How
would you use them together to retrieve the third page of results, assuming each page
has 10 records?

 # ans - 
 The Difference Between LIMIT and OFFSETLIMIT: Specifies the maximum number of rows to return. It controls the "size" of the result set.OFFSET: Specifies how many rows to skip before starting to return rows. It controls the "starting point."How to Retrieve the Third PageTo calculate the OFFSET for any given page, you can use this simple formula:$$\text{OFFSET} = (\text{Page Number} - 1) \times \text{Rows Per Page}$$For your specific scenario:Rows Per Page (LIMIT): 10Page Number: 3Calculation: $(3 - 1) \times 10 = 20$The SQL QuerySQLSELECT * FROM orders
ORDER BY order_date DESC
LIMIT 10 OFFSET 20;
What happens here:The database sorts the records (usually by a date or ID).The OFFSET 20 tells the database to skip the first 20 records (Pages 1 and 2).The LIMIT 10 tells the database to take the next 10 records (Page 3).

# Question 4 : What is a Common Table Expression (CTE) in SQL, and what are its main
benefits? Provide a simple SQL example demonstrating its usage.

# Ans-

A Common Table Expression (CTE) is a temporary, named result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement.

Think of it as a "virtual table" that only exists during the execution of a single query. It is defined using the WITH keyword at the very beginning of your SQL script.

Main Benefits of Using CTEs
Readability: CTEs allow you to break down long, complex queries into logical "building blocks." This prevents the "spaghetti code" effect common with deeply nested subqueries.

Reusability: You can reference the same CTE multiple times within the same query. This is much cleaner than copy-pasting the same subquery over and over.

Recursion: CTEs support Recursive Queries, which are essential for querying hierarchical data like organizational charts, family trees, or file systems—something standard subqueries cannot do.

Simplified Maintenance: If you need to change the logic of a calculation used in multiple places, you only have to update it once inside the CTE definition.

Simple SQL Example
Suppose we want to find employees who earn more than the average salary. Using a CTE makes this logic very clear:



-- Define the CTE
WITH AvgSalaryCTE AS (
    SELECT AVG(salary) as average_pay
    FROM employees
)

-- Use the CTE in the main query
SELECT e.employee_name, e.salary
FROM employees e, AvgSalaryCTE a
WHERE e.salary > a.average_pay;

# Question 5 : Describe the concept of SQL Normalization and its primary goals. Briefly
explain the first three normal forms (1NF, 2NF, 3NF)

# Ans:

SQL Normalization is a systematic process of organizing data in a database to reduce redundancy and improve data integrity. Essentially, it involves breaking down large, complex tables into smaller, related ones to ensure that each piece of data is stored in exactly one place.

Primary Goals of Normalization
Eliminate Redundancy: Prevents the same data from being stored in multiple locations, which saves storage space.

Prevent Data Anomalies:

Insertion Anomaly: Being unable to add data because some other related data is missing.

Update Anomaly: Changing data in one place but leaving "ghost" versions of the old data elsewhere.

Deletion Anomaly: Accidentally losing important information when deleting a seemingly unrelated record.

Improve Data Integrity: Ensures that data dependencies make sense and that the database remains consistent over time.

The First Three Normal Forms (1NF, 2NF, 3NF)
Normalization is progressive; to reach 2NF, a table must first satisfy 1NF, and so on.

a. First Normal Form (1NF): Atomicity
A table is in 1NF if every cell contains a single, indivisible (atomic) value.

Rule: No lists or multiple values in a single field (e.g., a "Skills" column shouldn't contain "SQL, Python, Java").

Rule: Each record must be unique (usually via a Primary Key).

b. Second Normal Form (2NF): Partial Dependency
A table is in 2NF if it is in 1NF and all non-key attributes are fully dependent on the entire primary key.

Rule: This specifically applies to tables with composite primary keys (keys made of two or more columns).

Goal: If a column only depends on part of the primary key, it must be moved to its own table. For example, in a "Course-Student" table, the "Course Name" shouldn't be there because it depends only on the Course ID, not the Student ID.

c. Third Normal Form (3NF): Transitive Dependency
A table is in 3NF if it is in 2NF and has no transitive dependencies.

Rule: Non-key columns should not depend on other non-key columns.

Goal: Data should depend on "the key, the whole key, and nothing but the key." If you have a "Zip Code" and a "City" in the same table, "City" depends on "Zip Code" (a non-key), not necessarily the "User ID" (the primary key). Therefore, "City" belongs in a separate table linked by the Zip Code.

# Question 6 : Create a database named ECommerceDB and perform the following
tasks:
1. Create the following tables with appropriate data types and constraints:
● Categories
○ CategoryID (INT, PRIMARY KEY)
○ CategoryName (VARCHAR(50), NOT NULL, UNIQUE)
● Products
○ ProductID (INT, PRIMARY KEY)
○ ProductName (VARCHAR(100), NOT NULL, UNIQUE)
○ CategoryID (INT, FOREIGN KEY → Categories)
○ Price (DECIMAL(10,2), NOT NULL)
○ StockQuantity (INT)
● Customers
○ CustomerID (INT, PRIMARY KEY)
○ CustomerName (VARCHAR(100), NOT NULL)
○ Email (VARCHAR(100), UNIQUE)
○ JoinDate (DATE)
● Orders
○ OrderID (INT, PRIMARY KEY)
○ CustomerID (INT, FOREIGN KEY → Customers)
○ OrderDate (DATE, NOT NULL)
○ TotalAmount (DECIMAL(10,2))
2. Insert the following records into each table
● Categories
CategoryID Category Name
1 Electronics
2 Books
3 Home Goods
4 Apparel
● Products
ProductID ProductName CategoryID Price StockQuantity
101 Laptop Pro 1 1200.00 50
102 SQL
Handbook
2 45.50 200
103 Smart Speaker 1 99.99 150
104 Coffee Maker 3 75.00 80
105 Novel : The
Great SQL
2 25.00 120
106 Wireless
Earbuds
1 150.00 100
107 Blender X 3 120.00 60
108 T-Shirt Casual 4 20.00 300
● Customers
CustomerID CustomerName Email Joining Date
1 Alice Wonderland alice@example.com 2023-01-10
2 Bob the Builder bob@example.com 2022-11-25
3 Charlie Chaplin charlie@example.com 2023-03-01
4 Diana Prince diana@example.com 2021-04-26
● Orders
OrderID CustomerID OrderDate TotalAmount
1001 1 2023-04-26 1245.50
1002 2 2023-10-12 99.99
1003 1 2023-07-01 145.00
1004 3 2023-01-14 150.00
1005 2 2023-09-24 120.00
1006 1 2023-06-19 20.00

# Ans

To set up your ECommerceDB, we will follow a logical order: first creating the database, then defining the tables (ensuring parent tables exist before child tables with foreign keys), and finally inserting the data.

-- Database and Table Creation


-- Create the Database
CREATE DATABASE ECommerceDB;
USE ECommerceDB;

-- Create Categories Table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL UNIQUE,
    CategoryID INT,
    Price DECIMAL(10,2) NOT NULL,
    StockQuantity INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
--- Data Insertion
Inserting Categories
SQL

INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Electronics'),
(2, 'Books'),
(3, 'Home Goods'),
(4, 'Apparel');
Inserting Products


INSERT INTO Products (ProductID, ProductName, CategoryID, Price, StockQuantity) VALUES
(101, 'Laptop Pro', 1, 1200.00, 50),
(102, 'SQL Handbook', 2, 45.50, 200),
(103, 'Smart Speaker', 1, 99.99, 150),
(104, 'Coffee Maker', 3, 75.00, 80),
(105, 'Novel: The Great SQL', 2, 25.00, 120),
(106, 'Wireless Earbuds', 1, 150.00, 100),
(107, 'Blender X', 3, 120.00, 60),
(108, 'T-Shirt Casual', 4, 20.00, 300);
Inserting Customers


INSERT INTO Customers (CustomerID, CustomerName, Email, JoinDate) VALUES
(1, 'Alice Wonderland', 'alice@example.com', '2023-01-10'),
(2, 'Bob the Builder', 'bob@example.com', '2022-11-25'),
(3, 'Charlie Chaplin', 'charlie@example.com', '2023-03-01'),
(4, 'Diana Prince', 'diana@example.com', '2021-04-26');
Inserting Orders


INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1001, 1, '2023-04-26', 1245.50),
(1002, 2, '2023-10-12', 99.99),
(1003, 1, '2023-07-01', 145.00),
(1004, 3, '2023-01-14', 150.00),
(1005, 2, '2023-09-24', 120.00),
(1006, 1, '2023-06-19', 20.00);
Verification
You can run the following command to ensure the data was inserted correctly:



SELECT * FROM Products;

# Question 7 : Generate a report showing CustomerName, Email, and the
TotalNumberofOrders for each customer. Include customers who have not placed
any orders, in which case their TotalNumberofOrders should be 0. Order the results
by CustomerName.

# Ans 

To generate this report, we need to combine the Customers table with the Orders table. Since we must include customers who have not placed any orders, a LEFT JOIN is the appropriate tool.A LEFT JOIN ensures that all records from the "left" table (Customers) are kept, even if there is no matching record in the "right" table (Orders).The SQL QuerySQLSELECT 
    c.CustomerName, 
    c.Email, 
    COUNT(o.OrderID) AS TotalNumberOfOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.Email
ORDER BY c.CustomerName;
Key Technical DetailsLEFT JOIN: This ensures that Diana Prince (who has no orders in our dataset) still appears in the list. If we used an INNER JOIN, she would be excluded.COUNT(o.OrderID): We count the OrderID from the Orders table rather than using COUNT(*). This is because COUNT(column_name) ignores NULL values. For customers with no orders, the OrderID will be NULL, resulting in a count of 0.GROUP BY: We must group by the non-aggregated columns (CustomerName, Email, and CustomerID) to allow the COUNT function to calculate the total per person.Expected ResultBased on the data inserted in the previous task, your report should look like this:CustomerNameEmailTotalNumberOfOrdersAlice Wonderlandalice@example.com3Bob the Builderbob@example.com2Charlie Chaplincharlie@example.com1Diana Princediana@example.com0

# Question 8 : Retrieve Product Information with Category: Write a SQL query to
display the ProductName, Price, StockQuantity, and CategoryName for all
products. Order the results by CategoryName and then ProductName alphabetically.

# Ans

To retrieve this information, you need to perform an INNER JOIN between the Products table and the Categories table. This allows you to replace the CategoryID (a number) with the actual CategoryName (text) from the related table.The SQL QuerySQLSELECT 
    p.ProductName, 
    p.Price, 
    p.StockQuantity, 
    c.CategoryName
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName ASC, p.ProductName ASC;
Why this query works:JOIN (or INNER JOIN): This matches each product to its corresponding category based on the CategoryID present in both tables.Aliasing (p and c): We use short aliases for the table names to make the query more readable and easier to type.Multi-Level Sorting: The ORDER BY clause first organizes the list by category. Within each category, it then sorts the products alphabetically, which is helpful for browsing a catalog.Expected ResultBased on your data, the results will look like this:ProductNamePriceStockQuantityCategoryNameNovel: The Great SQL25.00120BooksSQL Handbook45.50200BooksLaptop Pro1200.0050ElectronicsSmart Speaker99.99150ElectronicsWireless Earbuds150.00100ElectronicsBlender X120.0060Home GoodsCoffee Maker75.0080Home GoodsT-Shirt Casual20.00300Apparel


# Question 9 : Write a SQL query that uses a Common Table Expression (CTE) and a
Window Function (specifically ROW_NUMBER() or RANK()) to display the
CategoryName, ProductName, and Price for the top 2 most expensive products in
each CategoryName.

# Ans

To solve this, we use a CTE to first calculate the price rank of each product within its category, and then a main query to filter for the top two.A Window Function like DENSE_RANK() or ROW_NUMBER() is ideal here because it allows us to perform calculations across a set of table rows that are related to the current row (in this case, other products in the same category).The SQL QuerySQLWITH RankedProducts AS (
    SELECT 
        c.CategoryName, 
        p.ProductName, 
        p.Price,
        DENSE_RANK() OVER (PARTITION BY c.CategoryName ORDER BY p.Price DESC) as PriceRank
    FROM Products p
    JOIN Categories c ON p.CategoryID = c.CategoryID
)
SELECT CategoryName, ProductName, Price
FROM RankedProducts
WHERE PriceRank <= 2
ORDER BY CategoryName, Price DESC;
How it WorksThe CTE (RankedProducts):It joins the products and categories to get the names.PARTITION BY c.CategoryName: This "restarts" the ranking for every new category.ORDER BY p.Price DESC: This ensures the most expensive items get a rank of 1.DENSE_RANK(): I used DENSE_RANK instead of ROW_NUMBER because if two products have the exact same highest price, they will both be included in the "top 2."The Outer Query:Filters the results to only include rows where the PriceRank is 1 or 2.Expected ResultBased on your data, the report will look like this:CategoryNameProductNamePriceBooksSQL Handbook45.50BooksNovel: The Great SQL25.00ElectronicsLaptop Pro1200.00ElectronicsWireless Earbuds150.00Home GoodsBlender X120.00Home GoodsCoffee Maker75.00ApparelT-Shirt Casual20.00

# Question 10 : You are hired as a data analyst by Sakila Video Rentals, a global movie
rental company. The management team is looking to improve decision-making by
analyzing existing customer, rental, and inventory data.
Using the Sakila database, answer the following business questions to support key strategic
initiatives.
Tasks & Questions:
1. Identify the top 5 customers based on the total amount they’ve spent. Include customer
name, email, and total amount spent.
2. Which 3 movie categories have the highest rental counts? Display the category name
and number of times movies from that category were rented.
3. Calculate how many films are available at each store and how many of those have
never been rented.
4. Show the total revenue per month for the year 2023 to analyze business seasonality.
5. Identify customers who have rented more than 10 times in the last 6 months.

# Ans-
As a data analyst for Sakila Video Rentals, these queries will provide the management team with a clear picture of customer loyalty, inventory health, and seasonal trends.

Below are the SQL solutions for each business question.

1. Top 5 Customers by Spending
This helps the marketing team identify high-value customers for loyalty rewards.

SQL

SELECT 
    c.first_name, 
    c.last_name, 
    c.email, 
    SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;
2. Top 3 Movie Categories by Rental Count
This identifies which genres are most popular, assisting in future content acquisition.

SQL

SELECT 
    cat.name AS category_name, 
    COUNT(r.rental_id) AS rental_count
FROM category cat
JOIN film_category fc ON cat.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY cat.name
ORDER BY rental_count DESC
LIMIT 3;
3. Inventory vs. "Dead Stock" Analysis
This report shows total films per store and identifies items that are taking up shelf space without generating revenue.

SQL

SELECT 
    i.store_id,
    COUNT(i.inventory_id) AS total_films_available,
    COUNT(CASE WHEN r.rental_id IS NULL THEN 1 END) AS never_rented_count
FROM inventory i
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY i.store_id;
4. Monthly Revenue (2023 Seasonality)
Analyzing revenue trends helps the team prepare for peak periods or launch promotions during slow months.

SQL

SELECT 
    MONTHNAME(payment_date) AS month, 
    SUM(amount) AS total_revenue
FROM payment
WHERE YEAR(payment_date) = 2023
GROUP BY MONTH(payment_date), MONTHNAME(payment_date)
ORDER BY MONTH(payment_date);
5. High-Frequency Renters (Last 6 Months)
This identifies active users who have rented more than 10 times recently, useful for targeted engagement.

SQL

SELECT 
    c.first_name, 
    c.last_name, 
    c.email, 
    COUNT(r.rental_id) AS rental_count
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_date >= DATE_SUB('2026-01-21', INTERVAL 6 MONTH)
GROUP BY c.customer_id
HAVING rental_count > 10
ORDER BY rental_count DESC;