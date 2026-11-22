WITH MaxDate AS (
    SELECT MAX(InvoiceDate) AS LatestDate
    FROM dbo.cleaned_retail_data
),
RFM AS (
    SELECT
        d.CustomerID,
        DATEDIFF(
            DAY,
            MAX(d.InvoiceDate),
            DATEADD(DAY, 1, m.LatestDate)
        ) AS Recency,
        COUNT(DISTINCT d.InvoiceNo) AS Frequency,
        SUM(d.Revenue) AS Monetary
    FROM dbo.cleaned_retail_data d
    CROSS JOIN MaxDate m
    GROUP BY d.CustomerID, m.LatestDate
),
RFM_Scores AS (
    SELECT *,
        6 - NTILE(5) OVER (ORDER BY Recency ASC) AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(5) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM RFM
)
SELECT *,
    CASE
        WHEN R_Score >= 4 AND F_Score >= 4
            THEN 'Champions'
        WHEN F_Score >= 4
            THEN 'Loyal Customers'
        WHEN R_Score >= 4 AND F_Score <= 2
            THEN 'New Customers'
        WHEN R_Score <= 2 AND F_Score >= 3
            THEN 'At Risk'
        WHEN R_Score <= 2 AND F_Score <= 2
            THEN 'Lost Customers'
        ELSE 'Potential Loyalists'
    END AS CustomerSegment
FROM RFM_Scores
ORDER BY Monetary DESC;