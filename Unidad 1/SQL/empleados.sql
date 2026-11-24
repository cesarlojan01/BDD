

CREATE TABLE departamento (
    id_departamento INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_departamento PRIMARY KEY (id_departamento)
);

CREATE TABLE empleado (
    id_empleado INT NOT NULL,
    nombre VARCHAR(100),
    id_departamento INT NOT NULL,
    id_supervisor INT,
    CONSTRAINT pk_empleado PRIMARY KEY (id_empleado),
    CONSTRAINT fk_empleado_departamento FOREIGN KEY (id_departamento) REFERENCES departamento (id_departamento),
    CONSTRAINT fk_empleado_empleado FOREIGN KEY (id_supervisor) REFERENCES empleado (id_empleado)
);

CREATE TABLE historial_salario (
    id_empleado INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    salario DECIMAL(10,2),
    CONSTRAINT pk_historial_salario PRIMARY KEY (id_empleado, fecha_inicio),
    CONSTRAINT fk_historial_salario_empleado FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)
);

CREATE TABLE proyecto (
    id_proyecto INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_proyecto PRIMARY KEY (id_proyecto)
);

CREATE TABLE trabaja (
    id_empleado INT NOT NULL,
    id_proyecto INT NOT NULL,
    numero_horas INT,
    CONSTRAINT pk_trabaja PRIMARY KEY (id_empleado, id_proyecto),
    CONSTRAINT fk_trabaja_empleado FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado),
    CONSTRAINT fk_trabaja_proyecto FOREIGN KEY (id_proyecto) REFERENCES proyecto (id_proyecto)
);
