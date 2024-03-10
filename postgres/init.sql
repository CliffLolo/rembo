CREATE DATABASE rembo;

\c rembo



-- Create Customer table with modified data types
CREATE TABLE IF NOT EXISTS Customer (
    Customer_Id SERIAL PRIMARY KEY,
    Last_Name varchar(50),
    Address_Line1 varchar(50),
    Address_Line2 varchar(50),
    Birth_Date varchar(50),
    Age INTEGER,
    Commute_Distance varchar(50),
    Customer_Alternate_Key varchar(50),
    Customer_Key varchar(50),
    Date_First_Purchase varchar(50),
    Email_Address varchar(50),
    English_Education varchar(50),
    English_Occupation varchar(50),
    French_Education varchar(50),
    First_Name varchar(50),
    French_Occupation varchar(50),
    Gender varchar(50),
    House_Owner_Flag varchar(50),
    Marital_Status varchar(50),
    Middle_Name varchar(50),
    Name_Style varchar(50),
    Number_Cars_Owned varchar(50),
    Number_Children_At_Home varchar(50),
    Phone varchar(50),
    Spanish_Education varchar(50),
    Spanish_Occupation varchar(50),
    Suffix varchar(50),
    Title varchar(50),
    Total_Children varchar(50),
    Yearly_Income varchar(50)
);



-- Create Sales_Territory table with consistent naming
CREATE TABLE IF NOT EXISTS Sales_Territory (
    Territory_Id SERIAL PRIMARY KEY,
    Sales_Territory_Country varchar(50),
    Sales_Territory_Region varchar(50),
    Sales_Territory_City varchar(50)
);


-- Create Employee table with consistent naming and foreign key
CREATE TABLE IF NOT EXISTS Employee (
    Employee_Id SERIAL PRIMARY KEY,
    Employee_Name varchar(50),
    Employee_Territory_Id INT,
    CONSTRAINT fk_employee_territory FOREIGN KEY (Employee_Territory_Id) REFERENCES Sales_Territory (Territory_Id)
);





-- Create Sales table with foreign key constraints
CREATE TABLE IF NOT EXISTS Sales (
    Sales_Id SERIAL PRIMARY KEY,
    CurrencyKey varchar(50),
    Client_Id INT,
    Discount_Amount varchar(50),
    DueDate varchar(50),
    DueDateKey varchar(50),
    Extended_Amount varchar(50),
    Freight varchar(50),
    Order_Date varchar(50),
    Order_Quantity varchar(50),
    Product_Standard_Cost varchar(50),
    Revision_Number varchar(50),
    Sales_Amount varchar(50),
    Sales_Order_Line_Number varchar(50),
    Sales_Order_Number varchar(50),
    Sales_Territory_Id INT,
    ShipDate varchar(50),
    Tax_Amt varchar(50),
    Total_Product_Cost varchar(50),
    Unit_Price varchar(50),
    Unit_Price_Discount_Pct varchar(50),
    Sales_Employee_Id INT,
    FOREIGN KEY (Sales_Employee_Id) REFERENCES Employee (Employee_Id),
    FOREIGN KEY (Client_Id) REFERENCES Customer (Customer_Id),
    FOREIGN KEY (Sales_Territory_Id) REFERENCES Sales_Territory (Territory_Id)
);

-- ALTER TABLE Customer REPLICA IDENTITY FULL;
-- ALTER TABLE Sales_Territory REPLICA IDENTITY FULL;
-- ALTER TABLE Employee REPLICA IDENTITY FULL;
-- ALTER TABLE Sales REPLICA IDENTITY FULL;

-- Sample data for Sales_Territory table
INSERT INTO Sales_Territory (Sales_Territory_Country, Sales_Territory_Region, Sales_Territory_City) VALUES
('USA', 'East', 'New York'),
('USA', 'East', 'Boston'),
('USA', 'East', 'Washington'),
('USA', 'West', 'Los Angeles'),
('USA', 'West', 'San Francisco'),
('Canada', 'Ontario', 'Toronto'),
('Canada', 'Quebec', 'Montreal'),
('UK', 'England', 'London'),
('UK', 'Scotland', 'Edinburgh'),
('Australia', 'New South Wales', 'Sydney'),
('Australia', 'Victoria', 'Melbourne');


