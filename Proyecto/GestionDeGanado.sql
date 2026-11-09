
DROP TABLE IF EXISTS VENTA_DETALLE;
DROP TABLE IF EXISTS VENTA;
DROP TABLE IF EXISTS CONTROL_SANITARIO;
DROP TABLE IF EXISTS ALIMENTACION;
DROP TABLE IF EXISTS PESAJE;
DROP TABLE IF EXISTS ESTANCIA;
DROP TABLE IF EXISTS ANIMAL;
DROP TABLE IF EXISTS LOTE_GANADO;
DROP TABLE IF EXISTS COMPRA_GANADO;
DROP TABLE IF EXISTS POTRERO;
DROP TABLE IF EXISTS FINCA;


CREATE TABLE FINCA (
    id_finca      INT          NOT NULL AUTO_INCREMENT,
    nombre        VARCHAR(100) NOT NULL,
    ubicacion     VARCHAR(150),
    area_total    DECIMAL(8,2),
    responsable   VARCHAR(100),
    PRIMARY KEY (id_finca),
    CONSTRAINT uq_finca_nombre UNIQUE (nombre),
    CONSTRAINT ck_finca_area   CHECK (area_total IS NULL OR area_total > 0)
);


CREATE TABLE POTRERO (
    id_potrero      INT          NOT NULL AUTO_INCREMENT,
    id_finca        INT          NOT NULL,
    nombre          VARCHAR(80)  NOT NULL,
    area_hectareas  DECIMAL(6,2),
    tipo_pasto      VARCHAR(60),
    estado          VARCHAR(20)  NOT NULL DEFAULT 'DISPONIBLE',
    PRIMARY KEY (id_potrero),
    CONSTRAINT uq_potrero_nombre UNIQUE (id_finca, nombre),
    CONSTRAINT ck_potrero_area   CHECK (area_hectareas IS NULL
                                        OR area_hectareas > 0),
    CONSTRAINT ck_potrero_estado CHECK (estado IN ('DISPONIBLE', 'OCUPADO',
                                                   'EN_DESCANSO')),
    CONSTRAINT fk_potrero_finca  FOREIGN KEY (id_finca)
        REFERENCES FINCA (id_finca)
);


CREATE TABLE COMPRA_GANADO (
    id_compra      INT           NOT NULL AUTO_INCREMENT,
    fecha_compra   DATE          NOT NULL,
    proveedor      VARCHAR(120)  NOT NULL,
    cantidad       INT           NOT NULL,
    costo_total    DECIMAL(10,2) NOT NULL,
    documento      VARCHAR(40),
    PRIMARY KEY (id_compra),
    CONSTRAINT uq_compra_documento UNIQUE (documento),
    CONSTRAINT ck_compra_cantidad  CHECK (cantidad > 0),
    CONSTRAINT ck_compra_costo     CHECK (costo_total >= 0)
);


CREATE TABLE LOTE_GANADO (
    id_lote           INT          NOT NULL AUTO_INCREMENT,
    nombre_lote       VARCHAR(80)  NOT NULL,
    fecha_formacion   DATE         NOT NULL,
    objetivo_engorde  DECIMAL(7,2),
    estado            VARCHAR(20)  NOT NULL DEFAULT 'ACTIVO',
    PRIMARY KEY (id_lote),
    CONSTRAINT uq_lote_nombre   UNIQUE (nombre_lote),
    CONSTRAINT ck_lote_estado   CHECK (estado IN ('ACTIVO', 'CERRADO')),
    CONSTRAINT ck_lote_objetivo CHECK (objetivo_engorde IS NULL
                                       OR objetivo_engorde > 0)
);


