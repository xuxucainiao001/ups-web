/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.6.22 : Database - ups_account_web
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ups_account_web` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ups_account_web`;

/*Table structure for table `uaw_t_link` */

DROP TABLE IF EXISTS `uaw_t_link`;

CREATE TABLE `uaw_t_link` (
  `linkId` bigint(20) NOT NULL AUTO_INCREMENT,
  `linkName` varchar(20) DEFAULT '' COMMENT '链接名称',
  `linkCode` varchar(25) DEFAULT NULL COMMENT '链接编码',
  `linkUrl` varchar(150) DEFAULT '' COMMENT '请求链接地址',
  `linkType` char(2) DEFAULT '' COMMENT '链接类型 01：菜单 02：选项卡 03：按钮',
  `menuName` varchar(20) NOT NULL DEFAULT '' COMMENT '菜单名称(紧对菜单对象生效)',
  `menuLevel` int(11) DEFAULT NULL COMMENT '菜单级别(紧对菜单对象生效)',
  `parentMenu` varchar(25) DEFAULT NULL COMMENT '父类菜单编码(紧对菜单对象生效)',
  `menuOrder` bigint(20) DEFAULT '0' COMMENT '菜单顺序(紧对菜单对象生效)',
  `menuActive` tinyint(1) DEFAULT '0' COMMENT '菜单是否生效(紧对菜单对象生效)',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `createUser` varchar(25) DEFAULT '' COMMENT '创建用户',
  `updateUser` varchar(25) DEFAULT '' COMMENT '更新用户',
  PRIMARY KEY (`linkId`),
  UNIQUE KEY `linkCode` (`linkCode`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='请求链接表(包含菜单和按钮)';

/*Data for the table `uaw_t_link` */

insert  into `uaw_t_link`(`linkId`,`linkName`,`linkCode`,`linkUrl`,`linkType`,`menuName`,`menuLevel`,`parentMenu`,`menuOrder`,`menuActive`,`createTime`,`updateTime`,`createUser`,`updateUser`) values (1,'系统对账','M001','','01','系统对账',1,NULL,1,1,'2019-02-26 14:49:59','2019-02-26 14:49:59','system','system'),(2,'系统对账汇总','T001','/ups-web/proofreadSum','02','系统对账汇总',2,'M001',1,1,'2019-02-26 14:49:59','2019-02-26 14:49:59','system','system'),(3,'对账异常明细','T002','/ups-web/proofreadError','02','对账异常明细',2,'M001',2,1,'2019-02-26 14:49:59','2019-02-26 14:49:59','system','system'),(4,'对账文件下载','T003','/ups-web/proofreadResult','02','对账文件下载',2,'M001',3,1,'2019-02-26 14:49:59','2019-02-26 14:49:59','system','system'),(5,'归档对账明细','T004','/ups-web/proofreadSuccess','02','归档对账明细',2,'M001',4,1,'2019-02-26 14:50:48','2019-02-26 14:50:48','system','system'),(6,'产品管理','M002','','01','产品管理',1,NULL,2,1,'2019-03-04 17:16:06','2019-03-04 17:16:08','system','system'),(7,'银行管理','T005','/ups-web/productConfig/showBank','02','银行管理',2,'M002',1,1,'2019-03-04 17:16:06','2019-03-04 17:16:06','system','system'),(8,'商户管理','T006','/ups-web/productConfig/showMerchant','02','商户管理',2,'M002',2,1,'2019-03-04 17:16:06','2019-03-04 17:16:06','system','system'),(9,'路由管理','M003','','01','路由管理',1,NULL,3,1,'2019-03-15 11:10:23','2019-03-15 11:10:26','system','system'),(10,'商户路由配置','T007','/ups-web/routeConfig/showMerchant','02','商户路由配置',2,'M003',1,1,'2019-03-15 11:10:23','2019-03-15 11:10:23','system','system'),(11,'路由渠道配置','T008','/ups-web/routeConfig/showPayChannel','02','路由渠道配置',2,'M003',2,1,'2019-03-18 10:54:24','2019-03-18 10:54:26','system','system'),(12,'订单管理','M004','','01','订单管理',1,NULL,4,1,'2019-03-18 10:54:24','2019-03-18 10:54:24','system','system'),(13,'支付管理','T009','/ups-web/order/showOrder','02','支付管理',2,'M004',1,1,'2019-03-18 10:54:24','2019-03-18 10:54:24','system','system'),(14,'签约管理','T010','/ups-web/order/showSign','02','签约管理',2,'M004',2,1,'2019-03-18 10:54:24','2019-03-18 10:54:24','system','system'),(15,'代扣类型管理','T011','/ups-web/collect/showCollectChoose','02','代扣类型管理',2,'M002',3,1,'2019-04-09 20:03:30','2019-04-09 20:03:30','system','system');

/*Table structure for table `uaw_t_role` */

DROP TABLE IF EXISTS `uaw_t_role`;

CREATE TABLE `uaw_t_role` (
  `roleId` bigint(20) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(20) DEFAULT '' COMMENT '角色名称',
  `roleCode` varchar(25) DEFAULT NULL COMMENT '角色编码',
  `roleActive` tinyint(1) DEFAULT '0' COMMENT '是否生效',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `createUser` varchar(25) DEFAULT '' COMMENT '创建用户',
  `updateUser` varchar(25) DEFAULT '' COMMENT '更新用户',
  PRIMARY KEY (`roleId`),
  UNIQUE KEY `roleCode` (`roleCode`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色表';

/*Data for the table `uaw_t_role` */

insert  into `uaw_t_role`(`roleId`,`roleName`,`roleCode`,`roleActive`,`createTime`,`updateTime`,`createUser`,`updateUser`) values (1,'对账人员','R001',1,'2019-02-26 14:49:59','2019-02-26 14:49:59','system','system'),(2,'后台管理人员','R002',1,'2019-02-26 14:49:59','2019-02-26 14:49:59','system','system');

/*Table structure for table `uaw_t_role_menu_ref` */

DROP TABLE IF EXISTS `uaw_t_role_menu_ref`;

CREATE TABLE `uaw_t_role_menu_ref` (
  `uaw_t_role_menu_ref_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `roleCode` varchar(25) NOT NULL COMMENT '角色编码',
  `menuCode` varchar(25) NOT NULL COMMENT '菜单编码',
  PRIMARY KEY (`uaw_t_role_menu_ref_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='角色对应菜单表';

/*Data for the table `uaw_t_role_menu_ref` */

insert  into `uaw_t_role_menu_ref`(`uaw_t_role_menu_ref_id`,`roleCode`,`menuCode`) values (1,'R001','M001'),(2,'R001','T001'),(3,'R001','T002'),(4,'R001','T003'),(5,'R001','T004'),(6,'R002','M002'),(7,'R002','T005'),(8,'R002','T006'),(9,'R002','M003'),(10,'R002','T007'),(11,'R002','T008'),(12,'R002','M004'),(13,'R002','T009'),(14,'R002','T010'),(15,'R002','T011');

/*Table structure for table `uaw_t_user` */

DROP TABLE IF EXISTS `uaw_t_user`;

CREATE TABLE `uaw_t_user` (
  `userId` bigint(20) NOT NULL AUTO_INCREMENT,
  `userName` varchar(25) DEFAULT NULL COMMENT '用户账户名',
  `userPassword` varchar(25) NOT NULL COMMENT '用户账户密码',
  `userCode` varchar(25) NOT NULL COMMENT '用户编码',
  `description` varchar(50) DEFAULT '' COMMENT '用户描述',
  `createTime` datetime DEFAULT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  `createUser` varchar(25) DEFAULT '' COMMENT '创建用户',
  `updateUser` varchar(25) DEFAULT '' COMMENT '更新用户',
  PRIMARY KEY (`userId`),
  UNIQUE KEY `userName` (`userName`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='用户表';

/*Data for the table `uaw_t_user` */

insert  into `uaw_t_user`(`userId`,`userName`,`userPassword`,`userCode`,`description`,`createTime`,`updateTime`,`createUser`,`updateUser`) values (1,'pgy1','123456','P001','普通','2019-02-26 14:49:59','2019-02-26 14:49:59','',''),(2,'pgy2','123456','P002','普通','2019-02-26 14:49:59','2019-02-26 14:49:59','',''),(3,'pgy3','123456','P003','普通','2019-02-26 14:49:59','2019-02-26 14:49:59','',''),(4,'pgy4','654321','P004','普通','2019-03-04 17:11:43','2019-03-04 17:11:45','System','System'),(5,'pgy5','654321','P004','普通','2019-03-04 17:11:43','2019-03-04 17:11:45','','');

/*Table structure for table `uaw_t_user_blackname` */

DROP TABLE IF EXISTS `uaw_t_user_blackname`;

CREATE TABLE `uaw_t_user_blackname` (
  `user_blackName_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userCode` varchar(25) NOT NULL COMMENT '用户编码',
  `linkCode` varchar(25) NOT NULL COMMENT '链接编码',
  PRIMARY KEY (`user_blackName_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户访问地址黑名单';

/*Data for the table `uaw_t_user_blackname` */

/*Table structure for table `uaw_t_user_role_ref` */

DROP TABLE IF EXISTS `uaw_t_user_role_ref`;

CREATE TABLE `uaw_t_user_role_ref` (
  `user_role_ref_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `userCode` varchar(25) NOT NULL COMMENT '用户编码',
  `roleCode` varchar(25) NOT NULL COMMENT '角色编码',
  PRIMARY KEY (`user_role_ref_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='用户对应角色表';

/*Data for the table `uaw_t_user_role_ref` */

insert  into `uaw_t_user_role_ref`(`user_role_ref_id`,`userCode`,`roleCode`) values (1,'P001','R001'),(2,'P002','R001'),(3,'P003','R001'),(4,'P004','R002');

/*Table structure for table `ups_t_merchant_order_type` */

DROP TABLE IF EXISTS `ups_t_merchant_order_type`;

CREATE TABLE `ups_t_merchant_order_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_id` bigint(20) NOT NULL COMMENT '来源商户id',
  `order_type_id` bigint(20) NOT NULL COMMENT '支付类型id',
  `default_pay_channel` varchar(50) DEFAULT NULL COMMENT '默认支付渠道',
  `route_status` char(1) DEFAULT '0' COMMENT '0:开启默认 1：开启路由',
  `start_time` datetime DEFAULT NULL COMMENT '生效起示时间',
  `end_time` datetime DEFAULT NULL COMMENT '生效结束时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人员',
  PRIMARY KEY (`id`),
  UNIQUE KEY `merchant_id_2` (`merchant_id`,`order_type_id`),
  KEY `merchant_id` (`merchant_id`),
  KEY `order_type_id` (`order_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商户支付产品配置表';

/*Data for the table `ups_t_merchant_order_type` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
