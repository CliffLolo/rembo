-- CREATE DATABASE IF NOT EXISTS rembo;
CREATE TABLE IF NOT EXISTS rembo_data (
    `before.employee_id` UInt32,
    `before.employee_name` Nullable(String),
    `before.employee_territory_id` UInt32,
    `before.territory_id` UInt32,
    `before.sales_territory_country` Nullable(String),
    `before.sales_territory_region` Nullable(String),
    `before.sales_territory_city` Nullable(String),
    `before.customer_id` UInt32,
    `before.last_name` Nullable(String),
    `before.address_line1` Nullable(String),
    `before.address_line2` Nullable(String),
    `before.birth_date` Nullable(Date),
    `before.age` Nullable(UInt32),
    `before.commute_distance` Nullable(String),
    `before.customer_alternate_key` Nullable(String),
    `before.customer_key` Nullable(String),
    `before.date_first_purchase` Nullable(DateTime),
    `before.email_address` Nullable(String),
    `before.english_education` Nullable(String),
    `before.english_occupation` Nullable(String),
    `before.french_education` Nullable(String),
    `before.first_name` Nullable(String),
    `before.french_occupation` Nullable(String),
    `before.gender` Nullable(String),
    `before.house_owner_flag` Nullable(String),
    `before.marital_status` Nullable(String),
    `before.middle_name` Nullable(String),
    `before.name_style` Nullable(String),
    `before.number_cars_owned` Nullable(UInt32),
    `before.number_children_at_home` Nullable(UInt32),
    `before.phone` Nullable(String),
    `before.spanish_education` Nullable(String),
    `before.spanish_occupation` Nullable(String),
    `before.suffix` Nullable(String),
    `before.title` Nullable(String),
    `before.total_children` Nullable(UInt32),
    `before.yearly_income` Nullable(Decimal64(2)),
    `before.sales_id` UInt32,
    `before.currencykey` Nullable(String),
    `before.client_id` UInt32,
    `before.discount_amount` Decimal64(2),
    `before.duedate` Nullable(DateTime),
    `before.duedatekey` Nullable(String),
    `before.extended_amount` Nullable(Decimal64(2)),
    `before.freight` Nullable(Decimal64(2)),
    `before.order_date` Nullable(DateTime),
    `before.order_quantity` Nullable(UInt32),
    `before.product_standard_cost` Nullable(Decimal64(2)),
    `before.revision_number` Nullable(String),
    `before.sales_amount` Decimal64(2),
    `before.sales_order_line_number` Nullable(String),
    `before.sales_order_number` Nullable(UInt32),
    `before.sales_territory_id` UInt32,
    `before.shipdate` Nullable(DateTime),
    `before.tax_amt` Decimal64(2),
    `before.total_product_cost` Decimal64(2),
    `before.unit_price` Nullable(Decimal64(2)),
    `before.unit_price_discount_pct` Nullable(Decimal64(2)),
    `before.product_id` Nullable(UInt32),
    `before.sales_employee_id` UInt32,
    `after.employee_id` UInt32,
    `after.employee_name` Nullable(String),
    `after.employee_territory_id` UInt32,
    `after.territory_id` UInt32,
    `after.sales_territory_country` Nullable(String),
    `after.sales_territory_region` Nullable(String),
    `after.sales_territory_city` Nullable(String),
    `after.customer_id` UInt32,
    `after.last_name` Nullable(String),
    `after.address_line1` Nullable(String),
    `after.address_line2` Nullable(String),
    `after.birth_date` Nullable(Date),
    `after.age` Nullable(UInt32),
    `after.commute_distance` Nullable(String),
    `after.customer_alternate_key` Nullable(String),
    `after.customer_key` Nullable(String),
    `after.date_first_purchase` Nullable(String),
    `after.email_address` Nullable(String),
    `after.english_education` Nullable(String),
    `after.english_occupation` Nullable(String),
    `after.french_education` Nullable(String),
    `after.first_name` Nullable(String),
    `after.french_occupation` Nullable(String),
    `after.gender` Nullable(String),
    `after.house_owner_flag` Nullable(String),
    `after.marital_status` Nullable(String),
    `after.middle_name` Nullable(String),
    `after.name_style` Nullable(String),
    `after.number_cars_owned` Nullable(UInt32),
    `after.number_children_at_home` Nullable(UInt32),
    `after.phone` Nullable(String),
    `after.spanish_education` Nullable(String),
    `after.spanish_occupation` Nullable(String),
    `after.suffix` Nullable(String),
    `after.title` Nullable(String),
    `after.total_children` Nullable(UInt32),
    `after.yearly_income` Nullable(Decimal64(2)),
    `after.sales_id` UInt32,
    `after.currencykey` Nullable(String),
    `after.client_id` UInt32,
    `after.discount_amount` Decimal64(2),
    `after.duedate` Nullable(DateTime),
    `after.duedatekey` Nullable(String),
    `after.extended_amount` Nullable(Decimal64(2)),
    `after.freight` Nullable(Decimal64(2)),
    `after.order_date` Nullable(DateTime),
    `after.order_quantity` Nullable(UInt32),
    `after.product_standard_cost` Nullable(Decimal64(2)),
    `after.revision_number` Nullable(String),
    `after.sales_amount` UInt32,
    `after.sales_order_line_number` Nullable(String),
    `after.sales_order_number` Nullable(UInt32),
    `after.sales_territory_id` UInt32,
    `after.shipdate` Nullable(DateTime),
    `after.tax_amt` Decimal64(2),
    `after.total_product_cost` Decimal64(2),
    `after.unit_price` Nullable(Decimal64(2)),
    `after.unit_price_discount_pct` Nullable(Decimal64(2)),
    `after.product_id` Nullable(UInt32),
    `after.sales_employee_id` UInt32,
    `source.table` Nullable(String),
    op LowCardinality(String)
) ENGINE = MergeTree() 
ORDER BY tuple();



