
USE RetailAnalytics;
GO

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';


SELECT TOP 10 *
FROM dbo.cleaned_retail_data;


USE RetailAnalytics;
GO

-- Total transactions
SELECT COUNT(*) AS TotalTransactions
FROM dbo.cleaned_retail_data;

-- Unique customers
SELECT COUNT(DISTINCT CustomerID) AS TotalCustomers
FROM dbo.cleaned_retail_data;

-- Date range
SELECT
    MIN(InvoiceDate) AS FirstTransaction,
    MAX(InvoiceDate) AS LastTransaction
FROM dbo.cleaned_retail_data;

-- Preview records
SELECT TOP 10 *
FROM dbo.cleaned_retail_data;


--Which months generated the highest revenue?


SELECT TOP 10
    YEAR(InvoiceDate) AS SalesYear,
    MONTH(InvoiceDate) AS SalesMonth,
    ROUND(SUM(Revenue), 2) AS MonthlyRevenue
FROM dbo.cleaned_retail_data
GROUP BY
    YEAR(InvoiceDate),
    MONTH(InvoiceDate)
ORDER BY MonthlyRevenue DESC;

--What is the overall business performance?

SELECT
    ROUND(SUM(Revenue), 2) AS TotalRevenue,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    COUNT(DISTINCT CustomerID) AS TotalCustomers,
    ROUND(
        SUM(Revenue) / COUNT(DISTINCT InvoiceNo), 2
    ) AS AverageOrderValue
FROM dbo.cleaned_retail_data;

--Who are the most valuable customers?

SELECT TOP 10
    CustomerID,
    ROUND(SUM(Revenue), 2) AS TotalRevenue,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders
FROM dbo.cleaned_retail_data
GROUP BY CustomerID
ORDER BY TotalRevenue DESC;

--How many customers have purchased more than once?

WITH CustomerOrders AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo) AS OrderCount
    FROM dbo.cleaned_retail_data
    GROUP BY CustomerID
)
SELECT
    CASE
        WHEN OrderCount = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS CustomerType,
    COUNT(*) AS NumberOfCustomers,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (), 2
    ) AS CustomerPercentage
FROM CustomerOrders
GROUP BY
    CASE
        WHEN OrderCount = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;

--Which products generate the most revenue?

SELECT TOP 10
    StockCode,
    MAX(Description) AS ProductName,
    SUM(Quantity) AS TotalQuantitySold,
    ROUND(SUM(Revenue), 2) AS TotalRevenue
FROM dbo.cleaned_retail_data
GROUP BY StockCode
ORDER BY TotalRevenue DESC;

--Which countries contribute the most revenue?

SELECT
    Country,
    COUNT(DISTINCT CustomerID) AS TotalCustomers,
    COUNT(DISTINCT InvoiceNo) AS TotalOrders,
    ROUND(SUM(Revenue), 2) AS TotalRevenue
FROM dbo.cleaned_retail_data
GROUP BY Country
ORDER BY TotalRevenue DESC;

--How can we rank customers according to their spending?

WITH CustomerRevenue AS (
    SELECT
        CustomerID,
        SUM(Revenue) AS TotalRevenue
    FROM dbo.cleaned_retail_data
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    ROUND(TotalRevenue, 2) AS TotalRevenue,
    DENSE_RANK() OVER (
        ORDER BY TotalRevenue DESC
    ) AS CustomerRank
FROM CustomerRevenue
ORDER BY CustomerRank;

--What percentage of total revenue does each customer contribute?
WITH CustomerRevenue AS (
    SELECT
        CustomerID,
        SUM(Revenue) AS TotalRevenue
    FROM dbo.cleaned_retail_data
    GROUP BY CustomerID
)
SELECT
    CustomerID,
    ROUND(TotalRevenue, 2) AS TotalRevenue,
    ROUND(
        TotalRevenue * 100.0 /
        SUM(TotalRevenue) OVER (), 2
    ) AS RevenueContributionPercentage
FROM CustomerRevenue
ORDER BY TotalRevenue DESC;