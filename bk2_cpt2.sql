-- Get a list of sales records where the sale was a lease.
SELECT * FROM public.sales
	WHERE sales_type_id = 2;
	
-- Get a list of sales where the purchase date is within the last two years.
SELECT * FROM public.sales
	WHERE purchase_date >= '2018-11-01';
	
-- Get a list of sales where the deposit was above 5000 or the customer payed with American Express.
SELECT * FROM public.sales
	WHERE deposit >= 5000 OR LOWER(payment_method) LIKE '%american%express%';
	
-- Get a list of employees whose first names start with "M" or ends with "E".
SELECT * FROM public.employees
	WHERE LOWER(first_name) LIKE 'm%' OR first_name LIKE '%e'
	
-- Get a list of employees whose phone numbers have the 600 area code.
SELECT * FROM public.employees
	WHERE phone LIKE '6%'
	