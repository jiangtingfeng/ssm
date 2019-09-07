/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50018
Source Host           : localhost:3306
Source Database       : keshe

Target Server Type    : MYSQL
Target Server Version : 50018
File Encoding         : 65001

Date: 2019-09-07 08:50:49
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
