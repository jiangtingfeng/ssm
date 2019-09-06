/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50018
Source Host           : localhost:3306
Source Database       : keshe

Target Server Type    : MYSQL
Target Server Version : 50018
File Encoding         : 65001

Date: 2019-09-06 17:02:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL auto_increment,
  `categoryName` varchar(255) character set gbk default NULL,
  `categoryPic` varchar(255) character set gbk default NULL,
  `updateUser` varchar(255) character set gbk default NULL,
  `updateDate` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '洗衣机', 'V6ZCh6IEv2.jpg', 'admin', '2019-09-05 19:45:26');
INSERT INTO `category` VALUES ('2', '马桶', 'nY8JXApVBP.jpg', 'admin', '2019-09-05 19:45:54');
INSERT INTO `category` VALUES ('3', '上衣', 'kNaogrzxRT.jpg', 'admin', '2019-09-05 19:46:10');
INSERT INTO `category` VALUES ('4', '鞋子', 'R9QQkMEgoY.jpg', 'admin', '2019-09-05 19:46:33');
INSERT INTO `category` VALUES ('5', '沙发', '7orpb6bOYz.jpg', 'admin', '2019-09-06 16:58:49');

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(32) NOT NULL auto_increment,
  `message` varchar(255) character set utf8 default NULL,
  `userName` varchar(255) character set utf8 default NULL,
  `updateDate` datetime default NULL,
  `pid` int(32) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=sjis;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES ('1', 'asdas', 'sd', '2019-09-05 10:30:30', '1');
INSERT INTO `comment` VALUES ('2', 'asdas', 'sd', '2019-09-05 10:30:30', '1');
INSERT INTO `comment` VALUES ('3', 'sfs', '123', '2019-09-06 16:44:41', '2');
INSERT INTO `comment` VALUES ('4', 'fsdfsdfgs ', '123', '2019-09-06 16:46:34', '1');

-- ----------------------------
-- Table structure for count
-- ----------------------------
DROP TABLE IF EXISTS `count`;
CREATE TABLE `count` (
  `id` int(32) NOT NULL auto_increment,
  `pid` int(32) default NULL,
  `number` int(32) NOT NULL,
  `oid` int(32) NOT NULL,
  `createTime` datetime default NULL,
  `uid` int(11) default NULL,
  `status` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of count
-- ----------------------------
INSERT INTO `count` VALUES ('17', '2', '1', '7', '2019-09-06 15:22:41', '2', '3');
INSERT INTO `count` VALUES ('18', '1', '1', '7', '2019-09-06 15:59:28', '2', '3');
INSERT INTO `count` VALUES ('25', '1', '1', '13', '2019-09-06 16:45:46', '3', '2');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(32) NOT NULL auto_increment,
  `productName` varchar(255) character set gbk default NULL,
  `productTitle` varchar(255) character set gbk default NULL,
  `price` float(10,2) default NULL,
  `lowerPrice` float(10,2) default NULL,
  `number` int(32) default NULL,
  `cid` int(32) default NULL,
  `updateUser` varchar(255) character set gbk default NULL,
  `updateDate` datetime default NULL,
  `productPic` varchar(255) character set gbk default NULL,
  `categoryName` varchar(255) character set gbk default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', '李宁', '飞一样的力量', '99.98', '19.98', '85', '4', 'admin', '2019-09-05 19:48:52', 'th6tnDZ5wv.jpg', '鞋子');
INSERT INTO `product` VALUES ('2', 'nike', '就是好', '99.98', '19.98', '62', '4', 'admin', '2019-09-05 19:49:54', 'XvwZSt4GfJ.jpg', '鞋子');

-- ----------------------------
-- Table structure for productpic
-- ----------------------------
DROP TABLE IF EXISTS `productpic`;
CREATE TABLE `productpic` (
  `id` int(32) NOT NULL auto_increment,
  `productPic` varchar(255) character set gbk default NULL,
  `pid` int(32) default NULL,
  `updateTime` datetime default NULL,
  `updateUser` varchar(255) character set gbk default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of productpic
-- ----------------------------

-- ----------------------------
-- Table structure for property
-- ----------------------------
DROP TABLE IF EXISTS `property`;
CREATE TABLE `property` (
  `id` int(32) NOT NULL auto_increment,
  `propertyName` varchar(255) character set gbk default NULL,
  `cid` int(32) default NULL,
  `updateUser` varchar(255) character set gbk default NULL,
  `updateDate` datetime default NULL,
  `categoryName` varchar(255) character set gbk default NULL,
  `propertyValue` varchar(255) character set gbk default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of property
-- ----------------------------
INSERT INTO `property` VALUES ('1', '大小', '4', 'admin', '2019-09-05 19:46:44', '鞋子', null);
INSERT INTO `property` VALUES ('2', '尺寸', '4', 'admin', '2019-09-05 19:46:56', '鞋子', null);
INSERT INTO `property` VALUES ('3', '品牌', '4', 'admin', '2019-09-05 19:47:05', '鞋子', null);
INSERT INTO `property` VALUES ('4', '颜色', '3', 'admin', '2019-09-05 19:47:24', '上衣', null);
INSERT INTO `property` VALUES ('5', '风格', '3', 'admin', '2019-09-05 19:47:47', '上衣', null);
INSERT INTO `property` VALUES ('6', '水量', '2', 'admin', '2019-09-05 19:48:17', '马桶', null);
INSERT INTO `property` VALUES ('7', '价格', '1', 'admin', '2019-09-05 19:48:25', '洗衣机', null);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) default NULL,
  `password` varchar(32) default NULL,
  `phoneNumber` varchar(255) default NULL COMMENT '手机号码',
  `createTime` datetime default NULL COMMENT '创建时间',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '123456', '18720356426', '2019-09-05 19:42:36');
INSERT INTO `user` VALUES ('2', '123456', '123456', '18720356423', '2019-09-06 11:55:00');
INSERT INTO `user` VALUES ('3', '123', '123456', '18720356420', '2019-09-06 16:00:15');

-- ----------------------------
-- Table structure for userorder
-- ----------------------------
DROP TABLE IF EXISTS `userorder`;
CREATE TABLE `userorder` (
  `id` int(32) NOT NULL auto_increment,
  `status` int(2) default NULL,
  `totalMoney` float(255,2) default NULL,
  `productNumber` int(32) default NULL,
  `buyerName` varchar(255) character set gbk default NULL,
  `setTime` datetime default NULL,
  `payTime` datetime default NULL,
  `sendTime` datetime default NULL,
  `confirmTime` datetime default NULL,
  `address` varchar(255) character set gbk default NULL,
  `post` int(32) default NULL,
  `mobile` varchar(255) default NULL,
  `userMessage` varchar(255) character set gbk default NULL,
  `uid` int(32) default NULL,
  `receiver` varchar(255) character set gbk default NULL,
  `orderNumber` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userorder
-- ----------------------------
INSERT INTO `userorder` VALUES ('7', '3', '39.96', '2', '123456', '2019-09-06 15:22:41', '2019-09-06 15:59:32', '2019-09-06 15:59:38', '2019-09-06 15:57:21', '', null, '', '', '2', '123456', '207266c499e74346');
INSERT INTO `userorder` VALUES ('13', '5', '19.98', '1', '123', '2019-09-06 16:45:46', '2019-09-06 16:45:49', '2019-09-06 16:46:20', '2019-09-06 16:46:31', '', null, '', '', '3', '123', '0bfb7ea1da184148');
