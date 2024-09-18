CREATE Database Case1


CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName NVARCHAR(100),
Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1500.00),
(2, 'Mouse', 25.00),
(3, 'Keyboard', 45.00);

CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
Quantity INT,
SaleDate DATETIME,
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Sales (SaleID, ProductID, Quantity, SaleDate) VALUES
(1, 1, 2, '2024-01-10'),
(2, 2, 5, '2024-01-15'),
(3, 1, 1, '2024-02-20'),
(4, 3, 3, '2024-03-05'),
(5, 2, 7, '2024-03-25'),
(6, 3, 2, '2024-04-12');

--analyze the sales to find the total sales amount and number of sales for each product per year.

SELECT 
    Prod.ProductID,
    Prod.ProductName,
    YEAR(Sale.SaleDate) AS SaleYear,
    SUM(Sale.Quantity * Prod.Price) AS TotalSalesAmount,
    COUNT(Sale.SaleID) AS NumberOfSales
FROM 
    Sales Sale
JOIN 
    Products Prod ON Sale.ProductID = Prod.ProductID
GROUP BY 
    Prod.ProductID, Prod.ProductName, YEAR(Sale.SaleDate)
ORDER BY 
    Prod.ProductID, SaleYear;



--determine the product with the highest total sales amount.

SELECT TOP 1
    Prod.ProductID,
    Prod.ProductName,
    SUM(Sale.Quantity * Prod.Price) AS TotalSalesAmount
FROM 
    Sales Sale
JOIN 
    Products Prod ON Sale.ProductID = Prod.ProductID
GROUP BY 
    Prod.ProductID, Prod.ProductName
ORDER BY 
    TotalSalesAmount DESC;


