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

 Date: 11/09/2023 15:45:57
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for emp
-- ----------------------------
DROP TABLE IF EXISTS `emp`;
CREATE TABLE `emp`  (
  `id` int NULL DEFAULT NULL COMMENT '编号',
  `workno` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '工作编号',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `gender` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '性别',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `idcard` int NULL DEFAULT NULL,
  `workaddress` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `entrydate` date NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '雇员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of emp
-- ----------------------------
INSERT INTO `emp` VALUES (1, '00001', '刘岩', '女', 20, 1234567890, '北京', '2023-09-10');
INSERT INTO `emp` VALUES (2, '00002', '张无忌', '男', 18, 1234567891, '天津', '2023-09-22');
INSERT INTO `emp` VALUES (3, '00003', '韦一笑', '男', 38, 1234567892, '上海', '2023-09-11');
INSERT INTO `emp` VALUES (4, '00004', '赵敏', '女', 17, 1234567893, '北京', '2023-09-11');
INSERT INTO `emp` VALUES (5, '00005', '小昭', '女', 16, 1234567894, '北京', '2023-09-11');
INSERT INTO `emp` VALUES (6, '00006', '范瑶', '男', 40, 1234567895, '重庆', '2023-09-01');
INSERT INTO `emp` VALUES (7, '00007', '黛绮丝', '男', 38, NULL, '广州', '2023-09-21');
INSERT INTO `emp` VALUES (8, '00008', '范亮', '女', 45, NULL, '上海', '2023-09-11');
INSERT INTO `emp` VALUES (9, '00009', '范兵兵', '男', 53, NULL, '重庆', '2023-09-11');
INSERT INTO `emp` VALUES (10, '00010', '陈友谅', '男', 55, NULL, '苏州', '2023-09-11');
INSERT INTO `emp` VALUES (11, '00011', '张士诚', '男', 32, NULL, '杭州', '2023-09-11');
INSERT INTO `emp` VALUES (12, '00012', '常遇春', '男', 88, NULL, '北京', '2023-09-11');
INSERT INTO `emp` VALUES (13, '00013', '孙静', '女', 65, NULL, '西安', '2023-09-11');
INSERT INTO `emp` VALUES (14, '00014', '胡青牛', '男', 70, NULL, '天津', '2023-09-11');
INSERT INTO `emp` VALUES (15, '00015', '周芷若', '男', 27, NULL, '上海', '2023-08-30');
INSERT INTO `emp` VALUES (16, '00016', '胡浩', '女', 64, NULL, '西安', '2023-09-11');
INSERT INTO `emp` VALUES (17, '00017', '胡图图', '男', 33, 1234567907, '重庆', '2023-09-14');
INSERT INTO `emp` VALUES (18, '00018', '宋泽强', '男', 53, 1234567908, '无锡', '2023-09-11');
INSERT INTO `emp` VALUES (19, '00019', '樊斌', '女', 5, 1234567909, '南京', '2023-09-11');
INSERT INTO `emp` VALUES (20, '00020', '刘东升', '女', 19, 1234567910, '南京', '2023-09-11');

SET FOREIGN_KEY_CHECKS = 1;
