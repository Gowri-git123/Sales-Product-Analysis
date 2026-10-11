-- Create the Database
CREATE DATABASE SalesProductAnalysisDB;
USE SalesProductAnalysisDB;

-- Create Product table
CREATE TABLE Product
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    UnitPrice DECIMAL(10,2)
);

-- Insert product records
INSERT INTO Product
VALUES
(1, 'Laptop', 'Electronics', 55000),
(2, 'Smartphone', 'Electronics', 25000),
(3, 'Headphones', 'Accessories', 2500),
(4, 'Keyboard', 'Accessories', 1500),
(5, 'Mouse', 'Accessories', 800),
(6, 'Monitor', 'Electronics', 12000),
(7, 'Office Chair', 'Furniture', 8500),
(8, 'Desk', 'Furniture', 10000),
(9, 'Printer', 'Electronics', 15000),
(10, 'Webcam', 'Accessories', 3500);

SELECT * FROM Product;

-- Create Sales table
CREATE TABLE Sales
(
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    CustomerName VARCHAR(100),
    Region VARCHAR(50),

    FOREIGN KEY (ProductID)
        REFERENCES Product(ProductID)
);

-- Insert sales records
INSERT INTO Sales
VALUES
(1001, 1, 2, '2026-01-05', 'Arun', 'South'),
(1002, 2, 3, '2026-01-08', 'Priya', 'South'),
(1003, 3, 5, '2026-01-12', 'Rahul', 'North'),
(1004, 4, 4, '2026-01-15', 'Anjali', 'East'),
(1005, 5, 10, '2026-01-18', 'Vishnu', 'West'),
(1006, 6, 2, '2026-01-20', 'Meena', 'South'),
(1007, 7, 3, '2026-02-02', 'Sanjay', 'North'),
(1008, 8, 2, '2026-02-05', 'Divya', 'East'),
(1009, 9, 1, '2026-02-10', 'Karthik', 'West'),
(1010, 10, 4, '2026-02-15', 'Swetha', 'South'),
(1011, 1, 1, '2026-02-20', 'Ajay', 'North'),
(1012, 2, 2, '2026-02-25', 'Nisha', 'East'),
(1013, 3, 8, '2026-03-03', 'Manoj', 'West'),
(1014, 4, 6, '2026-03-07', 'Keerthi', 'South'),
(1015, 5, 12, '2026-03-12', 'Hari', 'North'),
(1016, 6, 3, '2026-03-18', 'Arun', 'East'),
(1017, 7, 2, '2026-03-22', 'Priya', 'West'),
(1018, 8, 3, '2026-03-25', 'Rahul', 'South'),
(1019, 9, 2, '2026-03-28', 'Anjali', 'North'),
(1020, 10, 5, '2026-03-30', 'Vishnu', 'East');

SELECT * FROM Sales

-- Calculate total quantity sold
SELECT SUM(Quantity) AS TotalQuantitySold
FROM Sales;

--  Count total sales transactions
SELECT COUNT(*) AS TotalSalesTransactions
FROM Sales;

-- Calculate sales amount for each transaction
SELECT
    Sales.SaleID,
    Product.ProductName,
    Sales.Quantity,
    Product.UnitPrice,
    Sales.Quantity * Product.UnitPrice AS SalesAmount
FROM Sales
INNER JOIN Product
ON Sales.ProductID = Product.ProductID;

-- Calculate total revenue
SELECT SUM(Sales.Quantity * Product.UnitPrice) AS TotalRevenue
FROM Sales
INNER JOIN Product
ON Sales.ProductID = Product.ProductID;

-- Calculate revenue by product
SELECT Product.ProductName,SUM(Sales.Quantity * Product.UnitPrice) AS TotalRevenue
FROM Sales
INNER JOIN Product
ON Sales.ProductID = Product.ProductID
GROUP BY Product.ProductName
ORDER BY TotalRevenue DESC;

-- Calculate revenue by category
SELECT Product.Category,SUM(Sales.Quantity * Product.UnitPrice) AS TotalRevenue
FROM Sales
INNER JOIN Product
ON Sales.ProductID = Product.ProductID
GROUP BY Product.Category
ORDER BY TotalRevenue DESC;

-- Calculate monthly revenue
SELECT MONTH(Sales.SaleDate) AS SaleMonth,SUM(Sales.Quantity * Product.UnitPrice) AS TotalRevenue
FROM Sales
INNER JOIN Product
ON Sales.ProductID = Product.ProductID
GROUP BY MONTH(Sales.SaleDate)
ORDER BY SaleMonth;

-- Calculate revenue by region
SELECT Sales.Region,SUM(Sales.Quantity * Product.UnitPrice) AS TotalRevenue
FROM Sales
INNER JOIN Product
ON Sales.ProductID = Product.ProductID
GROUP BY Sales.Region
ORDER BY TotalRevenue DESC;

-- Calculate quantity sold by product
SELECT Product.ProductName,SUM(Sales.Quantity) AS TotalQuantitySold
FROM Sales
INNER JOIN Product
ON Sales.ProductID = Product.ProductID
GROUP BY Product.ProductName
ORDER BY TotalQuantitySold DESC;

-- Find top 5 products by revenue
SELECT TOP 5 Product.ProductName,SUM(Sales.Quantity * Product.UnitPrice) AS TotalRevenue
FROM Sales
INNER JOIN Product
ON Sales.ProductID = Product.ProductID
GROUP BY Product.ProductName
ORDER BY TotalRevenue DESC;

