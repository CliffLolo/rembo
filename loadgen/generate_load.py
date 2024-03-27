import time
from psycopg import OperationalError
import psycopg
from faker import Faker
import random
import datetime
from decimal import Decimal
import json
import os


# Function to connect to PostgreSQL with retry logic
def connect_to_postgres():
    max_retries = 20
    retries = 0
    connected = False
    
    while not connected and retries < max_retries:
        try:
            conn = psycopg.connect("host=postgres dbname=rembo user=postgres password=postgres")
            connected = True
            print("Connected to PostgreSQL successfully!")
            return conn
        except OperationalError as e:
            print(f"Connection attempt failed: {e}")
            retries += 1
            if retries < max_retries:
                print("Retrying connection...")
                time.sleep(5)  # Wait for 5 seconds before retrying
            else:
                print("Max retries reached. Unable to connect to PostgreSQL.")
                raise

# Attempt to connect to PostgreSQL with retry logic
try:
    conn = connect_to_postgres()
    
    # Create a cursor object
    cur = conn.cursor()
    print("\033[1;32m")
    print("╔════════════════════════╗")
    print("║     Nicee! You are     ║")
    print("║       Connected!       ║")
    print("╚════════════════════════╝")
    print("\033[0m") 


    # Initialize Faker to generate fake data
    fake = Faker()

    # Generate data for Customer table
    for _ in range(10000):
        customer_data = (
            fake.last_name(),
            fake.street_address(),
            fake.secondary_address(),
            fake.date_of_birth(minimum_age=18, maximum_age=50).strftime('%Y-%m-%d'),
            random.randint(18, 50),
            random.choice(['1km', '2km', '3km', '4km', '5km']),
            str(random.randint(9999, 99999)),
            str(random.randint(7777, 77777)),
            fake.date_time_this_decade(before_now=True, after_now=False).strftime('%Y-%m-%d %H:%M:%S'),
            fake.email(),
            random.choice(['Yes', 'No']),
            fake.job(),
            random.choice(['Yes', 'No']),
            fake.first_name(),
            fake.job(),
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
            random.randint(10000, 100000)
        )
        

        cur.execute("""
            INSERT INTO Customer (
                last_name, address_line1, address_line2, birth_date, age, commute_distance,
                customer_alternate_key, customer_key, date_first_purchase, email_address,
                english_education, english_occupation, french_education, first_name,
                french_occupation, gender, house_owner_flag, marital_status, middle_name,
                name_style, number_cars_owned, number_children_at_home, phone, spanish_education,
                spanish_occupation, suffix, title, total_children, yearly_income
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, customer_data)

    # Generate data for Employee table
    for _ in range(1000):
        employee_data = (
            fake.name(),
            random.randint(1, 11)  # 11 sales territories
        )
        cur.execute("""
            INSERT INTO Employee (
                Employee_Name, Employee_Territory_Id
            ) VALUES (%s, %s)
        """, employee_data)

    # Generate data for Sales table
    for _ in range(500000):
        sales_data = (
            'USD',
            random.randint(1, 10000),  # 10000 customers            
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
            random.randint(1, 1000)  # 1000 employees
        )

        cur.execute("""
        INSERT INTO Sales (
            CurrencyKey, Client_Id, Extended_Amount,
                    DueDate, DueDateKey,
            Freight, Order_Date, Order_Quantity, Product_Standard_Cost, Revision_Number,
            Sales_Order_Line_Number, Sales_Order_Number, Sales_Territory_Id,
            ShipDate, Unit_Price, Unit_Price_Discount_Pct, Product_Id,
            Sales_Employee_Id
        ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, sales_data)

    # Commit changes
    conn.commit()

    # Close cursor and connection
    cur.close()
    conn.close()
finally:
    # Close the connection when done
    if conn:
        conn.close()