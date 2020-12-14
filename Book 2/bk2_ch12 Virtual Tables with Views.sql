-- Create a view that lists all vehicle body types, makes and models.
CREATE VIEW body_types_makes_models AS
  SELECT 
		vbt.name AS body_type,
		vmk.name AS make,
		vmd.name AS model
  FROM vehicletypes vt
  INNER JOIN vehiclebodytype vbt ON vt.vehicle_body_type_id = vbt.vehicle_body_type_id
  INNER JOIN vehiclemake vmk ON vt.vehicle_make_id = vmk.vehicle_make_id
  INNER JOIN vehiclemodel vmd ON vt.vehicle_model_id = vmd.vehicle_model_id
  
-- Create a view that shows the total number of employees for each employee type.
CREATE VIEW employees_of_each_type AS
	SELECT
		et.name AS department_name,
		COUNT(e.employee_type_id)
	FROM employees e
	INNER JOIN employeetypes et ON e.employee_type_id = et.employee_type_id
	GROUP BY et.name
	
-- Create a view that lists all customers without exposing their emails, phone numbers and street address.
CREATE VIEW customers_reduced AS
	SELECT
		c.first_name, 
		c.last_name, 
		c.city, 
		c.state, 
		c.zipcode, 
		c.company_name
	FROM customers c

-- Create a view named sales2018 that shows the total number of sales for each sales type for the year 2018.
CREATE VIEW sales2018 AS
	SELECT
		st.name AS sales_type,
		COUNT(s.sales_type_id)
	FROM sales s
	INNER JOIN salestypes st ON s.sales_type_id = st.sales_type_id
	WHERE s.purchase_date BETWEEN '2018-01-01' AND '2018-12-31'
	GROUP BY st.name

-- Create a view that shows the employee at each dealership with the most number of sales.
CREATE VIEW employee_most_sales AS
	SELECT
		CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
		d.business_name,
		COUNT(e.employee_id)
	FROM sales s
	INNER JOIN dealerships d ON s.dealership_id = d.dealership_id
	INNER JOIN employees e ON s.employee_id = e.employee_id
	GROUP BY employee_name, d.business_name

