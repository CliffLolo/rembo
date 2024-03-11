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
