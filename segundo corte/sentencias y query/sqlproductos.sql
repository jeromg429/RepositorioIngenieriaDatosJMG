create database if not exists tiendaonline_v3;
use tiendaonline_v3;

create table departamento (
    iddepto     varchar(50) primary key,
    nombredepto varchar(50) not null
);

create table empleado (
    idempleado      int auto_increment primary key,
    nombreeempleado varchar(50) not null,
    deptoidfk       varchar(50) not null,
    salario         int(10),
    constraint fkdeptoemple
        foreign key (deptoidfk) references departamento(iddepto)
);

create table producto (
    idproducto     int auto_increment primary key,
    nombreproducto varchar(50) not null,
    precioproducto double      not null,
    categoria      varchar(50) not null
);

create table pedido (
    idpedido     int auto_increment primary key,
    preciototal  double not null,
    idempleadofk int(11) not null,
    constraint fkempleado
        foreign key (idempleadofk) references empleado(idempleado)
);

create table detallepedido (
    iddetalle    int auto_increment primary key,
    idpedidofk   int not null,
    idproductofk int not null,
    cantidad     int not null default 1,
    constraint fkdetalle_pedido
        foreign key (idpedidofk)   references pedido(idpedido),
    constraint fkdetalle_producto
        foreign key (idproductofk) references producto(idproducto)
);

insert into departamento (iddepto, nombredepto) values
('A001', 'deportes'),
('A002', 'ropa y calzado'),
('A003', 'hogar y jardín'),
('A004', 'juguetería'),
('A005', 'belleza y cuidado'),
('A006', 'alimentación'),
('A007', 'mascotas'),
('A008', 'libros y papelería'),
('A009', 'ferretería'),
('A010', 'automotriz');


insert into producto (nombreproducto, precioproducto, categoria) values
('balón de fútbol',         80000,  'deportes'),
('camiseta deportiva',      65000,  'ropa y calzado'),
('zapatillas running',     250000,  'ropa y calzado'),
('juego de ollas',         320000,  'hogar y jardín'),
('set de legos 500 piezas',190000,  'juguetería'),
('shampoo anticaída',       35000,  'belleza y cuidado'),
('aceite de oliva 1l',      28000,  'alimentación'),
('collar para perro',       22000,  'mascotas'),
('cuaderno universitario',   8500,  'libros y papelería'),
('taladro inalámbrico',    450000,  'ferretería');


insert into empleado (nombreeempleado, deptoidfk, salario) values
('miguel ángel suárez',  'A001', 2400000),
('isabella reyes',       'A002', 2100000),
('tomás cifuentes',      'A003', 1950000),
('valeria sandoval',     'A004', 2200000),
('samuel ospina',        'A005', 2300000),
('natalia figueroa',     'A006', 1800000),
('daniel arango',        'A007', 2000000),
('paula jiménez',        'A008', 1750000),
('ricardo benavides',    'A009', 2600000),
('gloria estrada',       'A010', 2900000);


insert into pedido (preciototal, idempleadofk) values
(145000,  1),  
(250000,  3),  
(513000,  5),  
(398000,  2),  
(56500,   6),   
(472000,  4),  
(900000,  9),  
(63000,   7),   
(17000,   8);


insert into detallepedido (idpedidofk, idproductofk, cantidad) values
(1,  1, 1),   
(1,  2, 1),   
(2,  4, 1),   
(7,  6, 3),   
(3,  3, 1),   
(4,  3, 1),   
(4,  2, 2),   
(5,  7, 2),   
(6,  5, 2),   

select
    p.idpedido,
    e.nombreeempleado  as empleado,
    p.preciototal,
    pr.nombreproducto  as producto,
    dp.cantidad
from pedido p
inner join empleado      e  on p.idempleadofk  = e.idempleado
inner join detallepedido dp on p.idpedido      = dp.idpedidofk
inner join producto      pr on dp.idproductofk = pr.idproducto;