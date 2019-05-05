/*
SQLyog Ultimate v12.08 (64 bit)
MySQL - 5.6.22 : Database - ups_pay
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ups_pay` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ups_pay`;

/*Table structure for table `ups_t_balance` */

DROP TABLE IF EXISTS `ups_t_balance`;

CREATE TABLE `ups_t_balance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `balance` decimal(19,2) DEFAULT NULL COMMENT '余额',
  `tpp_mer_no` varchar(64) DEFAULT '',
  `status` tinyint(4) DEFAULT '0' COMMENT '余额状态',
  `remake` varchar(32) DEFAULT NULL,
  `pay_channel` varchar(32) DEFAULT NULL,
  `create_user` varchar(32) DEFAULT NULL,
  `update_user` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='余额表';

/*Data for the table `ups_t_balance` */

/*Table structure for table `ups_t_balance_config` */

DROP TABLE IF EXISTS `ups_t_balance_config`;

CREATE TABLE `ups_t_balance_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_user` varchar(20) DEFAULT '',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `update_user` varchar(20) DEFAULT '',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `tpp_mer_no` varchar(64) DEFAULT NULL COMMENT '商户号',
  `from_system` varchar(32) DEFAULT NULL COMMENT '渠道编号',
  `pay_channel` varchar(32) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商户配置表';

/*Data for the table `ups_t_balance_config` */

/*Table structure for table `ups_t_balance_sms_config` */

DROP TABLE IF EXISTS `ups_t_balance_sms_config`;

CREATE TABLE `ups_t_balance_sms_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_user` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `threshold_money` decimal(19,2) DEFAULT '0.00' COMMENT '阀值的金额',
  `tpp_mer_no` varchar(32) DEFAULT NULL COMMENT '需要检验的商户号',
  `number` int(11) DEFAULT NULL COMMENT '发送次数',
  `remakes` varchar(255) DEFAULT NULL COMMENT '备注',
  `update_user` varchar(20) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0',
  `msg_threshold_context` varchar(255) DEFAULT '' COMMENT '短信内容',
  `msg_default_context` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='余额发送短信表';

/*Data for the table `ups_t_balance_sms_config` */

/*Table structure for table `ups_t_balance_sms_record` */

DROP TABLE IF EXISTS `ups_t_balance_sms_record`;

CREATE TABLE `ups_t_balance_sms_record` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `is_delete` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除状态，1：删除，0：有效',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `send_account` varchar(32) NOT NULL COMMENT '发送手机号',
  `result_code` varchar(6) NOT NULL COMMENT '返回code',
  `msg_context` varchar(255) NOT NULL COMMENT '发送的内容',
  `msg_id` varchar(64) NOT NULL COMMENT '发送的id',
  `errorMsg` varchar(255) NOT NULL COMMENT '错误的说明',
  `tpp_mer_no` varchar(64) NOT NULL,
  `create_user` varchar(63) DEFAULT NULL,
  `update_user` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='短信记录';

/*Data for the table `ups_t_balance_sms_record` */

/*Table structure for table `ups_t_balance_transfer_config` */

DROP TABLE IF EXISTS `ups_t_balance_transfer_config`;

CREATE TABLE `ups_t_balance_transfer_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_user` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `is_delete` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `threshold_money` decimal(19,2) DEFAULT '0.00' COMMENT '转账的阀值',
  `pay_member_id` varchar(64) DEFAULT NULL COMMENT '代付商户号',
  `receipt_member_id` varchar(64) DEFAULT NULL COMMENT '代收商户号',
  `remakes` varchar(255) DEFAULT NULL COMMENT '备注',
  `update_user` bigint(20) DEFAULT NULL,
  `pay_channel` varchar(32) DEFAULT '',
  `status` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='转账表';

/*Data for the table `ups_t_balance_transfer_config` */

/*Table structure for table `ups_t_balance_transfer_record` */

DROP TABLE IF EXISTS `ups_t_balance_transfer_record`;

CREATE TABLE `ups_t_balance_transfer_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `is_delete` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `to_member_id` varchar(64) DEFAULT NULL COMMENT '收款人商户号',
  `transfer_money` decimal(19,2) DEFAULT NULL COMMENT '转账金额',
  `status` varchar(32) DEFAULT NULL COMMENT '回调状态',
  `error_reason` varchar(255) DEFAULT NULL COMMENT '失败原因',
  `trans_no` varchar(32) DEFAULT NULL COMMENT '商户订单号',
  `trans_orderid` varchar(32) DEFAULT NULL COMMENT '宝付订单号',
  `rans_batchid` varchar(32) DEFAULT NULL COMMENT '宝付流水号',
  `return_code` varchar(32) DEFAULT NULL,
  `member_id` varchar(32) DEFAULT NULL,
  `pay_channel` varchar(32) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='转账记录表';

/*Data for the table `ups_t_balance_transfer_record` */

/*Table structure for table `ups_t_balance_user_group` */

DROP TABLE IF EXISTS `ups_t_balance_user_group`;

CREATE TABLE `ups_t_balance_user_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `is_delete` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  `user_name` varchar(255) DEFAULT NULL COMMENT '姓名',
  `group_code` varchar(32) DEFAULT NULL COMMENT '用户组code',
  `tpp_mer_no` varchar(32) DEFAULT NULL,
  `remakes` varchar(255) DEFAULT NULL COMMENT '备注',
  `user_phone` varchar(32) DEFAULT NULL COMMENT '用户手机号',
  `create_user` varchar(64) DEFAULT '',
  `update_user` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='余额预警用户组表';

/*Data for the table `ups_t_balance_user_group` */

/*Table structure for table `ups_t_bank` */

DROP TABLE IF EXISTS `ups_t_bank`;

CREATE TABLE `ups_t_bank` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bank_name` varchar(50) DEFAULT '' COMMENT '支付银行名称',
  `bank_code` varchar(20) DEFAULT '' COMMENT '支付银行编码',
  `logo_url` varchar(128) DEFAULT NULL COMMENT 'Logo存储地址',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user` varchar(50) DEFAULT '',
  `update_user` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='支付银行表';

/*Data for the table `ups_t_bank` */

insert  into `ups_t_bank`(`id`,`bank_name`,`bank_code`,`logo_url`,`create_time`,`update_time`,`create_user`,`update_user`) values (1,'工商银行','ICBC',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(2,'中国银行','BOC',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(3,'建设银行','CCB',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(4,'农业银行','ABC',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(5,'交通银行','BCOM',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(6,'招商银行','CMB',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(7,'平安银行','PAB',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(8,'兴业银行','CIB',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(9,'上海浦东发展银行','SPDB',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(10,'中信银行','CITIC',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(11,'光大银行','CEB',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(12,'邮政储蓄','PSBC',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(13,'上海银行','SHB',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(14,'广发银行','GDB',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system'),(15,'民生银行','CMBC',NULL,'2019-01-10 11:33:49','2019-01-10 11:33:49','system','system');

/*Table structure for table `ups_t_channel_query_log` */

DROP TABLE IF EXISTS `ups_t_channel_query_log`;

CREATE TABLE `ups_t_channel_query_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT 'ups订单号',
  `business_flow_num` varchar(50) DEFAULT NULL COMMENT '业务流水号',
  `send_param` text COMMENT '发送给第三方参数报文',
  `return_param` text COMMENT '第三方返回参数报文',
  `create_time` datetime DEFAULT NULL COMMENT '日志创建时间',
  `error` tinyint(1) DEFAULT '0' COMMENT '是否发生异常 1.是  0.否',
  `error_message` varchar(50) DEFAULT '' COMMENT '异常原因',
  PRIMARY KEY (`id`),
  UNIQUE KEY `business_flow_num` (`business_flow_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ups请求渠道支付结果日志表';

/*Data for the table `ups_t_channel_query_log` */

/*Table structure for table `ups_t_collect_choose` */

DROP TABLE IF EXISTS `ups_t_collect_choose`;

CREATE TABLE `ups_t_collect_choose` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `merchant_code` varchar(80) NOT NULL COMMENT '商户编码',
  `collect_type` varchar(50) NOT NULL COMMENT 'Collect:普通代扣 ProtocolCollect:协议代扣',
  `active` tinyint(1) DEFAULT '1' COMMENT '是否激活',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user` varchar(50) DEFAULT '' COMMENT '创建时间',
  `update_user` varchar(50) DEFAULT '' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='商户代扣类型配置表';

/*Data for the table `ups_t_collect_choose` */

insert  into `ups_t_collect_choose`(`id`,`merchant_code`,`collect_type`,`active`,`create_time`,`update_time`,`create_user`,`update_user`) values (1,'10001','Collect',1,'2019-01-18 10:54:52','2019-04-09 22:18:23','system','pgy4'),(4,'10002','Collect',1,'2019-04-09 22:02:55','2019-04-09 22:18:20','pgy4','pgy4');

/*Table structure for table `ups_t_log` */

DROP TABLE IF EXISTS `ups_t_log`;

CREATE TABLE `ups_t_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_system` varchar(25) NOT NULL COMMENT '请求系统来源 美期 Meiqi 米融 Mirong 秒呗 Miaobei 多呗 Duobei 迅到 XunDao',
  `request_url` varchar(150) DEFAULT '' COMMENT '请求地址',
  `business_flow_num` varchar(50) DEFAULT NULL COMMENT '业务流水号',
  `business_param` text COMMENT '业务请求参数报文',
  `return_param` text COMMENT '返回参数报文',
  `code` char(4) DEFAULT '' COMMENT '返回编码',
  `message` varchar(50) DEFAULT '' COMMENT '返回消息',
  `order_id` varchar(50) DEFAULT '' COMMENT '请求订单id',
  `create_time` datetime DEFAULT NULL COMMENT '日志创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '日志修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `form_system` (`from_system`,`business_flow_num`)
) ENGINE=InnoDB AUTO_INCREMENT=387 DEFAULT CHARSET=utf8 COMMENT='ups请求日志表';

/*Data for the table `ups_t_log` */

/*Table structure for table `ups_t_merchant_config` */

DROP TABLE IF EXISTS `ups_t_merchant_config`;

CREATE TABLE `ups_t_merchant_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_code` varchar(50) DEFAULT NULL COMMENT '来源商户编码',
  `merchant_name` varchar(50) DEFAULT NULL COMMENT '来源商户名称',
  `description` varchar(50) DEFAULT '',
  `available` tinyint(1) DEFAULT '1' COMMENT '是否可用状态',
  `merchant_public_key` text,
  `ups_private_key` text,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` varchar(50) DEFAULT NULL COMMENT '创建人员',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人员',
  PRIMARY KEY (`id`),
  UNIQUE KEY `merchant_code` (`merchant_code`),
  UNIQUE KEY `merchant_name` (`merchant_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='来源商户配置表';

/*Data for the table `ups_t_merchant_config` */

