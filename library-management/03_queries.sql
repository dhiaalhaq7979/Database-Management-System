-- Library Management System - queries
USE library_db;

-- ===================== CRUD =====================

-- CREATE: register a new member
INSERT INTO members (full_name, email, phone, member_type, joined_on)
VALUES ('Hira Saleem', 'hira.saleem@example.com', '0300-6666666', 'Student', '2026-11-01');

-- READ: all books with their category
SELECT b.book_id, b.title, c.name AS category, b.available_copies
FROM books b
LEFT JOIN categories c ON b.category_id = c.category_id
ORDER BY b.title;

-- UPDATE: a member changes their phone number
UPDATE members SET phone = '0311-7777777' WHERE email = 'hira.saleem@example.com';

-- DELETE: remove the member again (they have no loans, so the FK allows it)
DELETE FROM members WHERE email = 'hira.saleem@example.com';

-- ===================== JOINs =====================

-- Books with all their authors (many-to-many through book_authors)
SELECT b.title, GROUP_CONCAT(a.full_name ORDER BY a.full_name SEPARATOR ', ') AS authors
FROM books b
JOIN book_authors ba ON b.book_id = ba.book_id
JOIN authors a       ON ba.author_id = a.author_id
GROUP BY b.book_id, b.title
ORDER BY b.title;

-- Books that are currently borrowed (not yet returned) and who has them
SELECT m.full_name AS member, b.title, l.loan_date, l.due_date
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b   ON l.book_id = b.book_id
WHERE l.return_date IS NULL
ORDER BY l.due_date;

-- Members who have never borrowed a book (LEFT JOIN + IS NULL)
SELECT m.full_name, m.member_type
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
WHERE l.loan_id IS NULL;

-- ===================== GROUP BY / reports =====================

-- Number of loans per member
SELECT m.full_name, COUNT(l.loan_id) AS total_loans, SUM(l.fine_amount) AS total_fines
FROM members m
LEFT JOIN loans l ON m.member_id = l.member_id
GROUP BY m.member_id, m.full_name
ORDER BY total_loans DESC, m.full_name;

-- Most borrowed categories
SELECT c.name AS category, COUNT(l.loan_id) AS times_borrowed
FROM categories c
JOIN books b ON b.category_id = c.category_id
JOIN loans l ON l.book_id = b.book_id
GROUP BY c.category_id, c.name
ORDER BY times_borrowed DESC, c.name;

-- Overdue loans on a given day (here: 2026-10-20)
SELECT m.full_name, b.title, l.due_date, DATEDIFF('2026-10-20', l.due_date) AS days_late
FROM loans l
JOIN members m ON l.member_id = m.member_id
JOIN books b   ON l.book_id = b.book_id
WHERE l.return_date IS NULL AND l.due_date < '2026-10-20'
ORDER BY days_late DESC;

-- Members whose total fines are above 0 (HAVING filters groups)
SELECT m.full_name, SUM(l.fine_amount) AS total_fines
FROM members m
JOIN loans l ON m.member_id = l.member_id
GROUP BY m.member_id, m.full_name
HAVING SUM(l.fine_amount) > 0;

-- Books borrowed more often than the average book (subquery)
SELECT b.title, COUNT(l.loan_id) AS loans
FROM books b
JOIN loans l ON l.book_id = b.book_id
GROUP BY b.book_id, b.title
HAVING COUNT(l.loan_id) > (
    SELECT AVG(cnt) FROM (SELECT COUNT(*) AS cnt FROM loans GROUP BY book_id) AS per_book
);
