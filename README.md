# Change Data Capture (CDC) using Postgres + Debezium + Kafka + ClickHouse + Metabase

### Architectural Diagram
![Image 3-11-24 at 2 09 AM](https://github.com/CliffLolo/rembo/assets/41656028/3f81325a-4353-4579-8995-5acab71608f8)



### Schema Diagram
![drawSQL-image-export-2024-03-10 2](https://github.com/CliffLolo/rembo/assets/41656028/899a2f95-4e32-4a17-a25f-979cdf5a27bb)



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
<img width="1284" alt="Screenshot 2024-03-17 at 17 47 41" src="https://github.com/CliffLolo/rembo/assets/41656028/897db708-c305-4159-9c1b-cf20e972dcee">

If all is well, you'll have everything running in their own containers, with Debezium configured to ship changes from Postgres into Kafka.

### 5. Verify PostgreSQL data
Access the [Postgres UI](http://localhost:7775/?pgsql=postgres&username=postgres&db=rembo&ns=public) and confirm the presence of 4 tables **employee**, **sales_territorry**, **customer** and **sales** with data in them. Use "**postgres**" as the username and password when logging in.
![screenshot-localhost_7775-2024 03 10-20_30_49](https://github.com/CliffLolo/rembo/assets/41656028/fd805190-53c6-4c98-8040-8ef21ddd15bf)
![screenshot-localhost_7775-2024 03 10-20_32_06](https://github.com/CliffLolo/rembo/assets/41656028/5c9f035f-ec90-4d55-8da7-312ab17e9721)


### 4. Verify connection between Debezium Connector and Kafka
Head over to [Kowl topics](http://localhost:8080/topics) and verify that the Debezium Connector has sucessfully published PostgreSQL data to a Kafka topic. There should be a topic named **rembo_data**.
![screenshot-localhost_8080-2024 03 10-20_32_53](https://github.com/CliffLolo/rembo/assets/41656028/167249ac-cf8b-442a-a30b-7be3ee97397e)


### 5. Verify connection between ClickHouseSink Connector and Kafka
Head over to [Consumer Groups](http://localhost:8080/groups) to verify that ClickHouseSink Connector is a stable consumer, and it has successfully subscribed to the **rembo_data** topic.
![screenshot-localhost_8080-2024 03 10-20_33_19](https://github.com/CliffLolo/rembo/assets/41656028/8b511ede-9844-4807-9d21-5acbf135da96)


### 6. Verify ClickHouse data
Open [ClickHouse UI](http://localhost:8123/play) and verify that PostgreSQL data are already pushed to ClickHouse from ClickHouseSink Connector by executing below:
```text
SELECT COUNT(*) FROM customer_data;
SELECT COUNT(*) FROM employee_data;
SELECT COUNT(*) FROM sales_territory_data;
SELECT COUNT(*) FROM sales_data;
```

<img width="1222" alt="Screenshot 2024-03-11 at 01 00 17" src="https://github.com/CliffLolo/rembo/assets/41656028/8a65994a-026b-44ad-9f04-edc70cfd8daf">
<img width="1215" alt="Screenshot 2024-03-11 at 01 18 10" src="https://github.com/CliffLolo/rembo/assets/41656028/7e91bded-7706-46b2-89a0-9be37f0972ca">
<img width="1220" alt="Screenshot 2024-03-17 at 19 49 32" src="https://github.com/CliffLolo/rembo/assets/41656028/cfefe47b-9460-42ce-a631-2558d97d98f1">
<img width="1216" alt="Screenshot 2024-03-17 at 19 50 28" src="https://github.com/CliffLolo/rembo/assets/41656028/c4962c14-0c3b-4136-9be8-32c487165d73">

## Try it out!

### 1. Make new Inserts or Updates in existing PostgreSQL tables
Go to [Postgres UI](http://localhost:7775/?pgsql=postgres&username=postgres&db=rembo&ns=public&table=employee) and insert or update existing rows.

### 2. Go Back to ClickHouse
Open [ClickHouse UI](http://localhost:8123/play) again and you should see your changes already applied.


## Business Intelligence: Metabase

1. In a browser, go to [Metabase UI](http://localhost:3000)

2. Click **Let's get started**.

3. Complete the first set of fields asking for your email address. This
   information isn't crucial for anything but does have to be filled in.

4. On the **Add your data** page, fill in the following information:

   | Field             | Enter...                        |
   | ----------------- | ------------------------------- |
   | Database          | **ClickHouse**                  |
   | Name              | **RemboCompanyDB**              |
   | Host              | **clickhouse-server**           |
   | Port              | **8123**                        |
   | Database name     | **default**                     |
   | Database username | **default**                     |
   | Database password | Your ClickHouse Password        |

5. Proceed past the screens until you reach your primary dashboard.

6. Click **New**

7. Click **SQL query**.

8. From **Select a database**, select **Rembo Company DB**.

9. In the query editor, enter:

   ```sql
   SELECT
        std.sales_territory_region,
        std.sales_territory_country,
        SUM(sd.unit_price * sd.order_quantity) AS total_sales
    FROM
        sales_data sd
    JOIN
        sales_territory_data std ON sd.sales_territory_id = std.territory_id
    GROUP BY
        std.sales_territory_region,
        std.sales_territory_country
    ORDER BY std.sales_territory_country; 
   ```

10. You can save the output and add it to a dashboard, once you've drafted a dashboard you can manually set the refresh rate to 1 second by adding `#refresh=1` to the end of the URL, here is an example of a real-time dashboard of the sales by region and country:
![9FCCB82D-BA33-4DA9-9A4B-EF172DD1E41F](https://github.com/CliffLolo/rembo/assets/41656028/2d6f8994-b691-442e-ab98-f327c58122e6)

### Insights
1. Each team/territory wants to understand which employees are selling the most products

<img width="1217" alt="Screenshot 2024-03-11 at 02 32 24" src="https://github.com/CliffLolo/rembo/assets/41656028/9964ff11-68bd-427a-a6e6-6c11f8fe7627">

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

<img width="1210" alt="Screenshot 2024-03-11 at 02 41 51" src="https://github.com/CliffLolo/rembo/assets/41656028/1feab1b0-8198-4c85-b4d2-180dd96f741b">

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
<img width="1218" alt="Screenshot 2024-03-17 at 19 52 57" src="https://github.com/CliffLolo/rembo/assets/41656028/73036588-6c58-4517-b487-c4e82369b860">


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


4. Each team / territory wants to understand their top 100 customers ( the average time between purchases and the average purchase price).
```shell

SELECT
    st.sales_territory_region,
    cd.customer_id,
    AVG(sd.order_date - prev.prev_sales_date) AS avg_time_between_purchases,
    AVG(sd.sales_amount) AS avg_purchase_price
FROM (
    SELECT
        sd.client_id,
        MAX(sd.order_date) AS prev_sales_date
    FROM sales_data sd
    GROUP BY sd.client_id
) AS prev
JOIN sales_data sd ON prev.client_id = sd.client_id
JOIN customer_data cd ON sd.client_id = cd.customer_id
JOIN sales_territory_data st ON sd.sales_territory_id = st.territory_id
GROUP BY
    st.sales_territory_region,
    cd.customer_id
ORDER BY
    st.sales_territory_region ASC,
    avg_purchase_price DESC
LIMIT 100

```
## Pipeline Resilience Strategies

### Fault Isolation:
Each service operates within its own container, enabling isolation of any issues that may arise. This ensures that if one component encounters a problem, it won't affect the functioning of the others.

### Restart Policies:
Restart policies are configured for most services to automatically restart in case of failures. Whether it's `restart: always` or `restart: on-failure`, these policies help maintain service availability by quickly recovering from unexpected downtime.

### Error Handling:
Error handling and retry mechanisms are implemented within the Kafka Connect configuration. For instance, the frequency of offset flushing to persistent storage is controlled, reducing the risk of data loss during failures.

### Monitoring:
Monitoring capabilities are set up for critical services like Kafka to closely monitor the health of the pipeline. This allows for proactive identification of issues and prompt resolution to minimize downtime.

### Redundancy and Replication:
Kafka's replication factor ensures data redundancy, while Debezium captures database changes redundantly to prevent potential data loss. Additionally, ClickHouse can be configured for replication and high availability, enhancing data durability and ensuring continuous availability.

### Side note :)
Regular backups of critical databases like Postgres and ClickHouse are essential for recovering from catastrophic failures and ensuring data integrity.


---

#### You have some infrastructure running in Docker containers, so don't forget to run `docker-compose down` to shut everything down!
---


## Contributed by Clifford Frempong



