import time
from psycopg import OperationalError
import psycopg
from faker import Faker
import random
import datetime
from decimal import Decimal
import json
import os

conn = psycopg.connect("host=localhost dbname=rembo user=postgres password=postgres")
print("Connected to PostgreSQL successfully!")

# Create a cursor object
cur = conn.cursor()

# Initialize Faker to generate fake data
fake = Faker()

# Generate data for Sales table
for _ in range(5000):
    # Generate 10 sets of fake data
    sales_data = []
    for _ in range(10):
        single_sale_data = (
            'USD',
            random.randint(1, 100),  # 10000 customers            
            random.randint(5, 1200),
            fake.date_time().strftime('%Y-%m-%d %H:%M:%S'),
            fake.date(pattern="%Y%m%d"),
            random.randint(10, 90),
            fake.date_time().strftime('%Y-%m-%d %H:%M:%S'),
            random.randint(1, 90),
            random.randint(5, 350),
            random.randint(1000, 100000),
            random.randint(0, 100),
            random.randint(0, 100),
            random.randint(1, 11),  # 11 sales territories
            fake.date_time().strftime('%Y-%m-%d %H:%M:%S'),
            random.randint(5, 350),
            random.randint(3, 20),
            random.randint(1, 5),
            random.randint(1, 10)  # 1000 employees
        )
        sales_data.append(single_sale_data)

    cur.executemany("""
    INSERT INTO Sales (
        CurrencyKey, Client_Id, Extended_Amount,
        DueDate, DueDateKey,
        Freight, Order_Date, Order_Quantity, Product_Standard_Cost, Revision_Number,
        Sales_Order_Line_Number, Sales_Order_Number, Sales_Territory_Id,
        ShipDate, Unit_Price, Unit_Price_Discount_Pct, Product_Id,
        Sales_Employee_Id
    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
""", sales_data)

    print(sales_data)
    print("Data inserted :)")
    time.sleep(1)

    # Commit the transaction
    conn.commit()

cur.close()
conn.close()

