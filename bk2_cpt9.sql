-- Which model of vehicle has the lowest current inventory? This will help dealerships know which models the purchase from manufacturers.
SELECT vmo.name AS model, SUM(v.vehicle_type_id) AS Total_Inventory FROM public.vehicles v
LEFT JOIN public.vehicletypes vt ON vt.vehicle_type_id = v.vehicle_type_id
LEFT JOIN public.vehiclemodel vmo ON vmo.vehicle_model_id = vt.vehicle_model_id
WHERE v.is_sold = false
GROUP BY vmo.name

-- Which model of vehicle has the highest current inventory? This will help dealerships know which models are, perhaps, not selling.
