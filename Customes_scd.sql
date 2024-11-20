-- Defining the new schema for the tables
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Country VARCHAR(50),
    Version INT
);

CREATE TABLE CustomerHistory (
    CustomerID INT,
    Country VARCHAR(50),
    Version INT,
    ChangeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- defining the trigger for adding the 
DELIMITER $$

CREATE TRIGGER scd_type_4_customers
BEFORE INSERT ON Customers
FOR EACH ROW
BEGIN
    DECLARE existing_version INT;

    -- Check if the record exists in the Customers table
    SELECT Version INTO existing_version
    FROM Customers
    WHERE CustomerID = NEW.CustomerID;

    -- If the record exists, move it to the CustomerHistory table
    IF existing_version IS NOT NULL THEN
        INSERT INTO CustomerHistory (CustomerID, Country, Version)
        SELECT CustomerID, Country, Version
        FROM Customers
        WHERE CustomerID = NEW.CustomerID;

        -- Increment the version for the new record
        SET NEW.Version = existing_version + 1;

        -- Delete the old version from the Customers table
        DELETE FROM Customers
        WHERE CustomerID = NEW.CustomerID;
    ELSE
        -- If the record does not exist, set the version to 1
        SET NEW.Version = 1;
    END IF;
END $$

DELIMITER ;
