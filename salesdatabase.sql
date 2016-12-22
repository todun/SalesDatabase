-- DDL---------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS Salesperson CASCADE;

CREATE TABLE Salesperson
(
  SalespersonID SERIAL PRIMARY KEY,
  Name          VARCHAR(255),
  Age           VARCHAR(255),
  Salary        NUMERIC(19, 4)
);

DROP TABLE IF EXISTS Customer CASCADE;
CREATE TABLE Customer
(
  CustomerID SERIAL PRIMARY KEY NOT NULL UNIQUE,
  Name       VARCHAR(255)
);


DROP TABLE IF EXISTS Orders CASCADE;
SET datestyle = dmy; -- set the datastyle to match the dd/mm/yyyy in DML

CREATE TABLE Orders
(
  OrderID       SERIAL PRIMARY KEY NOT NULL UNIQUE,
  OrderDate     TIMESTAMP,
  CustomerID    INT,
  SalespersonID INT,
  NumberOfUnits INT,
  CostOfUnit    NUMERIC(19, 4),
  FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
  FOREIGN KEY (SalespersonID) REFERENCES Salesperson (SalespersonID)
);


DROP TABLE IF EXISTS BigOrders CASCADE;
CREATE TABLE BigOrders
(
  CustomerID      INT PRIMARY KEY,
  TotalOrderValue INT,
  FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID)
);

-- DML -----------------------------------------------------------------------------------------------------------------

INSERT INTO Salesperson (SalespersonID, Name, Age, Salary)
VALUES ('1', 'Alice', '61', '140000'),
  ('2', 'Bob', '34', '44000'),
  ('6', 'Chris', '34', '40000'),
  ('8', 'Derek', '41', '52000'),
  ('11', 'Emmit', '57', '115000'),
  ('16', 'Fred', '38', '38000');


INSERT INTO Customer (CustomerID, Name)
VALUES ('4', 'George'),
  ('6', 'Harry'),
  ('7', 'Ingrid'),
  ('11', 'Jerry');

INSERT INTO Orders (OrderID, OrderDate, CustomerID, SalespersonID, NumberOfUnits, CostOfUnit)
VALUES
  -- given
  ('3', '02/01/2013', '4', '2', '4', '400'),
  ('6', '07/02/2013', '4', '1', '1', '600'),
  ('10', '04/03/2013', '7', '6', '2', '300'),
  ('17', '15/03/2013', '6', '1', '5', '300'),
  ('25', '19/04/2013', '11', '11', '7', '300'),
  ('34', '22/04/2013', '11', '11', '100', '26'),
  ('57', '12/07/2013', '7', '11', '14', '11'),
  -- added
  ('70', '02/01/2013', '4', '2', '4', '400.00'),
  ('71', '04/02/2011', '6', '1', '1', '600.00'),
  ('72', '04/03/1990', '7', '6', '2', '300.32'),
  ('73', '06/03/1880', '6', '1', '5', '300.45'),
  ('74', '09/04/1000', '11', '11', '7', '300.14'),
  ('75', '11/04/2090', '11', '11', '100', '26.98'),
  ('76', '12/07/1999', '7', '11', '14', '11.22'),
  ('77', '08/05/2013', '7', '1', '5', '4560.45'),
  ('78', '09/09/2014', '6', '16', '23', '111100.23');

-- Requirement 9---------------------------------------------------------------------------------------------------------
--
-- First question:
-- Return the names of all salespeople that have an order with George
--
-- First answer:
SELECT DISTINCT sp.Name AS "Sales person(s) having orders belonging to customer George"
FROM Salesperson AS sp, Customer AS c, Orders AS o
WHERE o.customerID = c.customerID AND sp.salespersonID = o.salespersonID AND c.Name = 'George';

-- Second question:
-- Return the names of all salespeople that do not have any order with George
--
-- Second answer:
SELECT DISTINCT sp.Name AS "Sales person(s) having orders not belonging to customer George"
FROM Salesperson AS sp, Customer AS c, Orders AS o
WHERE o.customerID = c.customerID AND sp.salespersonID = o.salespersonID AND c.Name != 'George';

-- Third question:
-- Return the names of salespeople that have 2 or more orders.
--
-- Third answer:
SELECT DISTINCT sp.Name AS "Sales person(s) with 2 or more orders"
FROM Salesperson AS sp, Customer AS c, Orders AS o
WHERE o.customerID = c.customerID AND sp.salespersonID = o.salespersonID AND o.NumberOfUnits >= 2;

-- Requirement 10--------------------------------------------------------------------------------------------------------
--
-- First question:
--
-- 	Return the name of the salesperson with the 3rd highest salary.
--
-- First answer:

SELECT Name AS "Sales person(s) with 3rd highest salary"
FROM (
       SELECT
         Name,
         ROW_NUMBER()
         OVER (
           ORDER BY salary DESC) AS rownumber
       FROM Salesperson
     ) AS orderedtable
WHERE rownumber IN (3);

-- Second question:
-- 	Create a new roll­up table BigOrders(where columns are CustomerID, TotalOrderValue),
-- 	and insert into that table customers whose total Amount across all orders is greater than 1000
--
-- Second answer:

INSERT INTO BigOrders (CustomerID, TotalOrderValue)
  SELECT
    DISTINCT
    CustomerID,
    SUM(CostOfUnit)
  FROM Orders
  GROUP BY CustomerID
  HAVING SUM(CostOfUnit) > 1000;

-- Third question:
-- 	Return the total Amount of orders for each month, ordered by year, then month
-- 	(both in descending order)
--
-- Third answer:
SELECT
  SUM(CostOfUnit)                      AS "Total Amount Of Orders",
  date_part('YEAR', Orders.OrderDate)  AS "Order Year",
  date_part('MONTH', Orders.OrderDate) AS "Order Month"
FROM Orders
GROUP BY orders.OrderDate, date_part('MONTH', Orders.OrderDate)
ORDER BY date_part('YEAR', Orders.OrderDate) DESC, date_part('MONTH', Orders.OrderDate) DESC;
