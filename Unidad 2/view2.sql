CREATE OR REPLACE VIEW vw_porcentaje_votos AS
SELECT
    c.id_candidato,
    c.nombres,
    c.apellidos,
    o.siglas,
    d.nombre   AS dignidad,
    ca.nombre  AS canton,
    r.votos,
    ROUND(
        r.votos * 100.0 / (
            SELECT SUM(r2.votos)
            FROM resultados r2
            JOIN candidatos c2 ON c2.id_candidato = r2.id_candidato
            WHERE c2.id_dignidad = c.id_dignidad
              AND c2.id_canton   = c.id_canton
        ), 2
    ) AS porcentaje
FROM candidatos c
JOIN resultados r               ON r.id_candidato    = c.id_candidato
JOIN organizaciones_politicas o ON o.id_organizacion = c.id_organizacion
JOIN dignidades d               ON d.id_dignidad     = c.id_dignidad
JOIN cantones ca                ON ca.id_canton      = c.id_canton;

