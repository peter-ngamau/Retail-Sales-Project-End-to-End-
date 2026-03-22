--Sales Trends Over Time.
--Reveals revenue trends month by month.

SELECT d.[Year],
	d.Month_Name,
	SUM(f.Total_Amount) AS MonthlyRevenue
FROM [dbo].[Fact_Sales] AS f
JOIN [dbo].[Dim_Date] AS d
	ON CAST(CONVERT(VARCHAR(8),f.[Sales_Date],112) AS INT) = d.Date_id
GROUP BY d.Year, d.Month_Name
ORDER BY d.Year, d.Month_Name;

--Top Performing Stores.
-- Identifies which branches generate the most revenue.

SELECT s.Store_Name,
	s.City,
	s.Region,
	SUM(f.Total_Amount) AS StoreRevenue
FROM [dbo].[Fact_Sales] AS f
JOIN [dbo].[Dim_Stores] AS s
	ON f.Store_ID = s.Store_ID
GROUP BY s.Store_Name, s.City, s.Region
ORDER BY StoreRevenue DESC; 

--Category Contribution
-- Shows which product categories drive sales.

SELECT p.Category,
	SUM(f.Total_Amount) AS CategoryRevenue
FROM [dbo].[Fact_Sales] AS f
JOIN [dbo].[Dim_Products] AS p
	ON f.Product_ID = p.Product_ID
GROUP BY p.Category
ORDER BY CategoryRevenue DESC;


--Supplier Performance.
-- Useful for procurement and supplier negotiations.
SELECT p.Supplier,
	SUM(f.Total_Amount) AS SupplierRevenue
FROM [dbo].[Fact_Sales] AS f
JOIN [dbo].[Dim_Products] AS p
	ON f.Product_ID = p.Product_ID
GROUP BY p.Supplier
ORDER BY SupplierRevenue DESC;

--Profitability Analysis.
--Highlights high-margin products.

SELECT p.Product_Name,
	SUM((p.Selling_Price - p.Cost_Price) * f.Quantity) AS TotalProfit
FROM [dbo].[Fact_Sales] AS f
JOIN [dbo].[Dim_Products] AS p
	ON f.Product_ID = p.Product_ID
GROUP BY p.Product_Name
ORDER BY TotalProfit DESC;

--Regional Performance.
--Compares regions across years.
SELECT d.Year, 
	s.Region, 
	SUM(f.[Total_Amount]) AS RegionalRevenue
FROM Fact_Sales f
JOIN Dim_Stores s 
	ON f.Store_ID = s.Store_ID
JOIN Dim_Date d 
	ON CAST(CONVERT(VARCHAR(8), f.Sales_Date, 112) AS INT) = d.Date_ID
GROUP BY d.Year, s.Region
ORDER BY d.Year, RegionalRevenue DESC;

--Customer Analysis
--Top Customers by Revenue
--Identifies your most valuable customers.
SELECT c.Customer_ID,
	c.Email,
	SUM(f.[Total_Amount]) AS Revenue,
	COUNT(f.Transaction_ID) AS Transactions
FROM [dbo].[Fact_Sales] AS f
JOIN [dbo].[Dim_Customers] c
	ON f.Customer_ID= c.Customer_ID
GROUP BY c.Customer_ID, c.Email
ORDER BY Revenue DESC;

--Loyalty Program Impact
--Measures how loyalty members vs non-members contribute to revenue.
SELECT c.Loyalty_Status,
	SUM(f.[Total_Amount]) AS Revenue, 
	COUNT(f.[Transaction_ID]) AS Transactions
FROM Fact_Sales f
JOIN Dim_Customers c 
	ON f.Customer_ID = c.Customer_ID
GROUP BY c.Loyalty_Status
ORDER BY Revenue DESC;

--Customer Acquisition Trends
--Tracks how many new customers signed up each year.
SELECT YEAR(c.Signup_Date) AS SignupYear,
	COUNT(c.Customer_ID) AS NewCustomers
FROM Dim_Customers c
GROUP BY YEAR(c.Signup_Date)
ORDER BY SignupYear;

select * from [dbo].[Dim_Stores]

SELECT 
    CASE 
        WHEN c.Age < 25 THEN 'Under 25'
        WHEN c.Age BETWEEN 25 AND 40 THEN '25-40'
        WHEN c.Age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+' END AS AgeGroup,
    SUM(f.Total_Amount) AS Revenue
FROM Fact_Sales f
JOIN Dim_Customers c 
	ON f.Customer_ID = c.Customer_ID
GROUP BY 
    CASE 
        WHEN c.Age < 25 THEN 'Under 25'
        WHEN c.Age BETWEEN 25 AND 40 THEN '25-40'
        WHEN c.Age BETWEEN 41 AND 60 THEN '41-60'
        ELSE '60+' END
ORDER BY Revenue DESC;







SELECT 
	s.Region,
	SUM(f.Total_Amount) AS StoreRevenue
FROM [dbo].[Fact_Sales] AS f
JOIN [dbo].[Dim_Stores] AS s
	ON f.Store_ID = s.Store_ID
GROUP BY s.Region
ORDER BY StoreRevenue DESC;