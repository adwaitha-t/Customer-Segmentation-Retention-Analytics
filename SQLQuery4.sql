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
    GROUP BY
        d.CustomerID,
        m.LatestDate
)
SELECT *
FROM RFM
ORDER BY Monetary DESC;

