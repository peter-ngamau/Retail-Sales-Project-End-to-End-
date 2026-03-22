--Create Database.
CREATE DATABASE RetailSalesDB;
GO 

USE RetailSalesDB;

--Create the tables
CREATE TABLE Dim_Stores(
	Store_ID INT PRIMARY KEY,	
	Store_Name VARCHAR(100),
	City VARCHAR(50),
	Region VARCHAR(50),
	Manager	VARCHAR(100),
	Opening_Date DATE,
	Store_Size INT,
	Employees INT
);

CREATE TABLE Dim_Products(
	 Product_ID INT PRIMARY KEY,
	 Product_Name VARCHAR(100),
	 Category VARCHAR(50),
	 Supplier VARCHAR(50),
	 Cost_Price DECIMAL(10,2), 
	 Selling_Price DECIMAL(10,2),
	 Launch_Date DATE
);

CREATE TABLE Dim_Customers(
	Customer_ID INT PRIMARY KEY,
	Gender VARCHAR(10),
	Age	INT,
	City VARCHAR(50),
	Loyalty_Status VARCHAR(50),
	Signup_Date	DATE,
	Email VARCHAR(50)
);

CREATE TABLE Fact_Sales(
	Transaction_ID INT PRIMARY KEY,
	Sales_Date DATE,	
	Store_ID INT,	
	Product_ID	INT,
	Customer_ID	INT,
	Quantity INT,
	Unit_Price	DECIMAL(10,2),
	Discount DECIMAL(10,2),
	Payment_Method VARCHAR(20),
	Sales_Rep VARCHAR(50),
	Total_Amount DECIMAL(10,2),

	FOREIGN KEY(Store_ID) REFERENCES Dim_Stores(Store_ID),
	FOREIGN KEY(Product_ID) REFERENCES Dim_Products(Product_ID),
	FOREIGN KEY(Customer_ID) REFERENCES Dim_Customers(Customer_ID)

);

CREATE TABLE Dim_Inventory(
	Inventory_ID INT PRIMARY KEY,
	Store_ID INT,
	Product_ID INT,
	Stock_Quantity INT,	
	Reorder_Level INT,
	Last_Restock_Date DATE,

	FOREIGN KEY(Store_ID) REFERENCES Dim_Stores(Store_ID),
	FOREIGN KEY(Product_ID) REFERENCES Dim_Products(Product_ID)
);

SELECT * FROM [dbo].[Dim_Stores];
SELECT * FROM [dbo].[Dim_Products];
SELECT * FROM [dbo].[Dim_Customers];
SELECT * FROM [dbo].[Dim_Inventory];
SELECT * FROM [dbo].[Fact_Sales];
SELECT  COUNT(DISTINCT Customer_ID) FROM [dbo].[Dim_Customers];


SELECT 
    f.[Transaction_ID],
    f.Product_ID,
    p.Product_Name,
    f.Quantity,
    p.Selling_Price,
    f.[Total_Amount],
    (f.Quantity * p.Selling_Price) AS CalculatedRevenue,
    (f.[Total_Amount] - (f.Quantity * p.Selling_Price)) AS Difference
FROM Fact_Sales f
JOIN Dim_Products p 
    ON f.Product_ID = p.Product_ID
WHERE ABS(f.[Total_Amount] - (f.Quantity * p.Selling_Price)) > 0.01
ORDER BY Difference DESC;

--Create Date Table for time intelligence analysis

CREATE TABLE Dim_Date (
	Date_id INT PRIMARY KEY,
	Full_Date DATE,
	Year INT,
	Quarter INT,
	Month INT,
	Month_Name VARCHAR(20), 
	Week INT,
	Day INT,
	Day_Name VARCHAR(20),
	);

--Populate with a range of dates

DECLARE @StartDate DATE, @EndDate DATE;

-- Get min and max sales dates
SELECT 
    @StartDate = MIN(Sales_Date),
    @EndDate = MAX(Sales_Date)
FROM Fact_Sales;

WITH Dates AS(
	SELECT @StartDate AS DateValue
	UNION ALL
	SELECT DATEADD(DAY, 1,DateValue) 
	FROM Dates
	WHERE DateValue <= @EndDate
)
INSERT INTO Dim_Date
SELECT 
	CAST(CONVERT(VARCHAR(8), DateValue, 112) AS INT) AS Date_id,
	DateValue,
	YEAR(DateValue),
	DATEPART(QUARTER, DateValue),
	MONTH(DateValue),
	DATENAME(MONTH, DateValue),
	DATEPART(WEEK, DateValue),
	DAY(DateValue),
	DATENAME(WEEKDAY, DateValue)
FROM Dates
OPTION (MAXRECURSION 0);


