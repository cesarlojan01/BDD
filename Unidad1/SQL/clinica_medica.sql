
CREATE TABLE paciente (
    id_paciente INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_paciente PRIMARY KEY (id_paciente)
);

CREATE TABLE consultorio (
    id_consultorio INT NOT NULL,
    numero VARCHAR(10),
    CONSTRAINT pk_consultorio PRIMARY KEY (id_consultorio)
);

CREATE TABLE especialidad (
    id_especialidad INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_especialidad PRIMARY KEY (id_especialidad)
);

CREATE TABLE medico (
    id_medico INT NOT NULL,
    nombre VARCHAR(100),
    id_especialidad INT NOT NULL,
    CONSTRAINT pk_medico PRIMARY KEY (id_medico),
    CONSTRAINT fk_medico_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidad (id_especialidad)
);

CREATE TABLE cita (
    id_cita INT NOT NULL,
    fecha DATE,
    hora TIME,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_consultorio INT NOT NULL,
    CONSTRAINT pk_cita PRIMARY KEY (id_cita),
    CONSTRAINT fk_cita_paciente FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente),
    CONSTRAINT fk_cita_medico FOREIGN KEY (id_medico) REFERENCES medico (id_medico),
    CONSTRAINT fk_cita_consultorio FOREIGN KEY (id_consultorio) REFERENCES consultorio (id_consultorio)
);

CREATE TABLE receta (
    id_receta INT NOT NULL,
    id_cita INT NOT NULL,
    duracion VARCHAR(100),
    dosis VARCHAR(100),
    CONSTRAINT pk_receta PRIMARY KEY (id_receta),
    CONSTRAINT uq_receta_id_cita UNIQUE (id_cita),
    CONSTRAINT fk_receta_cita FOREIGN KEY (id_cita) REFERENCES cita (id_cita)
);

CREATE TABLE medicamento (
    id_medicamento INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_medicamento PRIMARY KEY (id_medicamento)
);

CREATE TABLE receta_medicamento (
    id_receta INT NOT NULL,
    id_medicamento INT NOT NULL,
    CONSTRAINT pk_receta_medicamento PRIMARY KEY (id_receta, id_medicamento),
    CONSTRAINT fk_receta_medicamento_receta FOREIGN KEY (id_receta) REFERENCES receta (id_receta),
    CONSTRAINT fk_receta_medicamento_medicamento FOREIGN KEY (id_medicamento) REFERENCES medicamento (id_medicamento)
);
