# Retail Sales Data Analysis Project
 ## Project Overview.
 
This project demonstrates an end-to-end retail sales data analysis workflow, simulating a real-world business scenario. It covers the full pipeline:

- Data Cleaning (Python) – Preparing raw datasets for analysis

- Data Modeling (SQL) – Designing a star schema for efficient querying

- Exploratory Data Analysis (SQL) – Answering key business questions

- Business Intelligence (Power BI) – Building interactive dashboards for insights

The goal is to showcase skills in data cleaning, SQL modeling, analytics, and visualization, while generating actionable insights for business decision-making.

 ## Project Objectives
- Clean and prepare raw retail datasets

- Build a relational database (star schema) for scalable analysis

- Analyze sales performance, customers, and products

- Visualize insights with Power BI dashboards

- Provide recommendations to optimize business strategy

 ## Data Cleaning (Python)
### Tools Used
- Pandas

- NumPy

### Key Steps
1. Data Inspection – Identified missing values, duplicates, and inconsistencies

2. Handling Missing Values – Filled missing emails, replaced missing discounts with 0

3. Removing Duplicates – Eliminated duplicate sales records

4. Standardizing Text – Cleaned inconsistent city names with .str.title()

5. Cleaning Numeric Fields – Removed currency symbols, converted to numeric types

6. Handling Invalid Data – Removed negative quantities, invalid ages, unrealistic stock values

7. Fixing Data Types – Converted dates to proper datetime format

8. Feature Engineering – Created a Revenue column (Revenue = Quantity × Unit Price)

9. Exporting Clean Data – Saved cleaned datasets for SQL analysis

### Output Files:

- stores_clean.csv

- products_clean.csv

- customers_clean.csv

- sales_clean.csv

- inventory_clean.csv

 ## Data Modeling (SQL)
### Database Design
A star schema was implemented:

- Fact Table

 - Fact_Sales → Transactional sales data

- Dimension Tables

 - Dim_Stores

 - Dim_Products

 - Dim_Customers

 - Dim_Date

 - Dim_Inventory

### Relationships
- Foreign keys link sales to stores, products, customers, and dates

 - Enables efficient queries and trend analysis

### Date Dimension
- Created using recursive SQL queries

- Supports year, month, and trend reporting

### Data Validation
- Compared recorded vs calculated revenue

- Ensured accuracy and consistency across datasets

 ## Exploratory Data Analysis (SQL)
### Sales Performance
- Trends Over Time – Monthly revenue patterns

- Top Stores – Ranked by revenue

- Regional Performance – Compared revenue across regions

### Product Insights
- Category Contribution – Top-performing product categories

- Supplier Performance – Supplier impact on revenue

- Profitability Analysis – High-margin products identified

### Customer Insights
- Top Customers – High-value contributors

- Loyalty Program Impact – Loyalty vs non-loyalty revenue

- Acquisition Trends – New customers tracked over time

- Revenue by Age Group – Spending behavior by demographics

 ## Power BI Dashboards
To make insights executive-ready, interactive dashboards were built in Power BI:

### 1. Store Performance Dashboard
- KPIs: Total Stores, Top Store Revenue, Avg Revenue per Store

- Map: Revenue by City

- Bar Charts: Revenue by Region, Top 10 Stores

- Table: Store-level revenue, profit, employees

### 2. Product Performance Dashboard
- KPIs: Top Category Revenue, Top Supplier Revenue, Avg Profit Margin

- Pie Chart: Revenue by Category

- Bar Chart: Revenue by Supplier

- Scatter Plot: Revenue vs Profit by Product

- Table: Product-level profitability

### 3. Customer Performance Dashboard
- KPIs: Total Customers, New Customers, Loyalty Revenue, Avg Revenue per Customer

- Pie Chart: Revenue by Gender

- Bar Chart: Revenue by Age Group

- Line Chart: Customer Acquisition Trend

- Loyalty Impact Analysis

 ## Key Business Insights
1. Revenue Concentration – Few stores/customers drive majority of revenue → Targeted retention strategies

2. Top Products Drive Sales – Certain categories dominate → Prioritize stock & supplier relationships

3. High-Value Customers Matter Most – Loyalty programs & personalized offers are crucial

4. Loyalty Program Effectiveness – Loyalty members generate significantly higher revenue

5. Regional Differences – Expansion decisions guided by regional performance

6. Profitability ≠ Sales Volume – Focus on margin optimization, not just revenue

7. Customer Demographics Impact Sales – Age groups influence spending → Targeted marketing
