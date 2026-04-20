-- =====================================================
-- base de datos
-- =====================================================

drop database if exists tienda_tech;
create database tienda_tech;
use tienda_tech;

-- =====================================================
-- tablas
-- =====================================================

create table clientes (
    cliente_id int auto_increment primary key,
    nombre varchar(100),
    email varchar(100),
    ciudad varchar(60),
    fecha_registro date
);

create table productos (
    producto_id int auto_increment primary key,
    nombre varchar(100),
    categoria varchar(60),
    precio decimal(10,2),
    stock int
);

create table pedidos (
    pedido_id int auto_increment primary key,
    cliente_id int,
    producto_id int,
    cantidad int,
    fecha_pedido date,
    estado varchar(20),

    foreign key (cliente_id) references clientes(cliente_id),
    foreign key (producto_id) references productos(producto_id)
);

-- =====================================================
-- datos
-- =====================================================

insert into clientes values
(1,'ana','a@mail.com','bogota','2023-01-01'),
(2,'carlos','c@mail.com','medellin','2023-02-01');

insert into productos values
(1,'laptop','computadores',3000000,10),
(2,'mouse','perifericos',80000,50),
(3,'teclado','perifericos',200000,20);

insert into pedidos values
(1,1,1,1,'2024-01-01','entregado'),
(2,1,2,2,'2024-01-05','entregado'),
(3,2,3,1,'2024-02-01','pendiente');

-- =====================================================
-- 1. alter + update join (total del pedido)
-- =====================================================

alter table pedidos add column total decimal(12,2);

update pedidos p
join productos pr on p.producto_id = pr.producto_id
set p.total = p.cantidad * pr.precio;

-- =====================================================
-- 2. vista (ventas por cliente)
-- =====================================================

create view vista_ventas_cliente as
select 
    c.cliente_id,
    c.nombre,
    sum(p.cantidad * pr.precio) as total_ingresos,
    count(p.pedido_id) as total_pedidos
from clientes c
join pedidos p on c.cliente_id = p.cliente_id
join productos pr on p.producto_id = pr.producto_id
where p.estado = 'entregado'
group by c.cliente_id;

-- =====================================================
-- 3. funcion (ingreso cliente)
-- =====================================================

delimiter //

create function fn_ingreso_cliente(p_id int)
returns decimal(12,2)
deterministic
begin
    declare total decimal(12,2);

    select sum(p.cantidad * pr.precio)
    into total
    from pedidos p
    join productos pr on p.producto_id = pr.producto_id
    where p.cliente_id = p_id
    and p.estado = 'entregado';

    return ifnull(total,0);
end //

delimiter ;

-- =====================================================
-- 4. procedimiento (registrar pedido con validaciones)
-- =====================================================

delimiter //

create procedure sp_registrar_pedido(
    p_cliente int,
    p_producto int,
    p_cantidad int
)
begin
    declare v_stock int;

    -- validar stock
    select stock into v_stock
    from productos
    where producto_id = p_producto;

    if v_stock >= p_cantidad then

        -- insertar pedido
        insert into pedidos(cliente_id, producto_id, cantidad, fecha_pedido, estado)
        values(p_cliente, p_producto, p_cantidad, curdate(), 'pendiente');

        -- actualizar stock
        update productos
        set stock = stock - p_cantidad
        where producto_id = p_producto;

    else
        select 'stock insuficiente' as mensaje;
    end if;

end //

delimiter ;

-- =====================================================
-- 5. consulta avanzada (clientes vip)
-- =====================================================

select 
    c.nombre,
    fn_ingreso_cliente(c.cliente_id) as ingreso
from clientes c
where fn_ingreso_cliente(c.cliente_id) >
(
    select avg(total_ingresos)
    from vista_ventas_cliente
)
order by ingreso desc;