CREATE TABLE ANIMAL (
    id_animal         INT          NOT NULL AUTO_INCREMENT,
    id_lote           INT          NOT NULL,
    id_compra         INT,
    arete             VARCHAR(30),
    raza              VARCHAR(60),
    sexo              CHAR(1)      NOT NULL,
    fecha_nacimiento  DATE,
    fecha_ingreso     DATE         NOT NULL,
    estado            VARCHAR(20)  NOT NULL DEFAULT 'ACTIVO',
    fecha_baja        DATE,
    motivo_baja       VARCHAR(100),
    PRIMARY KEY (id_animal),

    CONSTRAINT uq_animal_arete  UNIQUE (arete),
    CONSTRAINT ck_animal_sexo   CHECK (sexo IN ('M', 'H')),
    CONSTRAINT ck_animal_estado CHECK (estado IN ('ACTIVO', 'VENDIDO',
                                                  'MUERTO', 'DESCARTADO')),

    CONSTRAINT ck_animal_baja   CHECK (
        (estado = 'ACTIVO'  AND fecha_baja IS NULL) OR
        (estado <> 'ACTIVO' AND fecha_baja IS NOT NULL)),
    CONSTRAINT ck_animal_fechas CHECK (
        fecha_nacimiento IS NULL OR fecha_nacimiento <= fecha_ingreso),
    CONSTRAINT fk_animal_lote   FOREIGN KEY (id_lote)
        REFERENCES LOTE_GANADO (id_lote),
    CONSTRAINT fk_animal_compra FOREIGN KEY (id_compra)
        REFERENCES COMPRA_GANADO (id_compra)
);


CREATE TABLE ESTANCIA (
    id_estancia    INT         NOT NULL AUTO_INCREMENT,
    id_animal      INT         NOT NULL,
    id_potrero     INT         NOT NULL,
    fecha_entrada  DATE        NOT NULL,
    fecha_salida   DATE,
    motivo         VARCHAR(100),
    PRIMARY KEY (id_estancia),
    CONSTRAINT uq_estancia_entrada UNIQUE (id_animal, fecha_entrada),
    CONSTRAINT ck_estancia_fechas  CHECK (
        fecha_salida IS NULL OR fecha_salida >= fecha_entrada),
    CONSTRAINT fk_estancia_animal  FOREIGN KEY (id_animal)
        REFERENCES ANIMAL (id_animal),
    CONSTRAINT fk_estancia_potrero FOREIGN KEY (id_potrero)
        REFERENCES POTRERO (id_potrero)
);


CREATE TABLE PESAJE (
    id_pesaje    INT          NOT NULL AUTO_INCREMENT,
    id_animal    INT          NOT NULL,
    fecha        DATE         NOT NULL,
    peso_kg      DECIMAL(7,2) NOT NULL,
    observacion  VARCHAR(150),
    PRIMARY KEY (id_pesaje),

    CONSTRAINT uq_pesaje_dia    UNIQUE (id_animal, fecha),
    CONSTRAINT ck_pesaje_peso   CHECK (peso_kg > 0 AND peso_kg < 2000),
    CONSTRAINT fk_pesaje_animal FOREIGN KEY (id_animal)
        REFERENCES ANIMAL (id_animal)
);

CREATE TABLE ALIMENTACION (
    id_alimentacion  INT          NOT NULL AUTO_INCREMENT,
    id_potrero       INT          NOT NULL,
    fecha            DATE         NOT NULL,
    tipo_alimento    VARCHAR(60)  NOT NULL,
    cantidad_kg      DECIMAL(8,2) NOT NULL,
    costo            DECIMAL(10,2),
    observacion      VARCHAR(150),
    PRIMARY KEY (id_alimentacion),
    CONSTRAINT ck_alim_cantidad CHECK (cantidad_kg > 0),
    CONSTRAINT ck_alim_costo    CHECK (costo IS NULL OR costo >= 0),
    CONSTRAINT fk_alim_potrero  FOREIGN KEY (id_potrero)
        REFERENCES POTRERO (id_potrero)
);


