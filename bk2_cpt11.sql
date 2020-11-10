-- What are the top 5 US states with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform?
SELECT c.state, COUNT(c.state) AS number_of_sales
	FROM sales s 
	LEFT JOIN customers c ON s.customer_id = c.customer_id
	GROUP BY c.state
	ORDER BY number_of_sales DESC
	LIMIT 5
	
-- What are the top 5 US zipcodes with the most customers who have purchased a vehicle from a dealership participating in the Carnival platform?
SELECT c.zipcode, COUNT(c.zipcode) AS number_of_sales
	FROM sales s 
	LEFT JOIN customers c ON s.customer_id = c.customer_id
	GROUP BY c.zipcode
	ORDER BY number_of_sales DESC
	LIMIT 5
	
-- What are the top 5 dealerships with the most customers?
SELECT d.business_name, COUNT(s.customer_id) AS number_of_customers
	FROM sales s 
	LEFT JOIN dealerships d ON s.dealership_id = d.dealership_id
	LEFT JOIN customers c ON s.customer_id = c.customer_id
	GROUP BY d.business_name
	ORDER BY number_of_customers DESC
	LIMIT 5
	
