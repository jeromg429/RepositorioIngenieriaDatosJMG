-- SENTENCIAS DML: Lenguaje de Manipulacion de datos
-- 0. es crear la estructura de la BD (modelo físico-diccionario de datos)
-- 1. DATOS PUROS O LIMPIOS (ETL)
-- 2. Manipulacion de datos (hacer registros, consultar registros, modificar registros, eliminar registros)
-- un logica transaccional (sentencias) (indicacion orden una petición transacción) MySQL SQL
-- trabajar sobre el contenido
-- Transaccional: Crear-Insertar Agregar registros (insert)
-- Modificar actualizar (Update)
-- Consultas sobre la BD (Select)
-- Eliminar (Delete)

-- Insert (agregar crear registra insertar datos
-- consulta general select * from nombre_tabla

-- CREACIÓN BD
CREATE DATABASE IF NOT EXISTS tiendaOnline;
USE tiendaOnline;

-- REINICIAR
DROP DATABASE tiendaOnline;

-- TABLAS
CREATE TABLE clientes(
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nombreCliente VARCHAR(100) NOT NULL,
emailCliente VARCHAR(150) UNIQUE,
ciudad VARCHAR(80) NULL,
creado_en DATETIME DEFAULT NOW()
);

CREATE TABLE productos(
idProducto INT PRIMARY KEY AUTO_INCREMENT,
nombreProducto VARCHAR(120) NOT NULL,
precioProducto DECIMAL(10,2),
stockProducto INT DEFAULT 0,
categoriaProducto VARCHAR(60)
);

CREATE TABLE pedido(
idPedido INT PRIMARY KEY AUTO_INCREMENT,
cantidadProducto INT NOT NULL,
fechaPedido DATE,
idClienteFK INT,
idProductoFK INT,
FOREIGN KEY (idClienteFK) REFERENCES clientes(idCliente),
FOREIGN KEY (idProductoFK) REFERENCES productos(idProducto)
);

-- 🔴 CORREGIDO: nombre consistente
CREATE TABLE cliente_backup (
idClienBack INT PRIMARY KEY AUTO_INCREMENT,
nombreCliente VARCHAR(100),
emailCliente VARCHAR(150),
copiado_en DATETIME DEFAULT NOW()
);

-- CONSULTAS
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM pedido;

-- INSERTS CLIENTES
DESCRIBE clientes;

INSERT INTO clientes(idCliente,nombreCliente,emailCliente,ciudad)
VALUES ('','Ana Garcia','ana@mail.com','Madrid');

INSERT INTO clientes(nombreCliente,emailCliente,ciudad)
VALUES ('Pedro Perez','pedro@mail.com','Barcelona');

SELECT * FROM clientes;

-- INSERTS PRODUCTOS
DESCRIBE productos;

INSERT INTO productos (nombreProducto,precioProducto,stockProducto,categoriaProducto)
VALUES 
('Laptop Pro',1200000,15,'Electrónica'), 
('Mouse USB',50000,80,'Accesorios'),
('Monitor 32"',500000,20,'Electrónica'),
('Teclados',100000,35,'Accesorios');

SELECT * FROM productos;

-- BACKUP (orden corregido)
INSERT INTO cliente_backup (nombreCliente,emailCliente)
SELECT nombreCliente,emailCliente
FROM clientes
WHERE creado_en < '2026-03-20';

SELECT * FROM cliente_backup;

DESCRIBE cliente_backup;

-- UPDATE
SELECT * FROM clientes;

UPDATE clientes
SET ciudad='Valencia'
WHERE idCliente=1;

SELECT * FROM productos;

UPDATE productos
SET precioProducto=1099000,
    stockProducto=10
WHERE idProducto=1;

UPDATE productos
SET precioProducto = precioProducto * 1.10
WHERE categoriaProducto='Accesorios';

-- DELETE
SELECT * FROM clientes;

DELETE FROM clientes 
WHERE idCliente=2;

SELECT * FROM productos;

DELETE FROM productos
WHERE stockProducto=0 AND categoriaProducto='Descatalogado';

-- CONFIGURACIÓN
SET SQL_SAFE_UPDATES = 0;

-- ALTER
ALTER TABLE productos CHANGE stockProducto stoProdT INT(11);

-- CONSULTAS CON WHERE
SELECT nombreProducto, stoProdT FROM productos;

SELECT nombreProducto AS Nombre_Producto, stoProdT AS stock 
FROM productos 
WHERE stoProdT>=15 AND idProducto=1;

SELECT nombreProducto AS Nombre_Producto, stoProdT AS stock 
FROM productos 
WHERE stoProdT>=25 OR idProducto=1;

-- ORDER BY
SELECT nombreProducto AS Nombre_Producto, stoProdT AS stock 
FROM productos 
ORDER BY stoProdT ASC;

SELECT nombreProducto AS Nombre_Producto, stoProdT AS stock 
FROM productos 
ORDER BY nombreProducto DESC;

-- BETWEEN
SELECT nombreProducto AS Nombre_Producto, precioProducto AS precio 
FROM productos 
WHERE precioProducto BETWEEN 50000 AND 100000 
ORDER BY precioProducto ASC;

-- LIKE
SELECT * FROM productos WHERE nombreProducto LIKE 'm%';
SELECT * FROM productos WHERE nombreProducto LIKE '%a%';
SELECT * FROM productos WHERE nombreProducto LIKE '%b';

-- CLIENTES
LOAD DATA INFILE 'C:\Users\jermu\Downloads\RepositorioIngenieriaDatosJMG\segundo corte\sentencias y query\data csv\clientes.csv'
INTO TABLE clientes
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- PRODUCTOS
LOAD DATA INFILE 'C:\Users\jermu\Downloads\RepositorioIngenieriaDatosJMG\segundo corte\sentencias y query\data csv\productos.csv'
INTO TABLE productos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- PEDIDOS
LOAD DATA INFILE "C:\Users\jermu\Downloads\RepositorioIngenieriaDatosJMG\segundo corte\sentencias y query\data csv\pedido.csv"
INTO TABLE pedido
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- ACTIVAR
SET GLOBAL local_infile = 1;

### METODOS ENTEROS
-- SUMA
SELECT SUM(stockProducto) AS total_stock FROM productos;

-- PROMEDIO
SELECT AVG(precioProducto) AS promedio_precio FROM productos;

### METODOS VARCHAR
-- CONCAT
SELECT CONCAT(nombreCliente, ' - ', ciudad) AS cliente_info FROM clientes;

-- LENGTH
SELECT nombreCliente, LENGTH(nombreCliente) AS longitud FROM clientes;