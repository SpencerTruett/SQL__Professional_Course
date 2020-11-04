-- Write a query that shows the total purchase sales income per dealership.
SELECT d.dealership_id, d.business_name, sum(s.price)  FROM public.dealerships d
LEFT JOIN sales s ON d.dealership_id = s.dealership_id
GROUP BY d.dealership_id
ORDER BY d.dealership_id;

--Write a query that shows the purchase sales income per dealership for the current month.
SELECT d.dealership_id, d.business_name, s.purchase_date, sum(s.price)  FROM public.dealerships d
LEFT JOIN sales s ON d.dealership_id = s.dealership_id
WHERE s.purchase_date > '2020-06-29'
GROUP BY d.dealership_id, s.purchase_date
ORDER BY d.dealership_id;

-- Write a query that shows the purchase sales income per dealership for the current year.
SELECT d.dealership_id, d.business_name, s.purchase_date, sum(s.price)  FROM public.dealerships d
LEFT JOIN sales s ON d.dealership_id = s.dealership_id
WHERE s.purchase_date > '2020-01-01'
GROUP BY d.dealership_id, s.purchase_date
ORDER BY d.dealership_id;

-- Write a query that shows the total lease income per dealership.
SELECT d.dealership_id, d.business_name, st.name, sum(s.price) AS lease_income FROM public.dealerships d
LEFT JOIN sales s ON d.dealership_id = s.dealership_id
LEFT JOIN salestypes st ON s.sales_type_id = st.sales_type_id
WHERE st.sales_type_id = 2
GROUP BY d.dealership_id, d.business_name, st.name
ORDER BY d.dealership_id;

-- Write a query that shows the lease income per dealership for the current month.
SELECT d.dealership_id, d.business_name, s.purchase_date, st.name, sum(s.price) FROM public.dealerships d
LEFT JOIN sales s ON d.dealership_id = s.dealership_id
LEFT JOIN salestypes st ON s.sales_type_id = st.sales_type_id
WHERE st.sales_type_id = 2
AND s.purchase_date > '2020-06-29'
GROUP BY d.dealership_id, st.sales_type_id, s.purchase_date
ORDER BY d.dealership_id;

-- Write a query that shows the lease income per dealership for the current year.
SELECT d.dealership_id, d.business_name, s.purchase_date, st.name, sum(s.price) FROM public.dealerships d
LEFT JOIN sales s ON d.dealership_id = s.dealership_id
LEFT JOIN salestypes st ON s.sales_type_id = st.sales_type_id
WHERE st.sales_type_id = 2
AND s.purchase_date > '2020-01-01'
GROUP BY d.dealership_id, st.sales_type_id, s.purchase_date
ORDER BY d.dealership_id;

-- Write a query that shows the total income (purchase and lease) per employee.
SELECT e.employee_id, e.first_name, e.last_name, sum(s.price) AS total_income FROM public.sales s
LEFT JOIN public.employees e ON s.employee_id = e.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY e.employee_id;
