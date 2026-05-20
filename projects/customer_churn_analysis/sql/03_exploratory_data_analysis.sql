-- ====================================================================
-- PROJECT: Telco Customer Churn Analysis
-- PURPOSE: Exploratory Data Analysis (EDA) to identify key churn drivers
-- DATABASE: churn_analysis
-- ====================================================================

USE churn_analysis;

-- 1. OVERALL CHURN RATE
-- Objective: Understand the baseline percentage of customers who have churned.
SELECT 
    Churn, 
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn), 2) AS percentage
FROM customer_churn
GROUP BY Churn;


-- 2. CHURN BY DEMOGRAPHICS
-- Objective: Analyze if churn is higher among specific gender or senior citizens.
SELECT 
    gender,
    SeniorCitizen,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY gender, SeniorCitizen
ORDER BY SeniorCitizen DESC;


-- 3. CHURN BY TENURE BRACKET
-- Objective: Identify which tenure groups (new vs. long-term customers) are most likely to churn.
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-1 Year'
        WHEN tenure <= 24 THEN '1-2 Years'
        WHEN tenure <= 36 THEN '2-3 Years'
        WHEN tenure <= 48 THEN '3-4 Years'
        WHEN tenure <= 60 THEN '4-5 Years'
        ELSE 'More than 5 Years'
    END AS tenure_bracket,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY tenure_bracket
ORDER BY churn_rate DESC;


-- 4. CHURN BY CONTRACT TYPE
-- Objective: Determine the relationship between contract types and customer loyalty.
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY Contract
ORDER BY churn_rate DESC;


-- 5. CHURN BY INTERNET SERVICE TYPE
-- Objective: Evaluate if the type of internet connection is correlated with churn rates.
SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY InternetService
ORDER BY churn_rate DESC;


-- 6. CHURN BY PAYMENT METHOD
-- Objective: Identify whether certain payment methods are associated with higher churn.
SELECT 
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;


-- 7. CHURN BY PARTNER/DEPENDENTS STATUS
-- Objective: Assess correlation between household status and churn.
SELECT 
    Partner,
    Dependents,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY Partner, Dependents
ORDER BY churn_rate DESC;


-- 8. CHURN BY MONTHLY CHARGE TIERS
-- Objective: Identify whether pricing tiers influence churn.
SELECT 
    CASE 
        WHEN MonthlyCharges <= 30 THEN 'Low (0-30)'
        WHEN MonthlyCharges <= 70 THEN 'Medium (31-70)'
        WHEN MonthlyCharges <= 100 THEN 'High (71-100)'
        ELSE 'Premium (100+)'
    END AS price_tier,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY price_tier
ORDER BY churn_rate DESC;


-- 9. CHURN BY ADD-ON SERVICES
-- Objective: Understand if auxiliary services affect customer retention.
SELECT 
    OnlineSecurity,
    OnlineBackup,
    TechSupport,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY OnlineSecurity, OnlineBackup, TechSupport
ORDER BY churn_rate DESC;


-- 10. CHURN BY PAYMENT METHOD & BILLING
-- Objective: Explore if paperless billing or payment method type drives churn.
SELECT 
    PaymentMethod,
    PaperlessBilling,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate
FROM customer_churn
GROUP BY PaymentMethod, PaperlessBilling
ORDER BY churn_rate DESC;


-- 11. CHARGES ANALYSIS (ACTIVE VS. CHURNED)
-- Objective: Compare average charges for churned versus retained customers.
SELECT 
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(CAST(NULLIF(TotalCharges, '') AS DECIMAL(10,2))), 2) AS avg_total_charges,
    ROUND(MAX(MonthlyCharges), 2) AS max_monthly_charges
FROM customer_churn
GROUP BY Churn;


-- 12. REVENUE LOSS DUE TO CHURN
-- Objective: Quantify the monthly revenue lost from churned customers.
SELECT 
    SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) AS monthly_revenue_lost,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) * 100.0 / SUM(MonthlyCharges), 2) AS percent_revenue_lost
FROM customer_churn;
>>>>>>> 3e0e78ce53ea2876fe88f253bedb0f5b443aea16
