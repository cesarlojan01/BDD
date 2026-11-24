CREATE OR REPLACE VIEW vw_resultados_consolidados AS

CREATE VIEW Vw_resultados_canton AS
SELECT
    can.nombre AS canton,
    COUNT(c.id_candidato) AS total_candidatos,
    IFNULL(SUM(c.votos), 0) AS total_votos
FROM cantones can
         LEFT JOIN candidatos c ON can.id_canton = c.id_canton
GROUP BY can.id_canton, can.nombre;