

CREATE TABLE manager (
    id_manager INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_manager PRIMARY KEY (id_manager)
);

CREATE TABLE artista (
    NIF VARCHAR(15) NOT NULL,
    nombre VARCHAR(100),
    id_manager INT NOT NULL,
    CONSTRAINT pk_artista PRIMARY KEY (NIF),
    CONSTRAINT fk_artista_manager FOREIGN KEY (id_manager) REFERENCES manager (id_manager)
);

CREATE TABLE evento (
    id_evento INT NOT NULL,
    fecha DATE,
    asistente INT,
    CONSTRAINT pk_evento PRIMARY KEY (id_evento)
);

CREATE TABLE participa (
    NIF VARCHAR(15) NOT NULL,
    id_evento INT NOT NULL,
    CONSTRAINT pk_participa PRIMARY KEY (NIF, id_evento),
    CONSTRAINT fk_participa_artista FOREIGN KEY (NIF) REFERENCES artista (NIF),
    CONSTRAINT fk_participa_evento FOREIGN KEY (id_evento) REFERENCES evento (id_evento)
);
