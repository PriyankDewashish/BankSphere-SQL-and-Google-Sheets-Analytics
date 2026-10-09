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

- A customer says their deposit isn't showing up - verify them by phone number, then check their recent transactions
- Which customers have defaulted loans and need recovery follow-up?
- Which branch is holding the most account balance?
- Which customers have an active loan but no phone number on file?
- Which payment or transaction type fails most often?

## Tech Used

SQL Server (T-SQL), SQL Server Management Studio (SSMS)

## Author

Priyank Dewashish
