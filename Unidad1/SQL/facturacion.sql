

CREATE TABLE cliente (
    cedula VARCHAR(10) NOT NULL,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    direccion VARCHAR(100),
    CONSTRAINT pk_cliente PRIMARY KEY (cedula)
);

CREATE TABLE producto (
    ref INT NOT NULL,
    descripcion VARCHAR(100),
    CONSTRAINT pk_producto PRIMARY KEY (ref)
);

CREATE TABLE cliente_telefono (
    cedula VARCHAR(10) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    CONSTRAINT pk_cliente_telefono PRIMARY KEY (cedula, telefono),
    CONSTRAINT fk_cliente_telefono_cliente FOREIGN KEY (cedula) REFERENCES cliente (cedula)
);

CREATE TABLE empleado (
    cedula VARCHAR(10) NOT NULL,
    nombre VARCHAR(100),
    telefono VARCHAR(15),
    CONSTRAINT pk_empleado PRIMARY KEY (cedula)
);

CREATE TABLE factura (
    codigo INT NOT NULL,
    fecha DATE,
    estado VARCHAR(20),
    cedula_cliente VARCHAR(10) NOT NULL,
    cedula_empleado VARCHAR(10) NOT NULL,
    CONSTRAINT pk_factura PRIMARY KEY (codigo),
    CONSTRAINT fk_factura_cliente FOREIGN KEY (cedula_cliente) REFERENCES cliente (cedula),
    CONSTRAINT fk_factura_empleado FOREIGN KEY (cedula_empleado) REFERENCES empleado (cedula)
);

CREATE TABLE detalle (
    codigo_factura INT NOT NULL,
    ref_producto INT NOT NULL,
    cantidad INT,
    precio DECIMAL(10,2),
    CONSTRAINT pk_detalle PRIMARY KEY (codigo_factura, ref_producto),
    CONSTRAINT fk_detalle_factura FOREIGN KEY (codigo_factura) REFERENCES factura (codigo),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (ref_producto) REFERENCES producto (ref)
);

CREATE TABLE usuario (
    cedula_empleado VARCHAR(10) NOT NULL,
    nombre_usuario VARCHAR(50),
    password VARCHAR(255),
    estado VARCHAR(20),
    CONSTRAINT pk_usuario PRIMARY KEY (cedula_empleado),
    CONSTRAINT uq_usuario_nombre_usuario UNIQUE (nombre_usuario),
    CONSTRAINT fk_usuario_empleado FOREIGN KEY (cedula_empleado) REFERENCES empleado (cedula)
);
