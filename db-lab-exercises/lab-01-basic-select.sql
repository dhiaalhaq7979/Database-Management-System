-- DB Lab 01: SELECT, WHERE, ORDER BY, LIMIT (uses library_db)
USE library_db;

SELECT title, published_year FROM books WHERE published_year >= 2016 ORDER BY published_year DESC;
SELECT full_name, member_type FROM members WHERE member_type <> 'Student';
SELECT title FROM books WHERE title LIKE '%Introduction%';
SELECT title, available_copies FROM books ORDER BY available_copies DESC, title LIMIT 3;
