--Set up a trigger on the Sales table. When a new row is added, add a new record 
--to the Accounts Receivable table with the deposit as credit_amount, the timestamp 
--as date_received and the appropriate sale_id.


 CREATE TABLE accounts_receivable
 (
 	accounts_receivable_id integer NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 ),
	credit_amount numeric(8,2),
	debit_amount numeric(8,2),
	date_received date,
	sale_id integer,
	CONSTRAINT accounts_receivable_sale_id_fkey FOREIGN KEY (sale_id)
       REFERENCES public.sales (sale_id)
)
CREATE FUNCTION create_revenue_record()
  RETURNS TRIGGER
  LANGUAGE PlPGSQL
AS $$
BEGIN
  -- trigger function logic
  INSERT INTO accounts_receivable(credit_amount, debit_amount, date_received, sale_id)
  VALUES (
  (SELECT price - deposit
   FROM sales
   ORDER BY sale_id DESC
   LIMIT 1
  ),
  (SELECT deposit
   FROM sales
   ORDER BY sale_id DESC
   LIMIT 1
  ),
  (SELECT purchase_date
   FROM sales
   ORDER BY sale_id DESC
   LIMIT 1
  ),
  (SELECT sale_id
   FROM sales
   ORDER BY sale_id DESC
   LIMIT 1
  )
  );
  RETURN NULL;
END;
$$
 CREATE TRIGGER sales_record_revenue
  AFTER INSERT
  ON sales
  FOR EACH ROW
  EXECUTE PROCEDURE create_revenue_record();
INSERT INTO public.sales(
	sales_type_id, vehicle_id, employee_id, customer_id, dealership_id, price, deposit, purchase_date, pickup_date, invoice_number, payment_method, sale_returned)
	VALUES (1, 10001, 497, 328, 1, 53725.80, 1455, '2020-12-01', '2020-12-08', '769486103', 'JCV', NULL);


--Set up a trigger on the Sales table for when the sale_returned flag is updated. 
--Add a new row to the Accounts Receivable table with the deposit as debit_amount, 
--the timestamp as date_received, etc.



CREATE FUNCTION return_vehicle_record()
  RETURNS TRIGGER
  LANGUAGE PlPGSQL
AS $$
BEGIN
  -- trigger function logic
  INSERT INTO accounts_receivable(credit_amount, debit_amount, date_received, sale_id)
  VALUES (NULL, NEW.deposit, CURRENT_DATE, NEW.sale_id);
  RETURN NULL;
END;
$$
 CREATE TRIGGER return_vehicle_trigger
  AFTER UPDATE
  ON sales
  FOR EACH ROW
  EXECUTE PROCEDURE return_vehicle_record();
UPDATE sales
SET sale_returned = true
WHERE sale_id = 5001;
CREATE PROCEDURE add_employee(IN a varchar, INOUT b varchar)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO employees(first_name, last_name, email_address, phone, employee_type_id)
	VALUES (a);
	INSERT INTO dealershipemployees(employee_id, dealership_id)
	VALUES (b);
END
$$;


--Create a stored procedure with a transaction to handle hiring a 
--new employee. Add a new record for the employee in the Employees table and 
--add a record to the Dealershipemployees table for the two dealerships the new 
--employee will start at.

CREATE OR REPLACE PROCEDURE add_employee(
	IN p_first_name varchar,
	IN p_last_name varchar,
	IN p_email_address varchar,
	IN p_phone varchar,
	IN p_employee_type_id integer,
	IN p_dealership_id integer,
	IN p_dealership_id2 integer
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO employees(first_name, last_name, email_address, phone, employee_type_id)
	VALUES (p_first_name, p_last_name, p_email_address, p_phone, p_employee_type_id);
	INSERT INTO dealershipemployees(employee_id, dealership_id)
	VALUES
	((
	SELECT employee_id
	FROM employees
	ORDER BY employee_id DESC
	LIMIT 1
), p_dealership_id),
	((
	SELECT employee_id
	FROM employees
	ORDER BY employee_id DESC
	LIMIT 1
), p_dealership_id2);
END
$$;
CALL add_employee('Spencer', 'Bennett', 'sb@gmail.com', '615-899-0000', 1, 1, 2);



--Create a stored procedure with a transaction to handle an employee leaving. 
--The employee record is removed and all records associating the employee with 
--dealerships must also be removed.



CREATE OR REPLACE PROCEDURE delete_employee(IN employeeId int)
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM employees
	WHERE employee_id = employeeId;
	DELETE FROM dealershipemployees
	WHERE employee_id = employeeId;
END
$$;
CALL delete_employee(1003);