CREATE MATERIALIZED VIEW customer_mv
TO customer_data
AS
SELECT
    `after.customer_id` as customer_id,
    `after.last_name` as last_name,
    `after.address_line1` as address_line1,
    `after.address_line2` as address_line2,
    `after.birth_date` as birth_date,
    `after.age` as age,
    `after.commute_distance` as commute_distance,
    `after.customer_alternate_key` as customer_alternate_key,
    `after.customer_key` as customer_key,
    `after.date_first_purchase` as date_first_purchase,
    `after.email_address` as email_address,
    `after.english_education` as english_education,
    `after.english_occupation` as english_occupation,
    `after.french_education` as french_education,
    `after.first_name` as first_name,
    `after.french_occupation` as french_occupation,
    `after.gender` as gender,
    `after.house_owner_flag` as house_owner_flag,
    `after.marital_status` as marital_status,
    `after.middle_name` as middle_name,
    `after.name_style` as name_style,
    `after.number_cars_owned` as number_cars_owned,
    `after.number_children_at_home` as number_children_at_home,
    `after.phone` as phone,
    `after.spanish_education` as spanish_education,
    `after.spanish_occupation` as spanish_occupation,
    `after.suffix` as suffix,
    `after.title` as title,
    `after.total_children` as total_children,
    `after.yearly_income` as yearly_income
FROM rembo_data
WHERE `source.table` = 'customer';
CREATE TABLE customer_data
(
    customer_id UInt32,
    last_name String,
    address_line1 String,
    address_line2 String,
    birth_date Date,
    age UInt32,
    commute_distance String,
    customer_alternate_key String,
    customer_key String,
    date_first_purchase DateTime,
    email_address String,
    english_education String,
    english_occupation String,
    french_education String,
    first_name String,
    french_occupation String,
    gender String,
    house_owner_flag String,
    marital_status String,
    middle_name String,
    name_style String,
    number_cars_owned UInt32,
    number_children_at_home UInt32,
    phone String,
    spanish_education String,
    spanish_occupation String,
    suffix String,
    title String,
    total_children UInt32,
    yearly_income Decimal64(2)
) ENGINE = ReplacingMergeTree()
ORDER BY customer_id;


CREATE MATERIALIZED VIEW sales_territory_mv
TO sales_territory_data
AS
SELECT
    `after.territory_id` as territory_id,
    `after.sales_territory_country` as sales_territory_country,
    `after.sales_territory_region` as sales_territory_region,
    `after.sales_territory_city` as sales_territory_city
FROM rembo_data
WHERE `source.table` = 'sales_territory';
CREATE TABLE sales_territory_data
(
    territory_id UInt32,
    sales_territory_country String,
    sales_territory_region String,
    sales_territory_city String
) ENGINE = ReplacingMergeTree()
ORDER BY territory_id;



CREATE MATERIALIZED VIEW employee_mv
TO employee_data
AS
SELECT
    `after.employee_id` as employee_id,
    `after.employee_name` as employee_name,
    `after.employee_territory_id` as employee_territory_id
FROM rembo_data
WHERE `source.table` = 'employee';
CREATE TABLE employee_data
(
    employee_id UInt32,
    employee_name String,
    employee_territory_id UInt32
) ENGINE = ReplacingMergeTree()
ORDER BY employee_id;





CREATE MATERIALIZED VIEW sales_mv
TO sales_data
AS
SELECT
    `after.sales_id` as sales_id,
    `after.currencykey` as currencykey,
    `after.client_id` as client_id,
    `after.discount_amount` as discount_amount,
    `after.duedate` as duedate,
    `after.duedatekey` as duedatekey,
    `after.extended_amount` as extended_amount,
    `after.freight` as freight,
    `after.order_date` as order_date,
    `after.order_quantity` as order_quantity,
    `after.product_standard_cost` as product_standard_cost,
    `after.revision_number` as revision_number,
    `after.sales_amount` as sales_amount,
    `after.sales_order_line_number` as sales_order_line_number,
    `after.sales_order_number` as sales_order_number,
    `after.sales_territory_id` as sales_territory_id,
    `after.shipdate` as shipdate,
    `after.tax_amt` as tax_amt,
    `after.total_product_cost` as total_product_cost,
    `after.unit_price` as unit_price,
    `after.unit_price_discount_pct` as unit_price_discount_pct,
    `after.product_id` as product_id,
    `after.sales_employee_id` as sales_employee_id
FROM rembo_data
WHERE `source.table` = 'sales';
CREATE TABLE sales_data
(
    sales_id UInt32,
    currencykey String,
    client_id UInt32,
    discount_amount Decimal64(2),
    duedate DateTime,
    duedatekey String,
    extended_amount Decimal64(2),
    freight Decimal64(2),
    order_date DateTime,
    order_quantity UInt32,
    product_standard_cost Decimal64(2),
    revision_number String,
    sales_amount Decimal64(2),
    sales_order_line_number String,
    sales_order_number UInt32,
    sales_territory_id UInt32,
    shipdate DateTime,
    tax_amt Decimal64(2),
    total_product_cost Decimal64(2),
    unit_price Decimal64(2),
    unit_price_discount_pct Decimal64(2),
    product_id UInt32,
    sales_employee_id UInt32
) ENGINE = ReplacingMergeTree()
ORDER BY sales_id;