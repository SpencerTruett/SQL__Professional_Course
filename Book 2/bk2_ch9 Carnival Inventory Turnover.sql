-- Which model of vehicle has the lowest current inventory? This will help dealerships know which models the purchase from manufacturers.
SELECT vmo.name AS model, SUM(v.vehicle_type_id) AS Total_Inventory FROM public.vehicles v
LEFT JOIN public.vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
LEFT JOIN public.vehiclemodel vmo ON vmo.vehicle_model_id = vt.vehicle_model_id
WHERE v.is_sold = false
GROUP BY vmo.name
ORDER BY total_inventory_highest DESC

-- Which model of vehicle has the highest current inventory? This will help dealerships know which models are, perhaps, not selling.
SELECT vmo.name AS model, SUM(v.vehicle_type_id) AS Total_Inventory FROM public.vehicles v
LEFT JOIN public.vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
LEFT JOIN public.vehiclemodel vmo ON vmo.vehicle_model_id = vt.vehicle_model_id
WHERE v.is_sold = false
GROUP BY vmo.name
ORDER BY total_inventory_lowest ASC

-- Which dealerships are currently selling the least number of vehicle models? This will let dealerships market vehicle models more effectively per region.
SELECT d.business_name, COUNT(vmd.name) AS number_of_models
	FROM vehicles v
	LEFT JOIN dealerships d ON v.dealership_location_id = d.dealership_id
	LEFT JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
	LEFT JOIN vehiclemodel vmd ON vt.vehicle_model_id = vmd.vehicle_model_id
	GROUP BY d.business_name
	ORDER BY number_of_models ASC

-- Which dealerships are currently selling the highest number of vehicle models? This will let dealerships know which regions have either a high population, or less brand loyalty.
SELECT d.business_name, COUNT(vmd.name) AS number_of_models
	FROM vehicles v
	LEFT JOIN dealerships d ON v.dealership_location_id = d.dealership_id
	LEFT JOIN vehicletypes vt ON v.vehicle_type_id = vt.vehicle_type_id
	LEFT JOIN vehiclemodel vmd ON vt.vehicle_model_id = vmd.vehicle_model_id
	GROUP BY d.business_name
	ORDER BY number_of_models DESC