/*
 Navicat Premium Data Transfer

 Source Server         : root
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : epmw

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 21/06/2020 11:19:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`
(
    `name`     varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`
(
    `id`          int(0)                                                  NOT NULL AUTO_INCREMENT,
    `name`        varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `price`       float(10, 2)                                            NOT NULL,
    `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `image`       varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'default.jpg',
    `state`       int(0)                                                  NOT NULL DEFAULT 0 COMMENT '是否上架 0否 1是 默认0',
    PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB
  AUTO_INCREMENT = 41
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for order_datail
-- ----------------------------
DROP TABLE IF EXISTS `order_datail`;
CREATE TABLE `order_datail`
(
    `orderId` int(0) NOT NULL,
    `goodsId` int(0) NOT NULL,
    `count`   int(0) NOT NULL,
    INDEX `fk1` (`orderId`) USING BTREE,
    INDEX `fk2` (`goodsId`) USING BTREE,
    CONSTRAINT `fk1` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CONSTRAINT `fk2` FOREIGN KEY (`goodsId`) REFERENCES `goods` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`
(
    `id`       int(0)                                                  NOT NULL AUTO_INCREMENT,
    `time`     timestamp(0)                                            NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `price`    float                                                   NOT NULL,
    `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `state`    int(0)                                                  NOT NULL DEFAULT 0,
    `phone`    varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `address`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `name`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL,
    PRIMARY KEY (`id`) USING BTREE,
    INDEX `orders_user_username_fk` (`username`) USING BTREE,
    CONSTRAINT `orders_user_username_fk` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB
  AUTO_INCREMENT = 15
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`
(
    `username`    varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `name`        varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL,
    `password`    varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci  NOT NULL,
    `address`     varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
    `phoneNumber` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci  NULL DEFAULT NULL,
    PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
