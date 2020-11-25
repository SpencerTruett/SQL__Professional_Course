--Because Carnival is a single company, we want to ensure that there is consistency 
--in the data provided to the user. Each dealership has it's own website but we want 
--to make sure the website URL are consistent and easy to remember. Therefore, any time 
--a new dealership is added or an existing dealership is updated, we want to ensure that 
--the website URL has the following format: http://www.carnivalcars.com/{name of the 
--dealership with underscores separating words}.

CREATE FUNCTION format_website() 
  RETURNS TRIGGER 
  LANGUAGE PlPGSQL
AS $$
BEGIN 
	UPDATE dealerships d
	SET website = CONCAT ('http://www.carnivalcars.com/', REPLACE(LOWER(NEW.business_name), ' ', '_'))
	WHERE dealership_id = NEW.dealership_id;
RETURN NULL;
END
$$;
CREATE TRIGGER update_website
 	AFTER UPDATE OF 
			business_name 
	OR INSERT 
	ON dealerships
	FOR EACH ROW
	EXECUTE PROCEDURE format_website();
	
--If a phone number is not provided for a new dealership, set the phone number 
--to the default customer care number 777-111-0305.

CREATE FUNCTION set_default_phone() 
  RETURNS TRIGGER 
  LANGUAGE PlPGSQL
AS $$
BEGIN 
	IF NEW.phone IS NULL THEN
		UPDATE dealerships
		SET phone = '777-111-0305'
		WHERE dealership_id = NEW.dealership_id;
	END IF;
RETURN NEW;
END
$$;
CREATE TRIGGER missing_phone
  AFTER INSERT
  ON dealerships
  FOR EACH ROW
  EXECUTE PROCEDURE set_default_phone();
----- TESTING -----
INSERT INTO public.dealerships(
	 business_name, phone, city, state, website, tax_id)
	VALUES ( 'NSS Car Dealers', null, 'Nashville', 'TN', null, '1234567');
SELECT * FROM dealerships WHERE business_name = 'NSS Car Dealers';


--For accounting purposes, the name of the state needs to be part of the 
--dealership's tax id. For example, if the tax id provided is bv-832-2h-se8w 
--for a dealership in Virginia, then it needs to be put into the database as 
--bv-832-2h-se8w--virginia.

CREATE FUNCTION format_tax_id() 
  RETURNS TRIGGER 
  LANGUAGE PlPGSQL
AS $$

BEGIN 

	UPDATE dealerships
	SET tax_id = CONCAT (SPLIT_PART(tax_id,'--',1), '--', LOWER(state))
	WHERE dealership_id = NEW.dealership_id;

RETURN NULL;
END
$$;


CREATE TRIGGER update_tax_id
 	AFTER UPDATE OF 
			state
	OR INSERT 
	ON dealerships
	FOR EACH ROW
	EXECUTE PROCEDURE format_tax_id();

-- DROP FUNCTION format_tax_id;
-- DROP TRIGGER update_tax_id;

----- TESTING -----
SELECT * FROM dealerships WHERE dealership_id = 2;

UPDATE dealerships
SET state = 'Ohio'
WHERE dealership_id = 2;

ALTER TABLE dealerships
ALTER COLUMN tax_id TYPE varchar(255);

SELECT CONCAT (SPLIT_PART(tax_id,'--',1), '--', LOWER(state)) FROM dealerships
WHERE dealership_id = 2;