CREATE TABLE CONTROL_SANITARIO (
    id_control              INT          NOT NULL AUTO_INCREMENT,
    id_animal               INT          NOT NULL,
    fecha                   DATE         NOT NULL,
    tipo_tratamiento        VARCHAR(60)  NOT NULL,
    medicamento             VARCHAR(100),
    dosis                   VARCHAR(40),
    costo                   DECIMAL(10,2),
    responsable             VARCHAR(100),
    PRIMARY KEY (id_control),
    CONSTRAINT ck_control_costo  CHECK (costo IS NULL OR costo >= 0),  
    CONSTRAINT fk_control_animal FOREIGN KEY (id_animal)
        REFERENCES ANIMAL (id_animal)
);


CREATE TABLE VENTA (
    id_venta       INT           NOT NULL AUTO_INCREMENT,
    fecha_venta    DATE          NOT NULL,
    comprador      VARCHAR(120)  NOT NULL,
    importe_total  DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (id_venta),
    CONSTRAINT ck_venta_importe CHECK (importe_total >= 0)
);


CREATE TABLE VENTA_DETALLE (
    id_venta       INT           NOT NULL,
    nro_linea      INT           NOT NULL,
    id_animal      INT           NOT NULL,
    peso_venta_kg  DECIMAL(7,2)  NOT NULL,
    precio_kg      DECIMAL(8,2)  NOT NULL,
    sub_total      DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_venta, nro_linea),

    CONSTRAINT uq_detalle_animal UNIQUE (id_animal),
    CONSTRAINT ck_detalle_peso   CHECK (peso_venta_kg > 0),
    CONSTRAINT ck_detalle_precio CHECK (precio_kg >= 0),
    CONSTRAINT ck_detalle_sub    CHECK (sub_total >= 0),
    CONSTRAINT fk_detalle_venta  FOREIGN KEY (id_venta)
        REFERENCES VENTA (id_venta) ON DELETE CASCADE,
    CONSTRAINT fk_detalle_animal FOREIGN KEY (id_animal)
        REFERENCES ANIMAL (id_animal)
);



INSERT INTO FINCA (nombre, ubicacion, area_total, responsable) VALUES
    ('Finca Desarrollo', 'Via Chone, Manabi', 42.0, 'Carlos Campoverde'),
    ('Finca Engorde', 'Via Chone, Manabi', 18.5, 'Carlos Campoverde'),
    ('Finca La Esperanza', 'Santa Ana, Manabi', 25.0, 'Luis Mera');


INSERT INTO POTRERO (id_finca, nombre, area_hectareas, tipo_pasto, estado) VALUES
    (1, 'Potrero 1'   ,   10.0, 'Brachiaria'  , 'EN_DESCANSO'),
    (1, 'Potrero 2'   ,   12.0, 'Brachiaria'  , 'OCUPADO'),
    (1, 'Potrero 3'   ,   10.0, 'Saboya'      , 'EN_DESCANSO'),
    (1, 'Potrero 4'   ,    9.5, 'Saboya'      , 'EN_DESCANSO'),
    (2, 'Engorde A'   ,    6.0, 'Maralfalfa'  , 'EN_DESCANSO'),
    (2, 'Engorde B'   ,    6.5, 'Maralfalfa'  , 'EN_DESCANSO'),
    (2, 'Engorde C'   ,    6.0, 'Maralfalfa'  , 'OCUPADO'),
    (3, 'Potrero Sur' ,    9.0, 'Brachiaria'  , 'DISPONIBLE');


INSERT INTO COMPRA_GANADO (fecha_compra, proveedor, cantidad,
                           costo_total, documento) VALUES
    ('2026-02-05', 'Ganadero Jose Loor'        , 6,   3180.0, 'NV-001-0452'),
    ('2026-08-02', 'Ganadero Jose Loor'        , 2,   1760.0, 'NV-001-0587'),
    ('2026-01-20', 'Feria de Santa Ana'        , 4,   1920.0, 'NV-002-0113'),
    ('2026-09-10', 'Ganadero Miguel Zambrano'  , 4,   2840.0, 'NV-003-0071'),
    ('2025-06-10', 'Ganadero Jose Loor'        , 4,   2100.0, 'NV-001-0318');


