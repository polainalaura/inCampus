-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-04-2026 a las 14:55:54
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gestion_academica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignatura`
--

CREATE TABLE `asignatura` (
  `id_asignatura` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asignatura`
--

INSERT INTO `asignatura` (`id_asignatura`, `nombre`, `codigo`, `descripcion`) VALUES
(1, 'Bases de Datos', 'BD01', 'Diseño y administración de bases de datos'),
(2, 'Sistemas Operativos', 'SO01', 'Administración de sistemas'),
(3, 'Implantación de Aplicaciones Web', 'IAW01', 'Despliegue de aplicaciones web'),
(4, 'Seguridad Informática', 'SEG01', 'Seguridad en sistemas y redes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `documento`
--

CREATE TABLE `documento` (
  `id_documento` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `url_archivo` varchar(255) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `fecha_subida` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_profesor` int(11) NOT NULL,
  `id_asignatura` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `documento`
--

INSERT INTO `documento` (`id_documento`, `titulo`, `url_archivo`, `tipo`, `fecha_subida`, `id_profesor`, `id_asignatura`) VALUES
(1, 'Tema 1 BD', '/docs/bd_tema1.pdf', 'pdf', '2026-02-25 16:35:09', 1, 1),
(2, 'Tema 2 BD', '/docs/bd_tema2.pdf', 'pdf', '2026-02-25 16:35:09', 1, 1),
(3, 'Guía SO', '/docs/so_guia.pdf', 'pdf', '2026-02-25 16:35:09', 2, 2),
(4, 'Manual Seguridad', '/docs/seg_manual.pdf', 'pdf', '2026-02-25 16:35:09', 2, 4),
(5, 'Práctica IAW', '/docs/iaw_practica.zip', 'zip', '2026-02-25 16:35:09', 1, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `matricula`
--

CREATE TABLE `matricula` (
  `id_alumno` int(11) NOT NULL,
  `id_asignatura` int(11) NOT NULL,
  `fecha_matricula` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `matricula`
--

INSERT INTO `matricula` (`id_alumno`, `id_asignatura`, `fecha_matricula`) VALUES
(4, 1, '2024-09-01'),
(4, 2, '2024-09-01'),
(5, 1, '2024-09-01'),
(5, 3, '2024-09-01'),
(6, 2, '2024-09-01'),
(6, 4, '2024-09-01'),
(7, 1, '2024-09-01'),
(8, 3, '2024-09-01'),
(9, 4, '2024-09-01'),
(10, 2, '2024-09-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor_asignatura`
--

CREATE TABLE `profesor_asignatura` (
  `id_profesor` int(11) NOT NULL,
  `id_asignatura` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesor_asignatura`
--

INSERT INTO `profesor_asignatura` (`id_profesor`, `id_asignatura`) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4),
(3, 1),
(3, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reserva_tutoria`
--

CREATE TABLE `reserva_tutoria` (
  `id_reserva` int(11) NOT NULL,
  `fecha_reserva` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('PENDIENTE','CONFIRMADA','CANCELADA') DEFAULT 'PENDIENTE',
  `motivo` text DEFAULT NULL,
  `id_tutoria` int(11) NOT NULL,
  `id_alumno` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reserva_tutoria`
--

INSERT INTO `reserva_tutoria` (`id_reserva`, `fecha_reserva`, `estado`, `motivo`, `id_tutoria`, `id_alumno`) VALUES
(1, '2026-02-25 16:35:09', 'CONFIRMADA', 'Dudas examen', 1, 4),
(2, '2026-02-25 16:35:09', 'PENDIENTE', 'Consulta proyecto', 2, 5),
(3, '2026-02-25 16:35:09', 'CONFIRMADA', 'Revisión práctica', 3, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tutoria`
--

CREATE TABLE `tutoria` (
  `id_tutoria` int(11) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `ubicacion` varchar(150) DEFAULT NULL,
  `estado_slot` enum('DISPONIBLE','RESERVADA','CANCELADA') DEFAULT 'DISPONIBLE',
  `id_profesor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tutoria`
--

INSERT INTO `tutoria` (`id_tutoria`, `fecha_inicio`, `fecha_fin`, `ubicacion`, `estado_slot`, `id_profesor`) VALUES
(1, '2025-03-01 10:00:00', '2025-03-01 11:00:00', 'Aula 1', 'DISPONIBLE', 1),
(2, '2025-03-02 09:00:00', '2025-03-02 10:00:00', 'Aula 2', 'DISPONIBLE', 2),
(3, '2025-03-03 12:00:00', '2025-03-03 13:00:00', 'Aula 3', 'DISPONIBLE', 3),
(4, '2025-03-04 10:00:00', '2025-03-04 11:00:00', 'Aula 1', 'DISPONIBLE', 1),
(5, '2025-03-05 09:00:00', '2025-03-05 10:00:00', 'Aula 2', 'DISPONIBLE', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido1` varchar(100) NOT NULL,
  `apellido2` varchar(100) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `rol` enum('ALUMNO','PROFESOR','ADMIN') NOT NULL,
  `fecha_alta` timestamp NOT NULL DEFAULT current_timestamp(),
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `apellido1`, `apellido2`, `email`, `password_hash`, `rol`, `fecha_alta`, `activo`) VALUES
(1, 'Carlos', 'Lopez', 'Garcia', 'carlos.lopez@email.com', '$2b$10$gL6fZQmTzYpXAjM2CYViAOCXqYwRmCg1JEaLkPQL6nvj.Qkco8Ciq', 'PROFESOR', '2026-02-25 16:35:09', 1),
(2, 'Ana', 'Martinez', 'Ruiz', 'ana.martinez@email.com', '$2b$10$gL6fZQmTzYpXAjM2CYViAOCXqYwRmCg1JEaLkPQL6nvj.Qkco8Ciq', 'PROFESOR', '2026-02-25 16:35:09', 1),
(3, 'Laura', 'Sanchez', 'Perez', 'laura.sanchez@email.com', '$2b$10$gL6fZQmTzYpXAjM2CYViAOCXqYwRmCg1JEaLkPQL6nvj.Qkco8Ciq', 'PROFESOR', '2026-02-25 16:35:09', 1),
(4, 'Mario', 'Fernandez', 'Diaz', 'mario.fernandez@email.com', '$2b$10$gL6fZQmTzYpXAjM2CYViAOCXqYwRmCg1JEaLkPQL6nvj.Qkco8Ciq', 'ALUMNO', '2026-02-25 16:35:09', 1),
(5, 'Lucia', 'Gomez', 'Navarro', 'lucia.gomez@email.com', '$2b$10$gL6fZQmTzYpXAjM2CYViAOCXqYwRmCg1JEaLkPQL6nvj.Qkco8Ciq', 'ALUMNO', '2026-02-25 16:35:09', 1),
(6, 'David', 'Torres', 'Santos', 'david.torres@email.com', '$2b$10$gL6fZQmTzYpXAjM2CYViAOCXqYwRmCg1JEaLkPQL6nvj.Qkco8Ciq', 'ALUMNO', '2026-02-25 16:35:09', 1),
(7, 'Paula', 'Romero', 'Iglesias', 'paula.romero@email.com', '$2b$10$gL6fZQmTzYpXAjM2CYViAOCXqYwRmCg1JEaLkPQL6nvj.Qkco8Ciq', 'ALUMNO', '2026-02-25 16:35:09', 1),
(8, 'Sergio', 'Vazquez', 'Molina', 'sergio.vazquez@email.com', '$2b$10$gL6fZQmTzYpXAjM2CYViAOCXqYwRmCg1JEaLkPQL6nvj.Qkco8Ciq', 'ALUMNO', '2026-02-25 16:35:09', 1),
(9, 'Elena', 'Castro', 'Ortega', 'elena.castro@email.com', '$2b$10$gL6fZQmTzYpXAjM2CYViAOCXqYwRmCg1JEaLkPQL6nvj.Qkco8Ciq', 'ALUMNO', '2026-02-25 16:35:09', 1),
(10, 'Javier', 'Herrera', 'Gil', 'javier.herrera@email.com', '$2b$10$gL6fZQmTzYpXAjM2CYViAOCXqYwRmCg1JEaLkPQL6nvj.Qkco8Ciq', 'ALUMNO', '2026-02-25 16:35:09', 1),
(11, '', '', NULL, 'ari@test.com', '$2b$10$gL6fZQmTzYpXAjM2CYViAOCXqYwRmCg1JEaLkPQL6nvj.Qkco8Ciq', 'ALUMNO', '2026-03-20 13:14:04', 1),
(12, 'Fernando', 'Alonso', 'Lopez', 'alonso@test.com', '$2b$10$OFMLoVRyzLjkPZNaPyeD9elvMLdDB0tTBSuRmOlGG9wRLp0BHinkm', 'ALUMNO', '2026-03-20 13:49:55', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asignatura`
--
ALTER TABLE `asignatura`
  ADD PRIMARY KEY (`id_asignatura`),
  ADD UNIQUE KEY `codigo` (`codigo`);

--
-- Indices de la tabla `documento`
--
ALTER TABLE `documento`
  ADD PRIMARY KEY (`id_documento`),
  ADD KEY `id_profesor` (`id_profesor`),
  ADD KEY `idx_documento_asignatura` (`id_asignatura`);

--
-- Indices de la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD PRIMARY KEY (`id_alumno`,`id_asignatura`),
  ADD KEY `id_asignatura` (`id_asignatura`);

--
-- Indices de la tabla `profesor_asignatura`
--
ALTER TABLE `profesor_asignatura`
  ADD PRIMARY KEY (`id_profesor`,`id_asignatura`),
  ADD KEY `id_asignatura` (`id_asignatura`);

--
-- Indices de la tabla `reserva_tutoria`
--
ALTER TABLE `reserva_tutoria`
  ADD PRIMARY KEY (`id_reserva`),
  ADD UNIQUE KEY `id_tutoria` (`id_tutoria`),
  ADD KEY `idx_reserva_alumno` (`id_alumno`);

--
-- Indices de la tabla `tutoria`
--
ALTER TABLE `tutoria`
  ADD PRIMARY KEY (`id_tutoria`),
  ADD KEY `idx_tutoria_profesor` (`id_profesor`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_usuario_email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asignatura`
--
ALTER TABLE `asignatura`
  MODIFY `id_asignatura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `documento`
--
ALTER TABLE `documento`
  MODIFY `id_documento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `reserva_tutoria`
--
ALTER TABLE `reserva_tutoria`
  MODIFY `id_reserva` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tutoria`
--
ALTER TABLE `tutoria`
  MODIFY `id_tutoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `documento`
--
ALTER TABLE `documento`
  ADD CONSTRAINT `documento_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `documento_ibfk_2` FOREIGN KEY (`id_asignatura`) REFERENCES `asignatura` (`id_asignatura`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `matricula`
--
ALTER TABLE `matricula`
  ADD CONSTRAINT `matricula_ibfk_1` FOREIGN KEY (`id_alumno`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `matricula_ibfk_2` FOREIGN KEY (`id_asignatura`) REFERENCES `asignatura` (`id_asignatura`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `profesor_asignatura`
--
ALTER TABLE `profesor_asignatura`
  ADD CONSTRAINT `profesor_asignatura_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `profesor_asignatura_ibfk_2` FOREIGN KEY (`id_asignatura`) REFERENCES `asignatura` (`id_asignatura`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reserva_tutoria`
--
ALTER TABLE `reserva_tutoria`
  ADD CONSTRAINT `reserva_tutoria_ibfk_1` FOREIGN KEY (`id_tutoria`) REFERENCES `tutoria` (`id_tutoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reserva_tutoria_ibfk_2` FOREIGN KEY (`id_alumno`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tutoria`
--
ALTER TABLE `tutoria`
  ADD CONSTRAINT `tutoria_ibfk_1` FOREIGN KEY (`id_profesor`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
