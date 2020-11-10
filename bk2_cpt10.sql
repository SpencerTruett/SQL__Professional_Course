-- How many emloyees are there for each role?
SELECT et.name, COUNT(e.employee_type_id)
	FROM employees e
	LEFT JOIN employeetypes et ON e.employee_type_id = et.employee_type_id
	GROUP BY et.name
	
-- How many finance managers work at each dealership?
SELECT d.business_name, COUNT(e.employee_type_id)
	FROM dealershipemployees de
	LEFT JOIN employees e ON de.employee_id = e.employee_id
	LEFT JOIN dealerships d ON de.dealership_id = d.dealership_id
	WHERE e.employee_type_id = 2
	GROUP BY d.business_name
	
-- Get the names of the top 3 employees who work shifts at the most dealerships?
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name, COUNT(de.employee_id) AS number_of_shifts
	FROM dealershipemployees de
	LEFT JOIN employees e ON de.employee_id = e.employee_id
	LEFT JOIN dealerships d ON de.dealership_id = d.dealership_id
	GROUP BY employee_name
	ORDER BY number_of_shifts DESC
	LIMIT 3
	
-- Get a report on the top two employees who has made the most sales through leasing vehicles.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS employee_name, COUNT(s.employee_id) number_of_sales
	FROM sales s 
	LEFT JOIN employees e ON s.employee_id = e.employee_id
	WHERE s.sales_type_id = 2
	GROUP BY employee_name
	ORDER BY number_of_sales DESC
	LIMIT 2
