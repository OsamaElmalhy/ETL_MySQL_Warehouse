SELECT SQL_CACHE 
   SUM(s.Quantity) AS TotalQuantity, 
   s.InvoiceNo, 
   s.CustomerID, 
   c.Country 
FROM 
    Sales_Transactions s
JOIN 
    Customers c ON s.CustomerID = c.CustomerID
WHERE 
    YEAR(s.InvoiceDate) > 2010
GROUP BY  
    s.InvoiceNo, 
    s.CustomerID, 
    c.Country
ORDER BY CustomerID;