CREATE DATABASE rembo;

\c rembo


-- Customer table
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



-- Sales_Territory table
CREATE TABLE IF NOT EXISTS Sales_Territory (
    Territory_Id SERIAL PRIMARY KEY,
    Sales_Territory_Country varchar(50),
    Sales_Territory_Region varchar(50),
    Sales_Territory_City varchar(50)
);


-- Employee table
CREATE TABLE IF NOT EXISTS Employee (
    Employee_Id SERIAL PRIMARY KEY,
    Employee_Name varchar(50),
    Employee_Territory_Id INT,
    CONSTRAINT fk_employee_territory FOREIGN KEY (Employee_Territory_Id) REFERENCES Sales_Territory (Territory_Id)
);





-- Sales table
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

ALTER TABLE Customer REPLICA IDENTITY FULL;
ALTER TABLE Sales_Territory REPLICA IDENTITY FULL;
ALTER TABLE Employee REPLICA IDENTITY FULL;
ALTER TABLE Sales REPLICA IDENTITY FULL;