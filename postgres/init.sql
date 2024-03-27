CREATE DATABASE rembo;

\c rembo;

-- Customer table
CREATE TABLE IF NOT EXISTS Customer (
    Customer_Id SERIAL PRIMARY KEY,
    Last_Name VARCHAR(255),
    Address_Line1 VARCHAR(255),
    Address_Line2 VARCHAR(255),
    Birth_Date VARCHAR(255),
    Age INTEGER,
    Commute_Distance VARCHAR(255),
    Customer_Alternate_Key VARCHAR(255),
    Customer_Key VARCHAR(255),
    Date_First_Purchase VARCHAR(255),
    Email_Address VARCHAR(255),
    English_Education VARCHAR(255),
    English_Occupation VARCHAR(255),
    French_Education VARCHAR(255),
    First_Name VARCHAR(255),
    French_Occupation VARCHAR(255),
    Gender VARCHAR(255),
    House_Owner_Flag VARCHAR(255),
    Marital_Status VARCHAR(255),
    Middle_Name VARCHAR(255),
    Name_Style VARCHAR(255),
    Number_Cars_Owned INTEGER,
    Number_Children_At_Home INTEGER,
    Phone VARCHAR(255),
    Spanish_Education VARCHAR(255),
    Spanish_Occupation VARCHAR(255),
    Suffix VARCHAR(255),
    Title VARCHAR(255),
    Total_Children INTEGER,
    Yearly_Income INTEGER
);

-- Sales_Territory table
CREATE TABLE IF NOT EXISTS Sales_Territory (
    Territory_Id SERIAL PRIMARY KEY,
    Sales_Territory_Country VARCHAR(255),
    Sales_Territory_Region VARCHAR(255),
    Sales_Territory_City VARCHAR(255)
);

-- Employee table
CREATE TABLE IF NOT EXISTS Employee (
    Employee_Id SERIAL PRIMARY KEY,
    Employee_Name VARCHAR(255),
    Employee_Territory_Id INTEGER,
    CONSTRAINT fk_employee_territory FOREIGN KEY (Employee_Territory_Id) REFERENCES Sales_Territory (Territory_Id)
);

-- Sales table
CREATE TABLE IF NOT EXISTS Sales (
    Sales_Id SERIAL PRIMARY KEY,
    CurrencyKey VARCHAR(255),
    Client_Id INTEGER,
    Extended_Amount INTEGER,
    DueDate VARCHAR(255),
    DueDateKey VARCHAR(255),
    Freight INTEGER,
    Order_Date VARCHAR(255),
    Order_Quantity INTEGER,
    Product_Standard_Cost INTEGER,
    Revision_Number VARCHAR(255),
    Sales_Order_Line_Number VARCHAR(255),
    Sales_Order_Number INTEGER,
    Sales_Territory_Id INTEGER,
    ShipDate VARCHAR(255),
    Unit_Price INTEGER,
    Unit_Price_Discount_Pct INTEGER,
    Sales_Employee_Id INTEGER,
    Product_Id INTEGER,
    Total_Product_Cost INTEGER GENERATED ALWAYS AS (Product_Standard_Cost * Order_Quantity) STORED,
    Discount_Amount INTEGER GENERATED ALWAYS AS (Unit_Price - (Unit_Price_Discount_Pct / 100)) STORED,
    Tax_Amt INTEGER GENERATED ALWAYS AS ((Freight) * (1.25 / 100)) STORED,
    Sales_Amount INTEGER GENERATED ALWAYS AS (Unit_Price * Order_Quantity) STORED,
    FOREIGN KEY (Sales_Employee_Id) REFERENCES Employee (Employee_Id),
    FOREIGN KEY (Client_Id) REFERENCES Customer (Customer_Id),
    FOREIGN KEY (Sales_Territory_Id) REFERENCES Sales_Territory (Territory_Id)
);

ALTER TABLE Customer REPLICA IDENTITY FULL;
ALTER TABLE Sales_Territory REPLICA IDENTITY FULL;
ALTER TABLE Employee REPLICA IDENTITY FULL;
ALTER TABLE Sales REPLICA IDENTITY FULL;


-- Insert into Sales_Territory table
INSERT INTO Sales_Territory (Sales_Territory_Country, Sales_Territory_Region, Sales_Territory_City) VALUES
('Ghana', 'Greater Accra', 'Accra'),
('Ghana', 'Ashanti', 'Kumasi'),
('Ghana', 'Volta', 'Aflao'),
('Ghana', 'Western', 'Prestea'),
('Ghana', 'Central', 'Cape Coast'),
('Rwanda', 'Kigali province', 'Kigali'),
('Rwanda', 'Eastern province', 'Kibungo'),
('Rwanda', 'Southern province', 'Nyanza'),
('Kenya', 'South-Central', 'Nairobi'),
('Kenya', 'South-Eastern', 'Mombasa'),
('Kenya', 'Western-Kenya', 'Kisumu');