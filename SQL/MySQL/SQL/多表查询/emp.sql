/*
 Navicat Premium Data Transfer

 Source Server         : Mydb
 Source Server Type    : MySQL
 Source Server Version : 80031
 Source Host           : localhost:3306
 Source Schema         : sql_test

 Target Server Type    : MySQL
 Target Server Version : 80031
 File Encoding         : 65001

 Date: 13/09/2023 18:05:22
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for emp
-- ----------------------------
DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `age` int NULL DEFAULT NULL,
  `dept_id` int NULL DEFAULT NULL,
  `managerid` int NULL DEFAULT NULL,
  `salary` decimal(10, 2) NULL DEFAULT NULL,
  `job` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dept_id`(`dept_id` ASC) USING BTREE,
  CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `dept` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emp
-- ----------------------------
INSERT INTO `emp` VALUES (1, '张无忌', 20, 1, 3, 2000.00, '经理');
INSERT INTO `emp` VALUES (2, '杨逍', 33, 1, 3, 9233.00, '经理');
INSERT INTO `emp` VALUES (3, '赵敏', 18, 2, 5, 3222.00, '销售');
INSERT INTO `emp` VALUES (4, '常遇春', 43, 2, NULL, 500.00, '销售');
INSERT INTO `emp` VALUES (5, '小昭', 23, NULL, 2, 8023.00, NULL);
INSERT INTO `emp` VALUES (6, '李毅', 25, 1, 3, 2000.00, '职员');
INSERT INTO `emp` VALUES (7, '鹿杖客', 33, 1, 2, 2000.00, '职员');
INSERT INTO `emp` VALUES (8, '宋远桥', 22, 2, 1, 500.00, '销售');

SET FOREIGN_KEY_CHECKS = 1;
