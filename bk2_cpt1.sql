-- Write a query that returns the business name, city, state, and website 
-- for each dealership. Use an alias for the Dealerships table.
SELECT business_name, city, state, website
	FROM public.dealerships;
	
-- Write a query that returns the first name, last name, and email address of every customer. 
-- Use an alias for the Customers table.
SELECT  cust.first_name, cust.last_name, cust.email
	FROM public.customers AS cust;