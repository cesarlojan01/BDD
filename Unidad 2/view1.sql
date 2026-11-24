CREATE OR REPLACE VIEW vw_candidatos AS
SELECT
    c.id_candidato,
    c.nombres,
    c.apellidos,
    o.nombre   AS organizacion_politica,
    o.siglas,
    d.nombre   AS dignidad,
    ca.nombre  AS canton,
    p.nombre   AS provincia
FROM candidatos c
JOIN organizaciones_politicas o ON o.id_organizacion = c.id_organizacion
JOIN dignidades d               ON d.id_dignidad     = c.id_dignidad
JOIN cantones ca                ON ca.id_canton      = c.id_canton
JOIN provincias p               ON p.id_provincia    = ca.id_provincia;

-- Prueba:
-- SELECT * FROM vw_candidatos;