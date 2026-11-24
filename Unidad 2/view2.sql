
CREATE VIEW Vw_resultados_dignidad AS
SELECT
    d.nombre AS dignidad,
    COUNT(c.id_candidato) AS total_candidatos,
    IFNULL(SUM(c.votos), 0) AS total_votos
FROM dignidades d
         LEFT JOIN candidatos c ON d.id_dignidad = c.id_dignidad
GROUP BY d.id_dignidad, d.nombre;