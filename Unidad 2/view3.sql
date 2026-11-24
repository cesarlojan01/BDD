CREATE OR REPLACE VIEW vw_resultados_consolidados AS
SELECT
    d.nombre              AS dignidad,
    p.nombre              AS provincia,
    ca.nombre             AS canton,
    COUNT(c.id_candidato) AS total_candidatos,
    COALESCE(SUM(r.votos), 0) AS total_votos,
    MAX(r.votos)          AS votacion_maxima
FROM candidatos c
JOIN dignidades d    ON d.id_dignidad   = c.id_dignidad
JOIN cantones ca     ON ca.id_canton    = c.id_canton
JOIN provincias p    ON p.id_provincia  = ca.id_provincia
LEFT JOIN resultados r ON r.id_candidato = c.id_candidato
GROUP BY d.nombre, p.nombre, ca.nombre;
