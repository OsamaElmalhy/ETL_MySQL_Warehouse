USE Artefact_Assesment;

CREATE TABLE Metadata (
    TableName VARCHAR(100),
    ColumnName VARCHAR(100),
    DataType VARCHAR(100),
    Constraints VARCHAR(255),
    ColumnDescription VARCHAR(255)
);


INSERT INTO Metadata (TableName, ColumnName, DataType, Constraints, ColumnDescription)
VALUES
    ('Customers', 'CustomerID', 'INT', 'UNIQUE, PRIMARY KEY', 'Unique identifier for each customer'),
    ('Customers', 'Country', 'VARCHAR(60)', '', 'The country of the customer'),
    ('Customers', 'InsertDate', 'DATETIME', '', 'Date and time when the customer record was inserted'),
    ('Products', 'StockCode', 'VARCHAR(20)', 'UNIQUE, PRIMARY KEY', 'Unique identifier for each product (stock code)'),
    ('Products', 'Description', 'VARCHAR(255)', '', 'Description of the product'),
    ('Products', 'InsertDate', 'DATETIME', '', 'Date and time when the product record was inserted'),
    ('Sales_Transactions', 'TransactionID', 'INT', 'AUTO_INCREMENT, PRIMARY KEY', 'Unique identifier for each sales transaction. Auto-incremented'),
    ('Sales_Transactions', 'InvoiceNo', 'VARCHAR(10)', '', 'Invoice number associated with the transaction'),
    ('Sales_Transactions', 'StockCode', 'VARCHAR(20)', 'FOREIGN KEY', 'The stock code of the product being sold. Foreign key referencing Products.StockCode'),
    ('Sales_Transactions', 'CustomerID', 'INT', 'FOREIGN KEY', 'The customer involved in the transaction. Foreign key referencing Customers.CustomerID'),
    ('Sales_Transactions', 'Quantity', 'INT', '', 'The quantity of products purchased in this transaction'),
    ('Sales_Transactions', 'InvoiceDate', 'DATETIME', '', 'The date and time when the invoice was generated for the transaction'),
    ('Sales_Transactions', 'UnitPrice', 'DECIMAL(10, 2)', '', 'The price per unit of the product being sold'),
    ('Sales_Transactions', 'TotalAmount', 'DECIMAL(10, 2)', '', 'The total amount for the transaction (calculated as Quantity * UnitPrice)'),
    ('Sales_Transactions', 'InsertDate', 'DATETIME', '', 'Date and time when the sales transaction record was inserted');