
-- 9. Candidatos con votación superior al promedio de su dignidad
SELECT c1.nombres, c1.apellidos, c1.votos
FROM candidatos c1
WHERE c1.votos > (
    SELECT AVG(c2.votos)
    FROM candidatos c2
    WHERE c2.id_dignidad = c1.id_dignidad
);

-- 10. Candidato con mayor votación por cantón
SELECT c1.nombres, c1.apellidos, c1.votos, c1.id_canton
FROM candidatos c1
WHERE c1.votos = (
    SELECT MAX(c2.votos)
    FROM candidatos c2
    WHERE c2.id_canton = c1.id_canton
);

-- 11. Organizaciones con más candidatos que el promedio
SELECT id_organizacion, COUNT(*) AS total_candidatos
FROM candidatos
GROUP BY id_organizacion
HAVING COUNT(*) > (
    SELECT AVG(conteo)
    FROM (
             SELECT COUNT(*) AS conteo
             FROM candidatos
             GROUP BY id_organizacion
         ) AS subconsulta
);

-- 12. Candidatos sin resultados electorales
SELECT nombres, apellidos
FROM candidatos
WHERE id_candidato NOT IN (
    SELECT id_candidato
    FROM resultados
);