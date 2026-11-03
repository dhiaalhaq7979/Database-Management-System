-- DB Lab 02: constraints (PRIMARY KEY, UNIQUE, NOT NULL, CHECK, FOREIGN KEY)
-- Each statement below is EXPECTED to fail; run them one by one and read the error.
USE library_db;

-- 1) duplicate primary key
-- INSERT INTO categories (category_id, name) VALUES (1, 'Duplicate');
-- 2) duplicate UNIQUE email
-- INSERT INTO members (full_name, email, joined_on) VALUES ('Copy', 'ahmed.raza@example.com', '2026-01-01');
-- 3) foreign key to a book that does not exist
-- INSERT INTO loans (book_id, member_id, loan_date, due_date) VALUES (999, 1, '2026-01-01', '2026-01-10');
-- 4) CHECK: due date before loan date
-- INSERT INTO loans (book_id, member_id, loan_date, due_date) VALUES (1, 1, '2026-01-10', '2026-01-01');

-- This one is valid: shows that ON DELETE SET NULL keeps the book when its category is deleted
START TRANSACTION;
INSERT INTO categories (name) VALUES ('Temporary');
UPDATE books SET category_id = LAST_INSERT_ID() WHERE book_id = 6;
DELETE FROM categories WHERE name = 'Temporary';
SELECT book_id, title, category_id FROM books WHERE book_id = 6;
ROLLBACK;
