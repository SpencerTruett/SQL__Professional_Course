--One of the main parts of our database that we normalized was Vehicles, Vehicle Body Types, Makes and Models. 
--Create a new table for the denormalized data and import Vehicles.csv. Use EXPLAIN to evaluate the performance 
--costs of reads and writes for the normalized data and the denormalized data.


CREATE VIEW vehiclesDenormalized AS
  SELECT 
	v.vehicle_id, 
	v.vin, 
	v.engine_type, 
	vbt.name AS body_type,
	vmk.name AS make,
	vmd.name AS model,
	v.exterior_color,
	v.interior_color,
	v.floor_price, 
	v.msr_price, 
	v.miles_count, 
	v.year_of_car, 
	v.is_sold, 
	v.is_new, 
	dealership_location_id
	FROM vehicles v
  INNER JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
  INNER JOIN vehiclebodytype vbt ON vt.vehicle_body_type_id = vbt.vehicle_body_type_id
  INNER JOIN vehiclemake vmk ON vt.vehicle_make_id = vmk.vehicle_make_id
  INNER JOIN vehiclemodel vmd ON vt.vehicle_model_id = vmd.vehicle_model_id
  
EXPLAIN SELECT 
	v.vehicle_id, 
	v.vin, 
	v.engine_type, 
	vbt.name AS body_type,
	vmk.name AS make,
	vmd.name AS model,
	v.exterior_color,
	v.interior_color,
	v.floor_price, 
	v.msr_price, 
	v.miles_count, 
	v.year_of_car, 
	v.is_sold, 
	v.is_new, 
	dealership_location_id
	FROM vehicles v
  INNER JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
  INNER JOIN vehiclebodytype vbt ON vt.vehicle_body_type_id = vbt.vehicle_body_type_id
  INNER JOIN vehiclemake vmk ON vt.vehicle_make_id = vmk.vehicle_make_id
  INNER JOIN vehiclemodel vmd ON vt.vehicle_model_id = vmd.vehicle_model_id
  
  
SELECT *
	FROM public.vehiclesdenormalized