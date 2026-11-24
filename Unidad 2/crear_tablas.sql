
CREATE TABLE
    IF NOT EXISTS provincias (
        id_provincia INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL
    );

CREATE TABLE
    IF NOT EXISTS cantones (
        id_canton INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        id_provincia INT,
        FOREIGN KEY (id_provincia) REFERENCES provincias (id_provincia)
    );

CREATE TABLE
    IF NOT EXISTS organizaciones (
        id_organizacion INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        siglas VARCHAR(20) NOT NULL
    );

CREATE TABLE
    IF NOT EXISTS dignidades (
        id_dignidad INT AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL
    );

CREATE TABLE
    IF NOT EXISTS candidatos (
        id_candidato INT AUTO_INCREMENT PRIMARY KEY,
        nombres VARCHAR(100) NOT NULL,
        apellidos VARCHAR(100) NOT NULL,
        id_organizacion INT,
        id_dignidad INT,
        id_canton INT,
        votos INT DEFAULT 0,
        FOREIGN KEY (id_organizacion) REFERENCES organizaciones (id_organizacion),
        FOREIGN KEY (id_dignidad) REFERENCES dignidades (id_dignidad),
        FOREIGN KEY (id_canton) REFERENCES cantones (id_canton)
    );

CREATE TABLE
    IF NOT EXISTS resultados (
        id_resultado INT AUTO_INCREMENT PRIMARY KEY,
        id_candidato INT,
        votos INT,
        FOREIGN KEY (id_candidato) REFERENCES candidatos (id_candidato)
    );