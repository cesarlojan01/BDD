use gad_db;
CREATE TABLE provincias (
    id_provincia   INT          PRIMARY KEY,
    nombre         VARCHAR(60)  NOT NULL UNIQUE
);

CREATE TABLE cantones (
    id_canton      INT          PRIMARY KEY,
    nombre         VARCHAR(60)  NOT NULL,
    id_provincia   INT          NOT NULL,
    CONSTRAINT fk_canton_provincia
        FOREIGN KEY (id_provincia) REFERENCES provincias(id_provincia)
);

CREATE TABLE organizaciones_politicas (
    id_organizacion  INT           PRIMARY KEY,
    nombre           VARCHAR(100)  NOT NULL UNIQUE,
    siglas           VARCHAR(10)   NOT NULL UNIQUE,
    numero_lista     INT           NOT NULL UNIQUE,
    tipo             VARCHAR(20)   NOT NULL,
    CONSTRAINT chk_tipo_organizacion
        CHECK (tipo IN ('Partido', 'Movimiento'))
);

CREATE TABLE dignidades (
    id_dignidad    INT          PRIMARY KEY,
    nombre         VARCHAR(60)  NOT NULL UNIQUE,
    ambito         VARCHAR(20)  NOT NULL,
    CONSTRAINT chk_ambito_dignidad
        CHECK (ambito IN ('Provincial', 'Cantonal', 'Parroquial'))
);


CREATE TABLE candidatos (
    id_candidato     INT          PRIMARY KEY,
    cedula           VARCHAR(10)  NOT NULL UNIQUE,
    nombres          VARCHAR(60)  NOT NULL,
    apellidos        VARCHAR(60)  NOT NULL,
    id_organizacion  INT          NOT NULL,
    id_dignidad      INT          NOT NULL,
    id_canton        INT          NOT NULL,
    CONSTRAINT fk_candidato_organizacion
        FOREIGN KEY (id_organizacion) REFERENCES organizaciones_politicas(id_organizacion),
    CONSTRAINT fk_candidato_dignidad
        FOREIGN KEY (id_dignidad) REFERENCES dignidades(id_dignidad),
    CONSTRAINT fk_candidato_canton
        FOREIGN KEY (id_canton) REFERENCES cantones(id_canton)
);


CREATE TABLE votantes (
    id_votante        INT          PRIMARY KEY,
    cedula            VARCHAR(10)  NOT NULL UNIQUE,
    nombres           VARCHAR(60)  NOT NULL,
    apellidos         VARCHAR(60)  NOT NULL,
    fecha_nacimiento  DATE         NOT NULL,
    id_canton         INT          NOT NULL,
    CONSTRAINT fk_votante_canton
        FOREIGN KEY (id_canton) REFERENCES cantones(id_canton)
);


CREATE TABLE resultados (
    id_resultado    INT   PRIMARY KEY,
    id_candidato    INT   NOT NULL UNIQUE,
    votos           INT   NOT NULL,
    fecha_registro  DATE  NOT NULL,
    CONSTRAINT chk_votos_positivos
        CHECK (votos >= 0),
    CONSTRAINT fk_resultado_candidato
        FOREIGN KEY (id_candidato) REFERENCES candidatos(id_candidato)
);