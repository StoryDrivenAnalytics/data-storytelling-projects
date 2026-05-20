#how many customers are in each churn category (Yes/No) and what percentage they represent out of total customers.
SELECT 
    Churn, 
    COUNT(*) AS total_customers,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM customer_churn), 2) AS percentage
FROM customer_churn
GROUP BY Churn;
#This query calculates the total customers, churned customers, and churn rate for each contract type, then ranks them from highest to lowest churn rate
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY Contract
ORDER BY churn_rate_percent DESC;
#This query calculates the churn rate percentage for each Internet service type and ranks them from highest to lowest churn.
SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY InternetService
ORDER BY churn_rate_percent DESC;
#This query groups customers by tenure range, calculates the churn rate for each group, and ranks them from highest to lowest churn.
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-1 Year'
        WHEN tenure <= 24 THEN '1-2 Years'
        WHEN tenure <= 48 THEN '2-4 Years'
        ELSE '4+ Years' 
    END AS tenure_group,
    COUNT(*) AS total_customers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY tenure_group
ORDER BY churn_rate_percent DESC;
#This query calculates the churn rate for each payment method and ranks them from highest to lowest churn.
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate_percent DESC;
#This query calculates total customers, churned customers, and churn rate for senior citizens vs non-senior customers.
SELECT 
    SeniorCitizen,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY SeniorCitizen;

This query calculates the churn rate for each combination of partner and dependents status, and ranks them from highest to lowest churn.
SELECT 
    Partner,
    Dependents,
    COUNT(*) AS total_customers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY Partner, Dependents
ORDER BY churn_rate_percent DESC;
#This query groups customers into monthly charge tiers, calculates the churn rate for each tier, and ranks them from highest to lowest churn.
SELECT 
    CASE 
        WHEN MonthlyCharges <= 30 THEN 'Low (0-30)'
        WHEN MonthlyCharges <= 70 THEN 'Medium (31-70)'
        WHEN MonthlyCharges <= 100 THEN 'High (71-100)'
        ELSE 'Premium (100+)' 
    END AS price_tier,
    COUNT(*) AS total_customers,
    ROUND((SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS churn_rate_percent
FROM customer_churn
GROUP BY price_tier
ORDER BY churn_rate_percent DESC;