INSERT INTO LOTE_GANADO (nombre_lote, fecha_formacion,
                         objetivo_engorde, estado) VALUES
    ('Lote Febrero 2026'   , '2026-02-05', 450.0, 'ACTIVO'),
    ('Lote Feria Enero'    , '2026-01-20', 450.0, 'ACTIVO'),
    ('Lote Engorde Toros'  , '2026-08-02', 480.0, 'ACTIVO'),
    ('Lote Septiembre'     , '2026-09-10', 450.0, 'ACTIVO'),
    ('Lote Junio 2025'     , '2025-06-10', 450.0, 'ACTIVO');


INSERT INTO ANIMAL (id_lote, id_compra, arete, raza, sexo,
                    fecha_nacimiento, fecha_ingreso, estado,
                    fecha_baja, motivo_baja) VALUES
    (5, 5, 'EC-0901' , 'Brahman' , 'M', '2024-01-15', '2025-06-10', 'ACTIVO'  , NULL         , NULL),
    (5, 5, 'EC-0902' , 'Nelore'  , 'M', '2024-02-03', '2025-06-10', 'ACTIVO'  , NULL         , NULL),
    (5, 5, 'EC-0903' , 'Mestizo' , 'M', '2024-03-20', '2025-06-10', 'ACTIVO'  , NULL         , NULL),
    (5, 5, 'EC-0904' , 'Mestizo' , 'M', '2024-04-08', '2025-06-10', 'ACTIVO'  , NULL         , NULL),
    (2, 3, 'EC-1009' , 'Mestizo' , 'M', '2024-09-20', '2026-01-20', 'ACTIVO'  , NULL         , NULL),
    (2, 3, 'EC-1010' , 'Mestizo' , 'M', '2024-10-02', '2026-01-20', 'ACTIVO'  , NULL         , NULL),
    (2, 3, 'EC-1011' , 'Brahman' , 'M', '2024-05-14', '2026-01-20', 'VENDIDO' , '2026-04-15' , 'Venta'),
    (2, 3, 'EC-1012' , 'Nelore'  , 'M', '2024-06-08', '2026-01-20', 'VENDIDO' , '2026-06-28' , 'Venta'),
    (1, 1, 'EC-1001' , 'Brahman' , 'M', '2024-12-10', '2026-02-05', 'ACTIVO'  , NULL         , NULL),
    (1, 1, 'EC-1002' , 'Nelore'  , 'M', '2024-11-02', '2026-02-05', 'VENDIDO' , '2026-10-20' , 'Venta'),
    (1, 1, 'EC-1003' , 'Mestizo' , 'M', '2025-01-15', '2026-02-05', 'ACTIVO'  , NULL         , NULL),
    (1, 1, 'EC-1004' , 'Mestizo' , 'M', '2024-08-20', '2026-02-05', 'MUERTO'  , '2026-10-22' , 'Complicacion respiratoria'),
    (1, 1, 'EC-1005' , 'Brahman' , 'M', '2024-12-01', '2026-02-05', 'VENDIDO' , '2026-10-20' , 'Venta'),
    (1, 1, 'EC-1006' , 'Nelore'  , 'M', '2024-10-05', '2026-02-05', 'ACTIVO'  , NULL         , NULL),
    (3, 2, 'EC-1007' , 'Brahman' , 'M', '2024-06-12', '2026-08-02', 'VENDIDO' , '2026-10-20' , 'Venta'),
    (3, 2, 'EC-1008' , 'Nelore'  , 'M', '2024-07-01', '2026-08-02', 'ACTIVO'  , NULL         , NULL),
    (4, 4, NULL      , 'Brahman' , 'M', '2025-04-11', '2026-09-10', 'ACTIVO'  , NULL         , NULL),
    (4, 4, NULL      , 'Mestizo' , 'M', '2025-05-03', '2026-09-10', 'ACTIVO'  , NULL         , NULL),
    (3, 4, 'EC-1015' , 'Brahman' , 'M', '2024-04-18', '2026-09-10', 'VENDIDO' , '2026-11-02' , 'Venta'),
    (3, 4, 'EC-1016' , 'Nelore'  , 'M', '2024-03-25', '2026-09-10', 'VENDIDO' , '2026-11-02' , 'Venta');

