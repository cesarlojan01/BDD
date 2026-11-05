

CREATE TABLE genero_musical (
    id_genero INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_genero_musical PRIMARY KEY (id_genero)
);

CREATE TABLE cancion (
    id_cancion INT NOT NULL,
    titulo VARCHAR(100),
    CONSTRAINT pk_cancion PRIMARY KEY (id_cancion)
);

CREATE TABLE cantante (
    id_cantante INT NOT NULL,
    nombre VARCHAR(100),
    pais VARCHAR(100),
    CONSTRAINT pk_cantante PRIMARY KEY (id_cantante)
);

CREATE TABLE disco (
    id_disco INT NOT NULL,
    titulo VARCHAR(100),
    precio DECIMAL(10,2),
    id_cantante INT NOT NULL,
    id_genero INT NOT NULL,
    CONSTRAINT pk_disco PRIMARY KEY (id_disco),
    CONSTRAINT fk_disco_cantante FOREIGN KEY (id_cantante) REFERENCES cantante (id_cantante),
    CONSTRAINT fk_disco_genero_musical FOREIGN KEY (id_genero) REFERENCES genero_musical (id_genero)
);

CREATE TABLE disco_cancion (
    id_disco INT NOT NULL,
    id_cancion INT NOT NULL,
    CONSTRAINT pk_disco_cancion PRIMARY KEY (id_disco, id_cancion),
    CONSTRAINT fk_disco_cancion_disco FOREIGN KEY (id_disco) REFERENCES disco (id_disco),
    CONSTRAINT fk_disco_cancion_cancion FOREIGN KEY (id_cancion) REFERENCES cancion (id_cancion)
);
