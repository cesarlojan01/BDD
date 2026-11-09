use ganado;
SELECT a.id_animal, a.raza, a.fecha_ingreso FROM ANIMAL a WHERE a.estado = 'ACTIVO' AND a.arete IS NULL;