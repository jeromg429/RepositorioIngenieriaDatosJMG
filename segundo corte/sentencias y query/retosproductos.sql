create database reto;
use reto;
drop database reto;

CREATE TABLE empleados(
idEmpleado INT PRIMARY KEY AUTO_INCREMENT,
nombreEmpleado VARCHAR(100) NOT NULL,
idDepartamentoFK INT,
salarioEmpleado DOUBLE NOT NULL,
FOREIGN KEY (idDepartamentoFK) REFERENCES departamento(idDepartamento)
);

CREATE TABLE producto(
idProducto INT PRIMARY KEY AUTO_INCREMENT,
nombreProducto VARCHAR(100) NOT NULL,
precioProducto DOUBLE NOT NULL
);

CREATE TABLE departamento(
idDepartamento INT PRIMARY KEY AUTO_INCREMENT,
nombreDepartamento VARCHAR(100) NOT NULL
);

INSERT INTO empleados (idEmpleado,nombreEmpleado,idDepartamentoFK,salarioEmpleado)
VALUES ('','juan','1','300000'),
('','juana','2','100000'),
('','juanes','3','200000'),
('','juancho','2','400000'),
('','juanita','1','350000');

INSERT INTO producto (idProducto,nombreProducto,precioProducto)
VALUES ('','prod1','10000'),
('','prod2','20000'),
('','prod3','30000'),
('','prod4','40000'),
('','prod5','50000');

INSERT INTO departamento (idDepartamento,nombreDepartamento)
VALUES ('','quindio'),
('','antioquia'),
('','caqueta');

SELECT * FROM empleados;



SELECT depto_id, prom_salario
FROM
	(select depto_id, AVG(salarioEmpleado) as prom_salario
    FROM empleados
    GROUP BY depto_id) AS promedios
where prom_salario > 280000.000000