-- Sample data for Employee table (5 rows)
INSERT INTO Employee (Employee_Name, Employee_Territory_Id) VALUES
('John Doe', 1),
('Jane Smith', 1),
('Mike Johnson', 4),
('Emily Brown', 6),
('David Wilson', 9),
('Alex Green', 1);

UPDATE Employee SET Employee_Name = 'Cliffy' WHERE Employee_Territory_Id = 4;

-- Sample data for Customer table
INSERT INTO Customer (Last_Name, Address_Line1, Address_Line2, Birth_Date, Age, Commute_Distance, Customer_Alternate_Key, Customer_Key, Date_First_Purchase, Email_Address, English_Education, English_Occupation, French_Education, First_Name, French_Occupation, Gender, House_Owner_Flag, Marital_Status, Middle_Name, Name_Style, Number_Cars_Owned, Number_Children_At_Home, Phone, Spanish_Education, Spanish_Occupation, Suffix, Title, Total_Children, Yearly_Income) VALUES
('Doe', '123 Main St', '123 Main St', '1990-05-15', 34, '5 miles', 'CustAltKey1', 'CustKey1', '2010-01-15', 'johndoe@example.com', 'Bachelors', 'Manager', 'Bachelors', 'John', 'Manager', 'Male', 'Yes', 'Single', 'A', 'Formal', 2, 0, '123-456-7890', 'Bachelors', 'Manager', '', '', 0, 75000),
('Smith', '456 Elm St', '456 Elm St', '1985-08-21', 39, '10 miles', 'CustAltKey2', 'CustKey2', '2008-03-20', 'janesmith@example.com', 'High School', 'Clerk', 'High School', 'Jane', 'Clerk', 'Female', 'No', 'Married', 'B', 'Informal', 1, 2, '456-789-0123', 'High School', 'Clerk', '', '', 2, 60000),
('Johnson', '789 Oak St', '789 Oak St', '1978-12-10', 46, '15 miles', 'CustAltKey3', 'CustKey3', '2015-11-10', 'mikejohnson@example.com', 'Masters', 'Engineer', 'Masters', 'Mike', 'Engineer', 'Male', 'Yes', 'Single', 'C', 'Formal', 3, 1, '789-012-3456', 'Masters', 'Engineer', '', '', 1, 90000),
('Brown', '101 Pine St', '101 Pine St', '1982-04-30', 42, '20 miles', 'CustAltKey4', 'CustKey4', '2012-06-05', 'emilybrown@example.com', 'High School', 'Teacher', 'High School', 'Emily', 'Teacher', 'Female', 'No', 'Married', 'D', 'Informal', 1, 3, '101-234-5678', 'High School', 'Teacher', '', '', 3, 55000),
('Wilson', '202 Cedar St', '202 Cedar St', '1995-10-18', 29, '5 miles', 'CustAltKey5', 'CustKey5', '2018-09-08', 'davidwilson@example.com', 'Associates', 'Technician', 'Associates', 'David', 'Technician', 'Male', 'Yes', 'Single', 'E', 'Formal', 2, 0, '202-345-6789', 'Associates', 'Technician', '', '', 0, 70000);



