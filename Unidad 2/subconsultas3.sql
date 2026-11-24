SELECT c.nombres, c.apellidos,
       (SELECT d.nombre FROM dignidades d WHERE d.id_dignidad = c.id_dignidad) AS dignidad,
       r.votos
FROM candidatos c
JOIN resultados r ON r.id_candidato = c.id_candidato
WHERE r.votos > (
    SELECT AVG(r2.votos)
    FROM resultados r2
    JOIN candidatos c2 ON c2.id_candidato = r2.id_candidato
    WHERE c2.id_dignidad = c.id_dignidad
)
ORDER BY dignidad, r.votos DESC;

SELECT (SELECT ca.nombre FROM cantones ca WHERE ca.id_canton = c.id_canton) AS canton,
       c.nombres, c.apellidos, r.votos
FROM candidatos c
JOIN resultados r ON r.id_candidato = c.id_candidato
WHERE r.votos = (
    SELECT MAX(r2.votos)
    FROM resultados r2
    JOIN candidatos c2 ON c2.id_candidato = r2.id_candidato
    WHERE c2.id_canton = c.id_canton
)
ORDER BY canton;


SELECT o.nombre, o.siglas,
       (SELECT COUNT(*) FROM candidatos c WHERE c.id_organizacion = o.id_organizacion) AS total_candidatos
FROM organizaciones_politicas o
WHERE (
    SELECT COUNT(*)
    FROM candidatos c
    WHERE c.id_organizacion = o.id_organizacion
) > (
    SELECT COUNT(*) * 1.0 / (SELECT COUNT(*) FROM organizaciones_politicas)
    FROM candidatos
)
ORDER BY total_candidatos DESC;

SELECT c.id_candidato, c.nombres, c.apellidos
FROM candidatos c
WHERE NOT EXISTS (
    SELECT 1
    FROM resultados r
    WHERE r.id_candidato = c.id_candidato
);