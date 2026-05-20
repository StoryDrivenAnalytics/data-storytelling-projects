CREATE DATABASE churn_analysis;
USE DATABASE churn_analysis;
create table customer_churn(customerID varchar(255) primary key,gender varchar(50),SeniorCitizen int,partner varchar(50),Dependents varchar(50),tenure int,PhoneService varchar(50),MultipleLines varchar(50),InternetService varchar(50),OnlineSecurity varchar(50),OnlineBackup varchar(50),DeviceProtection VARCHAR(50),TechSupport VARCHAR(50),StreamingTV VARCHAR(50),StreamingMovies VARCHAR(50),Contract VARCHAR(50),PaperlessBilling VARCHAR(50),PaymentMethod VARCHAR(50),MonthlyCharges DECIMAL(10,2),TotalCharges VARCHAR(50),Churn VARCHAR(50));
 LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/WA_Fn-UseC_-Telco-Customer-Churn.csv'
       INTO TABLE customer_churn
       FIELDS TERMINATED BY ','
       ENCLOSED BY '"'
       LINES TERMINATED BY '\n'
       IGNORE 1 ROWS;
       