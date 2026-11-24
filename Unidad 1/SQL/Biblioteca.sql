
CREATE TABLE libro (
    id_libro INT NOT NULL,
    titulo VARCHAR(100),
    CONSTRAINT pk_libro PRIMARY KEY (id_libro)
);

CREATE TABLE autor (
    id_autor INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_autor PRIMARY KEY (id_autor)
);

CREATE TABLE libro_autor (
    id_libro INT NOT NULL,
    id_autor INT NOT NULL,
    CONSTRAINT pk_libro_autor PRIMARY KEY (id_libro, id_autor),
    CONSTRAINT fk_libro_autor_libro FOREIGN KEY (id_libro) REFERENCES libro (id_libro),
    CONSTRAINT fk_libro_autor_autor FOREIGN KEY (id_autor) REFERENCES autor (id_autor)
);

CREATE TABLE socio (
    id_socio INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_socio PRIMARY KEY (id_socio)
);

CREATE TABLE prestamo (
    id_prestamo INT NOT NULL,
    id_libro INT NOT NULL,
    id_socio INT NOT NULL,
    fecha_retiro DATE,
    fecha_devolucion DATE,
    CONSTRAINT pk_prestamo PRIMARY KEY (id_prestamo),
    CONSTRAINT fk_prestamo_libro FOREIGN KEY (id_libro) REFERENCES libro (id_libro),
    CONSTRAINT fk_prestamo_socio FOREIGN KEY (id_socio) REFERENCES socio (id_socio)
);