insert  into `ups_t_merchant_config`(`id`,`merchant_code`,`merchant_name`,`description`,`available`,`merchant_public_key`,`ups_private_key`,`create_time`,`update_time`,`create_user`,`update_user`) values (1,'10001','美期','美期啊',1,'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCk/3cyUDC+6Hi+yQ0Y0ueZM0zmivdCDN3MnP9W4GcXTqedrt7JZNv/RPhejiOb4kwNSSCrjFz3+fq++ZeF1W4zOjUoeUSs5kbGTK6yLh0DZrvMOBvNaZgB7MZCiQXAHf5NeLShRZQVV8lMnYXfQP0nuD/7i1+hHKAxB2fIoHwLpQIDAQAB','MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKT/dzJQML7oeL7JDRjS55kzTOaK90IM3cyc/1bgZxdOp52u3slk2/9E+F6OI5viTA1JIKuMXPf5+r75l4XVbjM6NSh5RKzmRsZMrrIuHQNmu8w4G81pmAHsxkKJBcAd/k14tKFFlBVXyUydhd9A/Se4P/uLX6EcoDEHZ8igfAulAgMBAAECgYBUyo/nxDv4r6D1cn6PhjrMiQd45mtAfzowX3H8pF92I86Rgv8sge9olHoKpYL5JectYKowXnacXNOV9s/+T/tL9iANkVFCP+kgS97pjYiJORC/5bY+jdGAZSNYXDQo4811nLLJNvrLdLkuEJi8MVumALhNKgpVnSgv+iLjTk7itQJBAN9/vhzs66MZVFFn+tIzBMzRaqcy1Jn+1HsEOsXhh2JnOxjzqV8i1EMXbT5hXPeyOaWUzSEpxLFJ0FavCseWNW8CQQC8/eMtt++XHUx8Jw/NjQqm8bV8tH3LA7DwmckxXLhuzOZwI45nvQMHS/Uko0xTKQS02FVK1DYaETDWpRq5ew4rAkEAibCSOBHBzbZSGuDbRlpGD8TIVv9auRCkaLEfYD9j/7ynTOT4KHM1n6u0EqU6+CJln1v/z/mCgtJ9tpmaI4GnowJAJaQ3pDp3WNS4EB5DkoAd+AQ6Tn0wdMfmbPVkUhWSklbzKrCaQ2Us/j4NtF9l60ZHLrHLwxyjLevwmz/FI94zgwJAV071tF4Sawv6JgwARJWfzDrK4eQmqqfebMszK0O8mkrzs0gBlepsDmeedQFJhNXMJjHofB5K20bn1zA+C8Q1XQ==','2018-12-24 18:12:00','2019-04-22 14:39:08','system','pgy4'),(2,'10003','数融','数融啊',1,'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCk/3cyUDC+6Hi+yQ0Y0ueZM0zmivdCDN3MnP9W4GcXTqedrt7JZNv/RPhejiOb4kwNSSCrjFz3+fq++ZeF1W4zOjUoeUSs5kbGTK6yLh0DZrvMOBvNaZgB7MZCiQXAHf5NeLShRZQVV8lMnYXfQP0nuD/7i1+hHKAxB2fIoHwLpQIDAQAB','MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAKT/dzJQML7oeL7JDRjS55kzTOaK90IM3cyc/1bgZxdOp52u3slk2/9E+F6OI5viTA1JIKuMXPf5+r75l4XVbjM6NSh5RKzmRsZMrrIuHQNmu8w4G81pmAHsxkKJBcAd/k14tKFFlBVXyUydhd9A/Se4P/uLX6EcoDEHZ8igfAulAgMBAAECgYBUyo/nxDv4r6D1cn6PhjrMiQd45mtAfzowX3H8pF92I86Rgv8sge9olHoKpYL5JectYKowXnacXNOV9s/+T/tL9iANkVFCP+kgS97pjYiJORC/5bY+jdGAZSNYXDQo4811nLLJNvrLdLkuEJi8MVumALhNKgpVnSgv+iLjTk7itQJBAN9/vhzs66MZVFFn+tIzBMzRaqcy1Jn+1HsEOsXhh2JnOxjzqV8i1EMXbT5hXPeyOaWUzSEpxLFJ0FavCseWNW8CQQC8/eMtt++XHUx8Jw/NjQqm8bV8tH3LA7DwmckxXLhuzOZwI45nvQMHS/Uko0xTKQS02FVK1DYaETDWpRq5ew4rAkEAibCSOBHBzbZSGuDbRlpGD8TIVv9auRCkaLEfYD9j/7ynTOT4KHM1n6u0EqU6+CJln1v/z/mCgtJ9tpmaI4GnowJAJaQ3pDp3WNS4EB5DkoAd+AQ6Tn0wdMfmbPVkUhWSklbzKrCaQ2Us/j4NtF9l60ZHLrHLwxyjLevwmz/FI94zgwJAV071tF4Sawv6JgwARJWfzDrK4eQmqqfebMszK0O8mkrzs0gBlepsDmeedQFJhNXMJjHofB5K20bn1zA+C8Q1XQ==','2019-04-22 14:36:22','2019-04-22 17:30:19','system','pgy5');

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='商户支付产品配置表';

/*Data for the table `ups_t_merchant_order_type` */

insert  into `ups_t_merchant_order_type`(`id`,`merchant_id`,`order_type_id`,`default_pay_channel`,`route_status`,`start_time`,`end_time`,`update_time`,`update_user`) values (9,2,1,'baofoo','0','2019-04-01 00:00:00','2022-01-01 00:00:00','2019-04-22 14:53:56','pgy4'),(10,2,2,'baofoo','0','2019-04-01 00:00:00','2022-01-01 00:00:00','2019-04-09 18:43:58','pgy4'),(11,1,1,'baofoo','0','2019-04-01 00:00:00','2022-01-01 00:00:00','2019-04-09 22:09:41','pgy4'),(12,1,2,'baofoo','0','2019-04-01 00:00:00','2022-01-01 00:00:00','2019-04-22 14:42:12','pgy4'),(13,1,3,'baofoo','0','2019-04-01 00:00:00','2022-01-01 00:00:00','2019-04-09 22:17:56','pgy4'),(14,2,3,'baofoo','0','2019-04-22 00:00:00','2019-04-23 00:00:00','2019-04-22 14:42:22','pgy4'),(15,2,4,'yeepay','0','2019-04-22 00:00:00','2019-04-27 00:00:00','2019-04-23 14:50:37','pgy4'),(16,1,4,'baofoo','0','2019-04-23 00:00:00','2019-05-31 00:00:00','2019-04-28 14:50:52','pgy4');

/*Table structure for table `ups_t_order_10001` */

DROP TABLE IF EXISTS `ups_t_order_10001`;

