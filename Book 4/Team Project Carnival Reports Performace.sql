-- Indexes created to ease the speed of Select  for commonly searched categories
CREATE OR REPLACE INDEX customer_last_name ON customers(last_name);
CREATE OR REPLACE INDEX employee_last_name ON employees(last_name);
CREATE OR REPLACE INDEX vehicle_make_index ON vehicletypes (make);
CREATE OR REPLACE INDEX vehicle_body_type_index ON vehicletypes(body_type);
CREATE OR REPLACE INDEX vehicle_model_index ON vehicletypes(model);
CREATE OR REPLACE INDEX dealership_name ON dealerships(business_name);
CREATE OR REPLACE INDEX vehicles_type_id ON vehicles(vehicle_type_id);


--quick view of employees and their associated dealerships
CREATE VIEW employee_dealership_names_view AS
  SELECT 
    CONCAT(e.first_name, ' ', e.last_name) name,
    d.business_name
  FROM employees e
  INNER JOIN dealershipemployees de ON e.employee_id = de.employee_id
  INNER JOIN dealerships d ON d.dealership_id = de.dealership_id;
  
  
-- accounting (sales, customers, dealerships, employees)
CREATE VIEW accounting_view AS
  SELECT 
  s.sale_id, 
  st.name sales_type, 
  v.year_of_car,
  vmk.name make,
  vmd.name model,
  vbt.name body_type,
  CONCAT(e.first_name, ' ', e.last_name) employee_name, 
  CONCAT(c.first_name, ' ', c.last_name) customer_name, 
  d.business_name, 
  s.price, 
  s.deposit, 
  s.purchase_date, 
  s.pickup_date, 
  s.invoice_number, 
  s.payment_method, 
  s.sale_returned
  FROM sales s
  JOIN salestypes st ON st.sales_type_id = s.sales_type_id
  JOIN vehicles v ON v.vehicle_id = s.vehicle_id
  JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
  JOIN vehiclebodytype vbt ON vbt.vehicle_body_type_id = vt.body_type
  JOIN vehiclemake vmk ON vmk.vehicle_make_id = vt.make
  JOIN vehiclemodel vmd ON vmd.vehicle_model_id = vt.model
  JOIN employees e ON e.employee_id = s.employee_id
  JOIN customers c ON c.customer_id = s.customer_id
  JOIN dealerships d ON d.dealership_id = d.dealership_id;
  
  
-- vehicle type expanded (all FK data)
CREATE VIEW vehicle_types_view AS
  SELECT
  v.year_of_car,
  vmk.name make,
  vmd.name model,
  vbt.name body_type
  FROM vehicles v
  JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
  JOIN vehiclebodytype vbt ON vbt.vehicle_body_type_id = vt.body_type
  JOIN vehiclemake vmk ON vmk.vehicle_make_id = vt.make
  JOIN vehiclemodel vmd ON vmd.vehicle_model_id = vt.model;
  
  
-- Vehicle maintenance log (Show vehicle repairs and oil changes)
-- Union on repair types and oil change logs JOIN vehicles
CREATE VIEW vehicle_maintenance_view AS 
  SELECT
  v.vehicle_id,
  v.year_of_car,
  vmk.name make,
  vmd.name model,
  vbt.name body_type,
  crt.date_occured repair_date,
  rt.name repair_type_name,
  oc.date_occured oil_change_date
  FROM vehicles v
  JOIN vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
  JOIN vehiclebodytype vbt ON vbt.vehicle_body_type_id = vt.body_type
  JOIN vehiclemake vmk ON vmk.vehicle_make_id = vt.make
  JOIN vehiclemodel vmd ON vmd.vehicle_model_id = vt.model
  LEFT JOIN carrepairtypelogs crt ON crt.vehicle_id = v.vehicle_id
  LEFT JOIN repairtypes rt ON rt.repair_type_id = crt.repair_type_id
  LEFT JOIN oilchangelogs oc ON oc.vehicle_id = v.vehicle_id
  ORDER BY v.vehicle_id;
  
  
-- INSERT INTO public.carrepairtypelogs(
-- 	date_occured, vehicle_id, repair_type_id)
-- 	VALUES (current_date, 1, 1);
CREATE TABLE payments
(payment_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1),
payment_amount numeric (8, 2),
customer_id integer,
sale_id integer,
payment_date date,
CONSTRAINT payments_customer_id FOREIGN KEY (customer_id) 
REFERENCES customers (customer_id),
CONSTRAINT payments_sale_id FOREIGN KEY (sale_id) 
REFERENCES sales (sale_id));


-- DROP TABLE payments;

-- View created to track as a customer pays off thier car
CREATE OR REPLACE VIEW payments_and_balance AS
	SELECT 
		s.sale_id,
		s.price AS price,
		s.deposit AS deposit_amount,
		SUM(p.payment_amount) AS payment_total,
		s.price - s.deposit - SUM(p.payment_amount) AS balance
	FROM payments p
	JOIN sales s ON s.sale_id = p.sale_id
	GROUP BY s.sale_id
	

-- Procedure to make payments on a car using a sale_id and the amount
CREATE OR REPLACE PROCEDURE make_payment(
	IN p_payment_amount numeric (8, 2),
	IN p_sale_id integer	
)
LANGUAGE plpgsql
AS $$
DECLARE customer_id INT;
BEGIN
customer_id = (SELECT s.customer_id FROM sales s
	WHERE s.sale_id = p_sale_id),
deposit_amount = (SELECT s.deposit FROM sales s
	WHERE s.sale_id = p_sale_id);
INSERT INTO payments(payment_amount, customer_id, deposit_amount, sale_id, payment_date)
VALUES (p_payment_amount, customer_id, p_sale_id, current_date);
END
$$;

--The associated Call for the above Procedure
CALL make_payment(3000.00, 4988);


-- INSERT INTO public.payments(
-- 	payment_amount, customer_id, sale_id, payment_date)
-- 	VALUES (2000, 123, 4995, current_date);
	
	