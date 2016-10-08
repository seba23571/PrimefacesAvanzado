/*
Navicat MySQL Data Transfer

Source Server         : conexion
Source Server Version : 50545
Source Host           : localhost:3306
Source Database       : agenda

Target Server Type    : MYSQL
Target Server Version : 50545
File Encoding         : 65001

Date: 2016-10-08 01:47:03
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `categoria`
-- ----------------------------
DROP TABLE IF EXISTS `categoria`;
CREATE TABLE `categoria` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- ----------------------------
-- Records of categoria
-- ----------------------------

-- ----------------------------
-- Table structure for `menu`
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `codigo` tinyint(4) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `url` varchar(100) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `tipo` enum('S','I') COLLATE utf8_spanish2_ci NOT NULL,
  `tipoUsuario` enum('A','O') COLLATE utf8_spanish2_ci NOT NULL,
  `codigo_submenu` tinyint(4) DEFAULT NULL,
  `estado` bit(1) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_menu_item` (`codigo_submenu`),
  KEY `codigo` (`codigo`),
  CONSTRAINT `FK_menu_item` FOREIGN KEY (`codigo_submenu`) REFERENCES `menu` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', 'NOTAS', null, 'S', 'O', null, '');
INSERT INTO `menu` VALUES ('2', 'NUEVO', '/protegido/operario/nuevo.mitocode', 'I', 'O', '1', '');
INSERT INTO `menu` VALUES ('3', 'BUSCAR', '/protegido/operario/buscar.mitocode', 'I', 'O', '1', '');
INSERT INTO `menu` VALUES ('4', 'COMENTAR', '/protegido/administrador/comentar.mitocode', 'I', 'A', null, '');
INSERT INTO `menu` VALUES ('5', 'TELEFONOS', '/protegido/operario/telefono.mitocode', 'I', 'O', null, '');
INSERT INTO `menu` VALUES ('6', 'CONSULTAR', '/protegido/administrador/consultar.mitocode', 'I', 'A', null, '');
INSERT INTO `menu` VALUES ('7', 'PRECIOS', '/protegido/administrador/precios.mitocode', 'I', 'A', null, '');

-- ----------------------------
-- Table structure for `nota`
-- ----------------------------
DROP TABLE IF EXISTS `nota`;
CREATE TABLE `nota` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_persona` int(11) NOT NULL,
  `codigo_categoria` int(11) NOT NULL,
  `encabezado` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `cuerpo` varchar(500) COLLATE utf8_spanish2_ci NOT NULL,
  `fecha` datetime NOT NULL,
  `comentarioAdmin` varchar(50) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `valorizacion` enum('1','2','3','4','5') COLLATE utf8_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_nota_categoria` (`codigo_categoria`),
  KEY `FK_nota_persona` (`codigo_persona`),
  CONSTRAINT `FK_nota_categoria` FOREIGN KEY (`codigo_categoria`) REFERENCES `categoria` (`codigo`),
  CONSTRAINT `FK_nota_persona` FOREIGN KEY (`codigo_persona`) REFERENCES `persona` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- ----------------------------
-- Records of nota
-- ----------------------------

-- ----------------------------
-- Table structure for `persona`
-- ----------------------------
DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8_spanish2_ci NOT NULL,
  `sexo` enum('F','M') COLLATE utf8_spanish2_ci NOT NULL,
  `fechaNacimiento` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- ----------------------------
-- Records of persona
-- ----------------------------

-- ----------------------------
-- Table structure for `telefono`
-- ----------------------------
DROP TABLE IF EXISTS `telefono`;
CREATE TABLE `telefono` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_persona` int(11) NOT NULL,
  `numero` char(9) COLLATE utf8_spanish2_ci NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `FK_telefono_persona` (`codigo_persona`),
  CONSTRAINT `FK_telefono_persona` FOREIGN KEY (`codigo_persona`) REFERENCES `persona` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- ----------------------------
-- Records of telefono
-- ----------------------------

-- ----------------------------
-- Table structure for `usuario`
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `clave` varchar(40) COLLATE utf8_spanish2_ci NOT NULL,
  `tipo` enum('O','A') COLLATE utf8_spanish2_ci NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`codigo`),
  CONSTRAINT `FK_usuario_persona` FOREIGN KEY (`codigo`) REFERENCES `persona` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

-- ----------------------------
-- Records of usuario
-- ----------------------------
