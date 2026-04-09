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
    precioproducto double not null,
    categoria      varchar(50) not null,
    stock          int default 0
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

insert into producto (nombreproducto, precioproducto, categoria, stock) values
('balón de fútbol',         80000,  'deportes', 10),
('camiseta deportiva',      65000,  'ropa y calzado', 15),
('zapatillas running',     250000,  'ropa y calzado', 8),
('juego de ollas',         320000,  'hogar y jardín', 5),
('set de legos 500 piezas',190000,  'juguetería', 12),
('shampoo anticaída',       35000,  'belleza y cuidado', 20),
('aceite de oliva 1l',      28000,  'alimentación', 25),
('collar para perro',       22000,  'mascotas', 18),
('cuaderno universitario',   8500,  'libros y papelería', 30),
('taladro inalámbrico',    450000,  'ferretería', 4);

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
(6,  5, 2);   

select
    p.idpedido,
    e.nombreeempleado  as empleado,
    p.preciototal,
    pr.nombreproducto  as producto,
    dp.cantidad
from pedido p
inner join empleado e  on p.idempleadofk  = e.idempleado
inner join detallepedido dp on p.idpedido = dp.idpedidofk
inner join producto pr on dp.idproductofk = pr.idproducto;

/* ====== Procedimientos almacenados =======
bloques de codigo de sql que tienen un nombre que se almacenan en el servidor 
y se ejecutan con invocacion o llamandolos CALL registri o de consulta de modificacion o de acualización de eliminación
con parametros entrada in salida out o ambos inout

sintaxis

DELIMITER//
create procedure nommbreProcedimiento(
	in parametroEntrada tipo(,)
    out parametroSalida tipo(,)
    inout parametroAmbos tipo(,)
)
BEGIN
--declaracion de variables locales
declare variable tipo default valor;

--cuerpo del procedimieto
---sentencias sql, control flujo, etc...
END//
DELIMITER;

--invocar procedimiento
call nombreProcedimiento(valorEntrada, variableSalida, variableAmbos);
*/

-- ejemplo 1 registro de un pedido completo
delimiter //

create procedure crearPedido(
    in p_id_cliente int,
    in p_id_producto int,
    in p_cantidad_producto int,
    out p_id_pedido int,
    out p_mensaje varchar(200)
)
begin
    declare v_stock int;
    declare v_precio double;
    declare v_total double;

    declare exit handler for sqlexception
    begin
        rollback;
        set p_mensaje = "transacción no exitosa papu :v";
        set p_id_pedido = -1;
    end;

    -- validar
    select stock, precioproducto
    into v_stock, v_precio
    from producto
    where idproducto = p_id_producto;

    if v_stock < p_cantidad_producto then
        set p_mensaje = concat("stock insuficiente papu :v, hay:", v_stock, " del producto");
        set p_id_pedido = 0;
    else
        start transaction;

        set v_total = v_precio * p_cantidad_producto;

        -- crear pedido
        insert into pedido(preciototal, idempleadofk)
        values(p_id_cliente, v_total);

        set p_id_pedido = last_insert_id();

        -- insertar detalle
        insert into detallepedido(idpedidofk, idproductofk, cantidad)
        values(p_id_pedido, p_id_producto, p_cantidad_producto);

        -- descontar del stock
        update producto
        set stock = stock - p_cantidad_producto
        where idproducto = p_id_producto;

        commit;

        set p_mensaje = concat("pedido#", p_id_pedido, " creado correctamente");
    end if;

end //

delimiter ;

-- invocar procedimiento
call crearPedido(1,3,10,@pedido_id,@msg);