CREATE TABLE `ups_t_order_10001` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `ups_order_code` varchar(80) CHARACTER SET utf8 DEFAULT NULL COMMENT 'ups订单code',
  `merchant_code` varchar(25) CHARACTER SET utf8 NOT NULL COMMENT '商户编码',
  `order_type` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '订单类型：pay:代付  collect:代扣  signature:签约 bindCard:绑卡 transfer:转账',
  `pay_channel` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '支付渠道',
  `business_type` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '业务类型',
  `business_flow_num` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '业务流水号',
  `user_no` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '用户编码',
  `real_name` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '真实姓名',
  `real_name_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '真实姓名AES加密',
  `real_name_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '真实姓名MD5加密',
  `identity` varchar(25) CHARACTER SET utf8 NOT NULL COMMENT '身份证号码',
  `identity_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '身份证号码AES加密',
  `identity_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '身份证号码MD5加密',
  `phone_no` varchar(15) CHARACTER SET utf8 NOT NULL COMMENT '电话号码',
  `phone_no_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '电话号码AES加密',
  `phone_no_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '电话号码MD5加密',
  `bank_card` varchar(30) CHARACTER SET utf8 NOT NULL COMMENT '银行卡号',
  `bank_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '银行卡号AES加密',
  `bank_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '银行卡号MD5加密',
  `bank_code` varchar(10) CHARACTER SET utf8 NOT NULL COMMENT '银行编码',
  `amount` decimal(20,2) DEFAULT NULL COMMENT '金额',
  `order_status` varchar(25) CHARACTER SET utf8 NOT NULL COMMENT '订单状态： success：订单支付成功 new：新订单 dispose：订单受理中 error：订单请求发生异常 fail：订单支付失败',
  `notify_url` varchar(150) CHARACTER SET utf8 NOT NULL COMMENT '回调地址',
  `result_code` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '第三方渠道返回的编码',
  `result_message` varchar(150) CHARACTER SET utf8 DEFAULT '' COMMENT '第三方渠道返回的消息',
  `remark` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '订单修改时间(第三方渠道返回结果时进行修改)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `ups_order_code` (`ups_order_code`),
  UNIQUE KEY `business_flow_num` (`business_flow_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci COMMENT='ups订单表';

/*Data for the table `ups_t_order_10001` */

/*Table structure for table `ups_t_order_10002` */

DROP TABLE IF EXISTS `ups_t_order_10002`;

CREATE TABLE `ups_t_order_10002` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `ups_order_code` varchar(80) CHARACTER SET utf8 DEFAULT NULL COMMENT 'ups订单code',
  `merchant_code` varchar(25) CHARACTER SET utf8 NOT NULL COMMENT '商户编码',
  `order_type` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '订单类型：pay:代付  collect:代扣  signature:签约 bindCard:绑卡 transfer:转账',
  `pay_channel` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '支付渠道',
  `business_type` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '业务类型',
  `business_flow_num` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '业务流水号',
  `user_no` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '用户编码',
  `real_name` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '真实姓名',
  `real_name_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '真实姓名AES加密',
  `real_name_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '真实姓名MD5加密',
  `identity` varchar(25) CHARACTER SET utf8 NOT NULL COMMENT '身份证号码',
  `identity_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '身份证号码AES加密',
  `identity_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '身份证号码MD5加密',
  `phone_no` varchar(15) CHARACTER SET utf8 NOT NULL COMMENT '电话号码',
  `phone_no_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '电话号码AES加密',
  `phone_no_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '电话号码MD5加密',
  `bank_card` varchar(30) CHARACTER SET utf8 NOT NULL COMMENT '银行卡号',
  `bank_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '银行卡号AES加密',
  `bank_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '银行卡号MD5加密',
  `bank_code` varchar(10) CHARACTER SET utf8 NOT NULL COMMENT '银行编码',
  `amount` decimal(20,2) DEFAULT NULL COMMENT '金额',
  `order_status` varchar(25) CHARACTER SET utf8 NOT NULL COMMENT '订单状态： success：订单支付成功 new：新订单 dispose：订单受理中 error：订单请求发生异常 fail：订单支付失败',
  `notify_url` varchar(150) CHARACTER SET utf8 NOT NULL COMMENT '回调地址',
  `result_code` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '第三方渠道返回的编码',
  `result_message` varchar(150) CHARACTER SET utf8 DEFAULT '' COMMENT '第三方渠道返回的消息',
  `remark` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '订单修改时间(第三方渠道返回结果时进行修改)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `ups_order_code` (`ups_order_code`),
  UNIQUE KEY `business_flow_num` (`business_flow_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci COMMENT='ups订单表';

/*Data for the table `ups_t_order_10002` */

/*Table structure for table `ups_t_order_10003` */

DROP TABLE IF EXISTS `ups_t_order_10003`;

CREATE TABLE `ups_t_order_10003` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `ups_order_code` varchar(80) CHARACTER SET utf8 DEFAULT NULL COMMENT 'ups订单code',
  `merchant_code` varchar(25) CHARACTER SET utf8 NOT NULL COMMENT '商户编码',
  `order_type` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '订单类型：pay:代付  collect:代扣  signature:签约 bindCard:绑卡 transfer:转账',
  `pay_channel` varchar(20) CHARACTER SET utf8 NOT NULL COMMENT '支付渠道',
  `business_type` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '业务类型',
  `business_flow_num` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '业务流水号',
  `user_no` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '用户编码',
  `real_name` varchar(50) CHARACTER SET utf8 NOT NULL COMMENT '真实姓名',
  `real_name_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '真实姓名AES加密',
  `real_name_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '真实姓名MD5加密',
  `identity` varchar(25) CHARACTER SET utf8 NOT NULL COMMENT '身份证号码',
  `identity_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '身份证号码AES加密',
  `identity_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '身份证号码MD5加密',
  `phone_no` varchar(15) CHARACTER SET utf8 NOT NULL COMMENT '电话号码',
  `phone_no_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '电话号码AES加密',
  `phone_no_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '电话号码MD5加密',
  `bank_card` varchar(30) CHARACTER SET utf8 NOT NULL COMMENT '银行卡号',
  `bank_encrypt` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '银行卡号AES加密',
  `bank_md5` varchar(150) COLLATE utf8_german2_ci NOT NULL COMMENT '银行卡号MD5加密',
  `bank_code` varchar(10) CHARACTER SET utf8 NOT NULL COMMENT '银行编码',
  `amount` decimal(20,2) DEFAULT NULL COMMENT '金额',
  `order_status` varchar(25) CHARACTER SET utf8 NOT NULL COMMENT '订单状态： success：订单支付成功 new：新订单 dispose：订单受理中 error：订单请求发生异常 fail：订单支付失败',
  `notify_url` varchar(150) CHARACTER SET utf8 NOT NULL COMMENT '回调地址',
  `result_code` varchar(20) CHARACTER SET utf8 DEFAULT '' COMMENT '第三方渠道返回的编码',
  `result_message` varchar(150) CHARACTER SET utf8 DEFAULT '' COMMENT '第三方渠道返回的消息',
  `remark` varchar(50) CHARACTER SET utf8 DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '订单修改时间(第三方渠道返回结果时进行修改)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `ups_order_code` (`ups_order_code`),
  UNIQUE KEY `business_flow_num` (`business_flow_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_german2_ci COMMENT='ups订单表';

/*Data for the table `ups_t_order_10003` */

/*Table structure for table `ups_t_order_push_10001` */

DROP TABLE IF EXISTS `ups_t_order_push_10001`;

CREATE TABLE `ups_t_order_push_10001` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `pay_channel` varchar(20) NOT NULL COMMENT '支付渠道',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `order_code` varchar(80) NOT NULL COMMENT '订单编码',
  `order_type` varchar(20) NOT NULL COMMENT '订单类型：pay:代付  collect:代扣  signature:签约 bindCard:绑卡 transfer:转账',
  `merchant_code` varchar(50) NOT NULL COMMENT '商户编码',
  `order_create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `order_status` varchar(15) NOT NULL COMMENT '订单状态： success：订单支付成功 new：新订单 dispose：订单受理中 error：订单请求发生异常 受理失败 fail：订单支付失败',
  `channel_result_code` varchar(16) DEFAULT NULL COMMENT '支付渠道响应编码，对应订单状态最新的',
  `channel_result_msg` varchar(250) DEFAULT NULL COMMENT '支付渠道响应消息，对应订单状态最新的',
  `notify_url` varchar(150) NOT NULL COMMENT '商户回调地址',
  `push_status` char(1) NOT NULL DEFAULT '0' COMMENT '推送状态：0：待查询，1：待推送，2：推送中 3.完成推送',
  `push_count` int(11) DEFAULT '0' COMMENT '推送次数',
  `query_count` int(11) DEFAULT '0' COMMENT '查询次数',
  `next_query_time` datetime DEFAULT NULL COMMENT '下次查询时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `requery` tinyint(1) DEFAULT '0' COMMENT '重新查询',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `pay_channel` (`pay_channel`,`order_type`),
  KEY `create_time` (`create_time`),
  KEY `push_status` (`push_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单推送信息';

/*Data for the table `ups_t_order_push_10001` */

/*Table structure for table `ups_t_order_push_10002` */

DROP TABLE IF EXISTS `ups_t_order_push_10002`;

CREATE TABLE `ups_t_order_push_10002` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `pay_channel` varchar(20) NOT NULL COMMENT '支付渠道',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `order_code` varchar(80) NOT NULL COMMENT '订单编码',
  `order_type` varchar(20) NOT NULL COMMENT '订单类型：pay:代付  collect:代扣  signature:签约 bindCard:绑卡 transfer:转账',
  `merchant_code` varchar(50) NOT NULL COMMENT '商户编码',
  `order_create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `order_status` varchar(15) NOT NULL COMMENT '订单状态： success：订单支付成功 new：新订单 dispose：订单受理中 error：订单请求发生异常 受理失败 fail：订单支付失败',
  `channel_result_code` varchar(16) DEFAULT NULL COMMENT '支付渠道响应编码，对应订单状态最新的',
  `channel_result_msg` varchar(250) DEFAULT NULL COMMENT '支付渠道响应消息，对应订单状态最新的',
  `notify_url` varchar(150) NOT NULL COMMENT '商户回调地址',
  `push_status` char(1) NOT NULL DEFAULT '0' COMMENT '推送状态：0：待查询，1：待推送，2：推送中 3.完成推送',
  `push_count` int(11) DEFAULT '0' COMMENT '推送次数',
  `query_count` int(11) DEFAULT '0' COMMENT '查询次数',
  `next_query_time` datetime DEFAULT NULL COMMENT '下次查询时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `requery` tinyint(1) DEFAULT '0' COMMENT '重新查询',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `pay_channel` (`pay_channel`,`order_type`),
  KEY `create_time` (`create_time`),
  KEY `push_status` (`push_status`),
  KEY `next_query_time` (`next_query_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单推送信息';

/*Data for the table `ups_t_order_push_10002` */

/*Table structure for table `ups_t_order_push_10003` */

DROP TABLE IF EXISTS `ups_t_order_push_10003`;

CREATE TABLE `ups_t_order_push_10003` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `pay_channel` varchar(20) NOT NULL COMMENT '支付渠道',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `order_code` varchar(80) NOT NULL COMMENT '订单编码',
  `order_type` varchar(20) NOT NULL COMMENT '订单类型：pay:代付  collect:代扣  signature:签约 bindCard:绑卡 transfer:转账',
  `merchant_code` varchar(50) NOT NULL COMMENT '商户编码',
  `order_create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `order_status` varchar(15) NOT NULL COMMENT '订单状态： success：订单支付成功 new：新订单 dispose：订单受理中 error：订单请求发生异常 受理失败 fail：订单支付失败',
  `channel_result_code` varchar(16) DEFAULT NULL COMMENT '支付渠道响应编码，对应订单状态最新的',
  `channel_result_msg` varchar(250) DEFAULT NULL COMMENT '支付渠道响应消息，对应订单状态最新的',
  `notify_url` varchar(150) NOT NULL COMMENT '商户回调地址',
  `push_status` char(1) NOT NULL DEFAULT '0' COMMENT '推送状态：0：待查询，1：待推送，2：推送中 3.完成推送',
  `push_count` int(11) DEFAULT '0' COMMENT '推送次数',
  `query_count` int(11) DEFAULT '0' COMMENT '查询次数',
  `next_query_time` datetime DEFAULT NULL COMMENT '下次查询时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `requery` tinyint(1) DEFAULT '0' COMMENT '重新查询',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`),
  KEY `pay_channel` (`pay_channel`,`order_type`),
  KEY `create_time` (`create_time`),
  KEY `push_status` (`push_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='订单推送信息';

/*Data for the table `ups_t_order_push_10003` */

/*Table structure for table `ups_t_order_type` */

DROP TABLE IF EXISTS `ups_t_order_type`;

CREATE TABLE `ups_t_order_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_type` varchar(50) DEFAULT NULL COMMENT '订单类型',
  `order_type_name` varchar(50) DEFAULT NULL COMMENT '订单类型名称',
  `order_business_type` varchar(50) DEFAULT NULL COMMENT '订单业务类型(大类型)',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_user` varchar(50) DEFAULT NULL COMMENT '创建人员',
  `update_user` varchar(50) DEFAULT NULL COMMENT '更新人员',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_type` (`order_type`),
  UNIQUE KEY `order_type_name` (`order_type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='订单类型表';

/*Data for the table `ups_t_order_type` */

insert  into `ups_t_order_type`(`id`,`order_type`,`order_type_name`,`order_business_type`,`remark`,`create_time`,`update_time`,`create_user`,`update_user`) values (1,'Pay','代付','Pay',NULL,'2018-12-25 09:59:09','2018-12-25 09:59:11','system','system'),(2,'Collect','代扣','Collect',NULL,'2018-12-25 09:59:09','2018-12-25 09:59:09','system','system'),(3,'ProtocolCollect','协议代扣','Collect',NULL,'2018-12-25 09:59:09','2018-12-25 09:59:09','system','system'),(4,'Signature','签约','Signature',NULL,'2018-12-25 09:59:09','2018-12-25 09:59:09','system','system'),(5,'BindCard','绑卡','BindCard',NULL,'2018-12-25 09:59:09','2018-12-25 09:59:09','system','system'),(6,'ProtocolSignature','协议签约','Signature',NULL,'2018-12-25 09:59:09','2018-12-25 09:59:09','system','system'),(7,'ProtocolBindCard','协议绑卡','BindCard',NULL,'2018-12-25 09:59:09','2018-12-25 09:59:09','system','system');

/*Table structure for table `ups_t_pay_channel_bank` */

DROP TABLE IF EXISTS `ups_t_pay_channel_bank`;

CREATE TABLE `ups_t_pay_channel_bank` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ups_bank_id` bigint(11) DEFAULT NULL COMMENT 'ups银行id',
  `pay_channel` varchar(32) DEFAULT NULL COMMENT '支付渠道编码',
  `pay_channel_bank_code` varchar(32) DEFAULT NULL COMMENT '支付渠道银行编码',
  `pay_channel_bank_name` varchar(32) DEFAULT NULL COMMENT '支付渠道银行名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user` varchar(50) DEFAULT '',
  `update_user` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `ups_bank_id` (`ups_bank_id`),
  CONSTRAINT `ups_bank_id` FOREIGN KEY (`ups_bank_id`) REFERENCES `ups_t_bank` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COMMENT='与支付渠道银行编码映射表';

/*Data for the table `ups_t_pay_channel_bank` */

insert  into `ups_t_pay_channel_bank`(`id`,`ups_bank_id`,`pay_channel`,`pay_channel_bank_code`,`pay_channel_bank_name`,`create_time`,`update_time`,`create_user`,`update_user`) values (1,1,'baofoo','ICBC','中国工商银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(2,4,'baofoo','ABC','中国农业银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(3,3,'baofoo','CCB','中国建设银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(4,2,'baofoo','BOC','中国银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(5,5,'baofoo','BCOM','中国交通银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(6,8,'baofoo','CIB','兴业银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(7,10,'baofoo','CITIC','中信银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(8,11,'baofoo','CEB','中国光大银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(9,7,'baofoo','PAB','平安银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(10,12,'baofoo','PSBC','中国邮政储蓄银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(11,13,'baofoo','SHB','上海银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(12,9,'baofoo','SPDB','浦东发展银','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(13,15,'baofoo','CMBC','民生银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(14,6,'baofoo','CMB','招商银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(15,14,'baofoo','GDB','广发银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(16,1,'yeepay','ICBC','中国工商银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(17,2,'yeepay','BOC','中国银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(18,3,'yeepay','CCB','中国建设银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(19,4,'yeepay','ABC','中国农业银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(20,5,'yeepay','BOCO','交通银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(21,6,'yeepay','CMBCHINA','招商银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(22,7,'yeepay','SDB','平安银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(23,8,'yeepay','CIB','兴业银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(24,9,'yeepay','SPDB','上海浦东发展银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(25,10,'yeepay','ECITIC','中信银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(26,11,'yeepay','CEB','中国光大银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(27,12,'yeepay','PSBC','中国邮政储蓄银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(28,13,'yeepay','SHYH','上海银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(29,14,'yeepay','CGB','广发银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system'),(30,15,'yeepay','CMBC','中国民生银行','2019-01-10 10:11:03','2019-01-10 10:11:03','system','system');

/*Table structure for table `ups_t_quartz_config` */

DROP TABLE IF EXISTS `ups_t_quartz_config`;

CREATE TABLE `ups_t_quartz_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `class_name` varchar(80) DEFAULT '' COMMENT '任务class类名',
  `task_name` varchar(50) DEFAULT '' COMMENT '任务名',
  `task_group_name` varchar(50) DEFAULT '' COMMENT '任务所在组名',
  `cron_express` varchar(80) DEFAULT '' COMMENT '时间规则cron表达式',
  `run_ip` varchar(25) DEFAULT '' COMMENT '指定运行的机器IP',
  `description` varchar(50) DEFAULT '' COMMENT '任务描述',
  `active` tinyint(1) DEFAULT '1' COMMENT '是否生效',
  `create_user` varchar(50) DEFAULT '' COMMENT '创建人员',
  `update_user` varchar(50) DEFAULT '' COMMENT '更新人员',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `class_name` (`class_name`),
  UNIQUE KEY `task_name` (`task_name`,`task_group_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='ups定时器任务配置';

/*Data for the table `ups_t_quartz_config` */

insert  into `ups_t_quartz_config`(`id`,`class_name`,`task_name`,`task_group_name`,`cron_express`,`run_ip`,`description`,`active`,`create_user`,`update_user`,`create_time`,`update_time`) values (1,'BaofooQueryQuartzTask','baofoo-query-task','baofoo-group','*/30 * * * * ?','172.16.98.18','宝付查询交易定时器任务',1,'system','system','2018-12-29 15:26:05','2018-12-29 15:26:07'),(2,'YeepayQueryQuartzTask','yeepay-query-task','yeepay-group','*/30 * * * * ?','172.16.98.18','易宝查询交易定时器任务',1,'system','system','2019-01-03 10:20:28','2019-01-03 10:20:30'),(3,'PushOrderStatusTask','ups-push-task','ups-group','*/30 * * * * ?','192.168.5.147','订单最终状态推送业务端',1,'system','system','2019-01-03 10:20:28','2019-01-03 10:20:28'),(4,'BaofooBalanceQuartzTask','baofoo-ups-balance-task','ups-group','0/1 * * * * ?','172.16.206.1','宝付余额查询定时器任务',0,'system','system','2019-01-03 10:20:28','2019-01-03 10:20:30'),(5,'BaofooBalanceSmsWarningQuartzTask','baofoo-ups-balance-sms-task','ups-group','0 0 0/1 * * ?','172.16.206.1','宝付余额预警定时器任务',0,'system','system','2019-01-03 10:20:28','2019-01-03 10:20:30'),(6,'BaofooBalanceTransferQuartzTask','baofoo-ups-balance-transfer-task','ups-group','0 0 0/1 * * ?','172.16.206.1','宝付余额转账定时器任务',0,'system','system','2019-01-03 10:20:28','2019-01-03 10:20:30');

/*Table structure for table `ups_t_route_maintenance` */

DROP TABLE IF EXISTS `ups_t_route_maintenance`;

CREATE TABLE `ups_t_route_maintenance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_code` varchar(50) DEFAULT NULL COMMENT '来源商户编码',
  `order_type` varchar(50) DEFAULT NULL COMMENT '订单类型',
  `pay_channel` varchar(50) DEFAULT NULL COMMENT '支付渠道',
  `bank_code` varchar(50) DEFAULT NULL COMMENT '银行编码',
  `start_time` datetime DEFAULT NULL COMMENT '维护开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '维护结束时间',
  `active` tinyint(1) DEFAULT '1' COMMENT '是否激活生效',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user` varchar(50) DEFAULT '',
  `update_user` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `merchant_name` (`merchant_code`),
  KEY `order_type` (`order_type`),
  KEY `pay_channel` (`pay_channel`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='支付路由银行维护表';

/*Data for the table `ups_t_route_maintenance` */

insert  into `ups_t_route_maintenance`(`id`,`merchant_code`,`order_type`,`pay_channel`,`bank_code`,`start_time`,`end_time`,`active`,`create_time`,`update_time`,`create_user`,`update_user`) values (1,'10001','Pay','baofoo','CCB','2019-01-06 11:52:50','2019-01-31 11:52:53',0,'2019-01-07 11:52:56','2019-01-16 11:52:59','system','system'),(2,'10001','Pay','yeepay','CCB','2019-01-06 11:52:50','2019-01-31 11:52:53',0,'2019-01-07 11:52:56','2019-01-16 11:52:59','system','system');

/*Table structure for table `ups_t_route_pay_company` */

DROP TABLE IF EXISTS `ups_t_route_pay_company`;

CREATE TABLE `ups_t_route_pay_company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(50) DEFAULT '' COMMENT '支付公司名称',
  `company_code` varchar(15) DEFAULT '' COMMENT '支付公司编码',
  `active` tinyint(1) DEFAULT '1' COMMENT '是否激活生效',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user` varchar(50) DEFAULT '',
  `update_user` varchar(50) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_code` (`company_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='支付路由公司表';

/*Data for the table `ups_t_route_pay_company` */

insert  into `ups_t_route_pay_company`(`id`,`company_name`,`company_code`,`active`,`create_time`,`update_time`,`create_user`,`update_user`) values (1,'宝付','baofoo',1,'2018-12-25 11:11:10','2018-12-25 11:11:10','system','system'),(2,'易宝','yeepay',1,'2018-12-25 11:11:10','2018-12-25 11:11:10','system','system');

/*Table structure for table `ups_t_sign_default_config` */

DROP TABLE IF EXISTS `ups_t_sign_default_config`;

CREATE TABLE `ups_t_sign_default_config` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `merchant_code` varchar(11) NOT NULL COMMENT '商户编码',
  `tpp_mer_no` varchar(32) DEFAULT NULL COMMENT '支付渠道商户号',
  `sign_type` varchar(10) DEFAULT NULL COMMENT '签约方式：auth：认证，protocol：协议',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='签约默认渠道配置';

/*Data for the table `ups_t_sign_default_config` */

/*Table structure for table `ups_t_sms_channel` */

DROP TABLE IF EXISTS `ups_t_sms_channel`;

CREATE TABLE `ups_t_sms_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '短信通道ID',
  `sms_userful_code` varchar(10) DEFAULT NULL COMMENT '短信类型编码',
  `sms_userful_name` varchar(30) DEFAULT NULL COMMENT '短信类型名称',
  `sms_channel_code` varchar(20) DEFAULT NULL COMMENT '通道编码',
  `sms_channel_name` varchar(30) DEFAULT NULL COMMENT '通道名称',
  `request_url` varchar(250) DEFAULT NULL COMMENT '请求地址',
  `account` varchar(100) DEFAULT NULL COMMENT '账号',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `from_system` varchar(32) DEFAULT NULL,
  `is_userd` int(1) DEFAULT '1' COMMENT '是否使用0:是;1:否',
  `sort` int(2) DEFAULT NULL COMMENT '排序值',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` int(1) DEFAULT '0' COMMENT '是否删除0:否;1:是',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_channel_code` (`sms_channel_code`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='短信通道';

/*Data for the table `ups_t_sms_channel` */

insert  into `ups_t_sms_channel`(`id`,`sms_userful_code`,`sms_userful_name`,`sms_channel_code`,`sms_channel_name`,`request_url`,`account`,`password`,`from_system`,`is_userd`,`sort`,`create_time`,`update_time`,`is_deleted`) values (1,'NORMAL','常规短信','CHUANGLAN_NORMAL','创蓝常规','http://smssh1.253.com/msg/send/json','N2586509','ioMt3ZslO',NULL,1,0,'2018-04-18 15:02:50','2018-04-25 10:38:37',0);

/*Table structure for table `ups_t_thirdparty_config` */

DROP TABLE IF EXISTS `ups_t_thirdparty_config`;

CREATE TABLE `ups_t_thirdparty_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tpp_mer_no` varchar(64) DEFAULT '',
  `pay_channel` varchar(50) DEFAULT NULL COMMENT '第三方支付渠道名称',
  `merchant_code` varchar(25) DEFAULT '' COMMENT '系统编码',
  `order_type` varchar(20) DEFAULT NULL COMMENT '订单类型：pay:代付  collect:代扣  signature:签约 bindCard:绑卡 transfer:转账',
  `config_data` text COMMENT '配置数据信息JSON',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user` varchar(50) DEFAULT '' COMMENT '创建人员',
  `update_user` varchar(50) DEFAULT '' COMMENT '更新人员',
  PRIMARY KEY (`id`),
  KEY `pay_channel_fk` (`pay_channel`),
  KEY `from_system_fk` (`merchant_code`),
  KEY `order_type_fk` (`order_type`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='三方支付渠道配置表';

/*Data for the table `ups_t_thirdparty_config` */

insert  into `ups_t_thirdparty_config`(`id`,`tpp_mer_no`,`pay_channel`,`merchant_code`,`order_type`,`config_data`,`create_time`,`update_time`,`create_user`,`update_user`) values (1,'1222722','baofoo','10001','Pay','{\"member_id\":\"1222722\",\"terminal_id\":\"41535\",private_key:\"1222722privatekey.pfx\",public_key:\"baofu.cer\",\"key_store_password\":\"mqfq2018\",\"request_url\":\"https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do\",\"query_url\":\"https://public.baofoo.com/baofoo-fopay/pay/BF0040002.do\"}','2018-12-17 11:00:41','2018-12-17 11:00:42','system','system'),(2,'1214742','baofoo','10001','Collect','{\"member_id\":\"1214742\",\"terminal_id\":\"40063\",private_key:\"1214742privatekey.pfx\",public_key:\"baofu.cer\",\"key_store_password\":\"mqfq2018\",\"request_url\":\"https://public.baofoo.com/cutpayment/api/backTransRequest\",\"query_url\":\"https://public.baofoo.com/cutpayment/api/backTransRequest\"}','2018-12-17 11:00:56','2018-12-17 11:00:58','system','system'),(3,'1214742','baofoo','10001','Signature','{\"member_id\":\"1214742\",\"terminal_id\":\"40064\",\"pfxPath\":\"1214742privatekey.pfx\",\"cerpath\":\"baofu.cer\",\"aeskey\":\"4f66405c4f66405c\",\"pfxpwd\":\"mqfq2018\"}','2018-12-17 11:00:56','2018-12-17 11:00:58','system','system'),(4,'1214742','baofoo','10001','ProtocolCollect','{\"member_id\":\"1214742\",\"terminal_id\":\"40063\",\"version\":\"4.0.0.0\",\"aes_key\":\"4f66405c4f66405c\",\"public_key\":\"baofu.cer\",\"private_key\":\"1214742privatekey.pfx\",\"key_store_password\":\"mqfq2018\",\"request_url\":\"https://public.baofoo.com/cutpayment/protocol/backTransRequest\",query_url:\"https://public.baofoo.com/cutpayment/protocol/backTransRequest\"}','2018-12-20 15:25:11','2018-12-20 15:25:11','system','system'),(5,'1214742','baofoo','10001','BindCard','{\"member_id\":\"1214742\",\"terminal_id\":\"40064\",\"pfxPath\":\"1214742privatekey.pfx\",\"cerpath\":\"baofu.cer\",\"aeskey\":\"4f66405c4f66405c\",\"pfxpwd\":\"mqfq2018\"}','2018-12-20 15:25:11','2018-12-20 15:25:11','system','system'),(6,'1214742','baofoo','10001','ProtocolSignature','{\"member_id\":\"1214742\",\"terminal_id\":\"40063\",\"pfxPath\":\"1214742privatekey.pfx\",\"cerpath\":\"baofu.cer\",\"aeskey\":\"4f66405c4f66405c\",\"pfxpwd\":\"mqfq2018\"}','2018-12-17 11:00:56','2018-12-17 11:00:58','system','system'),(7,'1214742','baofoo','10001','ProtocolBindCard','{\"member_id\":\"1214742\",\"terminal_id\":\"40063\",\"pfxPath\":\"1214742privatekey.pfx\",\"cerpath\":\"baofu.cer\",\"aeskey\":\"4f66405c4f66405c\",\"pfxpwd\":\"mqfq2018\"}','2018-12-17 11:00:56','2018-12-17 11:00:58','system','system'),(8,'SQKK10020981510','yeepay','10001','Pay','{\"merchantno\":\"SQKK10020981510\",\"appKey\":\"SQKK10020981510\",\"groupNumber\":\"10000466938\",\"requestUrl\":\"/rest/v1.0/balance/transfer_send\",\"queryUrl\":\"/rest/v1.0/balance/transfer_query\"}','2018-12-17 11:00:56','2018-12-17 11:00:56','system','system'),(9,'SQKK10020981510','yeepay','10001','Collect','{\"merchantno\":\"SQKK10020981510\",\"terminalno\":\"SQKKSCENE10\",\"requestUrl\":\"/rest/v1.0/paperorder/unified/firstpay\",\"appKey\":\"SQKK10020981510\",\"queryUrl\":\"/rest/v1.0/paperorder/firstpayorder/query\"}','2018-12-17 11:00:56','2018-12-17 11:00:56','system','system'),(10,'SQKK10020981510','yeepay','10001','Signature','{\"appKey\":\"SQKK10020981510\"}','2018-12-17 11:00:56','2018-12-17 11:00:56','system','system'),(11,'1222722','baofoo','10003','Pay','{\"member_id\":\"1222722\",\"terminal_id\":\"41535\",private_key:\"1222722privatekey.pfx\",public_key:\"baofu.cer\",\"key_store_password\":\"mqfq2018\",\"request_url\":\"https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do\",\"query_url\":\"https://public.baofoo.com/baofoo-fopay/pay/BF0040002.do\"}','2018-12-17 11:00:41','2018-12-17 11:00:42','system','system'),(12,'1214742','baofoo','10003','Collect','{\"member_id\":\"1214742\",\"terminal_id\":\"40063\",private_key:\"1214742privatekey.pfx\",public_key:\"baofu.cer\",\"key_store_password\":\"mqfq2018\",\"request_url\":\"https://public.baofoo.com/cutpayment/api/backTransRequest\",\"query_url\":\"https://public.baofoo.com/cutpayment/api/backTransRequest\"}','2018-12-17 11:00:56','2018-12-17 11:00:58','system','system'),(13,'1214742','baofoo','10003','Signature','{\"member_id\":\"1214742\",\"terminal_id\":\"40064\",\"pfxPath\":\"1214742privatekey.pfx\",\"cerpath\":\"baofu.cer\",\"aeskey\":\"4f66405c4f66405c\",\"pfxpwd\":\"mqfq2018\"}','2018-12-17 11:00:56','2018-12-17 11:00:58','system','system'),(14,'1214742','baofoo','10003','ProtocolCollect','{\"member_id\":\"1214742\",\"terminal_id\":\"40063\",\"version\":\"4.0.0.0\",\"txn_type\":\"08\",\"aes_key\":\"4f66405c4f66405c\",\"public_key\":\"baofu.cer\",\"private_key\":\"1214742privatekey.pfx\",\"key_store_password\":\"mqfq2018\",\"request_url\":\"https://public.baofoo.com/cutpayment/protocol/backTransRequest\",query_url:\"https://public.baofoo.com/cutpayment/protocol/backTransRequest\"}','2018-12-20 15:25:11','2018-12-20 15:25:11','system','system'),(15,'1214742','baofoo','10003','BindCard','{\"member_id\":\"1214742\",\"terminal_id\":\"40064\",\"pfxPath\":\"1214742privatekey.pfx\",\"cerpath\":\"baofu.cer\",\"aeskey\":\"4f66405c4f66405c\",\"pfxpwd\":\"mqfq2018\"}','2018-12-20 15:25:11','2018-12-20 15:25:11','system','system'),(16,'1214742','baofoo','10003','ProtocolSignature','{\"member_id\":\"1214742\",\"terminal_id\":\"40063\",\"pfxPath\":\"1214742privatekey.pfx\",\"cerpath\":\"baofu.cer\",\"aeskey\":\"4f66405c4f66405c\",\"pfxpwd\":\"mqfq2018\"}','2018-12-17 11:00:56','2018-12-17 11:00:58','system','system'),(17,'1214742','baofoo','10003','ProtocolBindCard','{\"member_id\":\"1214742\",\"terminal_id\":\"40063\",\"pfxPath\":\"1214742privatekey.pfx\",\"cerpath\":\"baofu.cer\",\"aeskey\":\"4f66405c4f66405c\",\"pfxpwd\":\"mqfq2018\"}','2018-12-17 11:00:56','2018-12-17 11:00:58','system','system'),(18,'SQKK10020981510','yeepay','10003','Pay','{\"merchantno\":\"SQKK10020981510\",\"appKey\":\"SQKK10020981510\",\"groupNumber\":\"10000466938\",\"requestUrl\":\"/rest/v1.0/balance/transfer_send\",\"queryUrl\":\"/rest/v1.0/balance/transfer_query\"}','2018-12-17 11:00:56','2018-12-17 11:00:56','system','system'),(19,'SQKK10020981510','yeepay','10003','Collect','{\"merchantno\":\"SQKK10020981510\",\"terminalno\":\"SQKKSCENE10\",\"requestUrl\":\"/rest/v1.0/paperorder/unified/firstpay\",\"appKey\":\"SQKK10020981510\",\"queryUrl\":\"/rest/v1.0/paperorder/firstpayorder/query\"}','2018-12-17 11:00:56','2018-12-17 11:00:56','system','system'),(20,'SQKK10020981510','yeepay','10003','Signature','{\"appKey\":\"SQKK10020981510\"}','2018-12-17 11:00:56','2018-12-17 11:00:56','system','system');

/*Table structure for table `ups_t_thirdparty_log` */

DROP TABLE IF EXISTS `ups_t_thirdparty_log`;

CREATE TABLE `ups_t_thirdparty_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `merchant_code` varchar(25) NOT NULL COMMENT '商户编码',
  `order_type` varchar(20) NOT NULL COMMENT '订单类型：pay:代付  collect:代扣  signature:签约 bindCard:绑卡 transfer:转账',
  `pay_channel` varchar(50) NOT NULL COMMENT '第三方支付渠道名称',
  `ups_order_code` varchar(80) NOT NULL COMMENT '请求订单编码',
  `request_url` varchar(150) NOT NULL COMMENT '请求地址',
  `request_text` text COMMENT '第三方支付渠道请报文',
  `return_text` text COMMENT '第三方支付渠道返回报文',
  `create_time` datetime DEFAULT NULL COMMENT '日志创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '日志修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='ups第三方支付渠道交互日志表';

/*Data for the table `ups_t_thirdparty_log` */

insert  into `ups_t_thirdparty_log`(`id`,`merchant_code`,`order_type`,`pay_channel`,`ups_order_code`,`request_url`,`request_text`,`return_text`,`create_time`,`update_time`) values (1,'Shurong','Pay','baofoo','baofooShurong1115533704077381632','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115533704077381632\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 16:35:37','2019-04-09 16:35:37'),(2,'Shurong','Pay','baofoo','baofooShurong1115535054781681664','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115535054781681664\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','5a99c5407fc1d6af7623c0e465c3c66b7400349c511b0b41c0a9de152fcec90a9050dc6a03ddfc22b3a28baec1ffd5c3aeda88e254474507f1a85d6698bf048fa38437dd1dad7a7aa685095f8da95c3d342eefc2149d9d96e1ea751274b6fd29e054b20219f7672d2a38294170354f5f47e22a49d77311334ac28c83540006191df2f351e037b3df934944685030d6dd4eb2955bb96b79fccaafba1070a8f7a0e8006b61339d8b85dff2772b8c8f199798d7ab18ae1a9371e9e87c61282d6e978f161ca9207bac718d68fe5fdd44984434e8665a6110e30bb1c03099540890a50b29caacf8ac4e038ca2d0fb033d9fc35c94e51039b229aa5cd38f978d7e5b8e','2019-04-09 16:40:59','2019-04-09 16:40:59'),(3,'Shurong','Pay','baofoo','baofooShurong1115535084108255232','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115535084108255232\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','5a99c5407fc1d6af7623c0e465c3c66b7400349c511b0b41c0a9de152fcec90a9050dc6a03ddfc22b3a28baec1ffd5c3aeda88e254474507f1a85d6698bf048fa38437dd1dad7a7aa685095f8da95c3d342eefc2149d9d96e1ea751274b6fd29e054b20219f7672d2a38294170354f5f47e22a49d77311334ac28c83540006191df2f351e037b3df934944685030d6dd4eb2955bb96b79fccaafba1070a8f7a0e8006b61339d8b85dff2772b8c8f199798d7ab18ae1a9371e9e87c61282d6e978f161ca9207bac718d68fe5fdd44984434e8665a6110e30bb1c03099540890a50b29caacf8ac4e038ca2d0fb033d9fc35c94e51039b229aa5cd38f978d7e5b8e','2019-04-09 16:41:05','2019-04-09 16:41:05'),(4,'Shurong','Pay','baofoo','baofooShurong1115535588502671360','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115535588502671360\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 16:43:06','2019-04-09 16:43:06'),(5,'Shurong','Pay','baofoo','baofooShurong1115535624607240192','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115535624607240192\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 16:43:13','2019-04-09 16:43:13'),(6,'Shurong','Pay','baofoo','baofooShurong1115536999009357824','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115536999009357824\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 16:48:41','2019-04-09 16:48:41'),(7,'Shurong','Pay','baofoo','baofooShurong1115537029493559296','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115537029493559296\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 16:48:48','2019-04-09 16:48:48'),(8,'Shurong','Pay','baofoo','baofooShurong1115537035562717184','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115537035562717184\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 16:48:50','2019-04-09 16:48:50'),(9,'Shurong','Pay','baofoo','baofooShurong1115537039744438272','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115537039744438272\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 16:48:51','2019-04-09 16:48:51'),(10,'Shurong','Pay','baofoo','baofooShurong1115537043712249856','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115537043712249856\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 16:48:52','2019-04-09 16:48:52'),(11,'Shurong','Pay','baofoo','baofooShurong1115537046925086720','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115537046925086720\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 16:48:53','2019-04-09 16:48:53'),(12,'Shurong','Pay','baofoo','baofooShurong1115542928194932736','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115542928194932736\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 17:12:16','2019-04-09 17:12:16'),(13,'Shurong','Pay','baofoo','baofooShurong1115544272779743232','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115544272779743232\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 17:17:37','2019-04-09 17:17:37'),(14,'Shurong','Pay','baofoo','baofooShurong1115554551953494016','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115554551953494016\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 17:58:27','2019-04-09 17:58:27'),(15,'Shurong','Pay','baofoo','baofooShurong1115556031666196480','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115556031666196480\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 18:04:20','2019-04-09 18:04:20'),(16,'Shurong','Pay','baofoo','baofooShurong1115556361774698496','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115556361774698496\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 18:05:38','2019-04-09 18:05:38'),(17,'Shurong','Collect','baofoo','baofooShurong1115558283441213440','https://public.baofoo.com/cutpayment/api/backTransRequest','{\"version\":\"4.0.0\",\"terminal_id\":\"40063\",\"txn_type\":\"0431\",\"txn_sub_type\":\"13\",\"member_id\":\"1214742\",\"data_type\":\"json\",\"data_content\":\"{\\\"acc_no\\\":\\\"6217001660006437184\\\",\\\"biz_type\\\":\\\"0000\\\",\\\"id_card\\\":\\\"340403199002222652\\\",\\\"id_card_type\\\":\\\"01\\\",\\\"id_holder\\\":\\\"徐旭\\\",\\\"member_id\\\":\\\"1214742\\\",\\\"mobile\\\":\\\"15755498776\\\",\\\"pay_code\\\":\\\"CCB\\\",\\\"terminal_id\\\":\\\"40063\\\",\\\"trade_date\\\":\\\"20190409181315\\\",\\\"trans_id\\\":\\\"baofooShurong1115558283441213440\\\",\\\"trans_serial_no\\\":\\\"1115558283441213440\\\",\\\"txn_amt\\\":\\\"1.00\\\",\\\"txn_sub_type\\\":\\\"13\\\"}\"}','{\"data_type\":\"json\",\"resp_code\":\"BF00316\",\"resp_msg\":\"ip未绑定，请联系宝付\",\"txn_sub_type\":\"13\",\"txn_type\":\"0431\",\"version\":\"4.0.0\"}','2019-04-09 18:13:17','2019-04-09 18:13:17'),(18,'Shurong','Collect','baofoo','baofooShurong1115558599326830592','https://public.baofoo.com/cutpayment/api/backTransRequest','{\"version\":\"4.0.0\",\"terminal_id\":\"40063\",\"txn_type\":\"0431\",\"txn_sub_type\":\"13\",\"member_id\":\"1214742\",\"data_type\":\"json\",\"data_content\":\"{\\\"acc_no\\\":\\\"6217001660006437184\\\",\\\"biz_type\\\":\\\"0000\\\",\\\"id_card\\\":\\\"340403199002222652\\\",\\\"id_card_type\\\":\\\"01\\\",\\\"id_holder\\\":\\\"徐旭\\\",\\\"member_id\\\":\\\"1214742\\\",\\\"mobile\\\":\\\"15755498776\\\",\\\"pay_code\\\":\\\"CCB\\\",\\\"terminal_id\\\":\\\"40063\\\",\\\"trade_date\\\":\\\"20190409181430\\\",\\\"trans_id\\\":\\\"baofooShurong1115558599326830592\\\",\\\"trans_serial_no\\\":\\\"1115558599326830592\\\",\\\"txn_amt\\\":\\\"1.00\\\",\\\"txn_sub_type\\\":\\\"13\\\"}\"}','{\"data_type\":\"json\",\"resp_code\":\"BF00316\",\"resp_msg\":\"ip未绑定，请联系宝付\",\"txn_sub_type\":\"13\",\"txn_type\":\"0431\",\"version\":\"4.0.0\"}','2019-04-09 18:14:31','2019-04-09 18:14:31'),(19,'Shurong','Pay','baofoo','baofooShurong1115558612098486272','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115558612098486272\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 18:14:34','2019-04-09 18:14:34'),(20,'Shurong','Pay','baofoo','baofooShurong1115558644302352384','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofooShurong1115558644302352384\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-09 18:14:42','2019-04-09 18:14:42'),(21,'Shurong','Collect','baofoo','baofooShurong1115559270386110464','https://public.baofoo.com/cutpayment/api/backTransRequest','{\"version\":\"4.0.0\",\"terminal_id\":\"40063\",\"txn_type\":\"0431\",\"txn_sub_type\":\"13\",\"member_id\":\"1214742\",\"data_type\":\"json\",\"data_content\":\"{\\\"acc_no\\\":\\\"6217001660006437184\\\",\\\"biz_type\\\":\\\"0000\\\",\\\"id_card\\\":\\\"340403199002222652\\\",\\\"id_card_type\\\":\\\"01\\\",\\\"id_holder\\\":\\\"徐旭\\\",\\\"member_id\\\":\\\"1214742\\\",\\\"mobile\\\":\\\"15755498776\\\",\\\"pay_code\\\":\\\"CCB\\\",\\\"terminal_id\\\":\\\"40063\\\",\\\"trade_date\\\":\\\"20190409181710\\\",\\\"trans_id\\\":\\\"baofooShurong1115559270386110464\\\",\\\"trans_serial_no\\\":\\\"1115559270386110464\\\",\\\"txn_amt\\\":\\\"1.00\\\",\\\"txn_sub_type\\\":\\\"13\\\"}\"}','{\"data_type\":\"json\",\"resp_code\":\"BF00316\",\"resp_msg\":\"ip未绑定，请联系宝付\",\"txn_sub_type\":\"13\",\"txn_type\":\"0431\",\"version\":\"4.0.0\"}','2019-04-09 18:17:11','2019-04-09 18:17:11'),(22,'Shurong','Collect','baofoo','baofooShurong1115560147180195840','https://public.baofoo.com/cutpayment/api/backTransRequest','{\"version\":\"4.0.0\",\"terminal_id\":\"40063\",\"txn_type\":\"0431\",\"txn_sub_type\":\"13\",\"member_id\":\"1214742\",\"data_type\":\"json\",\"data_content\":\"{\\\"acc_no\\\":\\\"6217001660006437184\\\",\\\"biz_type\\\":\\\"0000\\\",\\\"id_card\\\":\\\"340403199002222652\\\",\\\"id_card_type\\\":\\\"01\\\",\\\"id_holder\\\":\\\"徐旭\\\",\\\"member_id\\\":\\\"1214742\\\",\\\"mobile\\\":\\\"15755498776\\\",\\\"pay_code\\\":\\\"CCB\\\",\\\"terminal_id\\\":\\\"40063\\\",\\\"trade_date\\\":\\\"20190409182039\\\",\\\"trans_id\\\":\\\"baofooShurong1115560147180195840\\\",\\\"trans_serial_no\\\":\\\"1115560147180195840\\\",\\\"txn_amt\\\":\\\"1.00\\\",\\\"txn_sub_type\\\":\\\"13\\\"}\"}','{\"data_type\":\"json\",\"resp_code\":\"BF00316\",\"resp_msg\":\"ip未绑定，请联系宝付\",\"txn_sub_type\":\"13\",\"txn_type\":\"0431\",\"version\":\"4.0.0\"}','2019-04-09 18:20:41','2019-04-09 18:20:41'),(23,'Meiqi','Collect','baofoo','baofooMeiqi1115619999063609344','https://public.baofoo.com/cutpayment/api/backTransRequest','{\"version\":\"4.0.0\",\"terminal_id\":\"40063\",\"txn_type\":\"0431\",\"txn_sub_type\":\"13\",\"member_id\":\"1214742\",\"data_type\":\"json\",\"data_content\":\"{\\\"acc_no\\\":\\\"6217001660006437184\\\",\\\"biz_type\\\":\\\"0000\\\",\\\"id_card\\\":\\\"340403199002222652\\\",\\\"id_card_type\\\":\\\"01\\\",\\\"id_holder\\\":\\\"徐旭\\\",\\\"member_id\\\":\\\"1214742\\\",\\\"mobile\\\":\\\"15755498776\\\",\\\"pay_code\\\":\\\"CCB\\\",\\\"terminal_id\\\":\\\"40063\\\",\\\"trade_date\\\":\\\"20190409221829\\\",\\\"trans_id\\\":\\\"baofooMeiqi1115619999063609344\\\",\\\"trans_serial_no\\\":\\\"1115619999063609344\\\",\\\"txn_amt\\\":\\\"1.00\\\",\\\"txn_sub_type\\\":\\\"13\\\"}\"}','{\"data_type\":\"json\",\"resp_code\":\"BF00316\",\"resp_msg\":\"ip未绑定，请联系宝付\",\"txn_sub_type\":\"13\",\"txn_type\":\"0431\",\"version\":\"4.0.0\"}','2019-04-09 22:18:31','2019-04-09 22:18:31'),(24,'Meiqi','Collect','yeepay','yeepayMeiqi1118853399044034560','/rest/v1.0/paperorder/unified/firstpay','{\"terminalno\":\"SQKKSCENE10\",\"amount\":0.01,\"identitytype\":\"ID_CARD\",\"requesttime\":\"2019-04-18 20:26:53\",\"idcardno\":\"340403199002222652\",\"requestno\":\"yeepayMeiqi1118853399044034560\",\"cardno\":\"6217001660006437184\",\"idcardtype\":\"ID\",\"authtype\":\"COMMON_FOUR\",\"issms\":\"false\",\"phone\":\"15755498776\",\"identityid\":\"user123\",\"username\":\"徐旭\"}','YopResponse[state=FAILURE,requestId=fb46457f-dcdd-4e81-87b9-0afcad9ad794,result=<null>,ts=<null>,sign=<null>,error=YopError[code=40029,subCode=sys.limit.ip-white-list.app,message=访问受限,subMessage=应用级ip白名单受限,solution=<null>],validSign=true]','2019-04-18 20:26:55','2019-04-18 20:26:55'),(25,'10001','Collect','yeepay','yeepay100011120176399232143360','/rest/v1.0/paperorder/unified/firstpay','{\"terminalno\":\"SQKKSCENE10\",\"amount\":0.01,\"identitytype\":\"ID_CARD\",\"requesttime\":\"2019-04-22 12:04:01\",\"idcardno\":\"340403199002222652\",\"requestno\":\"yeepay100011120176399232143360\",\"cardno\":\"6217001660006437184\",\"idcardtype\":\"ID\",\"authtype\":\"COMMON_FOUR\",\"issms\":\"false\",\"phone\":\"15755498776\",\"identityid\":\"user123\",\"username\":\"徐旭\"}','YopResponse[state=FAILURE,requestId=85e34a25-4d60-417c-b0df-7f89dcc8b9ee,result=<null>,ts=<null>,sign=<null>,error=YopError[code=40029,subCode=sys.limit.ip-white-list.app,message=访问受限,subMessage=应用级ip白名单受限,solution=<null>],validSign=true]','2019-04-22 12:04:04','2019-04-22 12:04:04'),(26,'10001','Collect','yeepay','yeepay100011120177260880596992','/rest/v1.0/paperorder/unified/firstpay','{\"terminalno\":\"SQKKSCENE10\",\"amount\":0.01,\"identitytype\":\"ID_CARD\",\"requesttime\":\"2019-04-22 12:07:30\",\"idcardno\":\"340403199002222652\",\"requestno\":\"yeepay100011120177260880596992\",\"cardno\":\"6217001660006437184\",\"idcardtype\":\"ID\",\"authtype\":\"COMMON_FOUR\",\"issms\":\"false\",\"phone\":\"15755498776\",\"identityid\":\"user123\",\"username\":\"徐旭\"}','YopResponse[state=FAILURE,requestId=ae2ae804-d3a4-437a-9c71-c1786956d751,result=<null>,ts=<null>,sign=<null>,error=YopError[code=40029,subCode=sys.limit.ip-white-list.app,message=访问受限,subMessage=应用级ip白名单受限,solution=<null>],validSign=true]','2019-04-22 12:07:32','2019-04-22 12:07:32'),(27,'10001','Collect','baofoo','baofoo100011120250435391852544','https://public.baofoo.com/cutpayment/api/backTransRequest','{\"version\":\"4.0.0\",\"terminal_id\":\"40063\",\"txn_type\":\"0431\",\"txn_sub_type\":\"13\",\"member_id\":\"1214742\",\"data_type\":\"json\",\"data_content\":\"{\\\"acc_no\\\":\\\"6217001660006437184\\\",\\\"biz_type\\\":\\\"0000\\\",\\\"id_card\\\":\\\"340403199002222652\\\",\\\"id_card_type\\\":\\\"01\\\",\\\"id_holder\\\":\\\"徐旭\\\",\\\"member_id\\\":\\\"1214742\\\",\\\"mobile\\\":\\\"15755498776\\\",\\\"pay_code\\\":\\\"CCB\\\",\\\"terminal_id\\\":\\\"40063\\\",\\\"trade_date\\\":\\\"20190422165811\\\",\\\"trans_id\\\":\\\"baofoo100011120250435391852544\\\",\\\"trans_serial_no\\\":\\\"1120250435391852544\\\",\\\"txn_amt\\\":\\\"1.00\\\",\\\"txn_sub_type\\\":\\\"13\\\"}\"}','{\"data_type\":\"json\",\"resp_code\":\"BF00316\",\"resp_msg\":\"ip未绑定，请联系宝付\",\"txn_sub_type\":\"13\",\"txn_type\":\"0431\",\"version\":\"4.0.0\"}','2019-04-22 16:58:13','2019-04-22 16:58:13'),(28,'10001','Collect','baofoo','baofoo100011120250486243594240','https://public.baofoo.com/cutpayment/api/backTransRequest','{\"version\":\"4.0.0\",\"terminal_id\":\"40063\",\"txn_type\":\"0431\",\"txn_sub_type\":\"13\",\"member_id\":\"1214742\",\"data_type\":\"json\",\"data_content\":\"{\\\"acc_no\\\":\\\"6217001660006437184\\\",\\\"biz_type\\\":\\\"0000\\\",\\\"id_card\\\":\\\"340403199002222652\\\",\\\"id_card_type\\\":\\\"01\\\",\\\"id_holder\\\":\\\"徐旭\\\",\\\"member_id\\\":\\\"1214742\\\",\\\"mobile\\\":\\\"15755498776\\\",\\\"pay_code\\\":\\\"CCB\\\",\\\"terminal_id\\\":\\\"40063\\\",\\\"trade_date\\\":\\\"20190422165823\\\",\\\"trans_id\\\":\\\"baofoo100011120250486243594240\\\",\\\"trans_serial_no\\\":\\\"1120250486243594240\\\",\\\"txn_amt\\\":\\\"1.00\\\",\\\"txn_sub_type\\\":\\\"13\\\"}\"}','{\"data_type\":\"json\",\"resp_code\":\"BF00316\",\"resp_msg\":\"ip未绑定，请联系宝付\",\"txn_sub_type\":\"13\",\"txn_type\":\"0431\",\"version\":\"4.0.0\"}','2019-04-22 16:58:24','2019-04-22 16:58:24'),(29,'10001','Collect','baofoo','baofoo100011120252397688590336','https://public.baofoo.com/cutpayment/api/backTransRequest','{\"version\":\"4.0.0\",\"terminal_id\":\"40063\",\"txn_type\":\"0431\",\"txn_sub_type\":\"13\",\"member_id\":\"1214742\",\"data_type\":\"json\",\"data_content\":\"{\\\"acc_no\\\":\\\"6217001660006437184\\\",\\\"biz_type\\\":\\\"0000\\\",\\\"id_card\\\":\\\"340403199002222652\\\",\\\"id_card_type\\\":\\\"01\\\",\\\"id_holder\\\":\\\"徐旭\\\",\\\"member_id\\\":\\\"1214742\\\",\\\"mobile\\\":\\\"15755498776\\\",\\\"pay_code\\\":\\\"CCB\\\",\\\"terminal_id\\\":\\\"40063\\\",\\\"trade_date\\\":\\\"20190422170559\\\",\\\"trans_id\\\":\\\"baofoo100011120252397688590336\\\",\\\"trans_serial_no\\\":\\\"1120252397688590336\\\",\\\"txn_amt\\\":\\\"1.00\\\",\\\"txn_sub_type\\\":\\\"13\\\"}\"}','{\"data_type\":\"json\",\"resp_code\":\"BF00316\",\"resp_msg\":\"ip未绑定，请联系宝付\",\"txn_sub_type\":\"13\",\"txn_type\":\"0431\",\"version\":\"4.0.0\"}','2019-04-22 17:06:01','2019-04-22 17:06:01'),(30,'10002','Pay','baofoo','baofoo100021120252581311025152','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"徐旭\\\",\\\"to_acc_no\\\":\\\"6217001660006437184\\\",\\\"to_bank_name\\\":\\\"中国建设银行\\\",\\\"trans_card_id\\\":\\\"340403199002222652\\\",\\\"trans_mobile\\\":\\\"15755498776\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100021120252581311025152\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-22 17:06:44','2019-04-22 17:06:44'),(31,'10001','Pay','baofoo','baofoo100011122766694847221760','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"金元乾\\\",\\\"to_acc_no\\\":\\\"6217920274289532\\\",\\\"to_bank_name\\\":\\\"浦东发展银\\\",\\\"trans_card_id\\\":\\\"330102199302060013\\\",\\\"trans_mobile\\\":\\\"13777365685\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100011122766694847221760\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-29 15:36:55','2019-04-29 15:36:55'),(32,'10001','Pay','baofoo','baofoo100011122777183220273152','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"金元乾\\\",\\\"to_acc_no\\\":\\\"6217920274289532\\\",\\\"to_bank_name\\\":\\\"浦东发展银\\\",\\\"trans_card_id\\\":\\\"330102199302060013\\\",\\\"trans_mobile\\\":\\\"13777365685\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100011122777183220273152\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-29 16:19:36','2019-04-29 16:19:36'),(33,'10001','Pay','baofoo','baofoo100011122777457854910464','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"金元乾\\\",\\\"to_acc_no\\\":\\\"6217920274289532\\\",\\\"to_bank_name\\\":\\\"浦东发展银\\\",\\\"trans_card_id\\\":\\\"330102199302060013\\\",\\\"trans_mobile\\\":\\\"13777365685\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100011122777457854910464\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-29 16:25:26','2019-04-29 16:25:26'),(34,'10001','Pay','baofoo','baofoo100011122782499274100736','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"金元乾\\\",\\\"to_acc_no\\\":\\\"6217920274289532\\\",\\\"to_bank_name\\\":\\\"浦东发展银\\\",\\\"trans_card_id\\\":\\\"330102199302060013\\\",\\\"trans_mobile\\\":\\\"13777365685\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100011122782499274100736\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-29 16:39:57','2019-04-29 16:39:57'),(35,'10001','Pay','baofoo','baofoo100011122783381675970560','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"金元乾\\\",\\\"to_acc_no\\\":\\\"6217920274289532\\\",\\\"to_bank_name\\\":\\\"浦东发展银\\\",\\\"trans_card_id\\\":\\\"330102199302060013\\\",\\\"trans_mobile\\\":\\\"13777365685\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100011122783381675970560\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-29 16:43:28','2019-04-29 16:43:28'),(36,'10001','Pay','baofoo','baofoo100011122783988436570112','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"金元乾\\\",\\\"to_acc_no\\\":\\\"6217920274289532\\\",\\\"to_bank_name\\\":\\\"浦东发展银\\\",\\\"trans_card_id\\\":\\\"330102199302060013\\\",\\\"trans_mobile\\\":\\\"13777365685\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100011122783988436570112\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-29 16:45:49','2019-04-29 16:45:49'),(37,'10001','Pay','baofoo','baofoo100011122792303753302016','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"金元乾\\\",\\\"to_acc_no\\\":\\\"6217920274289532\\\",\\\"to_bank_name\\\":\\\"浦东发展银\\\",\\\"trans_card_id\\\":\\\"330102199302060013\\\",\\\"trans_mobile\\\":\\\"13777365685\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100011122792303753302016\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-29 17:18:59','2019-04-29 17:18:59'),(38,'10001','Pay','baofoo','baofoo100011123129912425844736','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"金元乾\\\",\\\"to_acc_no\\\":\\\"6217920274289532\\\",\\\"to_bank_name\\\":\\\"浦东发展银\\\",\\\"trans_card_id\\\":\\\"330102199302060013\\\",\\\"trans_mobile\\\":\\\"13777365685\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100011123129912425844736\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-30 15:40:41','2019-04-30 15:40:41'),(39,'10001','Pay','baofoo','baofoo100011123130097210101760','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"金元乾\\\",\\\"to_acc_no\\\":\\\"6217920274289532\\\",\\\"to_bank_name\\\":\\\"浦东发展银\\\",\\\"trans_card_id\\\":\\\"330102199302060013\\\",\\\"trans_mobile\\\":\\\"13777365685\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100011123130097210101760\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-30 15:41:53','2019-04-30 15:41:53'),(40,'10001','Pay','baofoo','baofoo100011123130441277247488','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"金元乾\\\",\\\"to_acc_no\\\":\\\"6217920274289532\\\",\\\"to_bank_name\\\":\\\"浦东发展银\\\",\\\"trans_card_id\\\":\\\"330102199302060013\\\",\\\"trans_mobile\\\":\\\"13777365685\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100011123130441277247488\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-30 15:42:26','2019-04-30 15:42:26'),(41,'10001','Pay','baofoo','baofoo100011123130492842020864','https://public.baofoo.com/baofoo-fopay/pay/BF0040001.do','{\"member_id\":\"1222722\",\"data_type\":\"json\",\"data_content\":\"{\\\"trans_content\\\":{\\\"trans_reqDatas\\\":[{\\\"trans_reqData\\\":{\\\"to_acc_name\\\":\\\"金元乾\\\",\\\"to_acc_no\\\":\\\"6217920274289532\\\",\\\"to_bank_name\\\":\\\"浦东发展银\\\",\\\"trans_card_id\\\":\\\"330102199302060013\\\",\\\"trans_mobile\\\":\\\"13777365685\\\",\\\"trans_money\\\":\\\"0.01\\\",\\\"trans_no\\\":\\\"baofoo100011123130492842020864\\\"}}]}}\",\"version\":\"4.0.0\",\"terminal_id\":\"41535\"}','{\"trans_content\":{\"trans_head\":{\"return_code\":\"0203\",\"return_msg\":\"商户代付业务未绑定IP，请联系宝付技术支持\"}}}','2019-04-30 15:42:37','2019-04-30 15:42:37');

/*Table structure for table `ups_t_tpp_mer_config` */

DROP TABLE IF EXISTS `ups_t_tpp_mer_config`;

CREATE TABLE `ups_t_tpp_mer_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `pay_channel` varchar(50) DEFAULT '' COMMENT '第三方支付渠道名称',
  `order_type` varchar(20) DEFAULT '' COMMENT '订单类型：pay:代付  collect:代扣  signature:签约 bindCard:绑卡 transfer:转账',
  `tpp_mer_no` varchar(20) DEFAULT '',
  `config_data` text COMMENT '配置数据信息JSON',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_user` varchar(50) DEFAULT '' COMMENT '创建人员',
  `update_user` varchar(50) DEFAULT '' COMMENT '更新人员',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='三方支付渠道配置表';

/*Data for the table `ups_t_tpp_mer_config` */

/*Table structure for table `ups_t_user_sign_10001` */

DROP TABLE IF EXISTS `ups_t_user_sign_10001`;

CREATE TABLE `ups_t_user_sign_10001` (
  `id` bigint(20) NOT NULL,
  `pay_channel` varchar(16) NOT NULL DEFAULT '' COMMENT '渠道缩写',
  `sign_type` varchar(16) NOT NULL DEFAULT '' COMMENT '签约类型签约方式：auth认证签约，protocol协议签约'',',
  `merchant_code` varchar(25) NOT NULL DEFAULT '' COMMENT '商户编码',
  `tpp_mer_no` varchar(20) NOT NULL DEFAULT '' COMMENT 'TPP商户客户号',
  `user_no` varchar(32) NOT NULL DEFAULT '' COMMENT '商户用户标识',
  `bank_code` varchar(10) NOT NULL DEFAULT '' COMMENT '所属银行编码',
  `bank_card` varchar(20) NOT NULL DEFAULT '' COMMENT '卡号',
  `trade_no` varchar(64) NOT NULL DEFAULT '' COMMENT '签约订单号，绑卡与确认绑卡的关联订单号',
  `real_name` varchar(64) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `cert_type` varchar(2) NOT NULL DEFAULT '' COMMENT '证件类型',
  `identity` varchar(32) NOT NULL DEFAULT '' COMMENT '证件号码',
  `phone_no` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `status` tinyint(4) NOT NULL COMMENT '状态.10：正常，11：待确认,12：绑卡待查询，20：无效，30：过期',
  `ups_user_id` varchar(255) DEFAULT '' COMMENT '支付系统用户唯一ID，mer_no+tpp_code+tpp_mer_no+real_name+cert_no+ups_bank_code+bank_card_no)',
  `business_flow_num` varchar(64) DEFAULT '' COMMENT '业务订单号',
  `tpp_sign_no` varchar(64) DEFAULT '' COMMENT '支付渠道签约标识bind_id，protocol_no，用于代扣、解绑',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '订单修改时间',
  `gmt_ymd` int(64) DEFAULT NULL COMMENT '记录的时间,yyyyMMdd格式',
  `sign_date` datetime DEFAULT NULL COMMENT '完成签约时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `tpp_order_no` varchar(255) DEFAULT '' COMMENT '第三方渠道订单号',
  `business_type` varchar(32) DEFAULT '',
  `real_name_encrypt` varchar(255) DEFAULT '' COMMENT '姓名号密文可解',
  `real_name_md5` varchar(32) DEFAULT '' COMMENT '姓名密文无解，用于匹配',
  `identity_md5` varchar(32) DEFAULT '' COMMENT '身份证密文无解，用于匹配',
  `identity_encrypt` varchar(255) DEFAULT '' COMMENT '身份证密文可解',
  `phone_no_encrypt` varchar(255) DEFAULT '' COMMENT '手机号码密文可解',
  `phone_no_md5` varchar(32) DEFAULT '' COMMENT '手机号无解，用于匹配',
  `bank_encrypt` varchar(255) DEFAULT '' COMMENT '银行卡密文可解',
  `bank_md5` varchar(32) DEFAULT '' COMMENT '银行卡无解，用于匹配',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sign_userSignType` (`pay_channel`,`merchant_code`,`sign_type`,`user_no`,`bank_md5`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='宝付协议签约信息表';

/*Data for the table `ups_t_user_sign_10001` */

/*Table structure for table `ups_t_user_sign_10002` */

DROP TABLE IF EXISTS `ups_t_user_sign_10002`;

CREATE TABLE `ups_t_user_sign_10002` (
  `id` bigint(20) NOT NULL,
  `pay_channel` varchar(16) NOT NULL DEFAULT '' COMMENT '渠道缩写',
  `sign_type` varchar(16) NOT NULL DEFAULT '' COMMENT '签约类型签约方式：auth认证签约，protocol协议签约'',',
  `merchant_code` varchar(25) NOT NULL DEFAULT '' COMMENT '商户编码',
  `tpp_mer_no` varchar(20) NOT NULL DEFAULT '' COMMENT 'TPP商户客户号',
  `user_no` varchar(32) NOT NULL DEFAULT '' COMMENT '商户用户标识',
  `bank_code` varchar(10) NOT NULL DEFAULT '' COMMENT '所属银行编码',
  `bank_card` varchar(20) NOT NULL COMMENT '卡号',
  `trade_no` varchar(64) NOT NULL DEFAULT '' COMMENT '签约订单号，绑卡与确认绑卡的关联订单号',
  `real_name` varchar(64) NOT NULL DEFAULT '' COMMENT '真实姓名',
  `cert_type` varchar(2) NOT NULL DEFAULT '' COMMENT '证件类型',
  `identity` varchar(32) NOT NULL DEFAULT '' COMMENT '证件号码',
  `phone_no` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `status` tinyint(4) NOT NULL COMMENT '状态.10：正常，11：待确认,12：绑卡待查询，20：无效，30：过期',
  `ups_user_id` varchar(255) DEFAULT '' COMMENT '支付系统用户唯一ID，mer_no+tpp_code+tpp_mer_no+real_name+cert_no+ups_bank_code+bank_card_no)',
  `business_flow_num` varchar(64) DEFAULT '' COMMENT '业务订单号',
  `tpp_sign_no` varchar(64) DEFAULT '' COMMENT '支付渠道签约标识bind_id，protocol_no，用于代扣、解绑',
  `remark` varchar(255) DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '订单创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '订单修改时间',
  `gmt_ymd` int(64) DEFAULT NULL COMMENT '记录的时间,yyyyMMdd格式',
  `sign_date` datetime DEFAULT NULL COMMENT '完成签约时间',
  `is_delete` tinyint(1) NOT NULL DEFAULT '0',
  `tpp_order_no` varchar(255) DEFAULT '' COMMENT '第三方渠道订单号',
  `business_type` varchar(32) DEFAULT '',
  `real_name_encrypt` varchar(255) DEFAULT '' COMMENT '姓名号密文可解',
  `real_name_md5` varchar(32) DEFAULT '' COMMENT '姓名密文无解，用于匹配',
  `identity_md5` varchar(32) DEFAULT '' COMMENT '身份证密文无解，用于匹配',
  `identity_encrypt` varchar(255) DEFAULT '' COMMENT '身份证密文可解',
  `phone_no_encrypt` varchar(255) DEFAULT '' COMMENT '手机号码密文可解',
  `phone_no_md5` varchar(32) DEFAULT '' COMMENT '手机号无解，用于匹配',
  `bank_encrypt` varchar(255) DEFAULT '' COMMENT '银行卡密文可解',
  `bank_md5` varchar(32) DEFAULT '' COMMENT '银行卡无解，用于匹配',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_sign_userSignType` (`pay_channel`,`merchant_code`,`sign_type`,`user_no`,`bank_md5`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='宝付协议签约信息表';

/*Data for the table `ups_t_user_sign_10002` */

/*Table structure for table `ups_t_user_sign_log_10001` */

DROP TABLE IF EXISTS `ups_t_user_sign_log_10001`;

CREATE TABLE `ups_t_user_sign_log_10001` (
  `id` bigint(20) NOT NULL,
  `merchant_code` varchar(11) NOT NULL DEFAULT '' COMMENT '商户编码',
  `business_flow_num` varchar(64) NOT NULL COMMENT '商户系统订单号',
  `tpp_order_no` varchar(64) NOT NULL COMMENT 'ups系统订单号',
  `tpp_mer_no` varchar(32) NOT NULL COMMENT '支付渠道商户号',
  `ups_user_id` varchar(32) NOT NULL COMMENT '支付系统用户唯一ID',
  `user_no` varchar(32) NOT NULL COMMENT '商户唯一用户ID',
  `bank_card` varchar(20) NOT NULL DEFAULT '' COMMENT '卡号',
  `mer_request_params` varchar(3000) DEFAULT NULL COMMENT '商户请求数据，存明文',
  `mer_request_time` datetime DEFAULT NULL,
  `mer_response_params` varchar(3000) DEFAULT NULL COMMENT '响应商户数据，存明文',
  `mer_response_time` datetime DEFAULT NULL,
  `tpp_request_params` varchar(3000) DEFAULT NULL COMMENT '请求支付渠道参数，存明文',
  `tpp_request_time` datetime DEFAULT NULL,
  `tpp_response_params` varchar(3000) DEFAULT NULL COMMENT '支付渠道响应参数，存明文',
  `tpp_response_time` datetime DEFAULT NULL,
  `real_name` varchar(32) DEFAULT '' COMMENT '姓名',
  `phone_no` varchar(32) DEFAULT '' COMMENT '手机号码',
  `pay_channel` varchar(32) DEFAULT NULL,
  `identity` varchar(32) DEFAULT '' COMMENT '身份证',
  `order_type` varchar(32) DEFAULT NULL,
  `real_name_encrypt` varchar(255) DEFAULT '' COMMENT '姓名号密文可解',
  `real_name_md5` varchar(32) DEFAULT '' COMMENT '姓名密文无解，用于匹配',
  `identity_md5` varchar(32) DEFAULT '' COMMENT '身份证密文无解，用于匹配',
  `identity_encrypt` varchar(255) DEFAULT '' COMMENT '身份证密文可解',
  `phone_no_encrypt` varchar(255) DEFAULT '' COMMENT '手机号码密文可解',
  `phone_no_md5` varchar(32) DEFAULT '' COMMENT '手机号无解，用于匹配',
  `bank_encrypt` varchar(255) DEFAULT '' COMMENT '银行卡密文可解',
  `bank_md5` varchar(32) DEFAULT '' COMMENT '银行卡无解，用于匹配',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户签约日志';

/*Data for the table `ups_t_user_sign_log_10001` */

/*Table structure for table `ups_t_user_sign_log_10002` */

DROP TABLE IF EXISTS `ups_t_user_sign_log_10002`;

CREATE TABLE `ups_t_user_sign_log_10002` (
  `id` bigint(20) NOT NULL,
  `merchant_code` varchar(11) NOT NULL DEFAULT '' COMMENT '商户编码',
  `business_flow_num` varchar(64) NOT NULL COMMENT '商户系统订单号',
  `tpp_order_no` varchar(64) NOT NULL COMMENT 'ups系统订单号',
  `tpp_mer_no` varchar(32) NOT NULL COMMENT '支付渠道商户号',
  `ups_user_id` varchar(32) NOT NULL COMMENT '支付系统用户唯一ID',
  `user_no` varchar(32) NOT NULL COMMENT '商户唯一用户ID',
  `bank_card` varchar(20) NOT NULL DEFAULT '' COMMENT '卡号',
  `mer_request_params` varchar(3000) DEFAULT NULL COMMENT '商户请求数据，存明文',
  `mer_request_time` datetime DEFAULT NULL,
  `mer_response_params` varchar(3000) DEFAULT NULL COMMENT '响应商户数据，存明文',
  `mer_response_time` datetime DEFAULT NULL,
  `tpp_request_params` varchar(3000) DEFAULT NULL COMMENT '请求支付渠道参数，存明文',
  `tpp_request_time` datetime DEFAULT NULL,
  `tpp_response_params` varchar(3000) DEFAULT NULL COMMENT '支付渠道响应参数，存明文',
  `tpp_response_time` datetime DEFAULT NULL,
  `real_name` varchar(32) DEFAULT '' COMMENT '姓名',
  `phone_no` varchar(32) DEFAULT '' COMMENT '手机号码',
  `pay_channel` varchar(32) DEFAULT NULL,
  `identity` varchar(32) DEFAULT '' COMMENT '身份证',
  `order_type` varchar(32) DEFAULT NULL,
  `real_name_encrypt` varchar(255) DEFAULT '' COMMENT '姓名号密文可解',
  `real_name_md5` varchar(32) DEFAULT '' COMMENT '姓名密文无解，用于匹配',
  `identity_md5` varchar(32) DEFAULT '' COMMENT '身份证密文无解，用于匹配',
  `identity_encrypt` varchar(255) DEFAULT '' COMMENT '身份证密文可解',
  `phone_no_encrypt` varchar(255) DEFAULT '' COMMENT '手机号码密文可解',
  `phone_no_md5` varchar(32) DEFAULT '' COMMENT '手机号无解，用于匹配',
  `bank_encrypt` varchar(255) DEFAULT '' COMMENT '银行卡密文可解',
  `bank_md5` varchar(32) DEFAULT '' COMMENT '银行卡无解，用于匹配',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户签约日志';

/*Data for the table `ups_t_user_sign_log_10002` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
