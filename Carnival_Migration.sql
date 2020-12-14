-- Code must be run in individual blocks (ie not in order)

CREATE TABLE vehiclebodytype (
vehicle_body_type_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
name VARCHAR(20)
);

CREATE TABLE vehiclemodel (
vehicle_model_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
name VARCHAR(20)
);

CREATE TABLE vehiclemake (
vehicle_make_id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
name VARCHAR(20)
);

ALTER TABLE vehicleTypes
  RENAME COLUMN body_type TO vehicle_body_type_id;
ALTER TABLE vehicleTypes
  RENAME COLUMN make TO vehicle_make_id;
ALTER TABLE vehicleTypes
  RENAME COLUMN model TO vehicle_model_id;

UPDATE vehicleTypes 
SET vehicle_body_type_id =  CASE  
					WHEN vehicle_body_type_id = 'Car' THEN '1' 
					WHEN vehicle_body_type_id = 'Truck' THEN '2'
					WHEN vehicle_body_type_id = 'Van' THEN '3'
					WHEN vehicle_body_type_id = 'SUV' THEN '4'
					ELSE null
                 END ;
				 
UPDATE vehicleTypes 				 
SET      vehicle_make_id = CASE  
					WHEN vehicle_make_id = 'Chevrolet' THEN '1' 
					WHEN vehicle_make_id = 'Mazda' THEN '2'
					WHEN vehicle_make_id = 'Nissan' THEN '3'
					WHEN vehicle_make_id = 'Ford' THEN '4'
					WHEN vehicle_make_id = 'Volkswagen' THEN '5'
					ELSE null
				  END ;
				  
UPDATE vehicleTypes 
SET     vehicle_model_id =  CASE  
					WHEN vehicle_model_id = 'Corvette' THEN '1' 
					WHEN vehicle_model_id = 'Blazer' THEN '2'
					WHEN vehicle_model_id = 'Silverado' THEN '3'
					WHEN vehicle_model_id = 'MX-5 Miata' THEN '4'
					WHEN vehicle_model_id = 'CX-5' THEN '5'
					WHEN vehicle_model_id = 'CX-9' THEN '6' 
					WHEN vehicle_model_id = 'Maxima' THEN '7'
					WHEN vehicle_model_id = 'Altima' THEN '8'
					WHEN vehicle_model_id = 'Titan' THEN '9'
					WHEN vehicle_model_id = 'Fusion' THEN '10'
					WHEN vehicle_model_id = 'EcoSport' THEN '11'
					WHEN vehicle_model_id = 'F-250' THEN '12'
					WHEN vehicle_model_id = 'Beetle' THEN '13'
					WHEN vehicle_model_id = 'Passat' THEN '14'
					WHEN vehicle_model_id = 'Atlas' THEN '15'
					WHEN vehicle_model_id = 'Transit-150 Cargo' THEN '16'
					ELSE null
				 END ;
				 
ALTER TABLE vehicleTypes
  ALTER COLUMN vehicle_body_type_id TYPE INTEGER USING (vehicle_body_type_id::integer);
ALTER TABLE vehicleTypes
  ALTER COLUMN vehicle_make_id TYPE INTEGER USING (vehicle_make_id::integer);
ALTER TABLE vehicleTypes
  ALTER COLUMN vehicle_model_id TYPE INTEGER USING (vehicle_model_id::integer);
  

-- Must import the .csv files into the tables before attempting to add foreign key constraints

  
ALTER TABLE vehicleTypes
   ADD CONSTRAINT FK_vehicleTypes_vehicleBodyType FOREIGN KEY (vehicle_body_type_id)
      REFERENCES vehicleBodyType (vehicle_body_type_id),
   ADD CONSTRAINT FK_vehicleTypes_vehicleModel FOREIGN KEY (vehicle_model_id)
      REFERENCES vehicleModel (vehicle_model_id),
   ADD CONSTRAINT FK_vehicleTypes_vehicleMake FOREIGN KEY (vehicle_make_id)
      REFERENCES vehicleMake (vehicle_make_id);
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  