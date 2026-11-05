

CREATE TABLE personal_clinico (
    codigo INT NOT NULL,
    cedula VARCHAR(10),
    nombre VARCHAR(100),
    CONSTRAINT pk_personal_clinico PRIMARY KEY (codigo),
    CONSTRAINT uq_personal_clinico_cedula UNIQUE (cedula)
);

CREATE TABLE veterinario (
    codigo INT NOT NULL,
    fecha_alta DATE,
    especialidad VARCHAR(100),
    CONSTRAINT pk_veterinario PRIMARY KEY (codigo),
    CONSTRAINT fk_veterinario_personal_clinico FOREIGN KEY (codigo) REFERENCES personal_clinico (codigo)
);

CREATE TABLE auxiliar (
    codigo INT NOT NULL,
    base_cotizacion DECIMAL(10,2),
    CONSTRAINT pk_auxiliar PRIMARY KEY (codigo),
    CONSTRAINT fk_auxiliar_personal_clinico FOREIGN KEY (codigo) REFERENCES personal_clinico (codigo)
);

CREATE TABLE propietario (
    cedula VARCHAR(10) NOT NULL,
    nombre VARCHAR(100),
    apellidos VARCHAR(100),
    direccion VARCHAR(100),
    CONSTRAINT pk_propietario PRIMARY KEY (cedula)
);

CREATE TABLE mascota (
    cedula_propietario VARCHAR(10) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(100),
    fecha_nacimiento DATE,
    CONSTRAINT pk_mascota PRIMARY KEY (cedula_propietario, nombre),
    CONSTRAINT fk_mascota_propietario FOREIGN KEY (cedula_propietario) REFERENCES propietario (cedula)
);

CREATE TABLE consulta (
    codigo_veterinario INT NOT NULL,
    cedula_propietario VARCHAR(10) NOT NULL,
    nombre_mascota VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    CONSTRAINT pk_consulta PRIMARY KEY (codigo_veterinario, cedula_propietario, nombre_mascota, fecha),
    CONSTRAINT fk_consulta_veterinario FOREIGN KEY (codigo_veterinario) REFERENCES veterinario (codigo),
    CONSTRAINT fk_consulta_mascota FOREIGN KEY (cedula_propietario, nombre_mascota) REFERENCES mascota (cedula_propietario, nombre)
);

CREATE TABLE propietario_telefono (
    cedula VARCHAR(10) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    CONSTRAINT pk_propietario_telefono PRIMARY KEY (cedula, telefono),
    CONSTRAINT fk_propietario_telefono_propietario FOREIGN KEY (cedula) REFERENCES propietario (cedula)
);

CREATE TABLE familiar_contacto (
    cedula VARCHAR(10) NOT NULL,
    nombres VARCHAR(100),
    telefono VARCHAR(15),
    cedula_propietario VARCHAR(10) NOT NULL,
    CONSTRAINT pk_familiar_contacto PRIMARY KEY (cedula),
    CONSTRAINT uq_familiar_contacto_cedula_propietario UNIQUE (cedula_propietario),
    CONSTRAINT fk_familiar_contacto_propietario FOREIGN KEY (cedula_propietario) REFERENCES propietario (cedula)
);
