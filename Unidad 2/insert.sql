
INSERT INTO provincias (id_provincia, nombre) VALUES
(1, 'Loja'),
(2, 'Azuay'),
(3, 'El Oro');

INSERT INTO cantones (id_canton, nombre, id_provincia) VALUES
(1, 'Loja',      1),
(2, 'Catamayo',  1),
(3, 'Saraguro',  1),
(4, 'Cuenca',    2),
(5, 'Gualaceo',  2),
(6, 'Machala',   3);


INSERT INTO organizaciones_politicas (id_organizacion, nombre, siglas, numero_lista, tipo) VALUES
(1, 'Movimiento Renovación Ciudadana', 'MRC', 10, 'Movimiento'),
(2, 'Partido Unidad Progresista',      'PUP', 12, 'Partido'),
(3, 'Alianza Desarrollo del Sur',      'ADS', 15, 'Movimiento'),
(4, 'Partido Verde Andino',            'PVA', 20, 'Partido'),
(5, 'Movimiento Juventud Activa',      'MJA', 25, 'Movimiento'),
(6, 'Partido Fuerza Comunitaria',      'PFC', 30, 'Partido');


INSERT INTO dignidades (id_dignidad, nombre, ambito) VALUES
(1, 'Prefecto',                  'Provincial'),
(2, 'Alcalde',                   'Cantonal'),
(3, 'Concejal',                  'Cantonal'),
(4, 'Vocal de junta parroquial', 'Parroquial');

INSERT INTO candidatos (id_candidato, cedula, nombres, apellidos, id_organizacion, id_dignidad, id_canton) VALUES

(1,  '1100000011', 'Andrea Lucía',       'Jaramillo Ortega',     1, 2, 1),
(2,  '1100000029', 'Carlos Eduardo',     'Paredes Rojas',        2, 2, 1),
(3,  '1100000037', 'María José',         'Castillo Vega',        3, 2, 1),
(4,  '1100000045', 'Jorge Luis',         'Armijos Torres',       1, 1, 1),
(5,  '1100000052', 'Patricia Elena',     'Sánchez Mora',         4, 1, 1),
(6,  '1100000060', 'Luis Fernando',      'Ochoa Celi',           2, 3, 1),

(7,  '1100000078', 'Diego Andrés',       'Valdivieso Ruiz',      1, 2, 2),
(8,  '1100000086', 'Silvia Marcela',     'Ramón Guamán',         3, 2, 2),
(9,  '1100000094', 'Pedro Antonio',      'Cueva Loaiza',         4, 3, 2),
(10, '1100000102', 'Rosa Elvira',        'Quizhpe Medina',       3, 2, 3),
(11, '1100000110', 'Manuel Jesús',       'Sarango Lozano',       1, 4, 3),
(12, '0100000013', 'Gabriela Isabel',    'Cordero Vintimilla',   2, 2, 4),
(13, '0100000021', 'Esteban Mauricio',   'Malo Andrade',         4, 2, 4),
(14, '0100000039', 'Fernanda Sofía',     'Crespo Ordóñez',       1, 3, 4),
(15, '0100000047', 'Juan Pablo',         'Vázquez Peña',         2, 1, 4),
(16, '0100000054', 'Verónica Alexandra', 'Tenesaca Pulla',       3, 2, 5),
(17, '0100000062', 'Ramiro Patricio',    'Siguencia Mejía',      4, 4, 5),
(18, '0700000015', 'Ángel Gustavo',      'Romero Aguilar',       2, 2, 6),
(19, '0700000023', 'Karina Lisbeth',     'Espinoza Maldonado',   1, 2, 6),
(20, '0700000031', 'Héctor Javier',      'Ullauri Correa',       3, 3, 6);

INSERT INTO votantes (id_votante, cedula, nombres, apellidos, fecha_nacimiento, id_canton) VALUES
(1,  '1150000011', 'Ana Belén',       'Torres Guerrero',   '1990-03-15', 1),
(2,  '1150000029', 'Bryan Steven',    'Ojeda Carrión',     '2001-07-22', 1),
(3,  '1150000037', 'Lorena Paola',    'Riofrío Valarezo',  '1985-11-02', 1),
(4,  '1150000045', 'Kevin Josué',     'Jiménez Salinas',   '1998-01-30', 2),
(5,  '1150000052', 'Mónica Alejandra','Herrera Benítez',   '1976-05-19', 2),
(6,  '1150000060', 'Segundo Ángel',   'Gualán Chalán',     '1969-09-08', 3),
(7,  '1150000078', 'Carmen Rosa',     'Cartuche Minga',    '1993-12-12', 3),
(8,  '0150000016', 'Paúl Sebastián',  'Ochoa Durán',       '1988-04-25', 4),
(9,  '0150000024', 'Daniela Fernanda','Ortiz Zamora',      '2003-08-17', 4),
(10, '0150000032', 'Xavier Eduardo',  'Moscoso Abad',      '1972-02-03', 4),
(11, '0150000040', 'Gloria Marlene',  'Guzhñay Pintado',   '1981-10-29', 5),
(12, '0150000057', 'Wilson Rodrigo',  'Peralta Quito',     '1995-06-14', 5),
(13, '0750000018', 'Jessica Tatiana', 'Aguilar Sánchez',   '1999-03-09', 6),
(14, '0750000026', 'Fabián Alberto',  'Matamoros Vera',    '1979-07-01', 6),
(15, '0750000034', 'Lucía Fernanda',  'Bravo Cedeño',      '1987-12-20', 6);


INSERT INTO resultados (id_resultado, id_candidato, votos, fecha_registro) VALUES
(1,  1,   45200, '2027-02-14'),
(2,  2,   38750, '2027-02-14'),
(3,  3,   21300, '2027-02-14'),
(4,  4,   52100, '2027-02-14'),
(5,  5,   47800, '2027-02-14'),
(6,  6,   12400, '2027-02-14'),
(7,  7,    9850, '2027-02-14'),
(8,  8,    9850, '2027-02-14'),
(9,  9,    3200, '2027-02-14'),
(10, 10,   7600, '2027-02-14'),
(11, 11,   1450, '2027-02-14'),
(12, 12,  98300, '2027-02-15'),
(13, 13,  87650, '2027-02-15'),
(14, 14,  25400, '2027-02-15'),
(15, 15, 120500, '2027-02-15'),
(16, 16,   8900, '2027-02-15'),
(17, 17,    980, '2027-02-15'),
(18, 18,  64200, '2027-02-15');