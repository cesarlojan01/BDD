use ganado ;
SELECT l.id_lote, l.nombre_lote, COUNT(DISTINCT a.raza) AS razas
FROM   LOTE_GANADO l
JOIN   ANIMAL a ON a.id_lote = l.id_lote
GROUP  BY l.id_lote, l.nombre_lote
HAVING COUNT(DISTINCT a.raza) = (SELECT COUNT(DISTINCT raza) FROM ANIMAL);
