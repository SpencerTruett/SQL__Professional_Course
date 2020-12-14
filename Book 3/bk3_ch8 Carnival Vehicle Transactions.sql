--Adding 5 brand new 2021 Honda CR-Vs to the inventory. They have I4 engines 
--and are classified as a Crossover SUV or CUV. All of them have beige interiors 
--but the exterior colors are Lilac, Dark Red, Lime, Navy and Sand. The floor price 
--is $21,755 and the MSR price is $18,999.

INSERT INTO public.vehiclemake(
	name)
	VALUES ('Honda');
	
INSERT INTO vehiclemodel(
	name)
	VALUES('CRV');
	
INSERT INTO vehicletypes(
	body_type, make, model)
	VALUES(4, 6, 17);
-- start a transaction
BEGIN;
-- You can also use BEGIN TRANSACTION; or BEGIN WORK;
-- insert a new row into the sales type table
-- Adding 5 brand new 2021 Honda CR-Vs to the inventory.
-- They have I4 engines and are classified as a Crossover SUV or CUV.
-- All of them have beige interiors
-- but the exterior colors are Lilac, Dark Red, Lime, Navy and Sand.
-- The floor price is $21,755 and the MSR price is $18,999.
INSERT INTO public.vehicles(
	vin, engine_type, vehicle_type_id, exterior_color, interior_color, floor_price, msr_price, miles_count, year_of_car, is_sold, is_new, dealership_location_id)
	VALUES ('555', 'I4', 31, 'Lilac', 'Beige', 21755, 18999, 0, 2021, false, true, 1),
	('556', 'I4', 31, 'Dark Red', 'Beige', 21755, 18999, 0, 2021, false, true, 2),
	('557', 'I4', 31, 'Lime', 'Beige', 21755, 18999, 0, 2021, false, true, 3),
	('558', 'I4', 31, 'Navy', 'Beige', 21755, 18999, 0, 2021, false, true, 4),
	('559', 'I4', 31, 'Sand', 'Beige', 21755, 18999, 0, 2021, false, true, 5);
	
SAVEPOINT afterinsertion;
-- commit the change
COMMIT;
-- You can also use COMMIT TRANSACTION; or COMMIT WORK;
SELECT * FROM vehicles
WHERE engine_type = 'I4';

--For the CX-5s and CX-9s in the inventory that have not been sold, change the year 
--of the car to 2021 since we will be updating our stock of Mazdas. For all other unsold 
--Mazdas, update the year to 2020. The newer Mazdas all have red and black interiors.

BEGIN;
UPDATE vehicles v
SET year_of_car=2021
WHERE vehicle_type_id IN
(SELECT vehicle_type_id FROM vehicletypes WHERE vehicle_model_id in (5,6))
AND v.is_sold = false;
COMMIT;

--The vehicle with VIN KNDPB3A20D7558809 has been brought in for servicing. 
--Document that the service department did a tire change, windshield wiper 
--fluid refill and an oil change.

-- start a transaction
BEGIN;
-- You can also use BEGIN TRANSACTION; or BEGIN WORK;
SAVEPOINT foo;
INSERT INTO public.carrepairtypelogs(
	date_occured, vehicle_id, repair_type_id)
	VALUES (CURRENT_DATE, 651, 21), (CURRENT_DATE, 651, 22);
	
INSERT INTO public.oilchangelogs(
	date_occured, vehicle_id)
	VALUES (CURRENT_DATE, 651);
COMMIT;
ROLLBACK
SELECT * FROM carrepairtypelogs where vehicle_id = 651