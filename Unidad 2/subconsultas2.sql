
-- 5. Organizaciones con candidatos inscritos (IN)
SELECT nombre, siglas
FROM organizaciones
WHERE id_organizacion IN (
    SELECT DISTINCT id_organizacion
    FROM candidatos
);

-- 6. Organizaciones sin candidatos (NOT EXISTS)
SELECT o.nombre, o.siglas
FROM organizaciones o
WHERE NOT EXISTS (
    SELECT 1
    FROM candidatos c
    WHERE c.id_organizacion = o.id_organizacion
);

-- 7. Candidatos con votación superior a todos los candidatos de Loja (ALL)
SELECT nombres, apellidos, votos
FROM candidatos
WHERE votos > ALL (
    SELECT c.votos
    FROM candidatos c
             INNER JOIN cantones ca ON c.id_canton = ca.id_canton
    WHERE ca.nombre = 'Loja'
);

-- 8. Candidatos con votación superior a algún candidato de Catamayo (ANY)
SELECT nombres, apellidos, votos
FROM candidatos
WHERE votos > ANY (
    SELECT c.votos
    FROM candidatos c
             INNER JOIN cantones ca ON c.id_canton = ca.id_canton
    WHERE ca.nombre = 'Catamayo'
);