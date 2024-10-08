-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-10-2024 a las 15:11:18
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
-- Base de datos: `ucss`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `alumno_id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido_paterno` varchar(100) DEFAULT NULL,
  `apellido_materno` varchar(100) DEFAULT NULL,
  `numero_documento` varchar(20) DEFAULT NULL,
  `numero_celular` varchar(15) DEFAULT NULL,
  `carrera` varchar(100) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`alumno_id`, `usuario_id`, `nombre`, `apellido_paterno`, `apellido_materno`, `numero_documento`, `numero_celular`, `carrera`, `fecha_creacion`) VALUES
(1, 41, 'Prueba', 'Uno', '123', '55555555', '1111122222', 'Administrador de Negocios', '2024-10-08 01:53:04'),
(2, 46, 'Fernando ', 'Ponce', 'Molina', '55555555', '5511', 'Ciencia de la Computación', '2024-10-08 02:00:48'),
(3, 48, 'Fernando ', 'ADA', 'CAEFGB', 'dasd21', '950000993', 'Ingeniería Ambiental', '2024-10-08 13:09:06');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carreras`
--

CREATE TABLE `carreras` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carreras`
--

INSERT INTO `carreras` (`id`, `nombre`) VALUES
(1, 'Medicina Humana'),
(2, 'Administración de Negocios'),
(3, 'Ciencia de la Computación'),
(4, 'Ingeniería Electrónica y de Telecomunicaciones'),
(5, 'Educación'),
(6, 'Psicología'),
(7, 'Ingeniería Ambiental');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `semestre` int(11) DEFAULT NULL,
  `carrera_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id`, `nombre`, `semestre`, `carrera_id`) VALUES
