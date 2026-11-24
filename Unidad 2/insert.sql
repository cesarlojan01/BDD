INSERT INTO
    provincias (nombre)
VALUES
    ('Loja'),
    ('Azuay');

INSERT INTO
    cantones (nombre, id_provincia)
VALUES
    ('Loja', 1),
    ('Catamayo', 1),
    ('Saraguro', 1),
    ('Cuenca', 2);

INSERT INTO
    organizaciones (nombre, siglas)
VALUES
    ('Movimiento Renovación Ciudadana', 'MRC'),
    ('Partido Alianza Sur', 'PAS'),
    ('Movimiento Cambio Loja', 'MCL'),
    ('Partido Futuro Verde', 'PFV');

INSERT INTO
    dignidades (nombre)
VALUES
    ('Alcalde'),
    ('Prefecto'),
    ('Concejal');

INSERT INTO
    candidatos (
        nombres,
        apellidos,
        id_organizacion,
        id_dignidad,
        id_canton,
        votos
    )
VALUES
    ('Carlos', 'Sarmiento', 1, 1, 1, 15000),
    ('María', 'Jaramillo', 2, 1, 1, 18000),
    ('Luis', 'Valdivieso', 1, 1, 2, 8000),
    ('Andrea', 'Cordero', 3, 1, 2, 6000),
    ('Jorge', 'Quezada', 1, 2, 1, 25000),
    ('Diana', 'Espinoza', 2, 2, 1, 22000),
    ('Pedro', 'Alvarado', 3, 1, 3, 4000),
    ('Sofía', 'Benítez', 1, 3, 1, 12000);

INSERT INTO
    resultados (id_candidato, votos)
VALUES
    (1, 15000),
    (2, 18000),
    (3, 8000),
    (4, 6000),
    (5, 25000),
    (6, 22000);