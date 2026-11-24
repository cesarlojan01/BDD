
-- 1. Candidatos del Movimiento Renovación Ciudadana
SELECT nombres, apellidos
FROM candidatos
WHERE id_organizacion = (
    SELECT id_organizacion
    FROM organizaciones
    WHERE nombre = 'Movimiento Renovación Ciudadana'
);

-- 2. Candidatos para la dignidad de Alcalde
SELECT nombres, apellidos
FROM candidatos
WHERE id_dignidad = (
    SELECT id_dignidad
    FROM dignidades
    WHERE nombre = 'Alcalde'
);

-- 3. Candidatos de la provincia de Loja
SELECT nombres, apellidos
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

-- 4. Candidatos con votación superior al promedio general
SELECT nombres, apellidos, votos
FROM candidatos
WHERE votos > (
    SELECT AVG(votos)
    FROM candidatos
);