use ganado ;
SELECT a.arete, a.raza, p.nombre AS potrero, p.tipo_pasto, e.fecha_entrada 
FROM animal a 
JOIN estancia e ON a.id_animal = e.id_animal 
JOIN potrero p ON e.id_potrero = p.id_potrero 
JOIN finca f ON p.id_finca = f.id_finca 
WHERE a.estado = 'ACTIVO' AND e.fecha_salida IS NULL AND f.nombre = 'Finca Engorde';
