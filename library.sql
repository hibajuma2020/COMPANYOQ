CREATE DATABASE LibraryDB;
USE LibraryDB;

CREATE TABLE  LibraryDB (
  LibID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    EstablishedYear INT
);

CREATE TABLE Book (
    BookID INT IDENTITY PRIMARY KEY,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    Title VARCHAR(150) NOT NULL,
    Genre VARCHAR(20) NOT NULL,
    Price DECIMAL(8,2) CHECK (Price > 0),
    IsAvailable BIT DEFAULT 1,
    ShelfLocation VARCHAR(50) NOT NULL,
    LibID INT NOT NULL,

    FOREIGN KEY (LibID)
    REFERENCES LibraryDB(LibID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CHECK (Genre IN ('Fiction','Non-fiction','Reference','Children'))
);

DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Library;

CREATE TABLE Library (
    LibID INT IDENTITY PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(100) NOT NULL,
    ContactNumber VARCHAR(20) NOT NULL,
    EstablishedYear INT
);

CREATE TABLE Book (
    BookID INT IDENTITY PRIMARY KEY,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    Title VARCHAR(150) NOT NULL,
    Genre VARCHAR(20) NOT NULL,
    Price DECIMAL(8,2) CHECK (Price > 0),
    IsAvailable BIT DEFAULT 1,
    ShelfLocation VARCHAR(50) NOT NULL,
    LibID INT NOT NULL,

    CONSTRAINT FK_Book_Library
    FOREIGN KEY (LibID)
    REFERENCES Library(LibID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT CK_Book_Genre
    CHECK (Genre IN ('Fiction','Non-fiction','Reference','Children'))
);
CREATE TABLE Member (
    MemberID INT IDENTITY PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber VARCHAR(20),
    MembershipStartDate DATE NOT NULL
);

CREATE TABLE Loan (
    LoanID INT IDENTITY PRIMARY KEY,
    LoanDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    Status VARCHAR(20) DEFAULT 'Issued',

    BookID INT NOT NULL,
    MemberID INT NOT NULL,

    FOREIGN KEY (BookID)
    REFERENCES Book(BookID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY (MemberID)
    REFERENCES Member(MemberID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CHECK (Status IN ('Issued','Returned','Overdue')),
    CHECK (ReturnDate IS NULL OR ReturnDate >= LoanDate)
);
CREATE TABLE Payment (
    PaymentID INT IDENTITY PRIMARY KEY,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(8,2) NOT NULL CHECK (Amount > 0),
    Method VARCHAR(30),

    LoanID INT NOT NULL,
    FOREIGN KEY (LoanID)
    REFERENCES Loan(LoanID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE TABLE Staff (
    StaffID INT IDENTITY PRIMARY KEY,
    FullName VARCHAR(100),
    Position VARCHAR(50),
    ContactNumber VARCHAR(20),

    LibID INT NOT NULL,
    FOREIGN KEY (LibID)
    REFERENCES Library(LibID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
CREATE TABLE Review (
    ReviewID INT IDENTITY PRIMARY KEY,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comments VARCHAR(255) DEFAULT 'No comments',
    ReviewDate DATE NOT NULL,

    BookID INT NOT NULL,
    MemberID INT NOT NULL,

    FOREIGN KEY (BookID)
    REFERENCES Book(BookID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    FOREIGN KEY (MemberID)
    REFERENCES Member(MemberID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
