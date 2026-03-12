## query instruccion o peticion a la base de datos
/*
lenguaje de definiciion de datos ddl
create
alter
drop
truncate
*/
##creacion de base de datos (create database nombre_DB)
create database companiaseguros;

##habilitar o encender BD (use nombre_DB)
use companiaseguros;

/* crear tablas
create table nombre_tab(
campo1 datatype (tamaño) restriccion,
etc...
);
*/

create table compania(
idcompania varchar (50) primary key,
nit varchar (20) unique not null,
nombrecompania varchar (50) not null,
fechafundacion date null,
representantelegal varchar (50) not null
);

create table seguros(
idseguro varchar (50) primary key,
estado varchar (20) not null,
costo double  not null,
fechainicio date null,
fechaexpiracion date null
);
