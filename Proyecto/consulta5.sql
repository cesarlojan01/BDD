use ganado;
SELECT   v.comprador,
         COUNT(d.id_animal)          AS animales,
         ROUND(SUM(d.peso_venta_kg), 2) AS kg_vendidos,
         ROUND(AVG(d.precio_kg), 2)  AS precio_promedio_kg,
         ROUND(SUM(d.sub_total), 2)  AS ingreso_total
FROM     venta v
JOIN     venta_detalle d ON v.id_venta = d.id_venta
GROUP BY v.comprador;