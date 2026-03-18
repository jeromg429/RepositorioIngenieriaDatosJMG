##reto 1
create database tienda_online;
use tienda_online;

##reto 2
create table productos(
idproducto int unique auto_increment,
nombreproducto varchar(10) not null,
precioproducto double not null,
stockproducto int default 0,
fechacreacionproducto datetime default current_timestamp);

##reto 3
create table cliente(
idcliente int unique auto_increment,
nombrecliente varchar (10) not null,
emailcliente varchar(20) unique,
telefonocliente int null);

create table pedido(
idpedido int unique auto_increment,
idclientefk int ,
fechapedido date not null,
total int not null);


alter table cliente
add constraint fkcliente
foreign key (idclienteFK)
references pedido(idpedido);

alter table pedidos
add categoriaproductopedido varchar (50);

alter table cliente
change telefonocliente telefonocliente int null, telefonocliente varchar(15) null;




