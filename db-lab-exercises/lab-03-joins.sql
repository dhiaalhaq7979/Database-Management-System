-- DB Lab 03: INNER, LEFT and self-comparison joins
USE library_db;

-- INNER JOIN: only books that have been borrowed at least once
SELECT DISTINCT b.title FROM books b INNER JOIN loans l ON b.book_id = l.book_id ORDER BY b.title;

-- LEFT JOIN: every category, even if no book in it was borrowed
SELECT c.name, COUNT(l.loan_id) AS loans
FROM categories c
LEFT JOIN books b ON b.category_id = c.category_id
LEFT JOIN loans l ON l.book_id = b.book_id
GROUP BY c.category_id, c.name ORDER BY c.name;

-- Pairs of members who borrowed the same book
SELECT DISTINCT b.title, m1.full_name AS member_1, m2.full_name AS member_2
FROM loans l1
JOIN loans l2   ON l1.book_id = l2.book_id AND l1.member_id < l2.member_id
JOIN members m1 ON l1.member_id = m1.member_id
JOIN members m2 ON l2.member_id = m2.member_id
JOIN books b    ON l1.book_id = b.book_id;
