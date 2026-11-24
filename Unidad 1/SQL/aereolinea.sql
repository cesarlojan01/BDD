

CREATE TABLE avion (
    id_avion INT NOT NULL,
    modelo VARCHAR(100),
    CONSTRAINT pk_avion PRIMARY KEY (id_avion)
);

CREATE TABLE vuelo (
    id_vuelo INT NOT NULL,
    fecha DATE,
    origen VARCHAR(100),
    destino VARCHAR(100),
    id_avion INT NOT NULL,
    CONSTRAINT pk_vuelo PRIMARY KEY (id_vuelo),
    CONSTRAINT fk_vuelo_avion FOREIGN KEY (id_avion) REFERENCES avion (id_avion)
);

CREATE TABLE pasajero (
    id_pasajero INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_pasajero PRIMARY KEY (id_pasajero)
);

CREATE TABLE reserva (
    id_reserva INT NOT NULL,
    asiento VARCHAR(5),
    tarifa DECIMAL(10,2),
    id_vuelo INT NOT NULL,
    id_pasajero INT NOT NULL,
    CONSTRAINT pk_reserva PRIMARY KEY (id_reserva),
    CONSTRAINT fk_reserva_vuelo FOREIGN KEY (id_vuelo) REFERENCES vuelo (id_vuelo),
    CONSTRAINT fk_reserva_pasajero FOREIGN KEY (id_pasajero) REFERENCES pasajero (id_pasajero)
);
