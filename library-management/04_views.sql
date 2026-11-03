-- Reusable views for the library reports
USE library_db;

CREATE OR REPLACE VIEW active_loans AS
SELECT l.loan_id, m.full_name AS member, b.title, l.loan_date, l.due_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b   ON l.book_id = b.book_id
WHERE l.return_date IS NULL;

CREATE OR REPLACE VIEW book_availability AS
SELECT b.title, b.total_copies, b.available_copies,
       b.total_copies - b.available_copies AS on_loan
FROM books b;

SELECT * FROM active_loans ORDER BY due_date;
SELECT * FROM book_availability ORDER BY on_loan DESC, title;