INSERT INTO ESTANCIA (id_animal, id_potrero, fecha_entrada,
                      fecha_salida, motivo) VALUES
    ( 1, 1, '2025-06-10', '2025-09-30', 'Rotacion de potrero'),
    ( 1, 2, '2025-10-01', '2025-12-31', 'Rotacion de potrero'),
    ( 1, 3, '2026-01-01', '2026-01-14', 'Paso a engorde'),
    ( 1, 5, '2026-01-15', '2026-04-30', 'Rotacion de potrero'),
    ( 1, 6, '2026-05-01', '2026-08-31', 'Rotacion de potrero'),
    ( 1, 7, '2026-09-01',         NULL, NULL),
    ( 2, 1, '2025-06-10', '2025-09-30', 'Rotacion de potrero'),
    ( 2, 2, '2025-10-01', '2025-12-31', 'Rotacion de potrero'),
    ( 2, 3, '2026-01-01', '2026-01-14', 'Paso a engorde'),
    ( 2, 5, '2026-01-15', '2026-04-30', 'Rotacion de potrero'),
    ( 2, 6, '2026-05-01', '2026-08-31', 'Rotacion de potrero'),
    ( 2, 7, '2026-09-01',         NULL, NULL),
    ( 3, 1, '2025-06-10', '2025-09-30', 'Rotacion de potrero'),
    ( 3, 2, '2025-10-01', '2025-12-31', 'Rotacion de potrero'),
    ( 3, 3, '2026-01-01', '2026-03-31', 'Rotacion de potrero'),
    ( 3, 4, '2026-04-01', '2026-06-15', 'Rotacion de potrero'),
    ( 3, 1, '2026-06-16', '2026-08-31', 'Rotacion de potrero'),
    ( 3, 2, '2026-09-01',         NULL, NULL),
    ( 4, 1, '2025-06-10', '2025-09-30', 'Rotacion de potrero'),
    ( 4, 2, '2025-10-01', '2025-12-31', 'Rotacion de potrero'),
    ( 4, 3, '2026-01-01', '2026-03-31', 'Rotacion de potrero'),
    ( 4, 4, '2026-04-01', '2026-06-15', 'Rotacion de potrero'),
    ( 4, 1, '2026-06-16', '2026-08-31', 'Rotacion de potrero'),
    ( 4, 2, '2026-09-01',         NULL, NULL),
    ( 5, 3, '2026-01-20', '2026-03-31', 'Rotacion de potrero'),
    ( 5, 4, '2026-04-01', '2026-06-15', 'Rotacion de potrero'),
    ( 5, 1, '2026-06-16', '2026-08-31', 'Rotacion de potrero'),
    ( 5, 2, '2026-09-01',         NULL, NULL),
    ( 6, 3, '2026-01-20', '2026-03-31', 'Rotacion de potrero'),
    ( 6, 4, '2026-04-01', '2026-06-15', 'Rotacion de potrero'),
    ( 6, 1, '2026-06-16', '2026-08-31', 'Paso a engorde'),
    ( 6, 7, '2026-09-01',         NULL, NULL),
    ( 7, 3, '2026-01-20', '2026-03-31', 'Rotacion de potrero'),
    ( 7, 4, '2026-04-01', '2026-04-15', 'Salida por venta'),
    ( 8, 3, '2026-01-20', '2026-03-31', 'Rotacion de potrero'),
    ( 8, 4, '2026-04-01', '2026-06-15', 'Rotacion de potrero'),
    ( 8, 1, '2026-06-16', '2026-06-28', 'Salida por venta'),
    ( 9, 3, '2026-02-05', '2026-03-31', 'Rotacion de potrero'),
    ( 9, 4, '2026-04-01', '2026-06-15', 'Rotacion de potrero'),
    ( 9, 1, '2026-06-16', '2026-08-31', 'Rotacion de potrero'),
    ( 9, 2, '2026-09-01',         NULL, NULL),
    (10, 3, '2026-02-05', '2026-03-31', 'Rotacion de potrero'),
    (10, 4, '2026-04-01', '2026-06-15', 'Rotacion de potrero'),
    (10, 1, '2026-06-16', '2026-08-31', 'Paso a engorde'),
    (10, 7, '2026-09-01', '2026-10-20', 'Salida por venta'),
    (11, 3, '2026-02-05', '2026-03-31', 'Rotacion de potrero'),
    (11, 4, '2026-04-01', '2026-06-15', 'Rotacion de potrero'),
    (11, 1, '2026-06-16', '2026-08-31', 'Rotacion de potrero'),
    (11, 2, '2026-09-01',         NULL, NULL),
    (12, 3, '2026-02-05', '2026-03-31', 'Rotacion de potrero'),
    (12, 4, '2026-04-01', '2026-06-15', 'Rotacion de potrero'),
    (12, 1, '2026-06-16', '2026-08-31', 'Rotacion de potrero'),
    (12, 2, '2026-09-01', '2026-10-22', 'Salida por muerte'),
    (13, 3, '2026-02-05', '2026-03-31', 'Rotacion de potrero'),
    (13, 4, '2026-04-01', '2026-06-15', 'Paso a engorde'),
    (13, 6, '2026-06-16', '2026-08-31', 'Rotacion de potrero'),
    (13, 7, '2026-09-01', '2026-10-20', 'Salida por venta'),
    (14, 3, '2026-02-05', '2026-03-31', 'Rotacion de potrero'),
    (14, 4, '2026-04-01', '2026-06-15', 'Rotacion de potrero'),
    (14, 1, '2026-06-16', '2026-08-31', 'Rotacion de potrero'),
    (14, 2, '2026-09-01',         NULL, NULL),
    (15, 6, '2026-08-02', '2026-08-31', 'Rotacion de potrero'),
    (15, 7, '2026-09-01', '2026-10-20', 'Salida por venta'),
    (16, 6, '2026-08-02', '2026-08-31', 'Rotacion de potrero'),
    (16, 7, '2026-09-01',         NULL, NULL),
    (17, 2, '2026-09-10',         NULL, NULL),
    (18, 2, '2026-09-10',         NULL, NULL),
    (19, 7, '2026-09-10', '2026-11-02', 'Salida por venta'),
    (20, 7, '2026-09-10', '2026-11-02', 'Salida por venta');
