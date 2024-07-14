-- Calculate the Total Amount of All Orders in the "Orders" Table
SELECT SUM(Amount) AS TotalAmount FROM Orders;

-- Calculate the Average Amount of Orders for Each Customer Using GROUP BY
SELECT CustomerID, AVG(Amount) AS AverageAmount FROM Orders GROUP BY CustomerID;

-- Join the "Customers" and "Orders" Tables to List All Orders Along with Customer Names
SELECT Orders.OrderID, Orders.OrderDate, Customers.CustomerName, Orders.Amount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- Select Customers from the "Customers" Table Whose Country is 'USA'
SELECT * FROM Customers WHERE Country = 'USA';

-- Concatenate the Customer Name and Contact Name from the "Customers" Table
SELECT CONCAT(CustomerName, ' ', ContactName) AS FullName FROM Customers;

-- Extract the First 3 Characters from the Customer Name in the "Customers" Table
SELECT SUBSTRING(CustomerName, 1, 3) AS ShortName FROM Customers;

-- Update the Amount of the Order with OrderID = 3 to 200.00
UPDATE Orders SET Amount = 200.00 WHERE OrderID = 3;

-- Delete a Customer with CustomerID = 4 from the "Customers" Table
DELETE FROM Customers WHERE CustomerID = 4;

-- Count the Number of Orders Each Customer Has Made
SELECT CustomerID, COUNT(OrderID) AS OrderCount FROM Orders GROUP BY CustomerID;

-- Find the Maximum Order Amount from the "Orders" Table
SELECT MAX(Amount) AS MaxAmount FROM Orders;

-- Calculate the Total Amount of All Orders in the "Orders" Table
SELECT SUM(Amount) AS TotalAmount FROM Orders;
