/* =============================================================
   BankSphere - Retail Banking Analytics Query Set
   SQL Project by Priyank Dewashish
   ============================================================= */


-- ================= A. CUSTOMER LOOKUP & VERIFICATION (support desk scenarios) =================

-- Q1. Find a customer by phone number (common front-desk lookup)

SELECT CustomerID, FirstName, LastName, Phone, City
FROM Customers
WHERE Phone = '9876543210';

-- Q2. Find a customer by Aadhaar number

SELECT CustomerID, FirstName, LastName, AadhaarNumber, City
FROM Customers
WHERE AadhaarNumber = '123456789012';

-- Q3. Customers with incomplete KYC (missing phone or Aadhaar)

SELECT CustomerID, FirstName, LastName, Phone, AadhaarNumber
FROM Customers
WHERE Phone IS NULL OR AadhaarNumber IS NULL;

-- Q4. All accounts held by one customer (after identifying them by phone)

SELECT a.AccountID, a.AccountType, a.Balance, a.Status, b.BranchName
FROM Accounts a
INNER JOIN Branches b ON a.BranchID = b.BranchID
INNER JOIN Customers c ON a.CustomerID = c.CustomerID
WHERE c.Phone = '9876543210';


-- ================= B. ACCOUNT OVERVIEW =================

-- Q5. All active accounts

SELECT AccountID, CustomerID, AccountType, Balance
FROM Accounts
WHERE Status = 'Active';

-- Q6. Accounts with low balance (below 1000) - flag for follow-up

SELECT AccountID, CustomerID, Balance
FROM Accounts
WHERE Balance < 1000
ORDER BY Balance ASC;

-- Q7. Customers holding more than one account

SELECT CustomerID, COUNT(*) AS NumberOfAccounts
FROM Accounts
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- Q8. Account details with customer name and branch

SELECT a.AccountID, c.FirstName, c.LastName, a.AccountType, a.Balance, b.BranchName
FROM Accounts a
INNER JOIN Customers c ON a.CustomerID = c.CustomerID
INNER JOIN Branches b ON a.BranchID = b.BranchID;

-- Q9. Inactive accounts (candidates for reactivation calls)

SELECT a.AccountID, c.FirstName, c.LastName, c.Phone, a.Balance
FROM Accounts a
INNER JOIN Customers c ON a.CustomerID = c.CustomerID
WHERE a.Status = 'Inactive';


-- ================= C. TRANSACTION INVESTIGATION =================

-- Q10. "My deposit isn't showing" - check a customer's recent transactions

SELECT t.TransactionID, t.TransactionType, t.Amount, t.TransactionDate, t.Status
FROM Transactions t
INNER JOIN Accounts a ON t.AccountID = a.AccountID
INNER JOIN Customers c ON a.CustomerID = c.CustomerID
WHERE c.Phone = '9876543210'
ORDER BY t.TransactionDate DESC;

-- Q11. Failed transactions - the likely cause of a customer complaint

SELECT t.TransactionID, t.AccountID, t.TransactionType, t.Amount, t.TransactionDate
FROM Transactions t
WHERE t.Status = 'Failed'
ORDER BY t.TransactionDate DESC;

-- Q12. Pending transactions older than 3 days - needs escalation

SELECT TransactionID, AccountID, Amount, TransactionDate
FROM Transactions
WHERE Status = 'Pending'
  AND DATEDIFF(DAY, TransactionDate, '2025-09-01') > 3;

-- Q13. Total successful deposits vs withdrawals

SELECT TransactionType, SUM(Amount) AS TotalAmount, COUNT(*) AS TransactionCount
FROM Transactions
WHERE Status = 'Success'
GROUP BY TransactionType;

-- Q14. All transactions on one account, most recent first

SELECT TransactionID, TransactionType, Amount, TransactionDate, Status
FROM Transactions
WHERE AccountID = 15
ORDER BY TransactionDate DESC;

-- Q15. Large transactions (above 50,000) - review for monitoring

SELECT t.TransactionID, c.FirstName, c.LastName, t.Amount, t.TransactionDate
FROM Transactions t
INNER JOIN Accounts a ON t.AccountID = a.AccountID
INNER JOIN Customers c ON a.CustomerID = c.CustomerID
WHERE t.Amount > 50000
ORDER BY t.Amount DESC;

-- Q16. Transaction success rate by type

SELECT TransactionType,
       COUNT(*) AS TotalTransactions,
       SUM(CASE WHEN Status = 'Success' THEN 1 ELSE 0 END) AS SuccessfulTransactions,
       ROUND(100.0 * SUM(CASE WHEN Status = 'Success' THEN 1 ELSE 0 END) / COUNT(*), 2) AS SuccessRatePercent
