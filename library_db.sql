-- Create Database
CREATE DATABASE library_db;
USE library_db;

-- Table: Users
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Authors
CREATE TABLE Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
);

-- Table: Books
CREATE TABLE Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year YEAR,
    copies_available INT DEFAULT 1 CHECK (copies_available >= 0)
);

-- Junction Table for Many-to-Many (Books ↔ Authors)
CREATE TABLE BookAuthors (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE
);

-- Table: Borrowings (Users borrowing Books)
CREATE TABLE Borrowings (
    borrowing_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    book_id INT NOT NULL,
    borrowed_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- ---------------------------------------------------
-- Sample Data
-- ---------------------------------------------------

-- Insert Users
INSERT INTO Users (full_name, email, phone) VALUES
('Alice Johnson', 'alice@example.com', '0712345678'),
('Bob Smith', 'bob@example.com', '0722334455'),
('Charlie Brown', 'charlie@example.com', '0733445566');

-- Insert Authors
INSERT INTO Authors (author_name) VALUES
('J.K. Rowling'),
('George Orwell'),
('Harper Lee'),
('J.R.R. Tolkien');

-- Insert Books
INSERT INTO Books (title, isbn, published_year, copies_available) VALUES
('Harry Potter and the Philosopher''s Stone', '9780747532699', 1997, 5),
('1984', '9780451524935', 1949, 3),
('To Kill a Mockingbird', '9780060935467', 1960, 2),
('The Hobbit', '9780261103344', 1937, 4);

-- Link Books and Authors (Many-to-Many)
INSERT INTO BookAuthors (book_id, author_id) VALUES
(1, 1), -- Harry Potter → J.K. Rowling
(2, 2), -- 1984 → George Orwell
(3, 3), -- To Kill a Mockingbird → Harper Lee
(4, 4); -- The Hobbit → J.R.R. Tolkien

-- Insert Borrowings
INSERT INTO Borrowings (user_id, book_id, borrowed_date, return_date) VALUES
(1, 1, '2025-09-01', '2025-09-15'),
(2, 2, '2025-09-05', NULL), -- not yet returned
(3, 4, '2025-09-10', '2025-09-20');
