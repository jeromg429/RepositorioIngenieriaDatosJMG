## query instruccion o peticion a la base de datos
/* 
lenguaje de definicion de datos DDL 
create -> crea datos
alter -> hacer relaciones o alteraciones
drop -> borrar tablas j
truncate -> modificar obligadamente 
definen datos
*/
## creacion de base de datos
create database companiaseguros;
## encender/ habailitar bases de datos "use nombre_base_de_datos"
use companiaseguros;

/* crear tablas
create table nombre_tabla (campo1 tipodato1 (tamano) restriccion, campo2 tipodato2 tamano restriccion);
*/

create table compania(
idcompania varchar (50) primary key, 
nit varchar (20) unique not null,
nombreCompania varchar (50) not null,
fechafundacion date null,
representantelegal varchar (50) not null);
create table seguros(
idseguro varchar (50) primary key,
 estado varchar (20) not null,
 costo double not null,
 fechainicio date not null,
 fechaexpiracion date not null,
 valorasegurado double not null,
 idcompaniaFK varchar (50) not null,
 idautomovilFK varchar (50) not null);
 create table automovil (
 idauto varchar (50) primary key, 
 marca varchar (50) not null,
 modelo varchar (50) not null,
 tipo varchar (50) not null,
 anofabricacion int not null,
 serialchasis varchar (50) not null,
 pasajeros int not null,
 cilindraje double not null);
 create table detallesaccidente(
 iddetalle int primary key,
 idaccidenteFK varchar (50) not null,
 idautoFK varchar (50) not null);
 create table accidente(
 idaccidente varchar (50) primary key,
 fechaaccidente date not null,
 lugar varchar (50) not null,
 heridos int null,
 fatalidades int null,
 automotores int not null);
 
 alter table compania rename to companiaseguros;
 alter table companiaseguros drop fehcafundacion;
 alter table seguros drop foreign key idcompaniaFK;
 alter table seguros
 add constraint fkcompaniaseguros
 foreign key (idcompaniaFK)
 references companiaseguros(idcompania);