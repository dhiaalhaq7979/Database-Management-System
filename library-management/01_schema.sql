-- Library Management System - schema
-- Author: Dhia Alhaq Saleh Al-Hindrish
-- Tested on MySQL 8 / MariaDB 10.11

DROP DATABASE IF EXISTS library_db;
CREATE DATABASE library_db;
USE library_db;

-- Authors who wrote the books
CREATE TABLE authors (
    author_id   INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    country     VARCHAR(60)
);

-- Book categories (Programming, Databases, ...)
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(60) NOT NULL UNIQUE
);

-- Books (one category per book)
CREATE TABLE books (
    book_id          INT AUTO_INCREMENT PRIMARY KEY,
    title            VARCHAR(150) NOT NULL,
    isbn             VARCHAR(20) UNIQUE,
    category_id      INT,
    published_year   YEAR,
    total_copies     INT NOT NULL DEFAULT 1 CHECK (total_copies >= 0),
    available_copies INT NOT NULL DEFAULT 1 CHECK (available_copies >= 0),
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

-- Many-to-many: a book can have several authors, an author several books
CREATE TABLE book_authors (
    book_id   INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id)   REFERENCES books(book_id)     ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

-- Library members
CREATE TABLE members (
    member_id   INT AUTO_INCREMENT PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(120) UNIQUE,
    phone       VARCHAR(20),
    member_type ENUM('Student', 'Faculty', 'Staff') NOT NULL DEFAULT 'Student',
    joined_on   DATE NOT NULL
);

-- Each loan = one member borrowing one book
CREATE TABLE loans (
    loan_id     INT AUTO_INCREMENT PRIMARY KEY,
    book_id     INT NOT NULL,
    member_id   INT NOT NULL,
    loan_date   DATE NOT NULL,
    due_date    DATE NOT NULL,
    return_date DATE NULL,
    fine_amount DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (book_id)   REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    CHECK (due_date >= loan_date)
);

CREATE INDEX idx_loans_member ON loans(member_id);
CREATE INDEX idx_loans_book   ON loans(book_id);
