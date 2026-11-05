
CREATE TABLE camionero (
    CI VARCHAR(10) NOT NULL,
    nombre VARCHAR(100),
    salario DECIMAL(10,2),
    CONSTRAINT pk_camionero PRIMARY KEY (CI)
);

CREATE TABLE provincia (
    cod_provincia INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_provincia PRIMARY KEY (cod_provincia)
);

CREATE TABLE paquete (
    codigo_paquete INT NOT NULL,
    descripcion VARCHAR(100),
    destinatario VARCHAR(100),
    direccion_destinatario VARCHAR(100),
    CI_camionero VARCHAR(10) NOT NULL,
    cod_provincia INT NOT NULL,
    CONSTRAINT pk_paquete PRIMARY KEY (codigo_paquete),
    CONSTRAINT fk_paquete_camionero FOREIGN KEY (CI_camionero) REFERENCES camionero (CI),
    CONSTRAINT fk_paquete_provincia FOREIGN KEY (cod_provincia) REFERENCES provincia (cod_provincia)
);

CREATE TABLE camionero_direccion (
    CI VARCHAR(10) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    CONSTRAINT pk_camionero_direccion PRIMARY KEY (CI, direccion),
    CONSTRAINT fk_camionero_direccion_camionero FOREIGN KEY (CI) REFERENCES camionero (CI)
);

CREATE TABLE camionero_telefono (
    CI VARCHAR(10) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    CONSTRAINT pk_camionero_telefono PRIMARY KEY (CI, telefono),
    CONSTRAINT fk_camionero_telefono_camionero FOREIGN KEY (CI) REFERENCES camionero (CI)
);

CREATE TABLE camion (
    matricula VARCHAR(10) NOT NULL,
    modelo VARCHAR(100),
    tipo VARCHAR(100),
    potencia INT,
    CONSTRAINT pk_camion PRIMARY KEY (matricula)
);

CREATE TABLE maneja (
    CI VARCHAR(10) NOT NULL,
    matricula VARCHAR(10) NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT pk_maneja PRIMARY KEY (CI, matricula, fecha),
    CONSTRAINT fk_maneja_camionero FOREIGN KEY (CI) REFERENCES camionero (CI),
    CONSTRAINT fk_maneja_camion FOREIGN KEY (matricula) REFERENCES camion (matricula)
);
