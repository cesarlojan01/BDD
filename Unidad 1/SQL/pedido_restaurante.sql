
CREATE TABLE cliente (
    id_cliente INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente)
);

CREATE TABLE mesero (
    id_mesero INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_mesero PRIMARY KEY (id_mesero)
);

CREATE TABLE pedido (
    id_pedido INT NOT NULL,
    fecha DATE,
    id_cliente INT NOT NULL,
    id_mesero INT NOT NULL,
    CONSTRAINT pk_pedido PRIMARY KEY (id_pedido),
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    CONSTRAINT fk_pedido_mesero FOREIGN KEY (id_mesero) REFERENCES mesero (id_mesero)
);

CREATE TABLE categoria (
    id_categoria INT NOT NULL,
    nombre VARCHAR(100),
    CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE plato (
    id_plato INT NOT NULL,
    nombre VARCHAR(100),
    id_categoria INT NOT NULL,
    CONSTRAINT pk_plato PRIMARY KEY (id_plato),
    CONSTRAINT fk_plato_categoria FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
);

CREATE TABLE detalle_pedido (
    id_pedido INT NOT NULL,
    id_plato INT NOT NULL,
    precio_unitario DECIMAL(10,2),
    CONSTRAINT pk_detalle_pedido PRIMARY KEY (id_pedido, id_plato),
    CONSTRAINT fk_detalle_pedido_pedido FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
    CONSTRAINT fk_detalle_pedido_plato FOREIGN KEY (id_plato) REFERENCES plato (id_plato)
);
