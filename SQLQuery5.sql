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
SELECT
    CustomerID,
    Recency,
    Frequency,
    ROUND(Monetary, 2) AS Monetary,
    R_Score,
    F_Score,
    M_Score,
    CONCAT(R_Score, F_Score, M_Score) AS RFM_Score
FROM RFM_Scores
ORDER BY RFM_Score DESC;