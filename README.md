# BankSphere - Retail Banking SQL & Google Sheets Analytics

A retail banking analytics project built with SQL Server and Google Sheets, combining SQL-based analysis with simple business-focused visualizations. BankSphere simulates everyday banking operations across customers, accounts, transactions, loans, and branches.

The project combines **SQL-based data analysis** with **Google Sheets visualizations** to answer practical banking questions and present the results through simple business-focused charts.


## Project Overview

BankSphere models a small retail bank operating across 15 branches in India.
The SQL layer is used to create the database, manage the data, and answer practical banking questions such as customer verification, account analysis, transaction investigation, loan tracking, and branch-level reporting.
Google Sheets is then used to summarize selected metrics using pivot tables and visualize the results through charts.


## Schema

| Table | Description |
|---|---|
| Branches | 15 branches across Indian cities |
| Customers | 150 customers, with realistic incomplete KYC (some missing phone/Aadhaar) |
| Accounts | Savings/Current accounts, Active/Inactive status |
| Transactions | Deposits, withdrawals, transfers with Success/Failed/Pending status |
| Loans | Home/Personal/Car/Education loans with Active/Closed/Defaulted status |

Entity relationships:
```
Customers 1-* Accounts *-1 Branches
Accounts 1-* Transactions
Customers 1-* Loans
```
## 🛠️ Tools & Technologies
-SQL Server
-T-SQL
-SQL Server Management Studio (SSMS)
-Google Sheets
-Pivot Tables
-Data Visualization

## How to Run

1. Open SQL Server Management Studio (SSMS)
2. Run schema/BankSphere_Dataset.sql - creates the BankSphere database, all 5 tables, and loads sample data
3. Run queries/BankSphere_Queries.sql - all 30 queries, organized by scenario

## Query Categories

- Customer lookup and verification (by phone, by Aadhaar, incomplete KYC)
- Account overview (active/inactive, low balance, multiple accounts)
- Transaction investigation (failed transactions, pending escalations, large transactions)
- Loan and EMI overview (active loans, defaulted loans, loan totals by type)
- Branch-level insights (accounts per branch, total balance, failed transaction hotspots)
- Quick bank reports (branch ranking, monthly transaction trend, contact-gap detection)

## 📊 Analytics & Visualizations
The following banking questions were analyzed and visualized using Google Sheets.

### 1. How many accounts are Active vs Inactive?
<img width="255" height="244" alt="image" src="https://github.com/user-attachments/assets/fc09fefc-342e-4095-b622-a011a6488c3b" />

### 2. How many loans are Active, Closed, and Defaulted?
<img width="271" height="254" alt="image" src="https://github.com/user-attachments/assets/49c355e2-2e35-4f4c-85c8-33e694757218" />

### 3. Which account type has the most accounts?
<img width="257" height="278" alt="image" src="https://github.com/user-attachments/assets/83321e19-98ad-4438-9f35-0a93eead23b4" />

### 4. Which transaction type occurs most frequently?
<img width="319" height="286" alt="image" src="https://github.com/user-attachments/assets/6ae200f6-a35d-433f-b7c6-54bf7ce5f6c5" />

### 5. What is the distribution of transaction status?
<img width="314" height="281" alt="image" src="https://github.com/user-attachments/assets/ad59757e-82e1-45bb-98aa-ac544081da11" />

## 💡 Key Insights
- The majority of bank accounts are **Active (93.9%)**.
- **Active loans** make up the largest portion of the loan portfolio.
- **Savings accounts** are significantly more common than Current accounts.
- **Deposits** are the most frequently occurring transaction type.
- The majority of transactions (**89.8%**) were successful.

## Author

Priyank Dewashish
