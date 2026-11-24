USE elecciones;

CREATE VIEW Vw_candidatos AS
SELECT
    c.id_candidato,
    c.nombres,
    c.apellidos,
    o.nombre AS organizacion_politica,
    o.siglas,
    d.nombre AS dignidad,
    can.nombre AS canton,
    p.nombre AS provincia
FROM candidatos c
         INNER JOIN organizaciones o ON c.id_organizacion = o.id_organizacion
         INNER JOIN dignidades d ON c.id_dignidad = d.id_dignidad
         INNER JOIN cantones can ON c.id_canton = can.id_canton
         INNER JOIN provincias p ON can.id_provincia = p.id_provincia;