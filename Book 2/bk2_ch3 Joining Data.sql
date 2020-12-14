-- Get a list of the sales that were made for each sales type.
SELECT st.name AS sales_type, s.vehicle_id, s.employee_id, s.customer_id, s.dealership_id, s.price, s.deposit, s.purchase_date, s.pickup_date, s.invoice_number, s.payment_method, s.sale_returned
	FROM public.sales s
	LEFT JOIN salestypes st ON s.sales_type_id = st.sales_type_id

-- Get a list of sales with the VIN of the vehicle, the first name and last name of the customer, first name and last name 
-- of the employee who made the sale and the name, city and state of the dealership.
SELECT s.sale_id, v.vin, c.first_name, c.last_name
	FROM public.sales s
	LEFT JOIN vehicles v ON s.vehicle_id = v.vehicle_id
	LEFT JOIN customers c ON s.customer_id = c.customer_id
	
-- Get a list of all the dealerships and the employees, if any, working at each one.
SELECT d.business_name, e.first_name, e.last_name
	FROM public.dealershipemployees de
	LEFT JOIN dealerships d ON de.dealership_id = d.dealership_id
	LEFT JOIN employees e ON e.employee_id = e.employee_id;
	
-- Get a list of vehicles with the names of the body type, make, model and color.
SELECT v.year_of_car, v.exterior_color, vbt.name as body_type, vmk.name AS make, vmd.name AS model
FROM public.vehicletypes vt
LEFT JOIN vehicles v ON vt.vehicle_type_id = v.vehicle_type_id
LEFT JOIN vehiclebodytype vbt ON vt.vehicle_body_type_id = vbt.vehicle_body_type_id
LEFT JOIN vehiclemake vmk ON vt.vehicle_make_id = vmk.vehicle_make_id
LEFT JOIN vehiclemodel vmd ON vt.vehicle_model_id = vmd.vehicle_model_id
