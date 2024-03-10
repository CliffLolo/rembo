# Change Data Capture (CDC) using Postgres + Debezium + Kafka + ClickHouse + Metabase

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
<img width="1238" alt="Screenshot 2024-03-10 at 22 29 52" src="https://github.com/CliffLolo/rembo/assets/41656028/0cd77ea5-8e31-4b09-8d93-d4d785b46df2">

## Testing

### 1. Make new Inserts or Updates in existing PostgreSQL tables
Go to [Postgres UI](http://localhost:7775/?pgsql=postgres&username=postgres&db=rembo&ns=public&table=employee) and insert or update existing rows.

### 2. Go Back to ClickHouse
Open [ClickHouse UI](http://localhost:8123/play) again and you should see your changes already applied.


### Analytics on Metabase
Go to [Metabase UI](http://localhost:3000/) and create a question.
1. Each team/territory wants to understand which employees are selling the most products
```shell

```

2. Each team / territory wants to understand their top 100 customers ( the average time between purchases and the average purchase price).
```shell

```
3. The operations team wants to be able to know the Year over Year change of sales
across the entire organization.
```shell

```
4. They want to have a real time view of their sales, by region and country.
```shell

```

## Contributed by Clifford Frempong
