SELECT nombres, apellidos
FROM candidatos
WHERE id_organizacion = (
    SELECT id_organizacion
    FROM organizaciones_politicas
    WHERE nombre = 'Movimiento Renovación Ciudadana'
);

SELECT id_candidato, nombres, apellidos
FROM candidatos
WHERE id_dignidad = (
    SELECT id_dignidad
    FROM dignidades
    WHERE nombre = 'Alcalde'
);

SELECT id_candidato, nombres, apellidos
FROM candidatos
WHERE id_canton IN (
    SELECT id_canton
    FROM cantones
    WHERE id_provincia = (
        SELECT id_provincia
        FROM provincias
        WHERE nombre = 'Loja'
    )
);  

SELECT c.nombres, c.apellidos, r.votos
FROM candidatos c
JOIN resultados r ON r.id_candidato = c.id_candidato
WHERE r.votos > (
    SELECT AVG(votos)
    FROM resultados
)
ORDER BY r.votos DESC;