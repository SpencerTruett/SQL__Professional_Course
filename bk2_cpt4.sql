-- Produce a report that lists every dealership, 
-- the number of purchases done by each, and the number of leases done by each.
SELECT DISTINCT d.business_name,     
    SUM(CASE WHEN s.sales_type_id = 1 then 1 else 0 end) as number_of_purchase,
    SUM(CASE WHEN s.sales_type_id = 2 then 1 else 0 end) as number_of_lease
	FROM sales s
	LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
	LEFT JOIN salestypes st ON s.sales_type_id = st.sales_type_id
	GROUP BY d.dealership_id
	
-- Produce a report that determines the most popular vehicle model that is leased.
SELECT vmd.name, COUNT(vmd.name) AS number_of_leases
	FROM sales s
	LEFT JOIN vehicles v ON s.vehicle_id = v.vehicle_id
	LEFT JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
	LEFT JOIN vehiclemodel vmd ON vt.vehicle_model_id = vmd.vehicle_model_id
	WHERE s.sales_type_id =2
	GROUP BY vmd.name
	HAVING COUNT(vmd.name) > 1
	ORDER BY number_of_leases DESC
	
-- What is the most popular vehicle make in terms of number of sales?
SELECT vmk.name, COUNT(vmk.name) AS number_of_purchases
	FROM sales s
	LEFT JOIN vehicles v ON s.vehicle_id = v.vehicle_id
	LEFT JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
	LEFT JOIN vehiclemake vmk ON vt.vehicle_make_id = vmk.vehicle_make_id
	WHERE s.sales_type_id =2
	GROUP BY vmk.name
	HAVING COUNT(vmk.name) > 1
	ORDER BY number_of_purchases DESC
	
-- Which employee type sold the most of that make?
SELECT 
    SUM(CASE WHEN e.employee_type_id = 1 then 1 else 0 end) as num_sold_by_sales,
    SUM(CASE WHEN e.employee_type_id = 2 then 1 else 0 end) as num_sold_by_finance_mng,
	SUM(CASE WHEN e.employee_type_id = 3 then 1 else 0 end) as num_sold_by_sales_mng,
	SUM(CASE WHEN e.employee_type_id = 4 then 1 else 0 end) as num_sold_by_sust_serv,
	SUM(CASE WHEN e.employee_type_id = 5 then 1 else 0 end) as num_sold_by_buis_dpt,
	SUM(CASE WHEN e.employee_type_id = 6 then 1 else 0 end) as num_sold_by_gm,
	SUM(CASE WHEN e.employee_type_id = 7 then 1 else 0 end) as num_sold_by_porter
	FROM sales s
	LEFT JOIN employees e ON s.employee_id = e.employee_id
	LEFT JOIN vehicles v ON s.vehicle_id = v.vehicle_id
	LEFT JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
	LEFT JOIN vehiclemake vmk ON vt.vehicle_make_id = vmk.vehicle_make_id
	WHERE vmk.name = 'Nissan'