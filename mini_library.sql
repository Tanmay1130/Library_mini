-- ================================================
-- Mini Library Management System - SQL Schema
-- ================================================

-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS mini_library;
USE mini_library;

-- ================================================
-- 2. Table Definitions
-- ================================================

-- Members table: stores library member information
CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);

-- Authors table: stores book authors
CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL
);

-- Books table: stores books in the library
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    genre VARCHAR(50),
    published_year YEAR,
    copies_available INT DEFAULT 1,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Borrow table: records books borrowed by members
CREATE TABLE Borrow (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    due_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Returns table: tracks book returns and any fines
CREATE TABLE Returns (
    return_id INT PRIMARY KEY AUTO_INCREMENT,
    borrow_id INT,
    return_date DATE,
    fine DECIMAL(6, 2),
    FOREIGN KEY (borrow_id) REFERENCES Borrow(borrow_id)
);

-- ================================================
-- 3. Sample Data Insertion
-- ================================================

-- Authors
INSERT INTO Authors (author_name) VALUES
('J.K. Rowling'),
('George Orwell'),
('Agatha Christie'),
('Dan Brown'),
('Jane Austen');

-- Books
INSERT INTO Books (title, author_id, genre, published_year, copies_available) VALUES
('Harry Potter and the Sorcerer''s Stone', 1, 'Fantasy', 1997, 5),
('1984', 2, 'Dystopian', 1949, 4),
('Murder on the Orient Express', 3, 'Mystery', 1934, 2),
('The Da Vinci Code', 4, 'Thriller', 2003, 3),
('Pride and Prejudice', 5, 'Romance', 1813, 2);

-- Members
INSERT INTO Members (name, email, phone, address) VALUES
('Asha Reddy', 'asha@example.com', '9000010001', 'Delhi'),
('Ravi Sharma', 'ravi@example.com', '9000010002', 'Mumbai'),
('Kiran Das', 'kiran@example.com', '9000010003', 'Kolkata'),
('Meena Iyer', 'meena@example.com', '9000010004', 'Chennai'),
('Rahul Jain', 'rahul@example.com', '9000010005', 'Hyderabad');

-- Borrow Records
INSERT INTO Borrow (member_id, book_id, borrow_date, due_date) VALUES
(1, 1, '2024-06-01', '2024-06-10'),
(2, 2, '2024-06-02', '2024-06-12'),
(3, 3, '2024-06-03', '2024-06-11'),
(4, 4, '2024-06-04', '2024-06-13'),
(5, 5, '2024-06-05', '2024-06-14');

-- Return Records
INSERT INTO Returns (borrow_id, return_date, fine) VALUES
(1, '2024-06-09', 0.00),
(2, '2024-06-13', 5.00),
(3, '2024-06-10', 0.00),
(4, '2024-06-15', 10.00),
(5, '2024-06-14', 0.00);

-- ================================================
-- 4. Sample Queries
-- ================================================

-- a. List of borrowed books with member names
SELECT
    b.borrow_id,
    m.name AS member_name,
    bk.title AS book_title,
    b.borrow_date,
    b.due_date
FROM Borrow b
JOIN Members m ON b.member_id = m.member_id
JOIN Books bk ON b.book_id = bk.book_id;

-- b. Members with fines
SELECT
    m.name AS member_name,
    bk.title AS book_title,
    r.return_date,
    r.fine
FROM Returns r
JOIN Borrow b ON r.borrow_id = b.borrow_id
JOIN Members m ON b.member_id = m.member_id
JOIN Books bk ON b.book_id = bk.book_id
WHERE r.fine > 0;

-- c. Books with lowest stock
SELECT title, copies_available
FROM Books
ORDER BY copies_available ASC
LIMIT 3;

-- d. Total fines collected
SELECT SUM(fine) AS total_fines_collected
FROM Returns;