INSERT INTO PESAJE (id_animal, fecha, peso_kg, observacion) VALUES
    ( 1, '2025-06-10',   198.0, 'Peso de ingreso'),
    ( 1, '2025-10-13',   248.0, NULL),
    ( 1, '2026-02-15',   298.0, NULL),
    ( 1, '2026-06-20',   348.0, NULL),
    ( 1, '2026-10-23',   398.0, NULL),
    ( 2, '2025-06-10',   205.0, 'Peso de ingreso'),
    ( 2, '2025-10-13',  261.25, NULL),
    ( 2, '2026-02-15',   317.5, NULL),
    ( 2, '2026-06-20',  373.75, NULL),
    ( 2, '2026-10-23',   430.0, 'Listo para venta'),
    ( 3, '2025-06-10',   186.0, 'Peso de ingreso'),
    ( 3, '2025-10-13',   248.5, NULL),
    ( 3, '2026-02-15',   311.0, NULL),
    ( 3, '2026-06-20',   373.5, NULL),
    ( 3, '2026-10-23',   436.0, 'Listo para venta'),
    ( 4, '2025-06-10',   192.0, 'Peso de ingreso'),
    ( 4, '2025-10-13',  260.75, NULL),
    ( 4, '2026-02-15',   329.5, NULL),
    ( 4, '2026-06-20',  398.25, NULL),
    ( 4, '2026-10-23',   467.0, 'Listo para venta'),
    ( 5, '2026-01-20',   205.0, 'Peso de ingreso'),
    ( 5, '2026-05-25',   280.0, NULL),
    ( 5, '2026-09-27',   355.0, NULL),
    ( 6, '2026-01-20',   212.0, 'Peso de ingreso'),
    ( 6, '2026-05-25',  293.25, NULL),
    ( 6, '2026-09-27',   374.5, NULL),
    ( 7, '2026-01-20',   310.0, 'Peso de ingreso'),
    ( 7, '2026-04-15',   369.5, 'Pesaje de venta'),
    ( 8, '2026-01-20',   318.0, 'Peso de ingreso'),
    ( 8, '2026-05-25',  411.75, 'Listo para venta'),
    ( 8, '2026-06-28',  437.25, 'Pesaje de venta'),
    ( 9, '2026-02-05',   215.0, 'Peso de ingreso'),
    ( 9, '2026-06-10',   315.0, NULL),
    ( 9, '2026-10-13',   415.0, 'Listo para venta'),
    (10, '2026-02-05',   232.0, 'Peso de ingreso'),
    (10, '2026-06-10',  275.75, NULL),
    (10, '2026-10-13',   319.5, NULL),
    (10, '2026-10-20',  321.95, 'Pesaje de venta'),
    (11, '2026-02-05',   198.0, 'Peso de ingreso'),
    (11, '2026-06-10',   248.0, NULL),
    (11, '2026-10-13',   298.0, NULL),
    (12, '2026-02-05',   185.0, 'Peso de ingreso'),
    (12, '2026-06-10',  241.25, NULL),
    (12, '2026-10-13',   297.5, NULL),
    (13, '2026-02-05',   241.0, 'Peso de ingreso'),
    (13, '2026-06-10',   303.5, NULL),
    (13, '2026-10-13',   366.0, NULL),
    (13, '2026-10-20',   369.5, 'Pesaje de venta'),
    (14, '2026-02-05',   228.0, 'Peso de ingreso'),
    (14, '2026-06-10',  296.75, NULL),
    (14, '2026-10-13',   365.5, NULL),
    (15, '2026-08-02',   352.0, 'Peso de ingreso'),
    (15, '2026-10-20',   399.4, 'Pesaje de venta'),
    (16, '2026-08-02',   348.0, 'Peso de ingreso'),
    (17, '2026-09-10',   258.0, 'Peso de ingreso'),
    (18, '2026-09-10',   244.0, 'Peso de ingreso'),
    (19, '2026-09-10',   380.0, 'Peso de ingreso'),
    (19, '2026-11-02',   422.4, 'Pesaje de venta'),
    (20, '2026-09-10',   372.0, 'Peso de ingreso'),
    (20, '2026-11-02',  390.55, 'Pesaje de venta');

