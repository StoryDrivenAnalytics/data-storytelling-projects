# Customer Churn Analysis Case Study

## Executive Summary
Customer retention is one of the primary drivers of long-term profitability for subscription-based telecommunication companies. This project explores customer churn patterns using a Telco Customer Churn dataset containing information on 7,043 customers. 

By conducting a comprehensive analysis using **SQL** for data cleaning/analysis and **Power BI** for visual reporting, we identified critical churn drivers—specifically contract types, internet service technology, and support add-ons—and translated them into actionable business recommendations.

**Key Findings:**
*   **Overall Churn Rate:** **26.54%** of the customer base has churned.
*   **Revenue Impact:** Churned customers account for **$139,130.85** in lost monthly recurring revenue (MRR).
*   **Primary Driver:** Customers on **Month-to-Month contracts** exhibit a **42.71%** churn rate, representing **88.6%** of all churned customers.
*   **Service Risks:** **Fiber Optic** users churn at **41.89%**, indicating possible pricing or service-reliability pain points.

---

## Project Structure
```text
customer_churn_analysis/
├── data/
│   ├── raw/                  # Original unprocessed dataset
│   └── processed/            # Cleaned data exported for visualization
├── sql/
│   ├── 01_database_setup.sql # Database & schema instantiation
│   ├── 02_data_cleaning.sql  # Data standardisation & missing value handling
│   └── 03_exploratory_data_analysis.sql # SQL queries answering key business questions
└── powerbi/
    ├── churn analysis.pbix   # Power BI desktop workspace
    └── Screenshots/          # Visual representations of the dashboards
```

---

## Data Pipeline & Technical Workflow

### 1. Database Setup & Loading
Raw data was loaded into a MySQL database. A clean schema was established defining strict data types (e.g. converting `TotalCharges` from text to decimals and setting primary keys).
*   *SQL Script:* [`01_database_setup.sql`](./sql/01_database_setup.sql)

### 2. Data Cleaning & Standardisation
To prepare the dataset for analysis and dashboarding, several cleaning steps were completed in SQL:
*   Identified and investigated missing values in `TotalCharges`.
*   Standardized redundant strings. Columns containing value "No internet service" (such as `OnlineSecurity`, `TechSupport`, `OnlineBackup`) were unified to **"No"** to simplify the logical queries.
*   *SQL Script:* [`02_data_cleaning.sql`](./sql/02_data_cleaning.sql)

### 3. Exploratory Data Analysis (EDA)
Using aggregate SQL queries, we evaluated churn rates across multiple dimensions.
*   *SQL Script:* [`03_exploratory_data_analysis.sql`](./sql/03_exploratory_data_analysis.sql)

---

## Power BI Dashboards
Interactive dashboards were designed to visualize churn patterns, allowing executive stakeholders to slice data by demographics, billing characteristics, and subscribed services.

### Dashboard 1: Executive Overview
*Shows high-level metrics, demographic distribution, contract splits, and revenue impact.*

![Executive Overview](./powerbi/Screenshot%202026-05-07%20162229.png)

### Dashboard 2: Services & Billing Analysis
*Highlights churn correlations with subscribed tech services and payment types.*

![Services Analysis](./powerbi/Screenshot%202026-05-07%20162514.png)

### Dashboard 3: Churn Driver Deep-Dive
*Tracks correlations between monthly charges, tenure brackets, and churn behaviors.*

![Churn Drivers](./powerbi/Screenshot%202026-05-07%20162555.png)

---

## Key Insights & Business Recommendations

### 1. High Churn in Month-to-Month Contracts
*   **Insight:** Month-to-month contracts have a **42.71%** churn rate, compared to **11.27%** for 1-year and **2.83%** for 2-year contracts. 
*   **Recommendation:** Implement an auto-migration campaign. Offer month-to-month customers a small, temporary discount (e.g., 5% off for 6 months) if they transition to a 1-year or 2-year contract. The locked-in lifetime value far outweighs the discount.

### 2. Fiber Optic Service Concern
*   **Insight:** Customers with Fiber Optic service churn at **41.89%**, whereas DSL users churn at only **18.96%**. 
*   **Recommendation:** This suggests either network instability or price sensitivity. Conduct a targeted customer satisfaction survey specifically for Fiber Optic subscribers. Ensure technical teams proactively check line quality in high-churn zip codes.

### 3. Support Add-Ons Increase Loyalty
*   **Insight:** Customers without **Tech Support** and **Online Security** features churn at **41.6%** and **41.7%** respectively. When these services are active, churn drops below **15%**.
*   **Recommendation:** Package tech support and security features as a "Safe & Secure Bundle". Promote this bundle at a heavily discounted price during onboarding to increase retention rates.

### 4. Billing & Auto-Pay Opportunities
*   **Insight:** Customers paying via **Electronic Check** churn at **45.29%**, compared to only **15-16%** for credit card or bank transfer auto-payments.
*   **Recommendation:** Incentivize autopay setups. Offer a one-time bill credit (e.g. $5 or $10) for customers who switch from manual Electronic Check to Auto-Pay via Credit Card or Direct Debit. 

---
*By addressing these critical points, the organization can target high-risk segments, preserve monthly revenue, and boost customer lifetime value*
