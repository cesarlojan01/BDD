use db_competencias_deportivas;

create table competencia(
    id_competencia INT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);
ALTER TABLE competencia
    ADD COLUMN fecha_inscripcion_inicio TIMESTAMP NOT NULL,
    ADD COLUMN fecha_inscripcion_final TIMESTAMP NOT NULL;


create table facultad(
    id_facultad INT PRIMARY KEY,
    nombre varchar(70) NOT NULL,
    siglas varchar(10) NOT NULL
);


create table carrera(
    id_carrera INT PRIMARY KEY,
    nombre VARCHAR(70) NOT NULL
);

ALTER TABLE carrera
    ADD COLUMN id_facultad INT NOT NULL,
    ADD CONSTRAINT fk_carrera_facultad 
        FOREIGN KEY (id_facultad) REFERENCES facultad(id_facultad) 
        ON UPDATE CASCADE
        ON DELETE RESTRICT;
       

create table estudiante(
    nombres varchar(25)
);

ALTER TABLE estudiante
    ADD COLUMN id_estudiante INT PRIMARY KEY FIRST,
    ADD COLUMN cedula VARCHAR(10) NOT NULL UNIQUE AFTER id_estudiante,
    ADD COLUMN apellidos VARCHAR(25) NOT NULL,
    ADD COLUMN genero ENUM('M','F'),
    ADD COLUMN correo_institucional TEXT, 
    ADD COLUMN id_carrera INT NOT NULL,
    ADD CONSTRAINT fk_estudiante_carrera 
        FOREIGN KEY (id_carrera) REFERENCES carrera(id_carrera);

