use ganado;
SELECT c.documento, c.proveedor, c.fecha_compra, COUNT(a.id_animal) AS animales, ROUND(c.costo_total / COUNT(a.id_animal), 2) AS costo_por_animal, SUM(CASE WHEN a.estado = 'ACTIVO' THEN 1 ELSE 0 END) AS activos, SUM(CASE WHEN a.estado = 'VENDIDO' THEN 1 ELSE 0 END) AS vendidos
 FROM COMPRA_GANADO c JOIN ANIMAL a ON a.id_compra = c.id_compra JOIN LOTE_GANADO l ON l.id_lote = a.id_lote 
 GROUP BY c.id_compra, c.documento, c.proveedor, c.fecha_compra, c.costo_total HAVING COUNT(a.id_animal) >= 2 ORDER BY costo_por_animal DESC;