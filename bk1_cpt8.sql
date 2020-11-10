-- Pick two of your friends or family and write a single INSERT statement to add both of them to the Customers table.
INSERT INTO 
public.customers(customer_id, first_name, last_name, email, phone, street, city, state, zipcode, company_name)
VALUES 
('John', 'Gilliam', 'J@g.com', '615-123-4567', '123 S. Main St.', 'Dickson', 'TN', '37055', 'Gilliam Industries'),
('Matthew', 'McLendon', 'm@m.com', '615-987-6543', '765 N. First St.', 'Dickson', 'TN', '37055', 'Matt Tech');

-- Think of your dream car. In order to add this car to the Vehicles table, you might need to add data to the VehicleTypes table. 
-- Make sure the statements are ordered so that you can execute all your INSERT statements together.
INSERT INTO 
public.vehicles(vin, engine_type, vehicle_type_id, exterior_color, interior_color, floor_price, msr_price, miles_count, year_of_car, is_sold, is_new, dealership_location_id)
VALUES ('1SNYD38247H830440', 'V8', 1, 'red', 'black', 39894, 18225, 10, 2005, false, false, 22);

-- Use INSERT statements to add a new employee with the following info. 
-- This employee works shifts at the first three dealerships listed in your Dealerships table:
INSERT INTO 
public.employees(first_name, last_name, email_address, phone, employee_type_id)
VALUES ('Kennie', 'Maharg', 'kmaharge@com.com', '598-678-4885', 4);

INSERT INTO 
public.dealershipemployees(dealership_id, employee_id)
	VALUES 
	(1, 1001),
	(2, 1001),
	(3, 1001);