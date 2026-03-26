-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-03-2026 a las 19:19:44
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `companiaseguros`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `accidente`
--

CREATE TABLE `accidente` (
  `idaccidente` varchar(50) NOT NULL,
  `fechaaccidente` date NOT NULL,
  `lugar` varchar(50) NOT NULL,
  `heridos` int(11) DEFAULT NULL,
  `fatalidades` int(11) DEFAULT NULL,
  `automotores` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `automovil`
--

CREATE TABLE `automovil` (
  `idauto` varchar(50) NOT NULL,
  `marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `anofabricacion` int(11) NOT NULL,
  `serialchasis` varchar(50) NOT NULL,
  `pasajeros` int(11) NOT NULL,
  `cilindraje` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compania`
--

CREATE TABLE `compania` (
  `idcompania` varchar(50) NOT NULL,
  `nit` varchar(20) NOT NULL,
  `nombreCompania` varchar(50) NOT NULL,
  `fechafundacion` date DEFAULT NULL,
  `representantelegal` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `companiaseguros`
--

CREATE TABLE `companiaseguros` (
  `idcompania` varchar(50) NOT NULL,
  `nit` varchar(20) NOT NULL,
  `nombrecompania` varchar(50) NOT NULL,
  `fechafundacion` date DEFAULT NULL,
  `representantelegal` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detallesaccidente`
--

CREATE TABLE `detallesaccidente` (
  `iddetalle` int(11) NOT NULL,
  `idaccidenteFK` varchar(50) NOT NULL,
  `idautoFK` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `seguros`
--

CREATE TABLE `seguros` (
  `idseguro` varchar(50) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `costo` double NOT NULL,
  `fechainicio` date NOT NULL,
  `fechaexpiracion` date NOT NULL,
  `valorasegurado` double NOT NULL,
  `idcompaniaFK` varchar(50) NOT NULL,
  `idautomovilFK` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `accidente`
--
ALTER TABLE `accidente`
  ADD PRIMARY KEY (`idaccidente`);

--
-- Indices de la tabla `automovil`
--
ALTER TABLE `automovil`
  ADD PRIMARY KEY (`idauto`);

--
-- Indices de la tabla `compania`
--
ALTER TABLE `compania`
  ADD PRIMARY KEY (`idcompania`),
  ADD UNIQUE KEY `nit` (`nit`);

--
-- Indices de la tabla `companiaseguros`
--
ALTER TABLE `companiaseguros`
  ADD PRIMARY KEY (`idcompania`),
  ADD UNIQUE KEY `nit` (`nit`);

--
-- Indices de la tabla `detallesaccidente`
--
ALTER TABLE `detallesaccidente`
  ADD PRIMARY KEY (`iddetalle`);

--
-- Indices de la tabla `seguros`
--
ALTER TABLE `seguros`
  ADD PRIMARY KEY (`idseguro`),
  ADD KEY `fkcompaniaseguros` (`idcompaniaFK`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `seguros`
--
ALTER TABLE `seguros`
  ADD CONSTRAINT `fkcompaniaseguros` FOREIGN KEY (`idcompaniaFK`) REFERENCES `companiaseguros` (`idcompania`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