FROM Transactions
GROUP BY TransactionType;


-- ================= D. LOAN & EMI OVERVIEW =================

-- Q17. All loans held by a customer

SELECT l.LoanID, l.LoanType, l.LoanAmount, l.EMIAmount, l.Status
FROM Loans l
INNER JOIN Customers c ON l.CustomerID = c.CustomerID
WHERE c.Phone = '9876543210';

-- Q18. Active loans with their monthly EMI

SELECT c.FirstName, c.LastName, l.LoanType, l.LoanAmount, l.EMIAmount
FROM Loans l
INNER JOIN Customers c ON l.CustomerID = c.CustomerID
WHERE l.Status = 'Active';

-- Q19. Defaulted loans - needs recovery follow-up

SELECT c.FirstName, c.LastName, c.Phone, l.LoanType, l.LoanAmount
FROM Loans l
INNER JOIN Customers c ON l.CustomerID = c.CustomerID
WHERE l.Status = 'Defaulted';

-- Q20. Number of loans and total amount by loan type

SELECT LoanType, COUNT(*) AS TotalLoans, SUM(LoanAmount) AS TotalLoanAmount
FROM Loans
GROUP BY LoanType
ORDER BY TotalLoanAmount DESC;

-- Q21. Customers with more than one active loan

SELECT CustomerID, COUNT(*) AS ActiveLoanCount
FROM Loans
WHERE Status = 'Active'
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- Q22. Average loan amount by loan type

SELECT LoanType, ROUND(AVG(LoanAmount), 2) AS AverageLoanAmount
FROM Loans
GROUP BY LoanType;


-- ================= E. BRANCH-LEVEL INSIGHTS =================

-- Q23. Number of accounts handled by each branch

SELECT b.BranchName, b.City, COUNT(a.AccountID) AS TotalAccounts
FROM Branches b
LEFT JOIN Accounts a ON b.BranchID = a.BranchID
GROUP BY b.BranchName, b.City;

-- Q24. Total balance held at each branch

SELECT b.BranchName, SUM(a.Balance) AS TotalBalance
FROM Branches b
INNER JOIN Accounts a ON b.BranchID = a.BranchID
GROUP BY b.BranchName
ORDER BY TotalBalance DESC;

-- Q25. Branch with the highest number of failed transactions - possible system issue

SELECT b.BranchName, COUNT(t.TransactionID) AS FailedTransactionCount
FROM Transactions t
INNER JOIN Accounts a ON t.AccountID = a.AccountID
INNER JOIN Branches b ON a.BranchID = b.BranchID
WHERE t.Status = 'Failed'
GROUP BY b.BranchName
ORDER BY FailedTransactionCount DESC;


-- ================= F. QUICK BANK REPORTS =================

-- Q26. Rank branches by total account balance

WITH BranchBalance AS (
    SELECT b.BranchName, SUM(a.Balance) AS TotalBalance
    FROM Branches b
    INNER JOIN Accounts a ON b.BranchID = a.BranchID
    GROUP BY b.BranchName
)
SELECT BranchName, TotalBalance,
       RANK() OVER (ORDER BY TotalBalance DESC) AS BranchRank
FROM BranchBalance;

-- Q27. Monthly transaction volume trend

SELECT YEAR(TransactionDate) AS TxnYear, MONTH(TransactionDate) AS TxnMonth,
       COUNT(*) AS TransactionCount, SUM(Amount) AS TotalAmount
FROM Transactions
WHERE Status = 'Success'
GROUP BY YEAR(TransactionDate), MONTH(TransactionDate)
ORDER BY TxnYear, TxnMonth;

-- Q28. Customers with no contact details AND an active loan - highest-risk follow-up gap

SELECT c.CustomerID, c.FirstName, c.LastName, l.LoanType, l.LoanAmount
FROM Customers c
INNER JOIN Loans l ON c.CustomerID = l.CustomerID
WHERE c.Phone IS NULL
  AND l.Status = 'Active';

-- Q29. Best available contact detail per customer

SELECT FirstName, LastName,
       COALESCE(Phone, AadhaarNumber, 'No info available') AS ContactInfo
FROM Customers;

-- Q30. Overall bank snapshot - one summary query

SELECT
    (SELECT COUNT(*) FROM Customers) AS TotalCustomers,
    (SELECT COUNT(*) FROM Accounts WHERE Status = 'Active') AS ActiveAccounts,
    (SELECT SUM(Balance) FROM Accounts) AS TotalDeposits,
    (SELECT SUM(LoanAmount) FROM Loans WHERE Status = 'Active') AS TotalActiveLoanAmount,
    (SELECT COUNT(*) FROM Transactions WHERE Status = 'Failed') AS FailedTransactionCount;