(1, 'Fundamentos de la medicina I', 1, 1),
(2, 'Química General', 1, 1),
(3, 'Biología Celular y Genética', 1, 1),
(4, 'Matemática', 1, 1),
(5, 'Fundamentos de la medicina II', 2, 1),
(6, 'Bioquímica', 2, 1),
(7, 'Biología Molecular', 2, 1),
(8, 'Física', 2, 1),
(9, 'Anatomía Humana I', 3, 1),
(10, 'Estructura y Función I', 3, 1),
(11, 'Microbiología I: Virus y Bacterias', 3, 1),
(12, 'Embriología', 3, 1),
(13, 'Anatomía Humana II', 4, 1),
(14, 'Estructura y Función II', 4, 1),
(15, 'Microbiología II: Hongos y Parásitos', 4, 1),
(16, 'Introducción a la Clínica', 5, 1),
(17, 'Patología', 5, 1),
(18, 'Inmunología Clínica', 5, 1),
(19, 'Introducción a la Clínica II', 6, 1),
(20, 'Fisiopatología', 6, 1),
(21, 'Farmacología', 6, 1),
(22, 'Clínica Médica I', 7, 1),
(23, 'Imagenología', 7, 1),
(24, 'Psiquiatría', 7, 1),
(25, 'Clínica Médica II', 8, 1),
(26, 'Clínica Quirúrgica I', 8, 1),
(27, 'Psiquiatría', 8, 1),
(28, 'Clínica Médica III', 9, 1),
(29, 'Clínica Quirúrgica II', 9, 1),
(30, 'Medicina Física y Rehabilitación', 9, 1),
(31, 'Medicina Ocupacional y Legal', 9, 1),
(32, 'Pediatría I', 10, 1),
(33, 'Gineco Obstetricia I', 10, 1),
(34, 'Neurología Clínica Quirúrgica', 10, 1),
(35, 'Cuidados Paliativos', 10, 1),
(36, 'Matemática Básica', 1, 2),
(37, 'Fundamentos de Administración', 1, 2),
(38, 'Economía General', 1, 2),
(39, 'Contabilidad para Administradores', 1, 2),
(40, 'Álgebra y Geometría', 2, 2),
(41, 'Derecho Empresarial', 2, 2),
(42, 'Fundamentos de Marketing', 2, 2),
(43, 'Pensamiento Crítico e Innovación', 2, 2),
(44, 'Cálculo en una Variable', 3, 2),
(45, 'Pensamiento Computacional', 3, 2),
(46, 'Análisis Financiero', 3, 2),
(47, 'Comportamiento del Consumidor', 3, 2),
(48, 'Cálculo en Varias Variables', 4, 2),
(49, 'Estadística y Probabilidades', 4, 2),
(50, 'Desarrollo de Habilidades para el Trabajo en Equipo', 4, 2),
(51, 'Matemáticas Financieras', 4, 2),
(52, 'Análisis, Diseño y Gestión de Procesos', 5, 2),
(53, 'Desarrollo de Habilidades de Negociación', 5, 2),
(54, 'Microeconomía', 5, 2),
(55, 'Estadística para los Negocios', 6, 2),
(56, 'Investigación de Operadores', 6, 2),
(57, 'Logística', 6, 2),
(58, 'Macroeconomía', 6, 2),
(59, 'Taller de Investigación I', 7, 2),
(60, 'Investigación de Mercados', 7, 2),
(61, 'Data Science', 7, 2),
(62, 'Econometría', 8, 2),
(63, 'Planeamiento Estratégico', 8, 2),
(64, 'Desarrollo Organizacional', 8, 2),
(65, 'Taller de Investigación II', 9, 2),
(66, 'Plan de Negocios', 9, 2),
(67, 'Dirección Personal', 9, 2),
(68, 'Taller de Investigación III', 10, 2),
(69, 'Organización Industrial', 10, 2),
(70, 'Transformación Digital', 10, 2),
(71, 'Matemática I', 1, 3),
(72, 'Estructuras Discretas I', 1, 3),
(73, 'Programación de Videojuegos', 1, 3),
(74, 'Matemática II', 2, 3),
(75, 'Estructuras Discretas II', 2, 3),
(76, 'Ciencia de la Computación I', 2, 3),
(77, 'Cálculo I', 3, 3),
(78, 'Ciencia de la Computación II', 3, 3),
(79, 'Desarrollo Basado en Plataformas', 3, 3),
(80, 'Cálculo II', 4, 3),
(81, 'Algoritmos y Estructuras de Datos', 4, 3),
(82, 'Bases de Datos I', 4, 3),
(83, 'Física Computacional', 5, 3),
(84, 'Ingeniería de Software I', 5, 3),
(85, 'Bases de Datos II', 5, 3),
(86, 'Sistemas Operativos', 6, 3),
(87, 'Programación Competitiva', 6, 3),
(88, 'Ingeniería de Software II', 6, 3),
(89, 'Inteligencia Artificial', 7, 3),
(90, 'Lenguajes de Programación', 7, 3),
(91, 'Ingeniería de Software III', 7, 3),
(92, 'Compiladores', 8, 3),
(93, 'Seguridad en Computación', 8, 3),
(94, 'Proyecto de Final de Carrera I', 8, 3),
(95, 'Big Data', 9, 3),
(96, 'Proyecto de Final de Carrera II', 9, 3),
(97, 'Cloud Computing', 10, 3),
(98, 'Proyecto de Final de Carrera III', 10, 3),
(99, 'Matemática I', 1, 4),
(100, 'Álgebra y Geometría', 1, 4),
(101, 'Programación I', 1, 4),
(102, 'Álgebra Lineal', 2, 4),
(103, 'Física', 2, 4),
(104, 'Programación II', 2, 4),
(105, 'Electrónica Digital', 3, 4),
(106, 'Circuitos Electrónicos', 3, 4),
(107, 'Física II', 3, 4),
(108, 'Arquitectura de Computadoras', 4, 4),
(109, 'Redes de Acceso y Medio Compartido', 4, 4),
(110, 'Campos Electromagnéticos', 4, 4),
(111, 'Electrónica Industrial', 5, 4),
(112, 'Sistemas Lineales', 5, 4),
(113, 'Tratamiento de Información', 5, 4),
(114, 'Comunicaciones Digitales', 6, 4),
(115, 'Redes de Ordenadores', 6, 4),
(116, 'Electrónica de Comunicaciones', 6, 4),
(117, 'Sistemas de Control', 7, 4),
(118, 'Alta Frecuencia', 7, 4),
(119, 'Sistemas de Telecomunicaciones', 7, 4),
(120, 'Sistemas Optoelectricos', 8, 4),
(121, 'Antenas y Propagación', 8, 4),
(122, 'Control y Automatización', 9, 4),
(123, 'Proyecto de Tesis I', 9, 4),
(124, 'Comunicaciones Industriales', 10, 4),
(125, 'Proyecto de Tesis II', 10, 4),
(126, 'Epistemología de la Educación', 1, 5),
(127, 'Fundamentos neurobiológicos del aprendizaje', 1, 5),
(128, 'Familia y Escuela', 1, 5),
(129, 'Educación de la corporeidad', 1, 5),
(130, 'Filosofía de la Educación', 2, 5),
(131, 'Psicología del Desarrollo', 2, 5),
(132, 'Educación de la Afectividad', 2, 5),
(133, 'Historia de la Educación', 3, 5),
(134, 'Planificación de la enseñanza', 3, 5),
(135, 'Evaluación', 3, 5),
(136, 'Antropología', 3, 5),
(137, 'Antropología Pedagógica', 4, 5),
(138, 'Sociología de la Educación', 4, 5),
(139, 'Inclusión y Dignidad de la Persona', 4, 5),
(140, 'Alfabetización inicial', 4, 5),
(141, 'Didáctica de la Lengua', 5, 5),
(142, 'Didáctica de la Matemática I', 5, 5),
(143, 'Didáctica de las Ciencias Sociales', 5, 5),
(144, 'Introducción a la Investigación Científica', 5, 5),
(145, 'Seminario de Dificultades en la Lectoescritura', 6, 5),
(146, 'Didáctica de la Matemática II', 6, 5),
(147, 'Metodología de la Investigación cualitativa', 6, 5),
(148, 'Educación en Virtudes', 7, 5),
(149, 'Talleres de Proyectos Educativos', 7, 5),
(150, 'Introducción a las Ciencias Naturales', 7, 5),
(151, 'Didáctica de la Literatura infantil', 7, 5),
(152, 'Inglés y Didáctica', 8, 5),
(153, 'Educación Artística y su Didáctica', 8, 5),
(154, 'Práctica II: Ayudantía', 8, 5),
(155, 'Seminario de dificultades en el pensamiento lógico - matemático', 8, 5),
(156, 'Educación en el Bien, la Verdad y la Belleza', 9, 5),
(157, 'Gestión y Políticas Públicas Educativas', 9, 5),
(158, 'Taller de Tesis I', 9, 5),
(159, 'Práctica Integradora I', 9, 5),
(160, 'Lengua de Señas', 10, 5),
(161, 'Seminario de Actualidad Educativa', 10, 5),
(162, 'Taller de Tesis II', 10, 5),
(163, 'Práctica Integradora II', 10, 5),
(164, 'Matemática Básica', 1, 6),
(165, 'Psicología General I', 1, 6),
(166, 'Historia de la Psicología I', 1, 6),
(167, 'Introducción a la Vida Universitaria', 1, 6),
(168, 'Psico estadística', 2, 6),
(169, 'Psicología General II', 2, 6),
(170, 'Introducción a la Biología Humana', 2, 6),
(171, 'Historia de la Psicología II', 2, 6),
(172, 'Personalidad I', 3, 6),
(173, 'Psicología de Desarrollo I', 3, 6),
(174, 'Psicología Fisiológica', 3, 6),
(175, 'Teología', 3, 6),
(176, 'Personalidad II', 4, 6),
(177, 'Psicología de Desarrollo II', 4, 6),
(178, 'Psicología Cognitiva', 4, 6),
(179, 'Psicometría', 4, 6),
(180, 'Psicología de la Familia', 5, 6),
(181, 'Psicopatología', 5, 6),
(182, 'Psicología de la Educación', 5, 6),
(183, 'Metafísica', 5, 6),
(184, 'Psicofarmacología', 6, 6),
(185, 'Teorías del Aprendizaje', 6, 6),
(186, 'Psicología Organizacional', 6, 6),
(187, 'Moral', 6, 6),
(188, 'Psicología Social', 7, 6),
(189, 'Corrientes de Psicoterapia', 7, 6),
(190, 'Dificultades y Trastornos del Aprendizaje', 7, 6),
(191, 'Psicodiagnóstico', 7, 6),
(192, 'Seminario de Tesis I', 8, 6),
(193, 'Técnicas de Intervención y Tratamiento Psicológico', 8, 6),
(194, 'Intervención Psicoeducativa', 8, 6),
(195, 'Orientación Vocacional y Profesional', 8, 6),
(196, 'Seminario de Tesis II', 9, 6),
(197, 'Psicología Jurídica', 9, 6),
(198, 'Trastornos de Personalidad', 9, 6),
(199, 'Prácticas Pre Profesionales I', 9, 6),
(200, 'Prácticas Pre Profesionales II', 10, 6),
(201, 'Ética Profesional', 10, 6),
(202, 'Psicología de la Adicciones', 10, 6),
(203, 'Matematica I', 1, 7),
(204, 'Quimica I', 1, 7),
(205, 'Introducción a la Ingeniería Ambiental', 1, 7),
(206, 'Metodología del Estudió e Introducción a la Vida Universitaria', 1, 7),
(207, 'Calculo I', 2, 7),
(208, 'Matematica II', 2, 7),
(209, 'Quimica II', 2, 7),
(210, 'Dibujo Técnico y geometria Descriptiva', 2, 7),
(211, 'Calculo II', 3, 7),
(212, 'Fisica I', 3, 7),
(213, 'Estadistica I', 3, 7),
(214, 'Economia General y Ambiental', 3, 7),
(215, 'Estadistica II', 4, 7),
(216, 'Fisica II', 4, 7),
(217, 'Microbiología Ambiental', 4, 7),
(218, 'Ciencia y Tecnologia de los Materiales', 4, 7),
(219, 'Termodinámica', 5, 7),
(220, 'Balance de Materia y Energía', 5, 7),
(221, 'Fenomenos del transporte I', 5, 7),
(222, 'Fundamentos de Programación y Sistemas', 5, 7),
(223, 'Contaminación y Monitoreo Ambiental', 6, 7),
(224, 'Metafisica', 6, 7),
(225, 'Mecanica de Fluidos', 6, 7),
(226, 'Geografia y Topografia', 6, 7),
(227, 'Salud Ambiental', 7, 7),
(228, 'Edafologia y Geotelematica', 7, 7),
(229, 'Hidrologia Ambiental', 7, 7),
(230, 'Meteorologia y Climatologia', 7, 7),
(231, 'Remediación de Suelos y Áreas Contaminadas', 8, 7),
(232, 'Tratamiento de Aguas Residuales y Efluentes', 8, 7),
(233, 'Legislación Ambiental Nacional', 8, 7),
(234, 'Gestion de Residuos Solidos', 8, 7),
(235, 'Taller de Investigación I', 9, 7),
(236, 'Enseñanza Social de la Iglesia', 9, 7),
(237, 'Minería y Ambiente', 9, 7),
(238, 'Gestión de Desastres y Conflictos Ambientales', 9, 7),
(239, 'Taller de Investigación II', 10, 7),
(240, 'Etica Profesional', 10, 7),
(241, 'Gestion Ambiental Costera', 10, 7),
(242, 'Diseños de Sistemas de Ingenieria Ambiental', 10, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `postulantes`
--

CREATE TABLE `postulantes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido_paterno` varchar(100) NOT NULL,
  `apellido_materno` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `numero_celular` varchar(20) NOT NULL,
  `numero_documento` varchar(20) NOT NULL,
  `carrera` varchar(100) NOT NULL,
  `estado` varchar(20) DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `postulantes`
--

INSERT INTO `postulantes` (`id`, `nombre`, `apellido_paterno`, `apellido_materno`, `email`, `numero_celular`, `numero_documento`, `carrera`, `estado`) VALUES
(15, 'Paulo David', 'Carrasco', 'Ludeña', 'paulodex10@gmail.com', '938974574', '00000000', 'Administrador de Negocios', 'aceptado'),
(17, 'Prueba', 'Uno', '123', 'alumno1@gmail.com', '1111122222', '55555555', 'Administrador de Negocios', 'aceptado'),
(18, 'Fernando ', 'Ponce', 'Molina', 'pacsiponce@gmail.com', '1111122222', '55555555', 'Ciencia de la Computación', 'aceptado'),
(19, 'Fernando ', 'ADA', 'CAEFGB', 'angel.pacsi@ucsp.edu.pe', '950000993', 'dasd21', 'Ingeniería Ambiental', 'aceptado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `rol` enum('alumno','administrador') NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `correo`, `contraseña`, `rol`, `fecha_registro`) VALUES
(38, 'Paulo David', 'Carrasco', 'paulo david.carrasco.l@ucss.edu.pe', 'scrypt:32768:8:1$ogHLRgq8jyG4K5YC$79778b67b34ade660480cce27038283534e3506a3ba29d66d42bee4c7715df16efea9e520b0b661a7ce9f0eddfb40b0467a23e9cf9eb566ccc343b6f809bf00c', 'alumno', '2024-10-07 20:15:44'),
(41, 'Prueba', 'Uno', 'prueba.uno.1@ucss.edu.pe', 'scrypt:32768:8:1$LkrLdPBx6wYU4p74$f5491465c2395258316c94d58da4b18c62d6c03fc062b9e5bd5a1c11bf0c8f05595bd3591bb13d382b125d5c6f1f0cc3cd1a209784bd6dab6b037b73b73ccd96', 'alumno', '2024-10-07 20:53:04'),
(46, 'Fernando ', 'Ponce', 'fernando.ponce.m@ucss.edu.pe', 'scrypt:32768:8:1$Uvn9Iyf207xqCTKL$e7abf90396028c08fe7cd596c1084d0e6d6ea1c325aa4fa9e7fa777123e7f4067451bb0cbe54c690c01bea1ab5ece1eae5e5908b02b680c62303f39dc7d1963e', 'alumno', '2024-10-07 21:00:48'),
(47, 'Admin', 'Usuario', 'admin@example.com', 'scrypt:32768:8:1$VJ7pNwmC7DthRdHn$1d2310dc5b08b6960c7a9d964df1a718afb1f224a90d488cc7761bd9b2209b11f03f4089304edb61492bba73898d0aa5d961af1d39aafd544bb306f7612723bb', 'administrador', '2024-10-08 08:06:58'),
(48, 'Fernando ', 'ADA', 'fernando.ada.c@ucss.edu.pe', 'scrypt:32768:8:1$SYIszfe02Z98BpwE$bf6ab45e0b63c3aaf07ddbdf92d1e70322e2995536202d2d80c898e4e1a5fbe6d3556916fe8614431d20c72cfc0dc3b4b5357ee320df5419d94d2a41a4fc9a69', 'alumno', '2024-10-08 08:09:06');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`alumno_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `carreras`
--
ALTER TABLE `carreras`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carrera_id` (`carrera_id`);

--
-- Indices de la tabla `postulantes`
--
ALTER TABLE `postulantes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `alumno_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `carreras`
--
ALTER TABLE `carreras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=243;

--
-- AUTO_INCREMENT de la tabla `postulantes`
--
ALTER TABLE `postulantes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `alumno_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`carrera_id`) REFERENCES `carreras` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