-- ALIMENTACION
INSERT INTO ALIMENTACION (id_potrero, fecha, tipo_alimento,
                          cantidad_kg, costo, observacion) VALUES
    (4, '2026-05-03', 'Sal mineralizada'  ,   25.0,  21.25, 'Suplemento'),
    (4, '2026-05-03', 'Melaza'            ,   40.0,   14.0, 'Suplemento'),
    (2, '2026-09-12', 'Sal mineralizada'  ,   20.0,   17.0, NULL),
    (6, '2026-06-20', 'Balanceado 16%'    ,   24.0,  12.48, 'Racion diaria'),
    (6, '2026-06-21', 'Balanceado 16%'    ,   24.0,  12.48, 'Racion diaria'),
    (7, '2026-09-15', 'Balanceado 16%'    ,   30.0,   15.6, 'Racion diaria'),
    (7, '2026-09-16', 'Balanceado 16%'    ,   30.0,   15.6, 'Racion diaria'),
    (7, '2026-10-01', 'Balanceado 16%'    ,   28.0,  14.56, 'Racion diaria');


INSERT INTO CONTROL_SANITARIO (id_animal, fecha, tipo_tratamiento,
                               medicamento, dosis, costo,
                               responsable) VALUES
    (12, '2026-03-15', 'Vitaminizacion'  , 'Vitamina AD3E'   , '10 ml' ,    3.0, 'Carlos Campoverde'),
    ( 9, '2026-06-08', 'Desparasitacion' , 'Ivermectina 1%'  , '8 ml'  ,    3.6, 'Carlos Campoverde'),
    (11, '2026-06-08', 'Desparasitacion' , 'Ivermectina 1%'  , '7 ml'  ,   3.15, 'Carlos Campoverde'),
    (14, '2026-06-09', 'Antibiotico'     , 'Oxitetraciclina' , '20 ml' ,   12.0, 'Luis Mera'),
    (12, '2026-09-20', 'Antibiotico'     , 'Oxitetraciclina' , '20 ml' ,   12.0, 'Luis Mera'),
    ( 3, '2026-10-28', 'Desparasitacion' , 'Ivermectina 1%'  , '6 ml'  ,    2.7, 'Carlos Campoverde'),
    ( 4, '2026-10-28', 'Desparasitacion' , 'Ivermectina 1%'  , '6 ml'  ,    2.7, 'Carlos Campoverde');


