SELECT id_organizacion, nombre, siglas
FROM organizaciones_politicas
WHERE id_organizacion IN (
    SELECT id_organizacion
    FROM candidatos
);  

SELECT o.id_organizacion, o.nombre, o.siglas
FROM organizaciones_politicas o
WHERE NOT EXISTS (
    SELECT 1
    FROM candidatos c
    WHERE c.id_organizacion = o.id_organizacion
);

SELECT c.nombres, c.apellidos, r.votos
FROM candidatos c
JOIN resultados r ON r.id_candidato = c.id_candidato
WHERE r.votos > ALL (
    SELECT r2.votos
    FROM resultados r2
    WHERE r2.id_candidato IN (
        SELECT id_candidato
        FROM candidatos
        WHERE id_canton = (
            SELECT id_canton
            FROM cantones
            WHERE nombre = 'Loja'
        )
    )
)
ORDER BY r.votos DESC;

SELECT c.nombres, c.apellidos, r.votos
FROM candidatos c
JOIN resultados r ON r.id_candidato = c.id_candidato
WHERE r.votos > ANY (
    SELECT r2.votos
    FROM resultados r2
    WHERE r2.id_candidato IN (
        SELECT id_candidato
        FROM candidatos
        WHERE id_canton = (
            SELECT id_canton
            FROM cantones
            WHERE nombre = 'Catamayo'
        )
    )
)
ORDER BY r.votos DESC;