INSERT INTO Sales (CurrencyKey, Client_Id, Discount_Amount, DueDate, DueDateKey, Extended_Amount, Freight, Order_Date, Order_Quantity, Product_Standard_Cost, Revision_Number, Sales_Amount, Sales_Order_Line_Number, Sales_Order_Number, Sales_Territory_Id, ShipDate, Tax_Amt, Total_Product_Cost, Unit_Price, Unit_Price_Discount_Pct, Sales_Employee_Id) VALUES
('USD', 1, '10', '2024-03-08', '20240308', '90', '5', '2024-03-01', '1', '100', '1', '100', '1', '1', 1, '2024-03-05', '10', '80', '100', '0.1', 1),
('USD', 2, '15', '2024-03-10', '20240310', '85', '6', '2024-03-02', '2', '90', '1', '90', '1', '2', 2, '2024-03-06', '12', '70', '45', '0.2', 2),
('USD', 3, '20', '2024-03-12', '20240312', '80', '7', '2024-03-03', '3', '80', '1', '80', '1', '3', 3, '2024-03-07', '15', '60', '40', '0.3', 3),
('USD', 4, '25', '2024-03-14', '20240314', '75', '8', '2024-03-04', '4', '70', '1', '70', '1', '4', 4, '2024-03-08', '20', '50', '30', '0.4', 4),
('USD', 5, '30', '2024-03-16', '20240316', '70', '9', '2024-03-05', '5', '60', '1', '60', '1', '5', 5, '2024-03-09', '25', '40', '20', '0.5', 5),
('USD', 1, '35', '2024-03-18', '20240318', '65', '10', '2024-03-06', '6', '50', '1', '50', '1', '6', 6, '2024-03-10', '30', '30', '10', '0.6', 1),
('USD', 2, '40', '2024-03-20', '20240320', '60', '11', '2024-03-07', '7', '40', '1', '40', '1', '7', 7, '2024-03-11', '35', '20', '5', '0.7', 2),
('USD', 3, '45', '2024-03-22', '20240322', '55', '12', '2024-03-08', '8', '30', '1', '30', '1', '8', 8, '2024-03-12', '40', '10', '0', '0.8', 3),
('USD', 4, '50', '2024-03-24', '20240324', '50', '13', '2024-03-09', '9', '20', '1', '20', '1', '9', 9, '2024-03-13', '45', '0', '0', '0.9', 4),
('USD', 5, '55', '2024-03-26', '20240326', '45', '14', '2024-03-10', '10', '10', '1', '10', '1', '10', 10, '2024-03-14', '50', '0', '0', '1', 5),
('USD', 1, '60', '2024-03-28', '20240328', '40', '15', '2024-03-11', '11', '100', '2', '100', '2', '11', 1, '2024-03-15', '0', '80', '100', '0.1', 1),
('USD', 2, '65', '2024-03-30', '20240330', '35', '16', '2024-03-12', '12', '90', '2', '90', '2', '12', 2, '2024-03-16', '0', '70', '45', '0.2', 2),
('USD', 3, '70', '2024-04-01', '20240401', '30', '17', '2024-03-13', '13', '80', '2', '80', '2', '13', 3, '2024-03-17', '0', '60', '40', '0.3', 3),
('USD', 4, '75', '2024-04-03', '20240403', '25', '18', '2024-03-14', '14', '70', '2', '70', '2', '14', 4, '2024-03-18', '0', '50', '30', '0.4', 4),
('USD', 5, '80', '2024-04-05', '20240405', '20', '19', '2024-03-15', '15', '60', '2', '60', '2', '15', 5, '2024-03-19', '0', '40', '20', '0.5', 5),
('USD', 1, '85', '2024-04-07', '20240407', '15', '20', '2024-03-16', '16', '50', '2', '50', '2', '16', 6, '2024-03-20', '0', '30', '10', '0.6', 1),
('USD', 2, '90', '2024-04-09', '20240409', '10', '21', '2024-03-17', '17', '40', '2', '40', '2', '17', 7, '2024-03-21', '0', '20', '5', '0.7', 2),
('USD', 3, '95', '2024-04-11', '20240411', '5', '22', '2024-03-18', '18', '30', '2', '30', '2', '18', 8, '2024-03-22', '0', '10', '0', '0.8', 3),
('USD', 4, '100', '2024-04-13', '20240413', '0', '23', '2024-03-19', '19', '20', '2', '20', '2', '19', 9, '2024-03-23', '0', '0', '0', '0.9', 4),
('USD', 5, '105', '2024-04-15', '20240415', '100', '24', '2024-03-20', '20', '10', '2', '10', '2', '20', 10, '2024-03-24', '0', '0', '0', '1', 5);
