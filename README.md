# BankSphere - Retail Banking SQL Queries

A SQL Server project simulating everyday retail banking operations - customer lookups, transaction checks, loan tracking, and branch-level reporting. Built to reflect real front-desk and back-office questions a bank actually deals with, not abstract syntax exercises.

## Project Overview

BankSphere models a small retail bank with customers, accounts, transactions, and loans across 15 branches. The queries answer questions a bank employee or analyst would genuinely ask - verifying a customer by phone number, checking why a deposit isn't showing, reviewing defaulted loans, or seeing which branch holds the most deposits.

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

## Sample Scenarios Solved

- How many accounts are Active vs Inactive?
- <img width="255" height="244" alt="image" src="https://github.com/user-attachments/assets/fc09fefc-342e-4095-b622-a011a6488c3b" />

- How many loans are Active, Closed, and Defaulted?
- <img width="271" height="254" alt="image" src="https://github.com/user-attachments/assets/49c355e2-2e35-4f4c-85c8-33e694757218" />

- Which account type has the most accounts?
- <img width="257" height="278" alt="image" src="https://github.com/user-attachments/assets/83321e19-98ad-4438-9f35-0a93eead23b4" />

- Which transaction type occurs most frequently?
- <img width="319" height="286" alt="image" src="https://github.com/user-attachments/assets/6ae200f6-a35d-433f-b7c6-54bf7ce5f6c5" />

- What is the distribution of transaction status?
- <img width="314" height="281" alt="image" src="https://github.com/user-attachments/assets/ad59757e-82e1-45bb-98aa-ac544081da11" />


## Tech Used

SQL Server (T-SQL), SQL Server Management Studio (SSMS)

## Author

Priyank Dewashish
