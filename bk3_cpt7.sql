--Write a transaction to:
    --Add a new role for employees called Automotive Mechanic
    --Add five new mechanics, their data is up to you
    --Each new mechanic will be working at all three of these dealerships: 
	--Meeler Autos of San Diego, Meadley Autos of California and Major Autos of Florida
	
do $$ 
DECLARE
EmployeeTypeId int;
NewEmp1 int;
NewEmp2 int;
NewEmp3 int;
NewEmp4 int;
NewEmp5 int;
BEGIN
-- add new role
IF NOT EXISTS
	(SELECT employee_type_id FROM employeetypes WHERE name = 'Automotive Mechanic')
THEN
	 INSERT INTO employeetypes (name)
	 VALUES('Automotive Mechanic');
COMMIT;
EmployeeTypeId = SELECT employee_type_id FROM employeetypes WHERE name = 'Automotive Mechanic';
-- add new employees
INSERT INTO employeees (first_name, last_name, email_address, phone, employee_type_id)
    VALUES ('Will', 'Thombleson', 'wthombleson0@adobe.com', '649-212-7339', EmployeeTypeId)
	RETURNING employee_id INTO NewEmp1;
INSERT INTO employeees (first_name, last_name, email_address, phone, employee_type_id)
    VALUES 			('Daron', 'Harrowing', 'dharrowing1@miitbeian.gov.cn', '506-168-8192', EmployeeTypeId)
	RETURNING employee_id INTO NewEmp2;
INSERT INTO employeees (first_name, last_name, email_address, phone, employee_type_id)
    VALUES 			('Mari', 'Baldrick', 'mbaldrick2@zimbio.com', '427-939-0387', EmployeeTypeId)
	RETURNING employee_id INTO NewEmp3;
INSERT INTO employeees (first_name, last_name, email_address, phone, employee_type_id)
    VALUES 			('Stevie', 'Dymock', 'sdymock3@sfgate.com', '594-807-1375', EmployeeTypeId)
	RETURNING employee_id INTO NewEmp4;
INSERT INTO employeees (first_name, last_name, email_address, phone, employee_type_id)
    VALUES 			('Roana', 'Brideau', 'rbrideau4@state.gov', '134-229-8012', EmployeeTypeId)
	RETURNING employee_id INTO NewEmp5;
COMMIT;
-- set employees at dealerships
INSERT INTO dealershipemployees (dealership_id, employee_id)
	VALUES (50, NewEmp1),
			(36, NewEmp1),
			(20, NewEmp1),
			(50, NewEmp2),
			(36, NewEmp2),
			(20, NewEmp2),
			(50, NewEmp3),
			(36, NewEmp3),
			(20, NewEmp3),
			(50, NewEmp4),
			(36, NewEmp4),
			(20, NewEmp4),
			(50, NewEmp5),
			(36, NewEmp5),
			(20, NewEmp5)
COMMIT;
$$ language plpgsql;

--Create a transaction for:
    --Creating a new dealership in Washington, D.C. called Felphun Automotive
    --Hire 3 new employees for the new dealership: Sales Manager, General 
	--Manager and Customer Service.
    --All employees that currently work at Nelsen Autos of Illinois will now 
	--start working at Cain Autos of Missouri instead.
	

