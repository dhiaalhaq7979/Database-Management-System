-- DB Lab 05: subqueries (IN, NOT IN, EXISTS, scalar)
USE library_db;

-- members who borrowed a Databases book
SELECT full_name FROM members WHERE member_id IN (
    SELECT l.member_id FROM loans l JOIN books b ON l.book_id = b.book_id
    JOIN categories c ON b.category_id = c.category_id WHERE c.name = 'Databases');

-- books never borrowed
SELECT title FROM books WHERE book_id NOT IN (SELECT book_id FROM loans);

-- members with at least one loan still open (EXISTS)
SELECT full_name FROM members m WHERE EXISTS (
    SELECT 1 FROM loans l WHERE l.member_id = m.member_id AND l.return_date IS NULL);

-- the newest book (scalar subquery)
SELECT title, published_year FROM books WHERE published_year = (SELECT MAX(published_year) FROM books);
