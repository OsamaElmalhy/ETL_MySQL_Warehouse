USE Artefact_Assesment;

CREATE TABLE Customers (
    CustomerID INT UNIQUE PRIMARY KEY,
    Country VARCHAR(60)
);

CREATE TABLE Products (
    StockCode VARCHAR(20) UNIQUE PRIMARY KEY,
    Description VARCHAR(255)
);

CREATE TABLE Sales_Transactions (
    TransactionID INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceNo VARCHAR(10), 
    StockCode VARCHAR(20), 
    CustomerID INT,
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10, 2),
    TotalAmount DECIMAL(10, 2),
    InsertDate DATETIME,
    FOREIGN KEY (StockCode) REFERENCES Products(StockCode),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
