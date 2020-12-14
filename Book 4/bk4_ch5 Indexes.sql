--Let's take a look at how some of our queries perform? Take notes of how each query performs. 
--Then create indexes for each query below. Rerun your queries to see if they improve. 
--If they do not improve, why?

CREATE INDEX employee_type_id
ON employees (employee_type_id)

    SELECT * from Employees WHERE employee_type_id = 1


CREATE INDEX dealership_id 
ON sales (dealership_id)

    SELECT * from Sales WHERE dealership_id = 500;


CREATE INDEX state  
ON customers (state)

    SELECT * from customers WHERE state = 'CA';


CREATE INDEX year_of_car  
ON vehicles (year_of_car)

    SELECT * from vehicles where year_of_car BETWEEN 2018 AND 2020;


CREATE INDEX floor_price   
ON vehicles (floor_price)

    SELECT * from vehicles where floor_price < 30000;
