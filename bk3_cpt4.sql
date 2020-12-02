CREATE OR REPLACE PROCEDURE sell_car(
	IN p_vehicle_id integer,
	IN p_sales_type_id integer,
	IN p_employee_id integer,
	IN p_customer_id integer,
	IN p_dealership_id integer,
	IN p_price numeric,
	IN p_deposit integer,
	IN p_purchase_date date,
	IN p_pickup_date date,
	IN p_invoice_number varchar,
	IN p_payment_method varchar
)
LANGUAGE plpgsql
AS $$
BEGIN
UPDATE vehicles
	SET is_sold = true
	WHERE vehicle_id = p_vehicle_id;
INSERT INTO sales(sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method)
VALUES (p_sales_type_id, p_vehicle_id, p_employee_id, p_customer_id, p_dealership_id, p_price, p_deposit, p_purchase_date, p_pickup_date, p_invoice_number, p_payment_method);
END
$$;
CALL sell_car(1, 1, 2, 1, 1, 20000.00, 1, '2020-11-09', '2020-11-10', '123456789', 'mastercard');
SELECT sale_id FROM sales WHERE invoice_number = '123456789';


________________________
________________________


CREATE PROCEDURE return_car(
	IN p_sale_id integer,
	IN p_vehicle_id integer,
	IN p_date_occured timestamp with time zone
)
LANGUAGE plpgsql
AS $$
BEGIN
UPDATE sales
	SET sale_returned = true
	WHERE sale_id = p_sale_id;
INSERT INTO oilchangelogs(date_occured, vehicle_id)
VALUES (p_date_occured, p_vehicle_id);
END
$$;
CALL return_car(5006, 1, '2020-11-10 00:00-06');