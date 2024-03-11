# Change Data Capture (CDC) using Postgres + Debezium + Kafka + ClickHouse + Metabase
Architectural Diagram
![Image 3-11-24 at 2 09 AM](https://github.com/CliffLolo/rembo/assets/41656028/3f81325a-4353-4579-8995-5acab71608f8)


Schema Diagram

![drawSQL-image-export-2024-03-10 2](https://github.com/CliffLolo/rembo/assets/41656028/aad36d28-f63f-4b5f-9e99-e9e4552044df)


## Prerequisites
* Docker
* Docker Compose
* Git

## Services
The project consists of the following services:

### Required:
* Postgres
* ClickHouse
* Kafka
* Zookeeper
* Kafka-Connect
* Kowl
* Adminer
* Metabase
## Run Locally

### 1. Clone repository and start docker containers

```shell
git clone 
```

### 2. Go to the project directory
```shell
cd cdc-postgresql-clickhouse/
```

### 3. Run the docker compose file
```shell
docker-compose up -d
```

### 4. Check the command to check if all components are up and running

```shell
docker compose ps
```
If all is well, you'll have everything running in their own containers, with Debezium configured to ship changes from Postgres into Kafka.

### 5. Verify PostgreSQL data
Access the [Postgres UI](http://localhost:7775/?pgsql=postgres&username=postgres&db=rembo&ns=public) and confirm the presence of 4 tables **employee**, **sales_territorry**, **customer** and **sales** with data in them. Use "**postgres**" as the username and password when logging in.
<img width="1245" alt="Screenshot 2024-03-10 at 22 27 28" src="https://github.com/CliffLolo/rembo/assets/41656028/04fbdaf8-105e-4a28-a983-cd61176221f2">

### 4. Verify connection between Debezium Connector and Kafka
Head over to [Kowl topics](http://localhost:8080/topics) and verify that the Debezium Connector has sucessfully published PostgreSQL data to a Kafka topic. There should be a topic named **rembo_data**.
<img width="1231" alt="Screenshot 2024-03-10 at 22 28 20" src="https://github.com/CliffLolo/rembo/assets/41656028/73c8eb72-f52e-4b9f-831b-4b2a7a241d93">


### 5. Verify connection between ClickHouseSink Connector and Kafka
Head over to [Consumer Groups](http://localhost:8080/groups) to verify that ClickHouseSink Connector is a stable consumer, and it has successfully subscribed to the **rembo_data** topic.
<img width="1233" alt="Screenshot 2024-03-10 at 22 29 05" src="https://github.com/CliffLolo/rembo/assets/41656028/f65e6c65-4e91-4804-8eb6-54728d18b123">


### 6. Verify ClickHouse data
Open [ClickHouse UI](http://localhost:8123/play) and verify that PostgreSQL data are already pushed to ClickHouse from ClickHouseSink Connector by executing below:
```text
SELECT * FROM customer_data FINAL;
SELECT * FROM employee_data FINAL;
SELECT * FROM sales_territory_data FINAL;
SELECT * FROM sales_data FINAL;
```
<img width="1233" alt="Screenshot 2024-03-10 at 22 29 05" src="https://github.com/CliffLolo/rembo/assets/41656028/f65e6c65-4e91-4804-8eb6-54728d18b123">
<img width="1222" alt="Screenshot 2024-03-11 at 01 00 17" src="https://github.com/CliffLolo/rembo/assets/41656028/8a65994a-026b-44ad-9f04-edc70cfd8daf">
<img width="1215" alt="Screenshot 2024-03-11 at 01 18 10" src="https://github.com/CliffLolo/rembo/assets/41656028/7e91bded-7706-46b2-89a0-9be37f0972ca">
<img width="1225" alt="Screenshot 2024-03-11 at 01 52 46" src="https://github.com/CliffLolo/rembo/assets/41656028/432aa1b2-bd96-47aa-b2b1-4d9ff5af970f">
<img width="1223" alt="Screenshot 2024-03-11 at 01 54 39" src="https://github.com/CliffLolo/rembo/assets/41656028/3dd1d32a-da41-4f23-b441-2b856aff1c28">

## Testing

### 1. Make new Inserts or Updates in existing PostgreSQL tables
Go to [Postgres UI](http://localhost:7775/?pgsql=postgres&username=postgres&db=rembo&ns=public&table=employee) and insert or update existing rows.

### 2. Go Back to ClickHouse
Open [ClickHouse UI](http://localhost:8123/play) again and you should see your changes already applied.


### Analytics on Metabase
Go to [Metabase UI](http://localhost:3000/) and create a question.
1. Each team/territory wants to understand which employees are selling the most products
```shell
SELECT
    st.sales_territory_region,
    e.employee_name,
    COUNT(sd.sales_id) AS total_sales
FROM
    sales_data sd
JOIN
    employee_data e ON sd.sales_employee_id = e.employee_id
JOIN
    sales_territory_data st ON sd.sales_territory_id = st.territory_id
GROUP BY
    st.sales_territory_region,
    e.employee_name
ORDER BY
    st.sales_territory_region,
    total_sales DESC;
```

2. The operations team wants to be able to know the Year over Year change of sales
across the entire organization.
```shell
WITH yearly_sales AS (
    SELECT
        EXTRACT(YEAR FROM CAST(order_date AS DATE)) AS sales_year,
        SUM(CAST(sales_amount AS DECIMAL))::decimal AS total_sales
    FROM
        sales_data
    GROUP BY
        EXTRACT(YEAR FROM CAST(order_date AS DATE))
)
SELECT
    current_year.sales_year AS current_year,
    current_year.total_sales AS current_year_sales,
    previous_year.total_sales AS previous_year_sales,
    (current_year.total_sales - previous_year.total_sales) AS yoy_change
FROM
    yearly_sales current_year
LEFT JOIN
    yearly_sales previous_year ON current_year.sales_year = previous_year.sales_year + 1;

```
3. They want to have a real time view of their sales, by region and country.
```shell
SELECT
    std.sales_territory_region,
    std.sales_territory_country,
    SUM(CAST(sd.sales_amount AS DECIMAL)) AS total_sales
FROM
    sales_data sd
JOIN
    sales_territory_data std ON sd.sales_territory_id = std.territory_id
GROUP BY
    std.sales_territory_region,
    std.sales_territory_country;
```

## Contributed by Clifford Frempong
