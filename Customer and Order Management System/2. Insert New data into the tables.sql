INSERT INTO Customers (CustomerID, CustomerName, ContactName, Country) 
VALUES (1, 'Customer One', 'Contact One', 'USA'),
       (2, 'Customer Two', 'Contact Two', 'Canada'),
       (3, 'Customer Three', 'Contact Three', 'UK'),
       (4, 'Customer Four', 'Contact Four', 'USA'),
       (5, 'Customer Five', 'Contact Five', 'Australia');
SELECT * FROM Customers;


INSERT INTO Orders (OrderID, OrderDate, CustomerID, Amount) VALUES
(1, '2024-01-15', 1, 150.00),
(2, '2024-02-20', 2, 200.00),
(3, '2024-03-25', 3, 250.00),
(4, '2024-04-30', 1, 300.00),
(5, '2024-05-05', 5, 350.00);

SELECT * FROM ORDERS;
