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