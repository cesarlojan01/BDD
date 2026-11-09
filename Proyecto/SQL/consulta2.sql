use ganado;
SELECT f.nombre AS finca, p.nombre AS potrero, p.tipo_pasto, p.area_hectareas, p.estado
 FROM FINCA f JOIN POTRERO p ON p.id_finca = f.id_finca WHERE p.estado <> 'OCUPADO' ORDER BY f.nombre, p.nombre;