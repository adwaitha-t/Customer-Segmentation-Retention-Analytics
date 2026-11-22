# Customer-Segmentation-Retention-Analytics
An end-to-end e-commerce analytics project focused on understanding customer purchasing behaviour, identifying high-value customer segments, analysing retention patterns, and predicting repeat purchases using Python, SQL, Excel, and Machine Learning.
Project Overview

Customer retention and customer lifetime value are important factors in e-commerce business growth.

This project analyses historical online retail transactions to:

Understand customer purchasing patterns.

Identify high-value, loyal, and at-risk customers.

Segment customers using RFM analysis and K-Means clustering.

Analyse customer retention using cohort analysis.

Predict the likelihood of repeat purchases within a 90-day period.

Develop actionable business recommendations for improving customer engagement and retention.

Dataset: UCI Online Retail II
Domain: E-commerce / Retail Analytics

Note: This project uses a general online retail transaction dataset, not actual Myntra customer data. The analysis is intended as an e-commerce case study relevant to fashion and retail businesses.

Business Objectives

Identify the most valuable customers based on purchasing behaviour.

Understand repeat-purchase patterns and customer loyalty.

Identify customers who may be at risk of becoming inactive.

Analyse revenue contribution across customer segments.

Develop a predictive model for repeat-purchase behaviour.

Recommend targeted customer retention strategies.

Dataset Description

The project uses the UCI Online Retail II dataset, containing transaction records from an online retail business.

Original dataset features:

Invoice

StockCode

Description

Quantity

InvoiceDate

Price

Customer ID

Country

After combining the two sheets and cleaning the data:

Metric

Value

Cleaned transactions

779,425

Unique customers

5,878

Unique products

4,631

Total columns

9

Data Cleaning

Performed using Python and Pandas:

Combined transaction records from both years.

Removed duplicate records.

Handled missing customer IDs.

Removed cancelled transactions.

Excluded non-positive quantities and unit prices.

Converted transaction dates into datetime format.

Created a Revenue column using Quantity × Unit Price.

Technology Stack

Category

Tools

Programming

Python

Data Analysis

Pandas, NumPy

Visualization

Matplotlib, Seaborn

Database

Microsoft SQL Server

Spreadsheet Analysis

Microsoft Excel

Business Intelligence

Power BI

Machine Learning

Scikit-learn

Development

Jupyter Notebook, VS Code

Project Workflow

1. Exploratory Data Analysis (EDA)

Analysed sales performance, customer purchasing patterns, product performance, and geographical revenue distribution.

Key Business Metrics:

KPI

Result

Total Revenue

£17,374,804.27

Total Orders

36,969

Total Customers

5,878

Average Order Value

£469.98

Repeat Customer Rate

72.39%

2. RFM Customer Segmentation

Applied Recency, Frequency, and Monetary analysis to classify customers according to their purchasing behaviour.

Customer segments:

Champions

Loyal Customers

Potential Loyalists

New Customers

At Risk

Lost Customers

Key Findings:

Champions contributed approximately 68.97% of total revenue.

Champions and Loyal Customers together contributed approximately 85.22% of revenue.

Lost Customers represented approximately 25.96% of customers but contributed only 3.77% of revenue.

3. K-Means Clustering

Applied K-Means clustering to customer-level RFM features.

Applied log transformation to reduce skewness.

Standardized features using StandardScaler.

Evaluated cluster quality using the Elbow Method and Silhouette Score.

Selected four clusters for business interpretability.

Identified customer groups:

Inactive low-value customers.

Recent occasional buyers.

High-value frequent buyers.

Previously valuable, less-recent buyers.

4. Cohort Retention Analysis

Performed cohort analysis based on customers' first purchase month.

Identified customer acquisition cohorts.

Calculated monthly customer activity.

Generated cohort retention percentages.

Examined changes in repeat-purchase behaviour over time.

Key Finding: Average Month 1 retention was approximately 21.17%.

5. Repeat-Purchase Prediction

Developed machine learning models to estimate whether a customer would make another purchase within a 90-day prediction window.

Features used:

Recency

Frequency

Monetary Value

Average Order Value

Average Days Between Orders

Models implemented:

Logistic Regression

Random Forest Classifier

Model Evaluation:

Metric

Logistic Regression

Random Forest

Accuracy

74.1%

75.1%

Precision

59.0%

61.4%

Recall

78.7%

72.0%

F1 Score

67.4%

66.3%

ROC-AUC

0.824

0.824

Logistic Regression was selected as the primary model based on its higher recall and F1 score.

Validation note: These metrics come from a customer-level random train/test split. A separate later-period temporal validation is still recommended before using the model operationally.

6. SQL Business Analysis

Used Microsoft SQL Server to perform business analysis, including:

Overall sales and revenue analysis.

Monthly revenue trends.

Top 10 customers by revenue.

Repeat versus one-time customer analysis.

Top-performing products.

Country-wise revenue analysis.

Customer ranking using DENSE_RANK().

Customer revenue contribution.

RFM scoring and customer segmentation.

Revenue contribution by customer segment.

SQL concepts used: CTEs, aggregate functions, CASE statements, GROUP BY, window functions, NTILE(), DENSE_RANK(), and date functions.

7. Excel Dashboard

Developed an interactive Excel dashboard to monitor:

Total Revenue

Total Orders

Total Customers

Average Order Value

Repeat Customer Rate

Monthly Revenue Trends

Customer Segmentation

Top 10 Customers

Revenue by Country

Business Recommendations

Based on the analysis:

Retain Champions: Provide loyalty rewards and personalized offers to high-value customers.

Engage At-Risk Customers: Use targeted reactivation campaigns and personalized recommendations.

Convert New Customers: Encourage second purchases through follow-up offers.

Develop Potential Loyalists: Use relevant product recommendations and loyalty incentives.

Improve Retention: Use cohort insights to identify periods when customer engagement declines.
