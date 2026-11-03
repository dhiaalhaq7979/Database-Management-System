-- Sample data (fictional people and copies, real book titles)
USE library_db;

INSERT INTO categories (name) VALUES
('Programming'), ('Databases'), ('Software Engineering'), ('Mathematics'), ('Artificial Intelligence');

INSERT INTO authors (full_name, country) VALUES
('Bjarne Stroustrup', 'Denmark'),
('Abraham Silberschatz', 'Israel'),
('Henry F. Korth', 'USA'),
('Ian Sommerville', 'United Kingdom'),
('Gilbert Strang', 'USA'),
('Stuart Russell', 'United Kingdom'),
('Peter Norvig', 'USA'),
('Thomas H. Cormen', 'USA');

INSERT INTO books (title, isbn, category_id, published_year, total_copies, available_copies) VALUES
('The C++ Programming Language', '978-0321563842', 1, 2013, 4, 3),
('Database System Concepts', '978-0078022159', 2, 2019, 3, 2),
('Software Engineering', '978-0133943030', 3, 2015, 2, 2),
('Introduction to Linear Algebra', '978-0980232776', 4, 2016, 3, 3),
('Artificial Intelligence: A Modern Approach', '978-0134610993', 5, 2020, 2, 1),
('Introduction to Algorithms', '978-0262046305', 1, 2022, 3, 3);

INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1), (2, 2), (2, 3), (3, 4), (4, 5), (5, 6), (5, 7), (6, 8);

INSERT INTO members (full_name, email, phone, member_type, joined_on) VALUES
('Ahmed Raza',   'ahmed.raza@example.com',   '0300-1111111', 'Student', '2025-09-01'),
('Fatima Noor',  'fatima.noor@example.com',  '0300-2222222', 'Student', '2025-09-03'),
('Bilal Khan',   'bilal.khan@example.com',   '0300-3333333', 'Student', '2026-02-10'),
('Dr. Sana Iqbal', 'sana.iqbal@example.com', '0300-4444444', 'Faculty', '2024-08-15'),
('Usman Ali',    'usman.ali@example.com',    '0300-5555555', 'Staff',   '2025-01-20');

INSERT INTO loans (book_id, member_id, loan_date, due_date, return_date, fine_amount) VALUES
(1, 1, '2026-09-01', '2026-09-15', '2026-09-14', 0.00),
(2, 1, '2026-09-20', '2026-10-04', '2026-10-09', 250.00),
(5, 2, '2026-10-01', '2026-10-15', NULL, 0.00),
(1, 3, '2026-10-05', '2026-10-19', NULL, 0.00),
(2, 4, '2026-10-10', '2026-10-24', NULL, 0.00),
(3, 2, '2026-08-11', '2026-08-25', '2026-08-20', 0.00),
(4, 5, '2026-07-01', '2026-07-15', '2026-07-20', 250.00),
(6, 1, '2026-06-01', '2026-06-15', '2026-06-12', 0.00);
