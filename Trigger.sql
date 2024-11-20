DELIMITER //

CREATE TRIGGER check_customer_id_before_insert
BEFORE INSERT ON Sales_Transactions
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = NEW.CustomerID) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: customer_id does not exist in customer_dimension';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER check_stock_code_before_insert
BEFORE INSERT ON Sales_Transactions
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Customers WHERE StockCode = NEW.StockCode) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: stock_code does not exist in products_dimension';
    END IF;
END //

DELIMITER ;