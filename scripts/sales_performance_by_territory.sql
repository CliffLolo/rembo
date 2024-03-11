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