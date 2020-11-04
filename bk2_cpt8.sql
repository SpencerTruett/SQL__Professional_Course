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

