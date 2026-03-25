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
create database if not exists tiendaOnline;
use tiendaOnline;

create table clientes(
idCliente int primary key auto_increment,
nombreCliente varchar(100) not null,
emailCliente varchar(150) unique,
ciudad varchar(80) null,
creado_en datetime default now()
);

create table productos(
idProducto int primary key auto_increment,
nombreProducto varchar(120) not null,
precioProducto decimal(10,2),
stockProducto int default 0,
categoriaProducto varchar(60)
);

create table pedido(
idPedido int primary key auto_increment,
cantidadProducto int not null,
fechaPedido date,
idClienteFK int,
idProductoFK int,
foreign key (idClienteFK) references clientes(idCliente),
foreign key (idProductoFK) references productos(idProducto)
);

create table cliente_cbackup (
idClienBack int primary key auto_increment,
nombreCliente varchar(100) ,
emailCliente varchar(150),
copiado_en datetime default now()
);
-- select consulta general de las tablas 
select * from clientes;

select * from productos;

select * from pedido;


-- Inserciones insert into nombre_tabla (campos1,campo2,campo3,...) values (valor1,valor2,valor3,...)
-- si el campo es varchar va entre comillas
-- si el campo es autoincrement s debe enviar el campo sin valor ''
-- si el campo es una fecha debe revisar el formato

-- Agregar 1 registro
describe clientes;
insert into clientes(idCliente,nombreCliente,emailCliente,ciudad) values ('','Ana Garcia','ana@mail.com','Madrid');
insert into clientes(nombreCliente,emailCliente,ciudad) values ('Pedro Perez','pedro@mail.com','Barcelona');
 select * from clientes;
-- Agregar Varios registros
describe productos;
insert into productos (nombreProducto,precioProducto,stockProducto,categoriaProducto)
values ('Laptop Pro',1200000,15,'Electrónica'), 
('Mouse USB',50000,80,'Accesorios'),
('Monitor 32"',500000,20,'Electrónica'),
('Teclados',100000,35,'Accesorios');

select * from productos;

insert into cliente_backup (nombreCliente,emailCliente)
select nombreCliente,emailCliente
from clientes
where creado_en<'2026-03-20';

rename table cliente_cbackup to cliente_backup;

select * from cliente_backup;

describe cliente_backup;

-- Update actualizar o modificar los registros en una tabla
-- update nombreTabla set columna1=valor1,columna2=valor2,.... where condicion
select * from clientes;
-- Actualizar un campo
update clientes
set ciudad='Valencia'
where idCliente=1;

-- Actualizar varios campos
select * from productos;

update productos
set
precioProducto=1099000,
stockProducto=10
where idProducto=1;

update productos
set precioProducto=precioProducto * 1.10
where categoriaProducto='Accesorios';

-- delete eliminar registro  Where 

-- investigar los metodos de tipo numericos y caracteres en MySQL
-- investigar si se puede o no revertir una eliminacion de registros pista rollback csi se puede como
-- delete from nombre_tabla where condicion

select * from clientes;
delete from clientes 
where idCliente=2;

select * from productos;
delete from productos
where stockProducto=0 AND categoriaProducto='Descatalogado';

/* NSERT
1. Inserta 3 clientes nuevos con nombre, email y ciudad
2. Inserta 2 productos con nombre, precio, stock y categoría
3. Inserta 1 pedido vinculando un cliente y un producto recién creados
UPDATE
4. Cambia la ciudad de uno de tus clientes insertados
5. Aumenta en 5 unidades el stock de uno de tus productos
6. Modifica el precio del segundo producto aplicando un descuento del 10%
DELETE
7. Elimina el pedido que creaste en el punto 3
8. Elimina el cliente cuya ciudad cambiaste en el punto 4
9. Elimina todos los productos con stock menor a 3

*/

SET SQL_SAFE_UPDATES = 1;
SET SQL_SAFE_UPDATES = 0;

### sentencia para consultas

describe productos;

alter table productos change stockProducto stoProdT int(11);

### sentencias where
select nombreProducto, stoProdT from productos;
select nombreProducto as Nombre_Producto, stoProdT as stock from productos where stoProdT>=15 and idProducto=1;
select nombreProducto as Nombre_Producto, stoProdT as stock from productos where stoProdT>=25 or idProducto=1;

### select campos from nombre_tabla order by campo_a_ordenar formaOrden (ASC DESC)
select nombreProducto as Nombre_Producto, stoProdT as stock from productos order by stoProdT asc;
select nombreProducto as Nombre_Producto, stoProdT as stock from productos order by nombreProducto desc;

##between 
## select * from NOMBRE_TABLA between val1 and val2
select nombreProducto as Nombre_Producto, precioProducto as precio from productos where precioProducto between 50000 and 100000 order by precioProducto asc;

##like que inicien, que terminen o que contengan caracteres
#que inicien ('char%')
select * from productos where nombreproducto like 'm%';
#que contengan ('%char%')
select * from productos where nombreproducto like '%a%';
#que terminen ('%char%')
select * from productos where nombreproducto like '%b';

select * from productos;