import psycopg
from faker import Faker
import random
import datetime

# Connection to PG
conn = psycopg.connect("dbname=dbname user=user")

cur = conn.cursor()
print("connected")

# Faker Initialization
fake = Faker()

# Generate data for Customer table
for _ in range(10000):  
    customer_data = (
        fake.last_name(),
        fake.street_address(),
        fake.secondary_address(),
        fake.date_of_birth(minimum_age=18, maximum_age=90).strftime('%Y-%m-%d'),
        random.randint(18, 90),
        fake.word(),
        fake.uuid4(),
        fake.uuid4(),
        fake.date(pattern="%Y-%m-%d"),
        fake.email(),
        fake.word(),
        fake.word(),
        fake.word(),
        fake.first_name(),
        fake.word(),
        random.choice(['Male', 'Female']),
        random.choice(['Yes', 'No']),
        random.choice(['Single', 'Married', 'Divorced', 'Widowed']),
        fake.first_name(),
        random.choice(['A', 'B', 'C', 'D', 'E']),
        random.randint(0, 10),
        random.randint(0, 10),
        fake.phone_number(),
        fake.word(),
        fake.word(),
        fake.word(),
        fake.word(),
        random.randint(0, 10),
        random.randint(25000, 150000)
    )

    cur.execute("""
        INSERT INTO Customer (
            Last_Name, Address_Line1, Address_Line2, Birth_Date, Age, Commute_Distance,
            Customer_Alternate_Key, Customer_Key, Date_First_Purchase, Email_Address,
            English_Education, English_Occupation, French_Education, First_Name,
            French_Occupation, Gender, House_Owner_Flag, Marital_Status, Middle_Name,
            Name_Style, Number_Cars_Owned, Number_Children_At_Home, Phone, Spanish_Education,
            Spanish_Occupation, Suffix, Title, Total_Children, Yearly_Income
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, customer_data)

# Generate data for Sales_Territory table
for _ in range(10):  
    territory_data = (
        fake.country(),
        fake.state(),
        fake.city()
    )
    cur.execute("""
        INSERT INTO Sales_Territory (
            Sales_Territory_Country, Sales_Territory_Region, Sales_Territory_City
        ) VALUES (%s, %s, %s)
    """, territory_data)

# Generate data for Employee table
for _ in range(1000):  
    employee_data = (
        fake.name(),
        random.randint(1, 10)  # 11 sales territories
    )
    cur.execute("""
        INSERT INTO Employee (
            Employee_Name, Employee_Territory_Id
        ) VALUES (%s, %s)
    """, employee_data)

# Generate data for Sales table
for _ in range(40000):
    sales_data = (
        fake.currency_code(),
        random.randint(1, 10000),  # 10000 customers
        str(random.randint(0, 100)),
        fake.date(pattern="%Y-%m-%d"), 
        fake.date(pattern="%Y%m%d"),
        str(random.randint(0, 100)),
        str(random.randint(0, 100)),
        fake.date(pattern="%Y-%m-%d"),
        str(random.randint(0, 100)),
        str(random.randint(0, 100)),
        str(random.randint(0, 100)),
        str(random.randint(0, 100)),
        str(random.randint(0, 100)),
        str(random.randint(0, 100)),
        str(random.randint(1, 11)),  # 11 sales territories
        fake.date(pattern="%Y-%m-%d"),
        str(random.randint(0, 100)),
        str(random.randint(0, 100)),
        str(random.randint(0, 100)),
        str(random.randint(0, 100)),
        str(random.randint(1, 1000))  #1000 employees
    )
    cur.execute("""
    INSERT INTO Sales (
        CurrencyKey, Client_Id, Discount_Amount, DueDate, DueDateKey, Extended_Amount,
        Freight, Order_Date, Order_Quantity, Product_Standard_Cost, Revision_Number,
        Sales_Amount, Sales_Order_Line_Number, Sales_Order_Number, Sales_Territory_Id,
        ShipDate, Tax_Amt, Total_Product_Cost, Unit_Price, Unit_Price_Discount_Pct,
        Sales_Employee_Id
    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
""", sales_data)

# Commit changes
conn.commit()

# Close cursor and connection
cur.close()
conn.close()