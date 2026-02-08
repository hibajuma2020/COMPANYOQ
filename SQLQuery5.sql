CREATE DATABASE LIBRIRAY 
use LIBRIRAY

CREATE TABLE Library (
    LibID INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(100),
    ContactNumber VARCHAR(20),
    EstablishedYear INT
);

CREATE TABLE Book (
    BookID INT PRIMARY KEY,
    ISBN VARCHAR(20),
    Title VARCHAR(150),
    Genre VARCHAR(50),
    Price DECIMAL(8,2),
    AvailabilityStatus VARCHAR(20),
    ShelfLocation VARCHAR(50),
    LibID INT,
    FOREIGN KEY (LibID) REFERENCES Library(LibID)
);

CREATE TABLE Member (
    MemID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    MembershipStartDate DATE
);

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Position VARCHAR(50),
    ContactNumber VARCHAR(20),
    LibID INT,
    FOREIGN KEY (LibID) REFERENCES Library(LibID)
);


CREATE TABLE Loan (
    LoanID INT PRIMARY KEY,
    LoanDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    Status VARCHAR(20),
    MemID INT,
    BookID INT,
    FOREIGN KEY (MemID) REFERENCES Member(MemID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    PaymentDate DATE,
    Amount DECIMAL(8,2),
    Method VARCHAR(30),
    LoanID INT,
    FOREIGN KEY (LoanID) REFERENCES Loan(LoanID)
);
DROP TABLE IF EXISTS Payment;

CREATE TABLE LoanRecord (
    LoanID INT PRIMARY KEY,
    LoanDate DATE,
    DueDate DATE,
    ReturnDate DATE,
    Status VARCHAR(20),
    MemID INT,
    BookID INT,
    FOREIGN KEY (MemID) REFERENCES Member(MemID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    PaymentDate DATE,
    Amount DECIMAL(8,2),
    PaymentMethod VARCHAR(30),
    LoanID INT,
    FOREIGN KEY (LoanID) REFERENCES LoanRecord(LoanID)
);

CREATE TABLE Review (
    ReviewID INT PRIMARY KEY,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comments VARCHAR(500),
    ReviewDate DATE,
    MemID INT NOT NULL,
    BookID INT NOT NULL,
    FOREIGN KEY (MemID) REFERENCES Member(MemID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