INSERT INTO VENTA (fecha_venta, comprador, importe_total) VALUES
    ('2026-04-15', 'Comerciante Pedro Zambrano'  ,   757.47),
    ('2026-06-28', 'Frigorifico El Buen Corte'   ,   940.09),
    ('2026-10-20', 'Comerciante Pedro Zambrano'  ,  2290.79),
    ('2026-11-02', 'Frigorifico El Buen Corte'   ,  1788.49);

-- VENTA_DETALLE
INSERT INTO VENTA_DETALLE (id_venta, nro_linea, id_animal,
                           peso_venta_kg, precio_kg, sub_total) VALUES
    (1, 1,  7,   369.5, 2.05,   757.47),
    (2, 1,  8,  437.25, 2.15,   940.09),
    (3, 1, 13,   369.5, 2.1,   775.95),
    (3, 2, 10,  321.95, 2.1,    676.1),
    (3, 3, 15,   399.4, 2.1,   838.74),
    (4, 1, 19,   422.4, 2.2,   929.28),
    (4, 2, 20,  390.55, 2.2,   859.21);


-- =====================================================================
--  VERIFICACION RAPIDA
-- =====================================================================
SELECT 'FINCA' AS tabla, COUNT(*) AS registros FROM FINCA
UNION ALL SELECT 'POTRERO',           COUNT(*) FROM POTRERO
UNION ALL SELECT 'COMPRA_GANADO',     COUNT(*) FROM COMPRA_GANADO
UNION ALL SELECT 'LOTE_GANADO',       COUNT(*) FROM LOTE_GANADO
UNION ALL SELECT 'ANIMAL',            COUNT(*) FROM ANIMAL
UNION ALL SELECT 'ESTANCIA',          COUNT(*) FROM ESTANCIA
UNION ALL SELECT 'PESAJE',            COUNT(*) FROM PESAJE
UNION ALL SELECT 'ALIMENTACION',      COUNT(*) FROM ALIMENTACION
UNION ALL SELECT 'CONTROL_SANITARIO', COUNT(*) FROM CONTROL_SANITARIO
UNION ALL SELECT 'VENTA',             COUNT(*) FROM VENTA
UNION ALL SELECT 'VENTA_DETALLE',     COUNT(*) FROM VENTA_DETALLE;