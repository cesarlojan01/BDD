
CREATE TABLE cliente (
    codigo INT NOT NULL,
    nombre VARCHAR(100),
    apellidos VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR(15),
    CONSTRAINT pk_cliente PRIMARY KEY (codigo)
);

CREATE TABLE producto (
    codigo INT NOT NULL,
    descripcion VARCHAR(100),
    precio DECIMAL(10,2),
    num_existencias INT,
    CONSTRAINT pk_producto PRIMARY KEY (codigo)
);

CREATE TABLE compra (
    codigo_cliente INT NOT NULL,
    codigo_producto INT NOT NULL,
    fecha_compra DATE NOT NULL,
    CONSTRAINT pk_compra PRIMARY KEY (codigo_cliente, codigo_producto, fecha_compra),
    CONSTRAINT fk_compra_cliente FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo),
    CONSTRAINT fk_compra_producto FOREIGN KEY (codigo_producto) REFERENCES producto (codigo)
);

CREATE TABLE proveedor (
    codigo INT NOT NULL,
    nombres VARCHAR(100),
    apellidos VARCHAR(100),
    direccion VARCHAR(100),
    provincia VARCHAR(100),
    telefono VARCHAR(15),
    CONSTRAINT pk_proveedor PRIMARY KEY (codigo)
);

CREATE TABLE suministra (
    codigo_producto INT NOT NULL,
    codigo_proveedor INT NOT NULL,
    CONSTRAINT pk_suministra PRIMARY KEY (codigo_producto, codigo_proveedor),
    CONSTRAINT fk_suministra_producto FOREIGN KEY (codigo_producto) REFERENCES producto (codigo),
    CONSTRAINT fk_suministra_proveedor FOREIGN KEY (codigo_proveedor) REFERENCES proveedor (codigo)
);
