-- DB Lab 04: COUNT, SUM, AVG, MIN, MAX with GROUP BY and HAVING
USE library_db;

SELECT COUNT(*) AS total_books, SUM(total_copies) AS total_copies, AVG(total_copies) AS avg_copies FROM books;
SELECT member_type, COUNT(*) AS members FROM members GROUP BY member_type;
SELECT MIN(loan_date) AS first_loan, MAX(loan_date) AS last_loan FROM loans;
SELECT member_id, COUNT(*) AS loans FROM loans GROUP BY member_id HAVING COUNT(*) >= 2;
