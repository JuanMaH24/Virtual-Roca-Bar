-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 01-11-2023 a las 01:59:41
-- Versión del servidor: 8.0.31
-- Versión de PHP: 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `roca_bar`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

DROP TABLE IF EXISTS `carrito`;
CREATE TABLE IF NOT EXISTS `carrito` (
  `shopcar_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_cant` int DEFAULT '1',
  PRIMARY KEY (`shopcar_id`),
  UNIQUE KEY `user_id` (`user_id`,`product_id`),
  KEY `FK_shopcar_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

DROP TABLE IF EXISTS `compras`;
CREATE TABLE IF NOT EXISTS `compras` (
  `buy_id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `product_cant` int NOT NULL,
  `estado_borrado` int DEFAULT '1',
  PRIMARY KEY (`buy_id`),
  KEY `FK_buy_supplier_id` (`supplier_id`),
  KEY `FK_buy_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`buy_id`, `product_id`, `supplier_id`, `product_cant`, `estado_borrado`) VALUES
(1, 4, 4, 6, 1),
(2, 7, 4, 5, 1),
(3, 5, 5, 10, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes`
--

DROP TABLE IF EXISTS `imagenes`;
CREATE TABLE IF NOT EXISTS `imagenes` (
  `id` int NOT NULL,
  `img_ref` varchar(120) COLLATE latin1_spanish_ci NOT NULL,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `imagenes`
--

INSERT INTO `imagenes` (`id`, `img_ref`) VALUES
(1, ''),
(3, 'img/ron_marca_blanca.jpg'),
(4, 'img/aguardiente_marca_blanca.jpg'),
(5, 'img/cerveza_marca_blanca.jpg'),
(6, 'img/vino_marca_blanca.jpg'),
(7, 'img/mojito.jpeg'),
(8, 'img/brandy_marca_blanca.jpeg'),
(9, 'img/whisky.jpeg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

DROP TABLE IF EXISTS `productos`;
CREATE TABLE IF NOT EXISTS `productos` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) COLLATE latin1_spanish_ci NOT NULL DEFAULT 'NOMBRE DESCONOCIDO',
  `product_price` int UNSIGNED NOT NULL DEFAULT '0',
  `product_cant` int UNSIGNED NOT NULL DEFAULT '0',
  `estado_borrado` int DEFAULT '1',
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`product_id`, `product_name`, `product_price`, `product_cant`, `estado_borrado`) VALUES
(1, '', 0, 0, 0),
(3, 'RON MARCA BLANCA 125ML', 31500, 35, 1),
(4, 'AGUARDIENTE MARCA BLANCA 500ML', 47000, 18, 1),
(5, 'CERVEZA DE MARCA BLANCA', 5500, 37, 1),
(6, 'VINO MARCA BLANCA', 25000, 12, 1),
(7, 'MOJITO TRADICIONAL', 25000, 5, 1),
(8, 'Brandy 125ML', 25000, 5, 1),
(9, 'WHISKY MARCA BLANCA', 125000, 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE IF NOT EXISTS `proveedores` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `supplier_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `supplier_contact` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `supplier_tipe` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci DEFAULT NULL,
  `estado_borrado` int DEFAULT '1',
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`supplier_id`, `supplier_name`, `supplier_contact`, `supplier_tipe`, `estado_borrado`) VALUES
(1, 'BABARIA', 'BABARIA@BABARIA.COM', 'CERVEZAS', 0),
(4, 'DistriLicor', 'distri@gmail.com', 'TODO LICOR', 1),
(5, 'BABARIA', 'BABARIA@BABARIA.COM', 'CERVEZAS', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `rol_id` tinyint NOT NULL,
  `description` varchar(120) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`rol_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`rol_id`, `description`) VALUES
(0, 'ENCARGADO'),
(1, 'VENDEDOR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `lastname` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `user_name` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `password` varchar(105) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `rol` tinyint NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`user_id`, `name`, `lastname`, `user_name`, `password`, `rol`, `date_create`) VALUES
(6, 'Juan Manuel', 'Herrera', 'Jherrera5', 'pbkdf2:sha256:260000$vNlKmksPAWE29lke$1f5538083572c12fccf3e170b02476c8c2677e4c4214db1e40e052c18cd24b87', 0, '2023-10-22 02:04:37'),
(7, 'Jhonnier', 'Caminos', 'JonnhyBL', 'pbkdf2:sha256:260000$aWiV0CzbKPBqvbhv$68894ff7d177551ff642c87ab95a4f8324e6fa2566b6ac743fc29d733bb78d8d', 1, '2023-10-23 16:15:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_eliminados`
--

DROP TABLE IF EXISTS `usuarios_eliminados`;
CREATE TABLE IF NOT EXISTS `usuarios_eliminados` (
  `user_id` int NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `lastname` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `user_name` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `password` varchar(105) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `rol` tinyint(1) NOT NULL,
  `date_delete` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios_eliminados`
--

INSERT INTO `usuarios_eliminados` (`user_id`, `name`, `lastname`, `user_name`, `password`, `rol`, `date_delete`) VALUES
(8, 'Cristian Andrés', 'Osorio Zuluaga', 'ZuluCristian', 'pbkdf2:sha256:260000$mZ13fUZwLoqSAXr1$da2636afc22bb33259eeb258a557ac63882b6a1c05976527aec8df8977d64e38', 0, '2023-10-24 05:05:32'),
(9, 'Cristian Andrés', 'Osorio Zuluaga', 'ZuluCristian3', 'pbkdf2:sha256:260000$D7Vjsq3nZLmUxbON$d736f4a85c139b24671f23b9fdfe7a27546df99f74cf1a1d765d68173b462ca9', 0, '2023-10-24 05:34:09'),
(10, 'Carlos ', 'Ocampo', 'Kaoz', 'pbkdf2:sha256:260000$4b5OkIWgMlzqrP9B$af0b4db42e762bd8a05b8173f8d506ffebf6b57d123669ae0978910a4f2f7efc', 0, '2023-10-25 14:31:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

DROP TABLE IF EXISTS `ventas`;
CREATE TABLE IF NOT EXISTS `ventas` (
  `sale_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_cant` int UNSIGNED NOT NULL,
  `sale_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado_borrado` int DEFAULT '1',
  PRIMARY KEY (`sale_id`),
  KEY `FK_sales_user_id` (`user_id`),
  KEY `FK_sales_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`sale_id`, `user_id`, `product_id`, `product_cant`, `sale_date`, `estado_borrado`) VALUES
(11, 6, 3, 5, '2023-10-23 01:19:57', 1),
(12, 6, 4, 1, '2023-10-23 01:19:57', 1),
(13, 6, 5, 1, '2023-10-23 01:19:57', 1),
(14, 7, 3, 5, '2023-10-23 16:19:59', 1),
(15, 7, 7, 1, '2023-10-23 16:19:59', 1),
(16, 7, 5, 1, '2023-10-23 16:19:59', 1),
(17, 6, 3, 5, '2023-10-24 23:07:23', 1),
(18, 6, 4, 2, '2023-10-24 23:07:23', 1),
(19, 7, 5, 5, '2023-10-25 14:23:41', 1),
(20, 7, 5, 1, '2023-10-31 19:50:28', 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `FK_shopcar_product_id` FOREIGN KEY (`product_id`) REFERENCES `productos` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_shopcar_user_id` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `proveedores` (`supplier_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `productos` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `imagenes`
--
ALTER TABLE `imagenes`
  ADD CONSTRAINT `imagenes_ibfk_1` FOREIGN KEY (`id`) REFERENCES `productos` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `usuarios` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `productos` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
