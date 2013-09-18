-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.24


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema shared_offers_db
--

CREATE DATABASE IF NOT EXISTS shared_offers_db;
USE shared_offers_db;

--
-- Definition of table `data_biz`
--

DROP TABLE IF EXISTS `data_biz`;
CREATE TABLE `data_biz` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` bigint(20) unsigned NOT NULL,
  `name` varchar(250) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `category_id` bigint(20) unsigned DEFAULT '0',
  `subcategory_id` bigint(20) unsigned NOT NULL,
  `web_name` varchar(100) DEFAULT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `web` varchar(100) DEFAULT NULL,
  `status` bigint(20) unsigned NOT NULL DEFAULT '0',
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_biz`
--

/*!40000 ALTER TABLE `data_biz` DISABLE KEYS */;
INSERT INTO `data_biz` (`id`,`owner_id`,`name`,`description`,`category_id`,`subcategory_id`,`web_name`,`logo`,`phone`,`fax`,`email`,`web`,`status`,`dt`) VALUES 
 (7,0,'Exapt Income Tax Service','Income Tax Preparation',NULL,0,'exapt',' ','415-379-9545','415 379 9544','exapt@yahoo.com','upmile.com/biz/exapt',0,'0000-00-00 00:00:00'),
 (26,77,'green farms from bay area','description',NULL,0,NULL,'1354164578607_tag2.jpg','4153433343',NULL,'test3@test.com',NULL,0,'2012-05-09 22:05:33'),
 (28,334,'test2',NULL,NULL,0,NULL,NULL,'415345654',NULL,'eto@mil.com',NULL,0,'2012-07-28 23:43:02'),
 (30,90,'test3','descr',NULL,0,NULL,'1347322939731RSS.png','4153454466',NULL,'test3@test.com',NULL,0,'2012-09-10 17:22:30'),
 (31,90,'test3','descr',NULL,0,NULL,'1347323857472RSS.png','4153454466',NULL,'test3@test.com',NULL,0,'2012-09-10 17:37:37'),
 (32,90,'test3','descr',NULL,0,NULL,'1347339092914arrow_left.png','4153456799',NULL,'test1@test.com',NULL,0,'2012-09-10 21:51:32'),
 (33,90,'test3','descr',NULL,0,NULL,'1347342866227_arrow_left.png','4153456799',NULL,'test1@test.com',NULL,0,'2012-09-10 22:54:26'),
 (34,345,'test',NULL,1,4,NULL,NULL,'4152345566',NULL,'test@test.com',NULL,1,'2013-01-03 14:48:09');
/*!40000 ALTER TABLE `data_biz` ENABLE KEYS */;


--
-- Definition of table `data_biz_category`
--

DROP TABLE IF EXISTS `data_biz_category`;
CREATE TABLE `data_biz_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `status` int(10) unsigned NOT NULL DEFAULT '0',
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_biz_category`
--

/*!40000 ALTER TABLE `data_biz_category` DISABLE KEYS */;
INSERT INTO `data_biz_category` (`id`,`name`,`status`,`dt`) VALUES 
 (1,'Store',0,'2012-12-30 22:31:13'),
 (2,'Restaurant',0,'2012-12-30 22:31:13'),
 (3,'Other',0,'2012-12-30 22:31:13');
/*!40000 ALTER TABLE `data_biz_category` ENABLE KEYS */;


--
-- Definition of table `data_biz_location`
--

DROP TABLE IF EXISTS `data_biz_location`;
CREATE TABLE `data_biz_location` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `biz_id` bigint(20) unsigned NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `zipcode` varchar(5) DEFAULT NULL,
  `longitude` float NOT NULL,
  `latitude` float NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_biz_location`
--

/*!40000 ALTER TABLE `data_biz_location` DISABLE KEYS */;
INSERT INTO `data_biz_location` (`id`,`biz_id`,`name`,`street`,`city`,`state`,`zipcode`,`longitude`,`latitude`,`phone`,`fax`,`dt`) VALUES 
 (1,7,NULL,'5616 Geary blvd, Suite 207','San Francisco','CA','94121',0,0,NULL,NULL,'2010-01-02 12:50:07'),
 (14,26,NULL,'1 market','san francisco','ca','94103',0,0,NULL,NULL,'2012-05-09 22:05:33'),
 (16,28,NULL,'str1','sf','ca','94103',0,0,NULL,NULL,'2012-07-28 23:43:02'),
 (18,30,NULL,'1 main st.','san francisco','ca','94103',0,0,NULL,NULL,'2012-09-10 17:22:30'),
 (19,31,NULL,'1 main st.','san francisco','ca','94103',0,0,NULL,NULL,'2012-09-10 17:37:37'),
 (20,32,NULL,'1 main st','sf','ca','94103',0,0,NULL,NULL,'2012-09-10 21:51:32'),
 (21,33,NULL,'1 main st','sf','ca','94103',0,0,NULL,NULL,'2012-09-10 22:54:26'),
 (22,34,NULL,'1 pine','sf','CA','94103',0,0,NULL,NULL,'2013-01-03 14:48:09'),
 (23,35,NULL,'1 pine','sf','CA','94103',0,0,NULL,NULL,'2013-01-03 17:23:29'),
 (24,36,NULL,'1 pine','sf','CA','94103',0,0,NULL,NULL,'2013-01-03 17:38:27'),
 (25,37,NULL,'1 pine','sf','CA','94103',0,0,NULL,NULL,'2013-01-03 21:51:07'),
 (26,38,NULL,'1 pine','sf','CA','94103',0,0,NULL,NULL,'2013-01-07 16:42:21'),
 (27,39,NULL,'1 pine','sf','CA','94103',0,0,NULL,NULL,'2013-01-07 17:04:59'),
 (28,40,NULL,'1 pine','sf','CA','94103',0,0,NULL,NULL,'2013-01-08 21:31:23'),
 (29,41,NULL,'1 pine','sf','CA','94103',0,0,NULL,NULL,'2013-01-08 21:32:34'),
 (30,42,NULL,'1 pine','sf','CA','94103',0,0,NULL,NULL,'2013-01-08 21:36:30');
/*!40000 ALTER TABLE `data_biz_location` ENABLE KEYS */;


--
-- Definition of table `data_biz_subcategory`
--

DROP TABLE IF EXISTS `data_biz_subcategory`;
CREATE TABLE `data_biz_subcategory` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` int(10) unsigned NOT NULL DEFAULT '0',
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_biz_subcategory`
--

/*!40000 ALTER TABLE `data_biz_subcategory` DISABLE KEYS */;
INSERT INTO `data_biz_subcategory` (`id`,`category_id`,`name`,`status`,`dt`) VALUES 
 (1,1,'Jewelry',0,'2012-12-30 22:35:43'),
 (2,1,'Clothes',0,'2012-12-30 22:35:43'),
 (3,1,'Food',0,'2012-12-30 22:35:43'),
 (4,1,'Wine, Spirits',0,'2012-12-30 22:35:43'),
 (5,2,'Thai',0,'2012-12-30 22:35:43'),
 (6,2,'Indian',0,'2012-12-30 22:35:43'),
 (7,2,'Other',0,'2012-12-30 22:35:43'),
 (8,1,'Other',0,'2012-12-30 22:35:43');
/*!40000 ALTER TABLE `data_biz_subcategory` ENABLE KEYS */;


--
-- Definition of table `data_deal`
--

DROP TABLE IF EXISTS `data_deal`;
CREATE TABLE `data_deal` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `biz_id` bigint(20) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `subcategory_id` int(10) unsigned NOT NULL,
  `status` int(10) unsigned NOT NULL,
  `type` int(10) unsigned NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `pics` varchar(2000) DEFAULT NULL,
  `expiration` datetime NOT NULL,
  `regular_price` float NOT NULL,
  `deal_price` float NOT NULL,
  `address_name` varchar(100) DEFAULT NULL,
  `street` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `zipcode` varchar(5) DEFAULT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_deal`
--

/*!40000 ALTER TABLE `data_deal` DISABLE KEYS */;
INSERT INTO `data_deal` (`id`,`user_id`,`biz_id`,`category_id`,`subcategory_id`,`status`,`type`,`name`,`description`,`pics`,`expiration`,`regular_price`,`deal_price`,`address_name`,`street`,`city`,`state`,`phone`,`zipcode`,`latitude`,`longitude`,`dt`) VALUES 
 (1,345,34,1,4,0,0,'test','7937',NULL,'1970-01-01 22:34:00',12.44,12.44,'null','1 pine','sf','CA',NULL,'94103',0,0,'2013-01-24 22:53:19'),
 (2,345,34,1,4,0,0,'test deal','descr',NULL,'1970-01-01 17:30:00',55.99,55.99,'swnull','1 pine','sf','CA',NULL,'94103',0,0,'2013-03-09 23:08:36'),
 (3,345,34,1,4,0,0,'test deal','descr',NULL,'1970-01-01 17:30:00',55.99,55.99,'swnull','1 pine','sf','CA',NULL,'94103',0,0,'2013-03-09 23:10:07'),
 (4,345,34,1,4,0,0,'test4','descr',NULL,'1970-01-01 15:45:00',22.99,22.99,'null','1 pine','sf','CA',NULL,'94103',0,0,'2013-03-09 23:17:01'),
 (5,345,34,1,4,0,0,'test','descr1','[[\"1363067979917_IMG_20130312_055524_-1492511355.jpg\",\"1363067979921_IMG_20130312_055455_-1536283673.jpg\"]]','1970-01-01 16:55:00',11.99,11.99,'null','1 pine','sf','CA','4152345566','94103',0,0,'2013-03-11 22:59:39'),
 (6,345,34,1,4,0,0,'test','descr1','[\"1363068282518_IMG_20130312_055524_-1492511355.jpg\",\"1363068282522_IMG_20130312_055455_-1536283673.jpg\"]','1970-01-01 16:55:00',11.99,11.99,'null','1 pine','sf','CA','4152345566','94103',0,0,'2013-03-11 23:04:42');
/*!40000 ALTER TABLE `data_deal` ENABLE KEYS */;


--
-- Definition of table `data_email`
--

DROP TABLE IF EXISTS `data_email`;
CREATE TABLE `data_email` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `status` int(10) unsigned NOT NULL DEFAULT '0',
  `from_email` varchar(45) NOT NULL,
  `recip_to` varchar(100) NOT NULL,
  `subj` varchar(200) NOT NULL,
  `body` text NOT NULL,
  `send_date` datetime DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=155 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_email`
--

/*!40000 ALTER TABLE `data_email` DISABLE KEYS */;
INSERT INTO `data_email` (`id`,`status`,`from_email`,`recip_to`,`subj`,`body`,`send_date`,`dt`) VALUES 
 (138,1,'mailer@upmile.com','kirill_avramenko@yahoo.com','Upmile.com Order Cancellation','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\r\n<html>\r\n    <head>\r\n		<title>Order Cancellation</title>\r\n		<link rel=\"stylesheet\" type=\"text/css\" href=\"http://localhost:8080/static/css/email.css\"/>\r\n	</head>		\r\n	<body>\r\n			<div class=\"text\">\r\n				Hello kirill!\r\n				</br>\r\n				The order placed on your offer <a href=\"http://localhost:8080/myoffers\">offer1 has been cancelled by customer.</a></br> \r\n            </div>\r\n            </br>\r\n			<div style=\"display: table;\">\r\n				<div class=\"row\">\r\n                	<div class=\"cell\">\r\n                    	Customer:\r\n                    </div>\r\n                    &nbsp;\r\n                    <div class=\"cell\">\r\n                    	$customer.getNodeValueAsStr(\"first_name\") $customer.getNodeValueAsStr(\"last_name\") \r\n                    </div>\r\n                 </div>\r\n            </div>\r\n			<div class=\"row\">\r\n            	<div class=\"cell\">\r\n                	Order Items\r\n                </div>\r\n                <div class=\"cell\">&nbsp;</div>\r\n            </div>		\r\n	            <div class=\"row\">\r\n                	<div class=\"cell\">\r\n                    	<div id=\"itemsTbl\">\r\n    						<div class=\"row\">\r\n        						<div class=\"itemHeaderCell itemname\">\r\n            						Name\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemprice\">\r\n            						Price\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemqty\">\r\n                					Order Qty\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemtotal\">\r\n                					Total\r\n            					</div>\r\n        					</div>\r\n															        							<div class=\"row iteminfo\" id=\"117\">\r\n        							<div class=\"offerCell\" id=\"iname\">another</div>\r\n            						<div class=\"offerCell\" id=\"iprice\">$2.38 / bunch</div>\r\n            						<div class=\"offerCell qtyColumn\">20</div>\r\n            						<div class=\"offerCell\" id=\"itotal\">$47.6</div> \r\n       								</div>\r\n																							        							<div class=\"row iteminfo\" id=\"116\">\r\n        							<div class=\"offerCell\" id=\"iname\">new item</div>\r\n            						<div class=\"offerCell\" id=\"iprice\">$4.99 / bottle</div>\r\n            						<div class=\"offerCell qtyColumn\">45</div>\r\n            						<div class=\"offerCell\" id=\"itotal\">$224.55</div> \r\n       								</div>\r\n															        					<div class=\"row\"> \r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            				<div class=\"offerCellAmount\">&nbsp;</div>\r\n        					</div>\r\n        					<div class=\"row\">\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCellTotal\">\r\n            						Discount (%)\r\n            					</div>\r\n            					<div class=\"offerCellAmount\" id=\"discount\">6.83</div>\r\n        					</div>\r\n        					<div class=\"row\">\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCellTotal\">\r\n                 					Grand Total ($)\r\n            					</div>\r\n            					<div class=\"offerCellAmount\" id=\"grandtotal\">253.57</div>\r\n        					</div>\r\n							<br>\r\n						</div>\r\n                    </div>\r\n             	</div>\r\n			</div>\r\n	</body>\r\n</html>','2012-11-25 12:39:00','2012-11-25 12:39:35'),
 (139,1,'mailer@upmile.com','kirill_avramenko@yahoo.com','Umpile.com New Order Notification','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\r\n<html>\r\n    <head>\r\n		<title>New Order</title>\r\n		<link rel=\"stylesheet\" type=\"text/css\" href=\"http://localhost:8080/static/css/email.css\"/>\r\n	</head>		\r\n	<body>\r\n			<div class=\"text\">\r\n				Hello kirill!\r\n				</br>\r\n				You have a new order placed on your offer <a href=\"http://localhost:8080/myoffers\">offer1.</a></br> \r\n            </div>\r\n            </br>\r\n			<div style=\"display: table;\">\r\n				<div class=\"row\">\r\n                	<div class=\"cell\">\r\n                    	Customer:\r\n                    </div>\r\n                    &nbsp;\r\n                    <div class=\"cell\">\r\n                    	kir gmail\r\n                    </div>\r\n                 </div>\r\n            </div>\r\n			<div class=\"row\">\r\n            	<div class=\"cell\">\r\n                	Order Items\r\n                </div>\r\n                <div class=\"cell\">&nbsp;</div>\r\n            </div>		\r\n	            <div class=\"row\">\r\n                	<div class=\"cell\">\r\n                    	<div id=\"itemsTbl\">\r\n    						<div class=\"row\">\r\n        						<div class=\"itemHeaderCell itemname\">\r\n            						Name\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemprice\">\r\n            						Price\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemqty\">\r\n                					Order Qty\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemtotal\">\r\n                					Total\r\n            					</div>\r\n        					</div>\r\n															        							<div class=\"row iteminfo\" id=\"117\">\r\n        							<div class=\"offerCell\" id=\"iname\">another</div>\r\n            						<div class=\"offerCell\" id=\"iprice\">$2.38 / bunch</div>\r\n            						<div class=\"offerCell qtyColumn\">10</div>\r\n            						<div class=\"offerCell\" id=\"itotal\">$23.8</div> \r\n       								</div>\r\n																							        							<div class=\"row iteminfo\" id=\"116\">\r\n        							<div class=\"offerCell\" id=\"iname\">new item</div>\r\n            						<div class=\"offerCell\" id=\"iprice\">$4.99 / bottle</div>\r\n            						<div class=\"offerCell qtyColumn\">30</div>\r\n            						<div class=\"offerCell\" id=\"itotal\">$149.7</div> \r\n       								</div>\r\n															        					<div class=\"row\"> \r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            				<div class=\"offerCellAmount\">&nbsp;</div>\r\n        					</div>\r\n        					<div class=\"row\">\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCellTotal\">\r\n            						Discount (%)\r\n            					</div>\r\n            					<div class=\"offerCellAmount\" id=\"discount\">5.29</div>\r\n        					</div>\r\n        					<div class=\"row\">\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCellTotal\">\r\n                 					Grand Total ($)\r\n            					</div>\r\n            					<div class=\"offerCellAmount\" id=\"grandtotal\">164.33</div>\r\n        					</div>\r\n							<br>\r\n						</div>\r\n                    </div>\r\n             	</div>\r\n			</div>\r\n	</body>\r\n</html>','2012-11-25 12:40:00','2012-11-25 12:39:58'),
 (140,1,'mailer@upmile.com','kirill_avramenko@yahoo.com','Umpile.com Order Update Notification','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\r\n<html>\r\n    <head>\r\n		<title>New Order</title>\r\n		<link rel=\"stylesheet\" type=\"text/css\" href=\"http://localhost:8080/static/css/email.css\"/>\r\n	</head>		\r\n	<body>\r\n			<div class=\"text\">\r\n				Hello kirill!\r\n				</br>\r\n				Customer updated his order placed on your offer <a href=\"http://localhost:8080/myoffers\">offer1.</a></br> \r\n            </div>\r\n            </br>\r\n			<div style=\"display: table;\">\r\n				<div class=\"row\">\r\n                	<div class=\"cell\">\r\n                    	Customer:\r\n                    </div>\r\n                    &nbsp;\r\n                    <div class=\"cell\">\r\n                    	kir gmail\r\n                    </div>\r\n                 </div>\r\n            </div>\r\n			<div class=\"row\">\r\n            	<div class=\"cell\">\r\n                	Order Items\r\n                </div>\r\n                <div class=\"cell\">&nbsp;</div>\r\n            </div>		\r\n	            <div class=\"row\">\r\n                	<div class=\"cell\">\r\n                    	<div id=\"itemsTbl\">\r\n    						<div class=\"row\">\r\n        						<div class=\"itemHeaderCell itemname\">\r\n            						Name\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemprice\">\r\n            						Price\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemqty\">\r\n                					Order Qty\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemtotal\">\r\n                					Total\r\n            					</div>\r\n        					</div>\r\n															        							<div class=\"row iteminfo\" id=\"117\">\r\n        							<div class=\"offerCell\" id=\"iname\">another</div>\r\n            						<div class=\"offerCell\" id=\"iprice\">$2.38 / bunch</div>\r\n            						<div class=\"offerCell qtyColumn\">20</div>\r\n            						<div class=\"offerCell\" id=\"itotal\">$47.6</div> \r\n       								</div>\r\n																							        							<div class=\"row iteminfo\" id=\"116\">\r\n        							<div class=\"offerCell\" id=\"iname\">new item</div>\r\n            						<div class=\"offerCell\" id=\"iprice\">$4.99 / bottle</div>\r\n            						<div class=\"offerCell qtyColumn\">40</div>\r\n            						<div class=\"offerCell\" id=\"itotal\">$199.6</div> \r\n       								</div>\r\n															        					<div class=\"row\"> \r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            				<div class=\"offerCellAmount\">&nbsp;</div>\r\n        					</div>\r\n        					<div class=\"row\">\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCellTotal\">\r\n            						Discount (%)\r\n            					</div>\r\n            					<div class=\"offerCellAmount\" id=\"discount\">6.43</div>\r\n        					</div>\r\n        					<div class=\"row\">\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCellTotal\">\r\n                 					Grand Total ($)\r\n            					</div>\r\n            					<div class=\"offerCellAmount\" id=\"grandtotal\">231.31</div>\r\n        					</div>\r\n							<br>\r\n						</div>\r\n                    </div>\r\n             	</div>\r\n			</div>\r\n	</body>\r\n</html>','2012-11-25 12:40:00','2012-11-25 12:40:23'),
 (141,1,'mailer@upmile.com','kirill.avramenko@gmail.com','The offer1 offer Discount Update','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\r\n<html>\r\n    <head>\r\n		<title>Discount Update</title>\r\n		<link rel=\"stylesheet\" type=\"text/css\" href=\"http://localhost:8080/static/css/email.css\"/>\r\n	</head>		\r\n	<body>\r\n			<div class=\"text\">\r\n				Hello kir!</br>\r\n				The offer1 offer discount has changed to 8.66%. \r\n            </div>\r\n            </br>\r\n			<div style=\"display: table;\">\r\n				<div class=\"row\">\r\n		    		<div class=\"cell paragraph\">\r\n						Offer Details\r\n		    		</div>\r\n		    		<div class=\"cell\"></div>	\r\n				</div>\r\n				<div class=\"row\">\r\n		    		<div class=\"cell label\">\r\n						Merchant:\r\n		    		</div>\r\n		    		<div class=\"cell labeltext\">\r\n							green farms from bay area\r\n					</div>	\r\n				</div>\r\n				<div class=\"row\">\r\n		    		<div class=\"cell label\">\r\n						Order Pickup:\r\n		    		</div>\r\n		    		<div class=\"cell labeltext\">\r\n                            	<div class=\"row\">\r\n                                	<div class=\"offerHeaderTextCell\" id=\"pickup_time\">\r\n										                                		                                			8 am - 8 am, June 4 - June 8\r\n                                		                                	</div>\r\n                            	</div>\r\n                            	<div class=\"row\">\r\n                                	<div class=\"offerHeaderTextCell\" id=\"pickup_name\">\r\n                                		\r\n                                	</div>\r\n                            	</div>\r\n                            	<div class=\"row\">\r\n                                	<div class=\"offerHeaderTextCell\" id=\"pickup_address\">\r\n                                		1 market</br>\r\n                                		san francisco ca 94103\r\n                                	</div>\r\n                            	</div>\r\n                            						</div>	\r\n		</div>\r\n		<div class=\"row\">\r\n			&nbsp;	\r\n		</div>\r\n		<div class=\"row\">\r\n		    <div class=\"cell paragraph\">\r\n			Your Order\r\n		    </div>\r\n		    <div class=\"cell\"></div>		\r\n		</div>\r\n	</div>\r\n	</br>\r\n    <div id=\"itemsTbl\">\r\n    	<div class=\"row\">\r\n        	<div class=\"itemHeaderCell itemname\">\r\n            	Name\r\n            </div>\r\n            <div class=\"itemHeaderCell itemprice\">\r\n            	Price\r\n            </div>\r\n            <div class=\"itemHeaderCell itemqty\">\r\n                Order Qty\r\n            </div>\r\n            <div class=\"itemHeaderCell itemtotal\">\r\n                Total\r\n            </div>\r\n        </div>\r\n					        <div class=\"row iteminfo\" id=\"117\">\r\n        	<div class=\"offerCell\" id=\"iname\">another</div>\r\n            <div class=\"offerCell\" id=\"iprice\">$2.38 / bunch</div>\r\n            <div class=\"offerCell qtyColumn\">20</div>\r\n            <div class=\"offerCell\" id=\"itotal\">$278.46</div> \r\n       	</div>\r\n								        <div class=\"row iteminfo\" id=\"116\">\r\n        	<div class=\"offerCell\" id=\"iname\">new item</div>\r\n            <div class=\"offerCell\" id=\"iprice\">$4.99 / bottle</div>\r\n            <div class=\"offerCell qtyColumn\">40</div>\r\n            <div class=\"offerCell\" id=\"itotal\">$578.84</div> \r\n       	</div>\r\n					        <div class=\"row\"> \r\n        	<div class=\"offerFooterCell\">&nbsp;</div>\r\n        	<div class=\"offerFooterCell\">&nbsp;</div>\r\n        	<div class=\"offerFooterCell\">&nbsp;</div>\r\n            <div class=\"offerCellAmount\">&nbsp;</div>\r\n        </div>\r\n        <div class=\"row\">\r\n            <div class=\"offerFooterCell\">&nbsp;</div>\r\n            <div class=\"offerFooterCell\">&nbsp;</div>\r\n            <div class=\"offerFooterCellTotal\">\r\n            	Discount (%)\r\n            </div>\r\n            <div class=\"offerCellAmount\" id=\"discount\">8.66</div>\r\n        </div>\r\n        <div class=\"row\">\r\n            <div class=\"offerFooterCell\">&nbsp;</div>\r\n            <div class=\"offerFooterCell\">&nbsp;</div>\r\n            <div class=\"offerFooterCellTotal\">\r\n                 Grand Total ($)\r\n            </div>\r\n            <div class=\"offerCellAmount\" id=\"grandtotal\">225.8</div>\r\n        </div>\r\n		<br>\r\n	</div>\r\n</div>\r\n</body>\r\n</html>','2012-11-25 12:44:00','2012-11-25 12:44:44'),
 (142,1,'mailer@upmile.com','kirill_avramenko@yahoo.com','Umpile.com New Order Notification','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\r\n<html>\r\n    <head>\r\n		<title>New Order</title>\r\n		<link rel=\"stylesheet\" type=\"text/css\" href=\"http://localhost:8080/static/css/email.css\"/>\r\n	</head>		\r\n	<body>\r\n			<div class=\"text\">\r\n				Hello kirill!\r\n				</br>\r\n				You have a new order placed on your offer <a href=\"http://localhost:8080/myoffers\">offer1.</a></br> \r\n            </div>\r\n            </br>\r\n			<div style=\"display: table;\">\r\n				<div class=\"row\">\r\n                	<div class=\"cell\">\r\n                    	Customer:\r\n                    </div>\r\n                    &nbsp;\r\n                    <div class=\"cell\">\r\n                    	kirill avr\r\n                    </div>\r\n                 </div>\r\n            </div>\r\n			<div class=\"row\">\r\n            	<div class=\"cell\">\r\n                	Order Items\r\n                </div>\r\n                <div class=\"cell\">&nbsp;</div>\r\n            </div>		\r\n	            <div class=\"row\">\r\n                	<div class=\"cell\">\r\n                    	<div id=\"itemsTbl\">\r\n    						<div class=\"row\">\r\n        						<div class=\"itemHeaderCell itemname\">\r\n            						Name\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemprice\">\r\n            						Price\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemqty\">\r\n                					Order Qty\r\n            					</div>\r\n            					<div class=\"itemHeaderCell itemtotal\">\r\n                					Total\r\n            					</div>\r\n        					</div>\r\n															        							<div class=\"row iteminfo\" id=\"117\">\r\n        							<div class=\"offerCell\" id=\"iname\">another</div>\r\n            						<div class=\"offerCell\" id=\"iprice\">$2.38 / bunch</div>\r\n            						<div class=\"offerCell qtyColumn\">1</div>\r\n            						<div class=\"offerCell\" id=\"itotal\">$2.38</div> \r\n       								</div>\r\n																							        							<div class=\"row iteminfo\" id=\"116\">\r\n        							<div class=\"offerCell\" id=\"iname\">new item</div>\r\n            						<div class=\"offerCell\" id=\"iprice\">$4.99 / bottle</div>\r\n            						<div class=\"offerCell qtyColumn\">20</div>\r\n            						<div class=\"offerCell\" id=\"itotal\">$99.8</div> \r\n       								</div>\r\n															        					<div class=\"row\"> \r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n        					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            				<div class=\"offerCellAmount\">&nbsp;</div>\r\n        					</div>\r\n        					<div class=\"row\">\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCellTotal\">\r\n            						Discount (%)\r\n            					</div>\r\n            					<div class=\"offerCellAmount\" id=\"discount\">8.66</div>\r\n        					</div>\r\n        					<div class=\"row\">\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCell\">&nbsp;</div>\r\n            					<div class=\"offerFooterCellTotal\">\r\n                 					Grand Total ($)\r\n            					</div>\r\n            					<div class=\"offerCellAmount\" id=\"grandtotal\">93.33</div>\r\n        					</div>\r\n							<br>\r\n						</div>\r\n                    </div>\r\n             	</div>\r\n			</div>\r\n	</body>\r\n</html>','2012-11-25 12:45:00','2012-11-25 12:44:44'),
 (143,1,'mailer@upmile.com','kirill.avramenko@gmail.com','Order Cancellation Notification','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\r\n<html>\r\n    <head>\r\n		<title>Order Cancellation</title>\r\n		<link rel=\"stylesheet\" type=\"text/css\" href=\"http://localhost:8080/static/css/email.css\"/>\r\n	</head>		\r\n	<body>\r\n			<div class=\"text\">\r\n				Hello kir!</br>\r\n				Your order placed on offer1 offer has been cancelled. \r\n            </div>\r\n            </br>\r\n			<div style=\"display: table;\">\r\n				<div class=\"row\">\r\n		    		<div class=\"cell paragraph\">\r\n						Offer Details\r\n		    		</div>\r\n		    		<div class=\"cell\"></div>	\r\n				</div>\r\n				<div class=\"row\">\r\n		    		<div class=\"cell label\">\r\n						Merchant:\r\n		    		</div>\r\n		    		<div class=\"cell labeltext\">\r\n							green farms from bay area\r\n					</div>	\r\n				</div>\r\n				<div class=\"row\">\r\n		    		<div class=\"cell label\">\r\n						Order Pickup:\r\n		    		</div>\r\n		    		<div class=\"cell labeltext\">\r\n                            	<div class=\"row\">\r\n                                	<div class=\"offerHeaderTextCell\" id=\"pickup_time\">\r\n										                                		                                			8 am - 8 am, June 4 - June 8\r\n                                		                                	</div>\r\n                            	</div>\r\n                            	<div class=\"row\">\r\n                                	<div class=\"offerHeaderTextCell\" id=\"pickup_name\">\r\n                                		\r\n                                	</div>\r\n                            	</div>\r\n                            	<div class=\"row\">\r\n                                	<div class=\"offerHeaderTextCell\" id=\"pickup_address\">\r\n                                		1 market</br>\r\n                                		san francisco ca 94103\r\n                                	</div>\r\n                            	</div>\r\n                            						</div>	\r\n		</div>\r\n		<div class=\"row\">\r\n			&nbsp;	\r\n		</div>\r\n		<div class=\"row\">\r\n		    <div class=\"cell paragraph\">\r\n			Your Order\r\n		    </div>\r\n		    <div class=\"cell\"></div>		\r\n		</div>\r\n	</div>\r\n	</br>\r\n    <div id=\"itemsTbl\">\r\n    	<div class=\"row\">\r\n        	<div class=\"itemHeaderCell itemname\">\r\n            	Name\r\n            </div>\r\n            <div class=\"itemHeaderCell itemprice\">\r\n            	Price\r\n            </div>\r\n            <div class=\"itemHeaderCell itemqty\">\r\n                Order Qty\r\n            </div>\r\n            <div class=\"itemHeaderCell itemtotal\">\r\n                Total\r\n            </div>\r\n        </div>\r\n					        <div class=\"row iteminfo\" id=\"117\">\r\n        	<div class=\"offerCell\" id=\"iname\">another</div>\r\n            <div class=\"offerCell\" id=\"iprice\">$2.38 / bunch</div>\r\n            <div class=\"offerCell qtyColumn\">20</div>\r\n            <div class=\"offerCell\" id=\"itotal\">$278.46</div> \r\n       	</div>\r\n								        <div class=\"row iteminfo\" id=\"116\">\r\n        	<div class=\"offerCell\" id=\"iname\">new item</div>\r\n            <div class=\"offerCell\" id=\"iprice\">$4.99 / bottle</div>\r\n            <div class=\"offerCell qtyColumn\">40</div>\r\n            <div class=\"offerCell\" id=\"itotal\">$578.84</div> \r\n       	</div>\r\n					        <div class=\"row\"> \r\n        	<div class=\"offerFooterCell\">&nbsp;</div>\r\n        	<div class=\"offerFooterCell\">&nbsp;</div>\r\n        	<div class=\"offerFooterCell\">&nbsp;</div>\r\n            <div class=\"offerCellAmount\">&nbsp;</div>\r\n        </div>\r\n        <div class=\"row\">\r\n            <div class=\"offerFooterCell\">&nbsp;</div>\r\n            <div class=\"offerFooterCell\">&nbsp;</div>\r\n            <div class=\"offerFooterCellTotal\">\r\n            	Discount (%)\r\n            </div>\r\n            <div class=\"offerCellAmount\" id=\"discount\">8.66</div>\r\n        </div>\r\n        <div class=\"row\">\r\n            <div class=\"offerFooterCell\">&nbsp;</div>\r\n            <div class=\"offerFooterCell\">&nbsp;</div>\r\n            <div class=\"offerFooterCellTotal\">\r\n                 Grand Total ($)\r\n            </div>\r\n            <div class=\"offerCellAmount\" id=\"grandtotal\">225.8</div>\r\n        </div>\r\n		<br>\r\n	</div>\r\n</div>\r\n</body>\r\n</html>','2012-11-25 21:21:00','2012-11-25 21:03:53'),
 (144,1,'kirill_avramenko@yahoo.com','kirill_avramenko@yahoo.com','offer1','kirill_avramenko@yahoo.com wants to share this offer with you:\r\n\r\n\r\nOffer:\r\noffer1\r\nhttp://localhost:8080/offer/69','2012-11-25 21:30:00','2012-11-25 21:16:57'),
 (145,1,'kirill_avramenko@yahoo.com','kirill_avramenko@yahoo.com','offer1','<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<html>\r\n<head>\r\n</head>\r\n<body>\r\nkirill_avramenko@yahoo.com wants to share this offer with you:\r\n&nbsp;\r\nPersonal Message:\r\nGreat offer!\r\n&nbsp;\r\nOffer:\r\n&nbsp;\r\noffer1\r\n&nbsp;\r\nhttp://localhost:8080/offer/69\r\n</body>\r\n</html>','2012-11-25 21:41:00','2012-11-25 21:37:33'),
 (146,1,'kirill_avramenko@yahoo.com','kirill_avramenko@yahoo.com','offer1','<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<html>\r\n<head>\r\n</head>\r\n<body>\r\nkirill_avramenko@yahoo.com wants to share this offer with you:\r\n&nbsp;\r\n&nbsp;\r\nOffer:\r\n&nbsp;\r\noffer1\r\n&nbsp;\r\nhttp://localhost:8080/offer/69\r\n</body>\r\n</html>','2012-11-25 22:13:00','2012-11-25 22:13:33'),
 (147,1,'kirill_avramenko@yahoo.com','kirill_avramenko@yahoo.com','offer1','<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<html>\r\n<head>\r\n</head>\r\n<body>\r\nkirill_avramenko@yahoo.com wants to share this offer with you:\r\n&nbsp;\r\n&nbsp;\r\nOffer:\r\n&nbsp;\r\noffer1\r\n&nbsp;\r\nhttp://localhost:8080/offer/69\r\n</body>\r\n</html>','2012-11-25 22:24:00','2012-11-25 22:24:36'),
 (148,1,'mailer@upmile.com','kirill_avramenko@yahoo.com','Umpile.com New Order Notification','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\r\n<html>\r\n    <head>\r\n        <title>New Order</title>\r\n        <link rel=\"stylesheet\" type=\"text/css\" href=\"http://$domain/static/css/email.css\"/>\r\n    </head>\r\n    <body>\r\n        <div class=\"emailtext\">\r\n            <div class=\"text\">\r\n                Hello kirill!\r\n                <br/>\r\n                You have a new order placed on your offer <a href=\"http://$domain/myoffers\">offer1.</a>\r\n                <br/>\r\n            </div>\r\n            <br/>\r\n            <div sclass=\"table\">\r\n                <div class=\"row\">\r\n                    <div class=\"cell header paragraph\">\r\n                        Customer:\r\n                    </div>\r\n                    <div class=\"cell\">\r\n                        kirill avr\r\n                    </div>\r\n                </div>\r\n            </div>\r\n            <div class=\"row\">\r\n                <div class=\"cell\">\r\n                    Order Items\r\n                </div>\r\n                <div class=\"cell\">\r\n                    &nbsp;\r\n                </div>\r\n            </div>\r\n            <div class=\"row\">\r\n                <div class=\"cell\">\r\n                    <div id=\"itemsTbl\">\r\n                        <div class=\"row\">\r\n                            <div class=\"itemHeaderCell itemname\">\r\n                                Name\r\n                            </div>\r\n                            <div class=\"itemHeaderCell itemprice\">\r\n                                Price\r\n                            </div>\r\n                            <div class=\"itemHeaderCell itemqty\">\r\n                                Order Qty\r\n                            </div>\r\n                            <div class=\"itemHeaderCell itemtotal\">\r\n                                Total\r\n                            </div>\r\n                        </div>\r\n                                                                        <div class=\"row iteminfo\" id=\"117\">\r\n                            <div class=\"offerCell\" id=\"iname\">\r\n                                another\r\n                            </div>\r\n                            <div class=\"offerCell\" id=\"iprice\">\r\n                                $2.38 / bunch\r\n                            </div>\r\n                            <div class=\"offerCell qtyColumn\">\r\n                                20\r\n                            </div>\r\n                            <div class=\"offerCell\" id=\"itotal\">\r\n                                $47.6\r\n                            </div>\r\n                        </div>\r\n                                                                                                <div class=\"row iteminfo\" id=\"116\">\r\n                            <div class=\"offerCell\" id=\"iname\">\r\n                                new item\r\n                            </div>\r\n                            <div class=\"offerCell\" id=\"iprice\">\r\n                                $4.99 / bottle\r\n                            </div>\r\n                            <div class=\"offerCell qtyColumn\">\r\n                                40\r\n                            </div>\r\n                            <div class=\"offerCell\" id=\"itotal\">\r\n                                $199.6\r\n                            </div>\r\n                        </div>\r\n                                                                        <div class=\"row\">\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerCellAmount\">\r\n                                &nbsp;\r\n                            </div>\r\n                        </div>\r\n                        <div class=\"row\">\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCellTotal\">\r\n                                Discount (%)\r\n                            </div>\r\n                            <div class=\"offerCellAmount\" id=\"discount\">\r\n                                6.43\r\n                            </div>\r\n                        </div>\r\n                        <div class=\"row\">\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCellTotal\">\r\n                                Grand Total ($)\r\n                            </div>\r\n                            <div class=\"offerCellAmount\" id=\"grandtotal\">\r\n                                231.31\r\n                            </div>\r\n                        </div>\r\n                        <br>\r\n                    </div>\r\n                </div>\r\n                 <div class=\"cell\">\r\n                    &nbsp;\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </body>\r\n</html>','2012-11-28 22:37:00','2012-11-28 21:06:56'),
 (149,1,'mailer@upmile.com','kirill_avramenko@yahoo.com','Upmile.com Order Cancellation','<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\r\n<html>\r\n    <head>\r\n        <title>Order Cancellation</title>\r\n        <link rel=\"stylesheet\" type=\"text/css\" href=\"http://$domain/static/css/email.css\"/>\r\n    </head>\r\n    <body>\r\n        <div class=\"emailtext\">\r\n            <div class=\"text\">\r\n                Hello kirill!\r\n                <br/><br/>\r\n                The order placed on your offer <a href=\"http://$domain/myoffers\">offer1</a> has been cancelled by customer.<br/>\r\n            </div>\r\n            <div class=\"table\">\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        Customer:\r\n                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\r\n                        kirill avr\r\n                    </div>\r\n                </div>\r\n            </div>\r\n            <div class=\"row\">\r\n                <div class=\"cell header paragraph\">\r\n                    Order Items\r\n                </div>\r\n            </div>\r\n            <div class=\"row\">\r\n                <div class=\"cell\">\r\n                    <div id=\"itemsTbl\">\r\n                        <div class=\"row\">\r\n                            <div class=\"itemHeaderCell itemname\">\r\n                                Name\r\n                            </div>\r\n                            <div class=\"itemHeaderCell itemprice\">\r\n                                Price\r\n                            </div>\r\n                            <div class=\"itemHeaderCell itemqty\">\r\n                                Order Qty\r\n                            </div>\r\n                            <div class=\"itemHeaderCell itemtotal\">\r\n                                Total\r\n                            </div>\r\n                        </div>\r\n                                                                        <div class=\"row iteminfo\" id=\"117\">\r\n                            <div class=\"offerCell\" id=\"iname\">\r\n                                another\r\n                            </div>\r\n                            <div class=\"offerCell\" id=\"iprice\">\r\n                                $2.38 / bunch\r\n                            </div>\r\n                            <div class=\"offerCell qtyColumn\">\r\n                                20\r\n                            </div>\r\n                            <div class=\"offerCell\" id=\"itotal\">\r\n                                $47.6\r\n                            </div>\r\n                        </div>\r\n                                                                                                <div class=\"row iteminfo\" id=\"116\">\r\n                            <div class=\"offerCell\" id=\"iname\">\r\n                                new item\r\n                            </div>\r\n                            <div class=\"offerCell\" id=\"iprice\">\r\n                                $4.99 / bottle\r\n                            </div>\r\n                            <div class=\"offerCell qtyColumn\">\r\n                                40\r\n                            </div>\r\n                            <div class=\"offerCell\" id=\"itotal\">\r\n                                $199.6\r\n                            </div>\r\n                        </div>\r\n                                                                        <div class=\"row\">\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerCellAmount noRightBorder\">\r\n                                &nbsp;\r\n                            </div>\r\n                        </div>\r\n                        <div class=\"row\">\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCellTotal\">\r\n                                Discount (%)\r\n                            </div>\r\n                            <div class=\"offerCellAmount\" id=\"discount\">\r\n                                6.43\r\n                            </div>\r\n                        </div>\r\n                        <div class=\"row\">\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCell\">\r\n                                &nbsp;\r\n                            </div>\r\n                            <div class=\"offerFooterCellTotal\">\r\n                                Grand Total ($)\r\n                            </div>\r\n                            <div class=\"offerCellAmount\" id=\"grandtotal\">\r\n                                231.31\r\n                            </div>\r\n                        </div>\r\n                        <br>\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </body>\r\n</html>',NULL,'2012-11-30 16:48:56'),
 (150,1,'mailer@upmile.com','kir@test.com','Upmile.com Account Email Confirmation','<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<html>\r\n    <head>\r\n        <title >Upmile.com Account Confirmation</title>\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <link rel=\"stylesheet\" type=\"text/css\" href=\"http://localhost:8080/static/css/email.css\"/>\r\n    </head>\r\n    <body>\r\n        <div class=\"emailtext\">\r\n            <div class=\"table\">\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        Hello!\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:5px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        We wanted to confirm that you created account on www.upmile.com and you own this email address: <label>kir@test.com</label>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:10px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        If you created your account on www.upmile.com and you own this email address. Please click on this link:\r\n                        <a href=\"http://localhost:8080/authorize/3b7b9c7e-b924-467e-9cb0-043cee76050b/345/0\">Yes, I confirm. </a>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:10px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        If you didn\'t create your account on www.upmile.com Please click on the link below and we\'ll remove that account from the system.\r\n                        <a href=\"http://localhost:8080/authorize/3b7b9c7e-b924-467e-9cb0-043cee76050b/345/1\">No, I didn\'t create account.</a>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:15px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        Thanks,\r\n                        <br>\r\n                        Upmile.com\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </body>\r\n</html>','2013-01-15 21:35:00','2012-12-27 14:09:28'),
 (151,1,'mailer@upmile.com','kir2@test.com','Upmile.com Account Email Confirmation','<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<html>\r\n    <head>\r\n        <title >Upmile.com Account Confirmation</title>\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <link rel=\"stylesheet\" type=\"text/css\" href=\"http://localhost:8080/static/css/email.css\"/>\r\n    </head>\r\n    <body>\r\n        <div class=\"emailtext\">\r\n            <div class=\"table\">\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        Hello!\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:5px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        We wanted to confirm that you created account on www.upmile.com and you own this email address: <label>kir2@test.com</label>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:10px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        If you created your account on www.upmile.com and you own this email address. Please click on this link:\r\n                        <a href=\"http://localhost:8080/authorize/1b21a1e6-6930-49e7-8b18-34f50d28ff27/346/0\">Yes, I confirm. </a>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:10px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        If you didn\'t create your account on www.upmile.com Please click on the link below and we\'ll remove that account from the system.\r\n                        <a href=\"http://localhost:8080/authorize/1b21a1e6-6930-49e7-8b18-34f50d28ff27/346/1\">No, I didn\'t create account.</a>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:15px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        Thanks,\r\n                        <br>\r\n                        Upmile.com\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </body>\r\n</html>','2013-01-15 21:35:00','2012-12-27 14:16:56'),
 (152,1,'mailer@upmile.com','kir3@test.com','Upmile.com Account Email Confirmation','<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<html>\r\n    <head>\r\n        <title >Upmile.com Account Confirmation</title>\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <link rel=\"stylesheet\" type=\"text/css\" href=\"http://localhost:8080/static/css/email.css\"/>\r\n    </head>\r\n    <body>\r\n        <div class=\"emailtext\">\r\n            <div class=\"table\">\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        Hello!\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:5px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        We wanted to confirm that you created account on www.upmile.com and you own this email address: <label>kir3@test.com</label>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:10px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        If you created your account on www.upmile.com and you own this email address. Please click on this link:\r\n                        <a href=\"http://localhost:8080/authorize/70a069d0-7ab7-4024-ae87-5bca47031d22/347/0\">Yes, I confirm. </a>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:10px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        If you didn\'t create your account on www.upmile.com Please click on the link below and we\'ll remove that account from the system.\r\n                        <a href=\"http://localhost:8080/authorize/70a069d0-7ab7-4024-ae87-5bca47031d22/347/1\">No, I didn\'t create account.</a>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:15px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        Thanks,\r\n                        <br>\r\n                        Upmile.com\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </body>\r\n</html>','2013-01-15 21:35:00','2012-12-27 14:35:07'),
 (153,1,'mailer@upmile.com','kir55@test.com','Upmile.com Account Email Confirmation','<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<html>\r\n    <head>\r\n        <title >Upmile.com Account Confirmation</title>\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <link rel=\"stylesheet\" type=\"text/css\" href=\"http://localhost:8080/static/css/email.css\"/>\r\n    </head>\r\n    <body>\r\n        <div class=\"emailtext\">\r\n            <div class=\"table\">\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        Hello!\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:5px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        We wanted to confirm that you created account on www.upmile.com and you own this email address: <label>kir55@test.com</label>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:10px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        If you created your account on www.upmile.com and you own this email address. Please click on this link:\r\n                        <a href=\"http://localhost:8080/authorize/47abe276-4268-451a-9f02-17ef62d412b5/348/0\">Yes, I confirm. </a>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:10px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        If you didn\'t create your account on www.upmile.com Please click on the link below and we\'ll remove that account from the system.\r\n                        <a href=\"http://localhost:8080/authorize/47abe276-4268-451a-9f02-17ef62d412b5/348/1\">No, I didn\'t create account.</a>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:15px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        Thanks,\r\n                        <br>\r\n                        Upmile.com\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </body>\r\n</html>','2013-01-15 21:35:00','2012-12-27 15:11:42'),
 (154,1,'mailer@upmile.com','kir7@test.com','Upmile.com Account Email Confirmation','<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\r\n<html>\r\n    <head>\r\n        <title >Upmile.com Account Confirmation</title>\r\n        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n        <link rel=\"stylesheet\" type=\"text/css\" href=\"http://localhost:8080/static/css/email.css\"/>\r\n    </head>\r\n    <body>\r\n        <div class=\"emailtext\">\r\n            <div class=\"table\">\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        Hello!\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:5px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        We wanted to confirm that you created account on www.upmile.com and you own this email address: <label>kir7@test.com</label>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:10px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        If you created your account on www.upmile.com and you own this email address. Please click on this link:\r\n                        <a href=\"http://localhost:8080/authorize/00136786-736b-4320-8cc7-cc8ff512816c/349/0\">Yes, I confirm. </a>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:10px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        If you didn\'t create your account on www.upmile.com Please click on the link below and we\'ll remove that account from the system.\r\n                        <a href=\"http://localhost:8080/authorize/00136786-736b-4320-8cc7-cc8ff512816c/349/1\">No, I didn\'t create account.</a>\r\n                    </div>\r\n                </div>\r\n                <div class=\"row\" style=\"height:15px;line-height:1px;\">\r\n                    &nbsp;\r\n                </div>\r\n                <div class=\"row\">\r\n                    <div class=\"cell leftAlign\">\r\n                        Thanks,\r\n                        <br>\r\n                        Upmile.com\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </body>\r\n</html>','2013-01-15 21:35:00','2012-12-27 15:19:13');
/*!40000 ALTER TABLE `data_email` ENABLE KEYS */;


--
-- Definition of table `data_offer_items`
--

DROP TABLE IF EXISTS `data_offer_items`;
CREATE TABLE `data_offer_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `offer_id` bigint(20) unsigned NOT NULL,
  `status` int(10) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `price` double NOT NULL DEFAULT '0',
  `unit` varchar(15) NOT NULL,
  `total` int(10) unsigned NOT NULL,
  `ordered` int(10) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_offer_items`
--

/*!40000 ALTER TABLE `data_offer_items` DISABLE KEYS */;
INSERT INTO `data_offer_items` (`id`,`offer_id`,`status`,`name`,`description`,`price`,`unit`,`total`,`ordered`,`user_id`,`dt`) VALUES 
 (116,69,0,'Zinfandel','great wine',4.99,'bottle',63,0,77,'2012-12-11 17:48:17'),
 (117,69,0,'Parsley','fresh and organic',2.38,'bunch',22,0,77,'2012-12-11 17:48:17'),
 (118,70,0,'item1','descrrr',12.5,'bottle',44,0,77,'2012-09-18 15:35:31'),
 (119,71,0,'item10',NULL,12.99,'bunch',22,0,77,'2012-09-03 22:22:08'),
 (120,72,0,'peppers','green sweet peppers',3.99,'lb',50,0,77,'2012-10-13 23:02:29'),
 (121,72,0,'garlic','dry organic',5.99,'bunch',40,0,77,'2012-10-13 23:02:29'),
 (122,73,0,'i1','descr',3.55,'lb',45,0,77,'2012-09-13 17:13:05'),
 (123,74,0,'item1','descr',23.99,'lb',25,0,77,'2012-09-27 16:59:05'),
 (124,72,0,'apple','green',3.99,'lb',60,0,77,'2012-10-13 23:02:29');
/*!40000 ALTER TABLE `data_offer_items` ENABLE KEYS */;


--
-- Definition of table `data_offer_locations`
--

DROP TABLE IF EXISTS `data_offer_locations`;
CREATE TABLE `data_offer_locations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `offer_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `location_type` int(10) unsigned NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `state` varchar(5) DEFAULT NULL,
  `zip` varchar(5) DEFAULT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_offer_locations`
--

/*!40000 ALTER TABLE `data_offer_locations` DISABLE KEYS */;
INSERT INTO `data_offer_locations` (`id`,`offer_id`,`user_id`,`location_type`,`name`,`address`,`city`,`state`,`zip`,`latitude`,`longitude`,`dt`) VALUES 
 (34,69,77,0,NULL,'1 market','san francisco','ca','94103',37.774,-122.41,'2012-08-31 12:58:06'),
 (35,70,77,0,NULL,'1 market','san francisco','ca','94103',37.774,-122.41,'2012-09-03 21:48:41'),
 (36,71,77,0,NULL,'1 market','san francisco','ca','94103',37.774,-122.41,'2012-09-03 22:22:08'),
 (37,72,77,0,NULL,'1 market','san francisco','ca','94103',37.774,-122.41,'2012-09-13 13:05:02'),
 (38,73,77,0,NULL,'1 market','san francisco','ca','94103',37.774,-122.41,'2012-09-13 17:13:05'),
 (39,74,77,0,NULL,'1 market','san francisco','ca','94103',37.774,-122.41,'2012-09-27 16:59:05');
/*!40000 ALTER TABLE `data_offer_locations` ENABLE KEYS */;


--
-- Definition of table `data_offer_participants`
--

DROP TABLE IF EXISTS `data_offer_participants`;
CREATE TABLE `data_offer_participants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `offer_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `user_details` varchar(250) NOT NULL,
  `status` int(10) unsigned NOT NULL,
  `items` varchar(250) NOT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status_change_dt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `closed_discount` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_offer_participants`
--

/*!40000 ALTER TABLE `data_offer_participants` DISABLE KEYS */;
INSERT INTO `data_offer_participants` (`id`,`offer_id`,`user_id`,`user_details`,`status`,`items`,`dt`,`status_change_dt`,`closed_discount`) VALUES 
 (122,72,334,'{\"id\":\"334\",\"name\":\"john john\"}',2,'0000120|0000005^0000121|0000005^0000124|0000010','2012-10-13 23:01:40','2012-10-13 23:01:40',NULL),
 (123,72,338,'{\"id\":\"338\",\"name\":\"kirhotmail kirhotmail\"}',2,'0000120|0000015^0000121|0000005^0000124|0000010','2012-10-13 23:02:08','2012-10-13 23:02:08',NULL),
 (124,72,77,'{\"id\":\"77\",\"name\":\"kirill kirill\"}',2,'0000120|0000010^0000121|0000020^0000124|0000010','2012-10-13 23:02:29','2012-10-13 23:02:29',NULL),
 (125,69,77,'{\"id\":\"77\",\"name\":\"kirill kirill\"}',2,'0000116|0000023^0000117|0000010','2012-10-16 14:23:21','2012-10-16 14:23:21',NULL),
 (127,69,77,'{\"id\":\"77\",\"name\":\"kirill avr\"}',2,'0000116|0000010^0000117|0000010','2012-10-28 01:20:24','2012-10-28 01:20:24',NULL),
 (131,69,77,'{\"id\":\"77\",\"name\":\"kirill avr\"}',2,'0000116|0000020^0000117|0000010','2012-10-29 22:31:17','2012-10-29 22:31:17',NULL),
 (132,69,77,'{\"id\":\"77\",\"name\":\"kirill avr\"}',2,'0000116|0000010^0000117|0000020','2012-11-04 11:42:30','2012-11-04 11:42:30',NULL),
 (133,69,77,'{\"id\":\"77\",\"name\":\"kirill avr\"}',2,'0000116|0000020^0000117|0000010','2012-11-04 12:16:37','2012-11-04 12:16:37',NULL),
 (142,69,77,'{\"id\":\"77\",\"name\":\"kirill avr\"}',2,'0000116|0000030^0000117|0000020','2012-11-04 13:01:56','2012-11-04 13:01:56',NULL),
 (143,69,77,'{\"id\":\"77\",\"name\":\"kirill avr\"}',2,'0000116|0000050^0000117|0000020','2012-11-04 19:46:07','2012-11-04 19:46:07',NULL),
 (144,69,77,'{\"id\":\"77\",\"name\":\"kirill avr\"}',2,'0000116|0000040^0000117|0000020','2012-11-04 21:20:33','2012-11-04 21:20:33',NULL),
 (145,69,77,'{\"id\":\"77\",\"name\":\"kirill avr\"}',2,'0000116|0000030^0000117|0000020','2012-11-20 21:01:39','2012-11-20 21:01:39',NULL),
 (146,69,344,'{\"id\":\"344\",\"name\":\"kir gmail\"}',1,'0000116|0000040^0000117|0000020','2012-11-24 12:19:15','2012-11-24 12:19:15',NULL),
 (147,69,344,'{\"id\":\"344\",\"name\":\"kir gmail\"}',2,'0000116|0000030^0000117|0000020','2012-11-24 23:41:34','2012-11-24 23:41:34',NULL),
 (148,69,344,'{\"id\":\"344\",\"name\":\"kir gmail\"}',1,'0000116|0000039^0000117|0000022','2012-11-25 00:14:10','2012-11-25 00:14:10',NULL),
 (149,69,344,'{\"id\":\"344\",\"name\":\"kir gmail\"}',1,'0000116|0000045^0000117|0000020','2012-11-25 12:39:35','2012-11-25 12:39:35',NULL),
 (150,69,344,'{\"id\":\"344\",\"name\":\"kir gmail\"}',2,'0000116|0000040^0000117|0000020','2012-11-25 21:03:53','2012-11-25 21:03:53',NULL),
 (151,69,77,'{\"id\":\"77\",\"name\":\"kirill avr\"}',2,'0000116|0000020^0000117|0000001','2012-11-25 21:04:01','2012-11-25 21:04:01',NULL),
 (152,69,77,'{\"id\":\"77\",\"name\":\"kirill avr\"}',2,'0000116|0000040^0000117|0000020','2012-11-30 16:48:56','2012-11-30 16:48:56',NULL);
/*!40000 ALTER TABLE `data_offer_participants` ENABLE KEYS */;


--
-- Definition of table `data_offers`
--

DROP TABLE IF EXISTS `data_offers`;
CREATE TABLE `data_offers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `status` int(10) unsigned NOT NULL,
  `pickup_type` int(10) unsigned NOT NULL,
  `close_date` datetime NOT NULL,
  `discounts` varchar(100) DEFAULT NULL,
  `items` varchar(2000) DEFAULT NULL,
  `items_ordered` varchar(250) DEFAULT NULL,
  `di_type` int(10) unsigned NOT NULL,
  `total` int(10) unsigned NOT NULL,
  `total_ordered` int(10) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `biz_id` bigint(20) unsigned NOT NULL,
  `biz_name` varchar(250) NOT NULL,
  `pickup` varchar(1000) NOT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_offers`
--

/*!40000 ALTER TABLE `data_offers` DISABLE KEYS */;
INSERT INTO `data_offers` (`id`,`name`,`description`,`status`,`pickup_type`,`close_date`,`discounts`,`items`,`items_ordered`,`di_type`,`total`,`total_ordered`,`user_id`,`biz_id`,`biz_name`,`pickup`,`dt`) VALUES 
 (69,'Holiday Season Offer',NULL,1,2,'2012-12-30 12:00:00','{\"d0\":3,\"d25\":4.5,\"d100\":9,\"d75\":7.5,\"d50\":6}','[{\"id\":\"116\",\"total\":\"63\",\"unit\":\"bottle\",\"price\":\"4.99\",\"name\":\"Zinfandel\"},{\"id\":\"117\",\"total\":\"22\",\"unit\":\"bunch\",\"price\":\"2.38\",\"name\":\"Parsley\"}]','',1,85,0,77,26,'{\"logo\":\"1354164578607_tag2.jpg\",\"phone\":\"4153433343\",\"name\":\"green farms from bay area\"}','{\"dates\":{\"time\":{\"f\":\"08:00 am\",\"t\":\"08:00 am\"},\"ft\":\"8 am - 8 am, Jan 1 - 5 \'13\",\"type\":\"fd\",\"date\":{\"f\":\"01/01/2013\",\"t\":\"01/05/2013\"}},\"address\":\"1 market\",\"name\":\"\",\"zipcode\":\"94103\",\"state\":\"ca\",\"city\":\"san francisco\"}','2012-08-31 12:58:06'),
 (70,'offer2',NULL,3,2,'2012-09-05 12:00:00','{\"d0\":2,\"d25\":2.6,\"d100\":5,\"d75\":3.8,\"d50\":3.2}','[{\"id\":\"118\",\"total\":\"44\",\"unit\":\"bottle\",\"price\":\"12.5\",\"name\":\"item1\"}]','',1,44,0,77,26,'{\"logo\":\"1354164578607_tag2.jpg\",\"phone\":\"4153433343\",\"name\":\"green farms from bay area\"}','{\"dates\":{\"time\":{\"f\":\"08:00 am\",\"t\":\"12:00 pm\"},\"ft\":\"8 am - 12 pm, Aug 3 - 7 \'12\",\"type\":\"fd\",\"date\":{\"f\":\"8/3/2012\",\"t\":\"8/7/2012\"}},\"address\":\"1 market\",\"name\":\"\",\"zipcode\":\"94103\",\"state\":\"ca\",\"city\":\"san francisco\"}','2012-09-03 21:48:41'),
 (71,'offer3',NULL,3,1,'2012-09-14 12:00:00','{\"d0\":3,\"d25\":4,\"d100\":8,\"d75\":6,\"d50\":5}','[{\"id\":\"119\",\"total\":\"22\",\"unit\":\"bunch\",\"price\":\"12.99\",\"name\":\"item10\"}]',NULL,1,22,0,77,26,'{\"logo\":\"1354164578607_tag2.jpg\",\"phone\":\"4153433343\",\"name\":\"green farms from bay area\"}','{\"dates\":{\"dates\":[{\"to\":\"3 pm\",\"day\":\"Mon,Tue\",\"from\":\"8 am\"}],\"type\":\"wd\"},\"address\":\"1 market\",\"name\":\"\",\"zipcode\":\"94103\",\"state\":\"ca\",\"city\":\"san francisco\"}','2012-09-03 22:22:08'),
 (72,'test logo','amazing offer',3,2,'2012-10-31 12:00:00','{\"d0\":2,\"d25\":3.75,\"d100\":9,\"d75\":7.25,\"d50\":5.5}','[{\"id\":\"120\",\"total\":\"45\",\"unit\":\"lb\",\"price\":\"3.99\",\"name\":\"peppers\"},{\"id\":\"121\",\"total\":\"35\",\"unit\":\"bunch\",\"price\":\"5.99\",\"name\":\"garlic\"},{\"id\":\"124\",\"total\":\"50\",\"unit\":\"lb\",\"price\":\"3.99\",\"name\":\"apple\"}]','',1,130,0,77,26,'{\"logo\":\"1354164578607_tag2.jpg\",\"phone\":\"4153433343\",\"name\":\"green farms from bay area\"}','{\"dates\":{\"time\":{\"f\":\"12:00 pm\",\"t\":\"05:00 pm\"},\"ft\":\"12 pm - 5 pm, Oct 17 - 31 \'12\",\"type\":\"fd\",\"date\":{\"f\":\"10/17/2012\",\"t\":\"10/31/2012\"}},\"address\":\"1 market\",\"name\":\"\",\"zipcode\":\"94103\",\"state\":\"ca\",\"note\":\"Just come to my shop\",\"city\":\"san francisco\"}','2012-09-13 13:05:02'),
 (73,'test close date',NULL,3,2,'2012-09-13 12:00:00','{\"d0\":3,\"d25\":4.75,\"d100\":10,\"d75\":8.25,\"d50\":6.5}','[{\"id\":\"122\",\"total\":\"45\",\"unit\":\"lb\",\"price\":\"3.55\",\"name\":\"i1\"}]',NULL,1,45,0,77,26,'{\"logo\":\"1354164578607_tag2.jpg\",\"phone\":\"4153433343\",\"name\":\"green farms from bay area\"}','{\"dates\":{\"time\":{\"f\":\"08:00 am\",\"t\":\"03:00 pm\"},\"ft\":\"8 am - 3 pm, Oct 1 - 31 \'12\",\"type\":\"fd\",\"date\":{\"f\":\"10/01/2012\",\"t\":\"10/31/2012\"}},\"address\":\"1 market\",\"name\":\"\",\"zipcode\":\"94103\",\"state\":\"ca\",\"city\":\"san francisco\"}','2012-09-13 17:13:05'),
 (74,'test offer','offer descr',3,1,'2012-10-18 12:00:00','{\"d0\":3,\"d25\":4.5,\"d100\":9,\"d75\":7.5,\"d50\":6}','[{\"id\":\"123\",\"total\":\"25\",\"unit\":\"lb\",\"price\":\"23.99\",\"name\":\"item1\"}]',NULL,1,25,0,77,26,'{\"logo\":\"1354164578607_tag2.jpg\",\"phone\":\"4153433343\",\"name\":\"green farms from bay area\"}','{\"dates\":{\"time\":{\"f\":\"08:00 am\",\"t\":\"03:00 pm\"},\"ft\":\"8 am - 3 pm, Nov 13 - 29 \'12\",\"type\":\"fd\",\"date\":{\"f\":\"11/13/2012\",\"t\":\"11/29/2012\"}},\"address\":\"1 market\",\"name\":\"\",\"zipcode\":\"94103\",\"state\":\"ca\",\"city\":\"san francisco\"}','2012-09-27 16:59:05');
/*!40000 ALTER TABLE `data_offers` ENABLE KEYS */;


--
-- Definition of table `data_state_zipcodes`
--

DROP TABLE IF EXISTS `data_state_zipcodes`;
CREATE TABLE `data_state_zipcodes` (
  `zipcode` varchar(5) NOT NULL,
  `city` varchar(70) DEFAULT NULL,
  `state` varchar(5) NOT NULL,
  `area_code` varchar(10) DEFAULT NULL,
  `city_alias_name` varchar(70) DEFAULT NULL,
  `city_alias_abbr` varchar(45) DEFAULT NULL,
  `city_type` varchar(5) DEFAULT NULL,
  `county_name` varchar(70) DEFAULT NULL,
  `state_fips` int(10) unsigned DEFAULT NULL,
  `county_fips` int(10) unsigned DEFAULT NULL,
  `time_zone` int(10) unsigned DEFAULT NULL,
  `day_light_saving` varchar(5) DEFAULT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  `elevation` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_state_zipcodes`
--

/*!40000 ALTER TABLE `data_state_zipcodes` DISABLE KEYS */;
INSERT INTO `data_state_zipcodes` (`zipcode`,`city`,`state`,`area_code`,`city_alias_name`,`city_alias_abbr`,`city_type`,`county_name`,`state_fips`,`county_fips`,`time_zone`,`day_light_saving`,`latitude`,`longitude`,`elevation`) VALUES 
 ('94002','BELMONT','CA','650','BELMONT',NULL,'P','SAN MATEO',6,81,8,'Y',37.5173,-122.295,175),
 ('94005','BRISBANE','CA','415/650','BRISBANE',NULL,'P','SAN MATEO',6,81,8,'Y',37.6889,-122.405,18),
 ('94010','BURLINGAME','CA','650','BURLINGAME',NULL,'P','SAN MATEO',6,81,8,'Y',37.567,-122.366,227),
 ('94010','BURLINGAME','CA','650','HILLSBOROUGH',NULL,'N','SAN MATEO',6,81,8,'Y',37.567,-122.366,227),
 ('94011','BURLINGAME','CA','650','BURLINGAME',NULL,'P','SAN MATEO',6,81,8,'Y',37.5776,-122.345,36),
 ('94013','DALY `city`','CA','650','DALY `city`',NULL,'P','SAN MATEO',6,81,8,'Y',37.7203,-122.526,15),
 ('94013','DALY `city`','CA','650','SF INTERNATIONAL SERVICE CTR',NULL,'O','SAN MATEO',6,81,8,'Y',37.7203,-122.526,15),
 ('94014','DALY `city`','CA','650','COLMA',NULL,'N','SAN MATEO',6,81,8,'Y',37.6895,-122.439,1104),
 ('94014','DALY `city`','CA','650','DALY `city`',NULL,'P','SAN MATEO',6,81,8,'Y',37.6895,-122.439,1104),
 ('94015','DALY `city`','CA','650','DALY `city`',NULL,'P','SAN MATEO',6,81,8,'Y',37.6765,-122.482,283),
 ('94015','DALY `city`','CA','650','BROADMOOR VLG',NULL,'N','SAN MATEO',6,81,8,'Y',37.6765,-122.482,283),
 ('94016','DALY `city`','CA','650','DALY `city`',NULL,'P','SAN MATEO',6,81,8,'Y',37.7075,-122.454,348),
 ('94017','DALY `city`','CA','650','DALY `city`',NULL,'P','SAN MATEO',6,81,8,'Y',37.6921,-122.471,176),
 ('94018','EL GRANADA','CA','650','EL GRANADA',NULL,'P','SAN MATEO',6,81,8,'Y',37.505,-122.471,77),
 ('94019','HALF MOON BAY','CA','650','HALF MOON BAY',NULL,'P','SAN MATEO',6,81,8,'Y',37.48,-122.331,467),
 ('94019','HALF MOON BAY','CA','650','PRINCETON BY THE SEA',NULL,'O','SAN MATEO',6,81,8,'Y',37.48,-122.331,467),
 ('94020','LA HONDA','CA','650','LA HONDA',NULL,'P','SAN MATEO',6,81,8,'Y',37.2841,-122.227,924),
 ('94021','LOMA MAR','CA','650','LOMA MAR',NULL,'P','SAN MATEO',6,81,8,'Y',37.2415,-122.256,1355),
 ('94022','LOS ALTOS','CA','650','LOS ALTOS',NULL,'P','SANTA CLARA',6,85,8,'Y',37.3666,-122.137,400),
 ('94022','LOS ALTOS','CA','650','LOS ALTOS HILLS','LOS ALTOS','N','SANTA CLARA',6,85,8,'Y',37.3666,-122.137,400),
 ('94023','LOS ALTOS','CA','650','LOS ALTOS',NULL,'P','SANTA CLARA',6,85,8,'Y',37.3741,-122.115,216),
 ('94024','LOS ALTOS','CA','650','LOS ALTOS',NULL,'P','SANTA CLARA',6,85,8,'Y',37.3528,-122.088,232),
 ('94024','LOS ALTOS','CA','650','LOS ALTOS HILLS','LOS ALTOS','N','SANTA CLARA',6,85,8,'Y',37.3528,-122.088,232),
 ('94025','MENLO PARK','CA','650','MENLO PARK',NULL,'P','SAN MATEO',6,81,8,'Y',37.4369,-122.194,104),
 ('94025','MENLO PARK','CA','650','W MENLO PARK',NULL,'N','SAN MATEO',6,81,8,'Y',37.4369,-122.194,104),
 ('94025','MENLO PARK','CA','650','WEST MENLO PARK','W MENLO PARK','N','SAN MATEO',6,81,8,'Y',37.4369,-122.194,104),
 ('94026','MENLO PARK','CA','650','MENLO PARK',NULL,'P','SAN MATEO',6,81,8,'Y',37.4783,-122.182,22),
 ('94026','MENLO PARK','CA','650','WEST MENLO PARK',NULL,'O','SAN MATEO',6,81,8,'Y',37.4783,-122.182,22),
 ('94027','ATHERTON','CA','650','MENLO PARK',NULL,'N','SAN MATEO',6,81,8,'Y',37.4584,-122.198,63),
 ('94027','ATHERTON','CA','650','ATHERTON',NULL,'P','SAN MATEO',6,81,8,'Y',37.4584,-122.198,63),
 ('94028','PORTOLA VALLEY','CA','650','MENLO PARK',NULL,'N','SAN MATEO',6,81,8,'Y',37.3804,-122.211,558),
 ('94028','PORTOLA VALLEY','CA','650','MENLO PK',NULL,'O','SAN MATEO',6,81,8,'Y',37.3804,-122.211,558),
 ('94028','PORTOLA VALLEY','CA','650','PORTOLA VALLEY','PORTOLA VALLY','P','SAN MATEO',6,81,8,'Y',37.3804,-122.211,558),
 ('94028','PORTOLA VALLEY','CA','650','PORTOLA VALLY',NULL,'N','SAN MATEO',6,81,8,'Y',37.3804,-122.211,558),
 ('94030','MILLBRAE','CA','650','MILLBRAE',NULL,'P','SAN MATEO',6,81,8,'Y',37.5998,-122.401,94),
 ('94035','MOUNTAIN VIEW','CA','650','MOFFETT FIELD',NULL,'N','SANTA CLARA',6,85,8,'Y',37.411,-122.053,22),
 ('94035','MOUNTAIN VIEW','CA','650','MOFFETT FIELD NAS',NULL,'O','SANTA CLARA',6,85,8,'Y',37.411,-122.053,22),
 ('94035','MOUNTAIN VIEW','CA','650','MOUNTAIN VIEW',NULL,'P','SANTA CLARA',6,85,8,'Y',37.411,-122.053,22),
 ('94037','MONTARA','CA','650','MONTARA',NULL,'P','SAN MATEO',6,81,8,'Y',37.5409,-122.506,169),
 ('94038','MOSS BEACH','CA','650','MOSS BEACH',NULL,'P','SAN MATEO',6,81,8,'Y',37.5473,-122.498,453),
 ('94039','MOUNTAIN VIEW','CA','650','MOUNTAIN VIEW',NULL,'P','SANTA CLARA',6,85,8,'Y',37.3931,-122.077,78),
 ('94040','MOUNTAIN VIEW','CA','650','BLOSSOM VALLEY',NULL,'O','SANTA CLARA',6,85,8,'Y',37.378,-122.082,125),
 ('94040','MOUNTAIN VIEW','CA','650','MOUNTAIN VIEW',NULL,'P','SANTA CLARA',6,85,8,'Y',37.378,-122.082,125),
 ('94040','MOUNTAIN VIEW','CA','650','MT VIEW',NULL,'O','SANTA CLARA',6,85,8,'Y',37.378,-122.082,125),
 ('94041','MOUNTAIN VIEW','CA','650','MOUNTAIN VIEW',NULL,'P','SANTA CLARA',6,85,8,'Y',37.3886,-122.075,94),
 ('94042','MOUNTAIN VIEW','CA','650','MOUNTAIN VIEW',NULL,'P','SANTA CLARA',6,85,8,'Y',37.4093,-122.089,34),
 ('94043','MOUNTAIN VIEW','CA','650','MOUNTAIN VIEW',NULL,'P','SANTA CLARA',6,85,8,'Y',37.406,-122.079,43),
 ('94044','PACIFICA','CA','650','PACIFICA',NULL,'P','SAN MATEO',6,81,8,'Y',37.6019,-122.486,253),
 ('94044','PACIFICA','CA','650','SHARP PARK',NULL,'O','SAN MATEO',6,81,8,'Y',37.6019,-122.486,253),
 ('94060','PESCADERO','CA','650','PESCADERO',NULL,'P','SAN MATEO',6,81,8,'Y',37.2086,-122.381,446),
 ('94061','REDWOOD `city`','CA','650','REDWOOD `city`',NULL,'P','SAN MATEO',6,81,8,'Y',37.4629,-122.233,53),
 ('94061','REDWOOD `city`','CA','650','WOODSIDE',NULL,'N','SAN MATEO',6,81,8,'Y',37.4629,-122.233,53),
 ('94062','REDWOOD `city`','CA','650','REDWOOD `city`',NULL,'P','SAN MATEO',6,81,8,'Y',37.4483,-122.269,652),
 ('94062','REDWOOD `city`','CA','650','WOODSIDE',NULL,'N','SAN MATEO',6,81,8,'Y',37.4483,-122.269,652),
 ('94062','REDWOOD `city`','CA','650','EMERALD HILLS',NULL,'N','SAN MATEO',6,81,8,'Y',37.4483,-122.269,652),
 ('94062','REDWOOD `city`','CA','650','PALOMAR PARK',NULL,'N','SAN MATEO',6,81,8,'Y',37.4483,-122.269,652),
 ('94063','REDWOOD `city`','CA','650','REDWOOD `city`',NULL,'P','SAN MATEO',6,81,8,'Y',37.4915,-122.204,15),
 ('94064','REDWOOD `city`','CA','650','REDWOOD `city`',NULL,'P','SAN MATEO',6,81,8,'Y',37.4634,-122.255,242),
 ('94065','REDWOOD `city`','CA','650','REDWOOD `city`',NULL,'P','SAN MATEO',6,81,8,'Y',37.5324,-122.249,6),
 ('94066','SAN BRUNO','CA','650','SAN BRUNO',NULL,'P','SAN MATEO',6,81,8,'Y',37.625,-122.431,340),
 ('94070','SAN CARLOS','CA','650','SAN CARLOS',NULL,'P','SAN MATEO',6,81,8,'Y',37.4962,-122.272,287),
 ('94074','SAN GREGORIO','CA','650','SAN GREGORIO',NULL,'P','SAN MATEO',6,81,8,'Y',37.2974,-122.365,757),
 ('94080','SOUTH SAN FRANCISCO','CA','650','S SAN FRAN',NULL,'N','SAN MATEO',6,81,8,'Y',37.6524,-122.43,46),
 ('94080','SOUTH SAN FRANCISCO','CA','650','S SAN FRANCISCO',NULL,'O','SAN MATEO',6,81,8,'Y',37.6524,-122.43,46),
 ('94080','SOUTH SAN FRANCISCO','CA','650','SOUTH SAN FRANCISCO','S SAN FRAN','P','SAN MATEO',6,81,8,'Y',37.6524,-122.43,46),
 ('94080','SOUTH SAN FRANCISCO','CA','650','SSF',NULL,'O','SAN MATEO',6,81,8,'Y',37.6524,-122.43,46),
 ('94083','SOUTH SAN FRANCISCO','CA','650','S SAN FRAN',NULL,'N','SAN MATEO',6,81,8,'Y',37.645,-122.412,20),
 ('94083','SOUTH SAN FRANCISCO','CA','650','SOUTH SAN FRANCISCO','S SAN FRAN','P','SAN MATEO',6,81,8,'Y',37.645,-122.412,20),
 ('94083','SOUTH SAN FRANCISCO','CA','650','SOUTH SAN FRANCIS',NULL,'O','SAN MATEO',6,81,8,'Y',37.645,-122.412,20),
 ('94085','SUNNYVALE','CA','408/510/65','SUNNYVALE',NULL,'P','SANTA CLARA',6,85,8,'Y',37.3689,-122.035,124),
 ('94086','SUNNYVALE','CA','408/510','SUNNYVALE',NULL,'P','SANTA CLARA',6,85,8,'Y',37.3761,-122.022,84),
 ('94087','SUNNYVALE','CA','408','SUNNYVALE',NULL,'P','SANTA CLARA',6,85,8,'Y',37.3502,-122.032,173),
 ('94088','SUNNYVALE','CA','408','SUNNYVALE',NULL,'P','SANTA CLARA',6,85,8,'Y',37.3932,-122.037,57),
 ('94088','SUNNYVALE','CA','408','ONIZUKA AFB',NULL,'N','SANTA CLARA',6,85,8,'Y',37.3932,-122.037,57),
 ('94089','SUNNYVALE','CA','408/650','SUNNYVALE',NULL,'P','SANTA CLARA',6,85,8,'Y',37.4012,-122.008,16),
 ('94101','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.775,-122.418,51),
 ('94102','SAN FRANCISCO','CA','415/510','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7798,-122.417,64),
 ('94103','SAN FRANCISCO','CA','415/510/65','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.774,-122.41,29),
 ('94104','SAN FRANCISCO','CA','415/510/65','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7913,-122.401,23),
 ('94105','SAN FRANCISCO','CA','415/510/65','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7885,-122.395,25),
 ('94107','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7757,-122.395,10),
 ('94108','SAN FRANCISCO','CA','415/510/65','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.792,-122.407,151),
 ('94109','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7935,-122.419,230),
 ('94110','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7484,-122.414,52),
 ('94111','SAN FRANCISCO','CA','415/510/65','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7975,-122.399,10),
 ('94112','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7201,-122.44,173),
 ('94114','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7582,-122.436,206),
 ('94115','SAN FRANCISCO','CA','415/510','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7856,-122.436,139),
 ('94116','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7443,-122.482,329),
 ('94117','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7701,-122.441,327),
 ('94118','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7817,-122.459,206),
 ('94119','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7862,-122.455,245),
 ('94120','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7934,-122.403,19),
 ('94121','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7788,-122.491,244),
 ('94122','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7615,-122.481,228),
 ('94123','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.8001,-122.435,39),
 ('94124','SAN FRANCISCO','CA','415/510','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7336,-122.39,78),
 ('94125','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7307,-122.386,77),
 ('94126','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.795,-122.393,4),
 ('94127','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7354,-122.458,636),
 ('94128','SAN FRANCISCO','CA','650','SAN FRANCISCO',NULL,'P','SAN MATEO',6,81,8,'Y',37.6097,-122.387,27),
 ('94128','SAN FRANCISCO','CA','650','SAN FRANCISCO INTNL AIRPORT',NULL,'O','SAN MATEO',6,81,8,'Y',37.6097,-122.387,27),
 ('94129','SAN FRANCISCO','CA','415','PRESIDIO',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.797,-122.463,201),
 ('94129','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.797,-122.463,201),
 ('94130','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.8209,-122.369,10),
 ('94131','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7438,-122.44,500),
 ('94132','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7231,-122.478,121),
 ('94133','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.8005,-122.409,87),
 ('94134','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7205,-122.409,308),
 ('94137','SAN FRANCISCO','CA','415/650','BANK OF AMERICA',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7925,-122.403,28),
 ('94137','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7925,-122.403,28),
 ('94139','SAN FRANCISCO','CA','415/650','FIRST INTERSTATE BANK',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7932,-122.403,25),
 ('94139','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7932,-122.403,25),
 ('94139','SAN FRANCISCO','CA','415/650','WELLS FARGO BANK',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7932,-122.403,25),
 ('94140','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7555,-122.415,55),
 ('94141','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7667,-122.41,60),
 ('94142','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7819,-122.415,59),
 ('94143','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7616,-122.458,526),
 ('94143','SAN FRANCISCO','CA','415','UCSF',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7616,-122.458,526),
 ('94144','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7822,-122.462,190),
 ('94144','SAN FRANCISCO','CA','415/650','WELLS FARGO BANK',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7822,-122.462,190),
 ('94145','SAN FRANCISCO','CA','415/650','UNION BANK OF CALIFORNIA',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7931,-122.401,16),
 ('94145','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7931,-122.401,16),
 ('94146','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7582,-122.436,202),
 ('94147','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.8004,-122.435,36),
 ('94151','SAN FRANCISCO','CA','415/650','IRS',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.792,-122.397,12),
 ('94151','SAN FRANCISCO','CA','415/650','IRS REMITTANCE',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.792,-122.397,12),
 ('94151','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.792,-122.397,12),
 ('94153','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.775,-122.418,51),
 ('94153','SAN FRANCISCO','CA','415/650','WELLS FARGO BANK',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.775,-122.418,51),
 ('94154','SAN FRANCISCO','CA','415/650','BANK OF AMERICA',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.775,-122.418,51),
 ('94154','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.775,-122.418,51),
 ('94156','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7895,-122.402,33),
 ('94156','SAN FRANCISCO','CA','415/650','WELLS FARGO BANK',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7895,-122.402,33),
 ('94158','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7587,-122.395,10),
 ('94159','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7814,-122.452,223),
 ('94160','SAN FRANCISCO','CA','415/650','BANK OF AMERICA',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7193,-122.402,255),
 ('94160','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7193,-122.402,255),
 ('94161','SAN FRANCISCO','CA','415/650','BANK OF AMERICA',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7984,-122.4,11),
 ('94161','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7984,-122.4,11),
 ('94162','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7895,-122.402,33),
 ('94162','SAN FRANCISCO','CA','415/650','WELLS FARGO BANK',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7895,-122.402,33),
 ('94163','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7895,-122.402,33),
 ('94163','SAN FRANCISCO','CA','415/650','WELLS FARGO BANK',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7895,-122.402,33),
 ('94164','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.789,-122.421,167),
 ('94171','SAN FRANCISCO','CA','415/650','AT & T',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.775,-122.418,51),
 ('94171','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.775,-122.418,51),
 ('94172','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7631,-122.485,206),
 ('94177','SAN FRANCISCO','CA','415/650','PG&E',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.7914,-122.397,12),
 ('94177','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7914,-122.397,12),
 ('94188','SAN FRANCISCO','CA','415','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.7404,-122.383,21),
 ('94199','SAN FRANCISCO','CA','415/650','SAN FRANCISCO',NULL,'P','SAN FRANCISCO',6,75,8,'Y',37.775,-122.418,51),
 ('94199','SAN FRANCISCO','CA','415/650','PACIFIC AREA OFFICE',NULL,'O','SAN FRANCISCO',6,75,8,'Y',37.775,-122.418,51),
 ('94203','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94204','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.6008,-121.442,37),
 ('94205','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.4753,-121.443,15),
 ('94206','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.4964,-121.45,22),
 ('94207','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.581,-121.49,27),
 ('94208','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94209','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.492,30),
 ('94211','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94229','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94230','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.4753,-121.443,15),
 ('94232','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5554,-121.497,20),
 ('94234','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94235','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94236','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94237','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94239','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5553,-121.497,20),
 ('94240','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94244','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5853,-121.493,30),
 ('94245','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94246','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94247','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94248','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94249','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5759,-121.466,42),
 ('94250','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5846,-121.493,30),
 ('94252','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94254','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94256','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94257','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94258','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94259','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5554,-121.497,20),
 ('94261','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94262','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.585,-121.493,30),
 ('94263','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94267','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94268','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94269','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5554,-121.497,20),
 ('94271','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5845,-121.493,30),
 ('94273','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94274','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94277','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94278','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5756,-121.466,33),
 ('94279','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94280','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94282','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94283','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.4753,-121.443,15),
 ('94284','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5532,-121.499,17),
 ('94285','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5554,-121.497,20),
 ('94286','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5554,-121.497,20),
 ('94287','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.492,30),
 ('94288','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5854,-121.493,30),
 ('94289','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5849,-121.493,30),
 ('94290','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5554,-121.497,20),
 ('94291','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5555,-121.497,18),
 ('94293','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5554,-121.497,20),
 ('94294','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5554,-121.497,18),
 ('94295','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5852,-121.493,30),
 ('94296','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5729,-121.506,21),
 ('94297','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5554,-121.497,20),
 ('94298','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5852,-121.493,30),
 ('94299','SACRAMENTO','CA','916','SACRAMENTO',NULL,'P','SACRAMENTO',6,67,8,'Y',38.5668,-121.467,27),
 ('94299','SACRAMENTO','CA','916','CA BRM ZIP',NULL,'O','SACRAMENTO',6,67,8,'Y',38.5668,-121.467,27),
 ('94301','PALO ALTO','CA','650','PALO ALTO',NULL,'P','SANTA CLARA',6,85,8,'Y',37.4433,-122.15,36),
 ('94302','PALO ALTO','CA','650','PALO ALTO',NULL,'P','SANTA CLARA',6,85,8,'Y',37.4459,-122.158,51),
 ('94303','PALO ALTO','CA','650','E PALO ALTO',NULL,'N','SANTA CLARA',6,85,8,'Y',37.4494,-122.125,5),
 ('94303','PALO ALTO','CA','650','EAST PALO ALTO','E PALO ALTO','N','SANTA CLARA',6,85,8,'Y',37.4494,-122.125,5),
 ('94303','PALO ALTO','CA','650','PALO ALTO',NULL,'P','SANTA CLARA',6,85,8,'Y',37.4494,-122.125,5),
 ('94304','PALO ALTO','CA','650','PALO ALTO',NULL,'P','SANTA CLARA',6,85,8,'Y',37.4099,-122.16,173),
 ('94305','STANFORD','CA','650','PALO ALTO',NULL,'N','SANTA CLARA',6,85,8,'Y',37.4213,-122.164,91),
 ('94305','STANFORD','CA','650','STANFORD',NULL,'P','SANTA CLARA',6,85,8,'Y',37.4213,-122.164,91),
 ('94306','PALO ALTO','CA','650','PALO ALTO',NULL,'P','SANTA CLARA',6,85,8,'Y',37.4169,-122.129,41),
 ('94309','PALO ALTO','CA','650','PALO ALTO',NULL,'P','SANTA CLARA',6,85,8,'Y',37.4167,-122.167,175),
 ('94309','PALO ALTO','CA','650','STANFORD',NULL,'N','SANTA CLARA',6,85,8,'Y',37.4167,-122.167,175),
 ('94401','SAN MATEO','CA','650','SAN MATEO',NULL,'P','SAN MATEO',6,81,8,'Y',37.5707,-122.319,15),
 ('94402','SAN MATEO','CA','650','SAN MATEO',NULL,'P','SAN MATEO',6,81,8,'Y',37.5474,-122.331,152),
 ('94403','SAN MATEO','CA','650','SAN MATEO',NULL,'P','SAN MATEO',6,81,8,'Y',37.5383,-122.304,35),
 ('94404','SAN MATEO','CA','650','FOSTER `city`',NULL,'N','SAN MATEO',6,81,8,'Y',37.5529,-122.27,9),
 ('94404','SAN MATEO','CA','650','SAN MATEO',NULL,'P','SAN MATEO',6,81,8,'Y',37.5529,-122.27,9),
 ('94497','SAN MATEO','CA','650','POSTAL DATA CENTER',NULL,'O','SAN MATEO',6,81,8,'Y',37.563,-122.324,41),
 ('94497','SAN MATEO','CA','650','SAN MATEO',NULL,'P','SAN MATEO',6,81,8,'Y',37.563,-122.324,41),
 ('94501','ALAMEDA','CA','510','ALAMEDA',NULL,'P','ALAMEDA',6,1,8,'Y',37.7636,-122.258,3),
 ('94501','ALAMEDA','CA','510','ALAMEDA PT',NULL,'O','ALAMEDA',6,1,8,'Y',37.7636,-122.258,3),
 ('94502','ALAMEDA','CA','510','ALAMEDA',NULL,'P','ALAMEDA',6,1,8,'Y',37.7384,-122.242,4),
 ('94503','AMERICAN CANYON','CA','707','AMERICAN CANYON','AMERICAN CYN','P','NAPA',6,55,8,'Y',38.1167,-122.233,80),
 ('94503','AMERICAN CANYON','CA','707','VALLEJO',NULL,'N','NAPA',6,55,8,'Y',38.1167,-122.233,80),
 ('94503','AMERICAN CANYON','CA','707','AMERICAN CYN',NULL,'N','NAPA',6,55,8,'Y',38.1167,-122.233,80),
 ('94505','DISCOVERY BAY','CA','925','BYRON',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.9028,-121.602,13),
 ('94505','DISCOVERY BAY','CA','925','DISCOVERY BAY',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9028,-121.602,13),
 ('94506','DANVILLE','CA','925','BLACKHAWK',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.8131,-121.91,919),
 ('94506','DANVILLE','CA','925','DANVILLE',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8131,-121.91,919),
 ('94507','ALAMO','CA','925','ALAMO',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8528,-122.02,310),
 ('94508','ANGWIN','CA','707','ANGWIN',NULL,'P','NAPA',6,55,8,'Y',38.5759,-122.446,1672),
 ('94509','ANTIOCH','CA','925','ANTIOCH',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.994,-121.801,80),
 ('94510','BENICIA','CA','707','BENICIA',NULL,'P','SOLANO',6,95,8,'Y',38.0688,-122.162,344),
 ('94511','BETHEL ISLAND','CA','925','BETHEL ISLAND',NULL,'P','CONTRA COSTA',6,13,8,'Y',38.021,-121.65,6),
 ('94512','BIRDS LANDING','CA','510/707','BIRDS LANDING',NULL,'P','SOLANO',6,95,8,'Y',38.1231,-121.827,221),
 ('94512','BIRDS LANDING','CA','510/707','SUISUN `city`',NULL,'O','SOLANO',6,95,8,'Y',38.1231,-121.827,221),
 ('94513','BRENTWOOD','CA','925','BRENTWOOD',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9353,-121.694,73),
 ('94514','BYRON','CA','925','BYRON',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.872,-121.614,6),
 ('94514','BYRON','CA','925','DISCOVERY BAY',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.872,-121.614,6),
 ('94515','CALISTOGA','CA','707','CALISTOGA',NULL,'P','NAPA',6,55,8,'Y',38.5831,-122.568,458),
 ('94516','CANYON','CA','925','CANYON',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8316,-122.187,1182),
 ('94517','CLAYTON','CA','925','CLAYTON',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9291,-121.919,578),
 ('94518','CONCORD','CA','925','CONCORD',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9511,-122.023,68),
 ('94519','CONCORD','CA','925','CONCORD',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9818,-122.01,119),
 ('94520','CONCORD','CA','925','CLYDE',NULL,'O','CONTRA COSTA',6,13,8,'Y',37.9834,-122.037,58),
 ('94520','CONCORD','CA','925','CONCORD',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9834,-122.037,58),
 ('94521','CONCORD','CA','925','CONCORD',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9623,-121.963,268),
 ('94522','CONCORD','CA','925','CONCORD',NULL,'P','CONTRA COSTA',6,13,8,'Y',38.0134,-122.02,41),
 ('94523','PLEASANT HILL','CA','925','CONCORD',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.9541,-122.077,64),
 ('94523','PLEASANT HILL','CA','925','PLEASANT HILL',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9541,-122.077,64),
 ('94524','CONCORD','CA','925','CONCORD',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9769,-122.056,28),
 ('94525','CROCKETT','CA','510','CROCKETT',NULL,'P','CONTRA COSTA',6,13,8,'Y',38.0525,-122.221,63),
 ('94526','DANVILLE','CA','925','DANVILLE',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8162,-121.97,433),
 ('94527','CONCORD','CA','925','CONCORD',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.978,-122.056,27),
 ('94528','DIABLO','CA','925','DIABLO',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8366,-121.956,608),
 ('94529','CONCORD','CA','925','CONCORD',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8764,-122.048,181),
 ('94529','CONCORD','CA','925','CHEVRON USA INC',NULL,'O','CONTRA COSTA',6,13,8,'Y',37.8764,-122.048,181),
 ('94529','CONCORD','CA','925','CHEVRON',NULL,'O','CONTRA COSTA',6,13,8,'Y',37.8764,-122.048,181),
 ('94530','EL CERRITO','CA','510','EL CERRITO',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9191,-122.303,171),
 ('94531','ANTIOCH','CA','925','ANTIOCH',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9969,-121.807,63),
 ('94533','FAIRFIELD','CA','707','FAIRFIELD',NULL,'P','SOLANO',6,95,8,'Y',38.2845,-122.017,85),
 ('94534','FAIRFIELD','CA','707','FAIRFIELD',NULL,'P','SOLANO',6,95,8,'Y',38.2728,-122.064,85),
 ('94534','FAIRFIELD','CA','707','SUISUN `city`',NULL,'N','SOLANO',6,95,8,'Y',38.2728,-122.064,85),
 ('94535','TRAVIS AFB','CA','707','FAIRFIELD',NULL,'N','SOLANO',6,95,8,'Y',38.2494,-122.039,13),
 ('94535','TRAVIS AFB','CA','707','TRAVIS AFB',NULL,'P','SOLANO',6,95,8,'Y',38.2494,-122.039,13),
 ('94536','FREMONT','CA','408/510/92','FREMONT',NULL,'P','ALAMEDA',6,1,8,'Y',37.5628,-122,43),
 ('94537','FREMONT','CA','510','FREMONT',NULL,'P','ALAMEDA',6,1,8,'Y',37.5562,-122.015,47),
 ('94538','FREMONT','CA','408/510/92','FREMONT',NULL,'P','ALAMEDA',6,1,8,'Y',37.5268,-121.965,42),
 ('94539','FREMONT','CA','510','FREMONT',NULL,'P','ALAMEDA',6,1,8,'Y',37.518,-121.929,365),
 ('94540','HAYWARD','CA','510','HAYWARD',NULL,'P','ALAMEDA',6,1,8,'Y',37.6564,-122.096,70),
 ('94541','HAYWARD','CA','510/925','HAYWARD',NULL,'P','ALAMEDA',6,1,8,'Y',37.6748,-122.082,116),
 ('94542','HAYWARD','CA','510','HAYWARD',NULL,'P','ALAMEDA',6,1,8,'Y',37.6583,-122.044,739),
 ('94543','HAYWARD','CA','510','HAYWARD',NULL,'P','ALAMEDA',6,1,8,'Y',37.6707,-122.083,106),
 ('94544','HAYWARD','CA','510/925','HAYWARD',NULL,'P','ALAMEDA',6,1,8,'Y',37.6338,-122.062,26),
 ('94545','HAYWARD','CA','510','HAYWARD',NULL,'P','ALAMEDA',6,1,8,'Y',37.6355,-122.102,38),
 ('94546','CASTRO VALLEY','CA','510','CASTRO VALLEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.7261,-122.08,242),
 ('94546','CASTRO VALLEY','CA','510','HAYWARD',NULL,'N','ALAMEDA',6,1,8,'Y',37.7261,-122.08,242),
 ('94547','HERCULES','CA','510','HERCULES',NULL,'P','CONTRA COSTA',6,13,8,'Y',38.0111,-122.266,112),
 ('94547','HERCULES','CA','510','RODEO',NULL,'N','CONTRA COSTA',6,13,8,'Y',38.0111,-122.266,112),
 ('94548','KNIGHTSEN','CA','510','KNIGHTSEN',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9725,-121.658,20),
 ('94549','LAFAYETTE','CA','925','LAFAYETTE',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8981,-122.116,408),
 ('94550','LIVERMORE','CA','925','LIVERMORE',NULL,'P','ALAMEDA',6,1,8,'Y',37.6812,-121.752,526),
 ('94551','LIVERMORE','CA','925','LIVERMORE',NULL,'P','ALAMEDA',6,1,8,'Y',37.7292,-121.691,954),
 ('94552','CASTRO VALLEY','CA','510','CASTRO VALLEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.6941,-122.019,411),
 ('94552','CASTRO VALLEY','CA','510','HAYWARD',NULL,'N','ALAMEDA',6,1,8,'Y',37.6941,-122.019,411),
 ('94553','MARTINEZ','CA','925','MARTINEZ',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9913,-122.164,622),
 ('94553','MARTINEZ','CA','925','PACHECO',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.9913,-122.164,622),
 ('94553','MARTINEZ','CA','925','BRIONES',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.9913,-122.164,622),
 ('94555','FREMONT','CA','510','FREMONT',NULL,'P','ALAMEDA',6,1,8,'Y',37.5737,-122.047,23),
 ('94556','MORAGA','CA','925','MORAGA',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8418,-122.123,520),
 ('94557','HAYWARD','CA','510','HAYWARD',NULL,'P','ALAMEDA',6,1,8,'Y',37.6277,-122.105,23),
 ('94557','HAYWARD','CA','510','MOUNT EDEN',NULL,'N','ALAMEDA',6,1,8,'Y',37.6277,-122.105,23),
 ('94558','NAPA','CA','707','NAPA',NULL,'P','NAPA',6,55,8,'Y',38.3455,-122.305,64),
 ('94558','NAPA','CA','707','SPANISH FLAT',NULL,'N','NAPA',6,55,8,'Y',38.3455,-122.305,64),
 ('94559','NAPA','CA','707','NAPA',NULL,'P','NAPA',6,55,8,'Y',38.2912,-122.286,17),
 ('94560','NEWARK','CA','510','NEWARK',NULL,'P','ALAMEDA',6,1,8,'Y',37.538,-122.031,26),
 ('94561','OAKLEY','CA','925','OAKLEY',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.991,-121.714,35),
 ('94562','OAKVILLE','CA','707','OAKVILLE',NULL,'P','NAPA',6,55,8,'Y',38.4295,-122.402,160),
 ('94563','ORINDA','CA','925','ORINDA',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8808,-122.176,725),
 ('94564','PINOLE','CA','510','PINOLE',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9967,-122.286,38),
 ('94565','PITTSBURG','CA','925','PITTSBURG',NULL,'P','CONTRA COSTA',6,13,8,'Y',38.0159,-121.911,75),
 ('94565','PITTSBURG','CA','925','PORT CHICAGO',NULL,'O','CONTRA COSTA',6,13,8,'Y',38.0159,-121.911,75),
 ('94565','PITTSBURG','CA','925','BAY POINT',NULL,'N','CONTRA COSTA',6,13,8,'Y',38.0159,-121.911,75),
 ('94565','PITTSBURG','CA','925','WEST PITTSBURG',NULL,'O','CONTRA COSTA',6,13,8,'Y',38.0159,-121.911,75),
 ('94566','PLEASANTON','CA','925','PLEASANTON',NULL,'P','ALAMEDA',6,1,8,'Y',37.6715,-121.884,339),
 ('94567','POPE VALLEY','CA','707','POPE VALLEY',NULL,'P','NAPA',6,55,8,'Y',38.6776,-122.408,1276),
 ('94568','DUBLIN','CA','925','DUBLIN',NULL,'P','ALAMEDA',6,1,8,'Y',37.7147,-121.93,342),
 ('94568','DUBLIN','CA','925','PLEASANTON',NULL,'N','ALAMEDA',6,1,8,'Y',37.7147,-121.93,342),
 ('94569','PORT COSTA','CA','510','PORT COSTA',NULL,'P','CONTRA COSTA',6,13,8,'Y',38.0465,-122.186,167),
 ('94570','MORAGA','CA','925','MORAGA',NULL,'P','CONTRA COSTA',6,13,8,'Y',38.1141,-122.139,533),
 ('94571','RIO VISTA','CA','707','RIO VISTA',NULL,'P','SOLANO',6,95,8,'Y',38.1722,-121.718,67),
 ('94572','RODEO','CA','510','RODEO',NULL,'P','CONTRA COSTA',6,13,8,'Y',38.0306,-122.261,63),
 ('94573','RUTHERFORD','CA','707','RUTHERFORD',NULL,'P','NAPA',6,55,8,'Y',38.4558,-122.411,147),
 ('94574','SAINT HELENA','CA','707','SAINT HELENA',NULL,'P','NAPA',6,55,8,'Y',38.5089,-122.448,222),
 ('94575','MORAGA','CA','925','MORAGA',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8438,-122.123,589),
 ('94576','DEER PARK','CA','707','ANGWIN',NULL,'N','NAPA',6,55,8,'Y',38.5301,-122.467,573),
 ('94576','DEER PARK','CA','707','DEER PARK',NULL,'P','NAPA',6,55,8,'Y',38.5301,-122.467,573),
 ('94577','SAN LEANDRO','CA','510','SAN LEANDRO',NULL,'P','ALAMEDA',6,1,8,'Y',37.7205,-122.157,52),
 ('94578','SAN LEANDRO','CA','510','SAN LEANDRO',NULL,'P','ALAMEDA',6,1,8,'Y',37.7034,-122.124,34),
 ('94579','SAN LEANDRO','CA','510','SAN LEANDRO',NULL,'P','ALAMEDA',6,1,8,'Y',37.6887,-122.151,13),
 ('94580','SAN LORENZO','CA','510','SAN LORENZO',NULL,'P','ALAMEDA',6,1,8,'Y',37.6781,-122.131,28),
 ('94581','NAPA','CA','707','NAPA',NULL,'P','NAPA',6,55,8,'Y',38.2968,-122.286,19),
 ('94582','SAN RAMON','CA','925','SAN RAMON',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.6725,-121.889,333),
 ('94583','SAN RAMON','CA','925','SAN RAMON',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.7547,-121.953,419),
 ('94585','SUISUN `city`','CA','707','SUISUN `city`',NULL,'P','SOLANO',6,95,8,'Y',38.2462,-122.022,12),
 ('94585','SUISUN `city`','CA','707','BIRDS LNDG',NULL,'N','SOLANO',6,95,8,'Y',38.2462,-122.022,12),
 ('94586','SUNOL','CA','925','SUNOL',NULL,'P','ALAMEDA',6,1,8,'Y',37.604,-121.894,437),
 ('94587','UNION `city`','CA','510','UNION `city`',NULL,'P','ALAMEDA',6,1,8,'Y',37.5906,-122.046,28),
 ('94588','PLEASANTON','CA','925','PLEASANTON',NULL,'P','ALAMEDA',6,1,8,'Y',37.6853,-121.895,327),
 ('94589','VALLEJO','CA','707','AMERICAN CANYON','AMERICAN CYN','N','SOLANO',6,95,8,'Y',38.1623,-122.249,54),
 ('94589','VALLEJO','CA','707','VALLEJO',NULL,'P','SOLANO',6,95,8,'Y',38.1623,-122.249,54),
 ('94589','VALLEJO','CA','707','AMERICAN CYN',NULL,'N','SOLANO',6,95,8,'Y',38.1623,-122.249,54),
 ('94590','VALLEJO','CA','707','VALLEJO',NULL,'P','SOLANO',6,95,8,'Y',38.1048,-122.247,22),
 ('94591','VALLEJO','CA','707','VALLEJO',NULL,'P','SOLANO',6,95,8,'Y',38.1015,-122.21,76),
 ('94592','VALLEJO','CA','707','MARE ISLAND',NULL,'O','SOLANO',6,95,8,'Y',38.1001,-122.276,22),
 ('94592','VALLEJO','CA','707','VALLEJO',NULL,'P','SOLANO',6,95,8,'Y',38.1001,-122.276,22),
 ('94595','WALNUT CREEK','CA','510/707/92','WALNUT CREEK',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8697,-122.071,332),
 ('94596','WALNUT CREEK','CA','925','LAFAYETTE',NULL,'O','CONTRA COSTA',6,13,8,'Y',37.9021,-122.056,123),
 ('94596','WALNUT CREEK','CA','925','WALNUT CREEK',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9021,-122.056,123),
 ('94597','WALNUT CREEK','CA','925','WALNUT CREEK',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.8977,-122.06,142),
 ('94598','WALNUT CREEK','CA','510/707/92','WALNUT CREEK',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9185,-122.025,145),
 ('94599','YOUNTVILLE','CA','707','YOUNTVILLE',NULL,'P','NAPA',6,55,8,'Y',38.4055,-122.359,92),
 ('94601','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.7784,-122.217,49),
 ('94602','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8029,-122.206,284),
 ('94602','OAKLAND','CA','510','PIEDMONT',NULL,'N','ALAMEDA',6,1,8,'Y',37.8029,-122.206,284),
 ('94603','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.7388,-122.172,35),
 ('94604','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8018,-122.265,34),
 ('94605','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.7627,-122.157,274),
 ('94606','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.7931,-122.243,56),
 ('94607','OAKLAND','CA','510/650','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.807,-122.286,22),
 ('94608','EMERYVILLE','CA','510','EMERYVILLE',NULL,'P','ALAMEDA',6,1,8,'Y',37.8344,-122.289,15),
 ('94608','EMERYVILLE','CA','510','OAKLAND',NULL,'N','ALAMEDA',6,1,8,'Y',37.8344,-122.289,15),
 ('94609','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8357,-122.264,106),
 ('94610','OAKLAND','CA','415/510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8184,-122.235,109),
 ('94610','OAKLAND','CA','415/510','PIEDMONT',NULL,'N','ALAMEDA',6,1,8,'Y',37.8184,-122.235,109),
 ('94610','OAKLAND','CA','415/510','PIEDMONTXXX',NULL,'O','ALAMEDA',6,1,8,'Y',37.8184,-122.235,109),
 ('94611','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8356,-122.223,704),
 ('94611','OAKLAND','CA','510','PIEDMONT',NULL,'N','ALAMEDA',6,1,8,'Y',37.8356,-122.223,704),
 ('94611','OAKLAND','CA','510','PIEDMONTXXX',NULL,'O','ALAMEDA',6,1,8,'Y',37.8356,-122.223,704),
 ('94612','OAKLAND','CA','415/510/92','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8102,-122.269,20),
 ('94612','OAKLAND','CA','415/510/92','PHILATELIC CENTER',NULL,'O','ALAMEDA',6,1,8,'Y',37.8102,-122.269,20),
 ('94613','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.783,-122.186,151),
 ('94614','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.7279,-122.203,8),
 ('94615','OAKLAND','CA','415/510/92','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.809,-122.298,17),
 ('94617','OAKLAND','CA','415/510/65','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.7594,-122.147,249),
 ('94618','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8244,-122.231,325),
 ('94618','OAKLAND','CA','510','PIEDMONT',NULL,'N','ALAMEDA',6,1,8,'Y',37.8244,-122.231,325),
 ('94619','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.7894,-122.182,291),
 ('94620','PIEDMONT','CA','510','OAKLAND',NULL,'N','ALAMEDA',6,1,8,'Y',37.7767,-122.213,62),
 ('94620','PIEDMONT','CA','510','PIEDMONT',NULL,'P','ALAMEDA',6,1,8,'Y',37.7767,-122.213,62),
 ('94621','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.756,-122.188,17),
 ('94622','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.7515,-122.194,12),
 ('94622','OAKLAND','CA','510','OAKLAND INTRNTL SERVICE CTR',NULL,'O','ALAMEDA',6,1,8,'Y',37.7515,-122.194,12),
 ('94623','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8093,-122.299,16),
 ('94624','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.7478,-122.172,31),
 ('94649','OAKLAND','CA','510','EBMUD',NULL,'O','ALAMEDA',6,1,8,'Y',37.8056,-122.265,32),
 ('94649','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8056,-122.265,32),
 ('94659','OAKLAND','CA','510','BLUE CROSS',NULL,'O','ALAMEDA',6,1,8,'Y',37.8105,-122.266,22),
 ('94659','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8105,-122.266,22),
 ('94660','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.7958,-122.27,27),
 ('94660','OAKLAND','CA','510','SAFEWAY STORES',NULL,'O','ALAMEDA',6,1,8,'Y',37.7958,-122.27,27),
 ('94661','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8285,-122.209,748),
 ('94662','EMERYVILLE','CA','510','EMERYVILLE',NULL,'P','ALAMEDA',6,1,8,'Y',37.8426,-122.291,16),
 ('94662','EMERYVILLE','CA','510','OAKLAND',NULL,'N','ALAMEDA',6,1,8,'Y',37.8426,-122.291,16),
 ('94666','OAKLAND','CA','510','KAISER SERVICES',NULL,'O','ALAMEDA',6,1,8,'Y',37.8075,-122.264,11),
 ('94666','OAKLAND','CA','510','OAKLAND',NULL,'P','ALAMEDA',6,1,8,'Y',37.8075,-122.264,11),
 ('94701','BERKELEY','CA','510','BERKELEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.8691,-122.27,175),
 ('94702','BERKELEY','CA','510','BERKELEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.8656,-122.285,82),
 ('94703','BERKELEY','CA','510','BERKELEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.8638,-122.275,124),
 ('94704','BERKELEY','CA','510','BERKELEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.8674,-122.26,251),
 ('94705','BERKELEY','CA','510','BERKELEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.8574,-122.245,321),
 ('94706','ALBANY','CA','510','ALBANY',NULL,'P','ALAMEDA',6,1,8,'Y',37.8895,-122.294,62),
 ('94706','ALBANY','CA','510','BERKELEY',NULL,'N','ALAMEDA',6,1,8,'Y',37.8895,-122.294,62),
 ('94706','ALBANY','CA','510','KENSINGTON',NULL,'N','ALAMEDA',6,1,8,'Y',37.8895,-122.294,62),
 ('94707','BERKELEY','CA','510','ALBANY',NULL,'N','ALAMEDA',6,1,8,'Y',37.8993,-122.277,454),
 ('94707','BERKELEY','CA','510','BERKELEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.8993,-122.277,454),
 ('94707','BERKELEY','CA','510','KENSINGTON',NULL,'N','ALAMEDA',6,1,8,'Y',37.8993,-122.277,454),
 ('94708','BERKELEY','CA','510','BERKELEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.9061,-122.273,745),
 ('94708','BERKELEY','CA','510','KENSINGTON',NULL,'N','ALAMEDA',6,1,8,'Y',37.9061,-122.273,745),
 ('94709','BERKELEY','CA','510','BERKELEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.8793,-122.265,303),
 ('94710','BERKELEY','CA','510','ALBANY',NULL,'N','ALAMEDA',6,1,8,'Y',37.8685,-122.298,22),
 ('94710','BERKELEY','CA','510','BERKELEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.8685,-122.298,22),
 ('94712','BERKELEY','CA','510','BERKELEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.8693,-122.268,186),
 ('94720','BERKELEY','CA','510','BERKELEY',NULL,'P','ALAMEDA',6,1,8,'Y',37.8692,-122.256,296),
 ('94720','BERKELEY','CA','510','UC BERKELEY',NULL,'N','ALAMEDA',6,1,8,'Y',37.8692,-122.256,296),
 ('94720','BERKELEY','CA','510','U C BERKELEY',NULL,'O','ALAMEDA',6,1,8,'Y',37.8692,-122.256,296),
 ('94801','RICHMOND','CA','510','NORTH RICHMOND','N RICHMOND','N','CONTRA COSTA',6,13,8,'Y',37.9407,-122.353,41),
 ('94801','RICHMOND','CA','510','POINT RICHMOND','PT RICHMOND','N','CONTRA COSTA',6,13,8,'Y',37.9407,-122.353,41),
 ('94801','RICHMOND','CA','510','RICHMOND',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9407,-122.353,41),
 ('94801','RICHMOND','CA','510','PT RICHMOND',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.9407,-122.353,41),
 ('94801','RICHMOND','CA','510','N RICHMOND',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.9407,-122.353,41),
 ('94802','RICHMOND','CA','510','RICHMOND',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9372,-122.358,31),
 ('94803','EL SOBRANTE','CA','510','EL SOBRANTE',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9721,-122.296,283),
 ('94803','EL SOBRANTE','CA','510','RICHMOND',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.9721,-122.296,283),
 ('94803','EL SOBRANTE','CA','510','SAN PABLO',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.9721,-122.296,283),
 ('94804','RICHMOND','CA','510','RICHMOND',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.926,-122.334,42),
 ('94805','RICHMOND','CA','510','RICHMOND',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9409,-122.32,203),
 ('94806','SAN PABLO','CA','510','RICHMOND',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.9724,-122.334,139),
 ('94806','SAN PABLO','CA','510','SAN PABLO',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9724,-122.334,139),
 ('94806','SAN PABLO','CA','510','TARA HILLS',NULL,'O','CONTRA COSTA',6,13,8,'Y',37.9724,-122.334,139),
 ('94806','SAN PABLO','CA','510','HILLTOP MALL',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.9724,-122.334,139),
 ('94807','RICHMOND','CA','510','RICHMOND',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9288,-122.356,20),
 ('94808','RICHMOND','CA','510','RICHMOND',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9338,-122.343,53),
 ('94820','EL SOBRANTE','CA','510','EL SOBRANTE',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9799,-122.296,235),
 ('94820','EL SOBRANTE','CA','510','RICHMOND',NULL,'N','CONTRA COSTA',6,13,8,'Y',37.9799,-122.296,235),
 ('94850','RICHMOND','CA','510','RICHMOND',NULL,'P','CONTRA COSTA',6,13,8,'Y',37.9457,-122.382,17),
 ('94901','SAN RAFAEL','CA','415','SAN RAFAEL',NULL,'P','MARIN',6,41,8,'Y',37.975,-122.51,130),
 ('94903','SAN RAFAEL','CA','415','MARINWOOD',NULL,'O','MARIN',6,41,8,'Y',38.0153,-122.546,357),
 ('94903','SAN RAFAEL','CA','415','SAN RAFAEL',NULL,'P','MARIN',6,41,8,'Y',38.0153,-122.546,357),
 ('94903','SAN RAFAEL','CA','415','SANTA VENETIA',NULL,'O','MARIN',6,41,8,'Y',38.0153,-122.546,357),
 ('94903','SAN RAFAEL','CA','415','TERRA LINDA',NULL,'O','MARIN',6,41,8,'Y',38.0153,-122.546,357),
 ('94904','GREENBRAE','CA','415','GREENBRAE',NULL,'P','MARIN',6,41,8,'Y',37.9511,-122.54,25),
 ('94904','GREENBRAE','CA','415','KENT WOODLANDS',NULL,'O','MARIN',6,41,8,'Y',37.9511,-122.54,25),
 ('94904','GREENBRAE','CA','415','KENTFIELD',NULL,'N','MARIN',6,41,8,'Y',37.9511,-122.54,25),
 ('94904','GREENBRAE','CA','415','SAN RAFAEL',NULL,'O','MARIN',6,41,8,'Y',37.9511,-122.54,25),
 ('94912','SAN RAFAEL','CA','415','SAN RAFAEL',NULL,'P','MARIN',6,41,8,'Y',37.9769,-122.506,196),
 ('94913','SAN RAFAEL','CA','415','SAN RAFAEL',NULL,'P','MARIN',6,41,8,'Y',38.0235,-122.547,170),
 ('94914','KENTFIELD','CA','415','GREENBRAE',NULL,'O','MARIN',6,41,8,'Y',37.9476,-122.538,15),
 ('94914','KENTFIELD','CA','415','KENTFIELD',NULL,'P','MARIN',6,41,8,'Y',37.9476,-122.538,15),
 ('94914','KENTFIELD','CA','415','SAN RAFAEL',NULL,'O','MARIN',6,41,8,'Y',37.9476,-122.538,15),
 ('94915','SAN RAFAEL','CA','415','MISSION RAFAEL',NULL,'O','MARIN',6,41,8,'Y',37.9586,-122.507,37),
 ('94915','SAN RAFAEL','CA','415','SAN RAFAEL',NULL,'P','MARIN',6,41,8,'Y',37.9586,-122.507,37),
 ('94920','BELVEDERE TIBURON','CA','415','BELVEDERE',NULL,'N','MARIN',6,41,8,'Y',37.8913,-122.473,309),
 ('94920','BELVEDERE TIBURON','CA','415','BELVEDERE TIBURON','BEL TIBURON','P','MARIN',6,41,8,'Y',37.8913,-122.473,309),
 ('94920','BELVEDERE TIBURON','CA','415','TIBURON',NULL,'N','MARIN',6,41,8,'Y',37.8913,-122.473,309),
 ('94920','BELVEDERE TIBURON','CA','415','BEL TIBURON',NULL,'N','MARIN',6,41,8,'Y',37.8913,-122.473,309),
 ('94922','BODEGA','CA','707','BODEGA',NULL,'P','SONOMA',6,97,8,'Y',38.3771,-122.984,715),
 ('94923','BODEGA BAY','CA','707','BODEGA BAY',NULL,'P','SONOMA',6,97,8,'Y',38.348,-123.048,342),
 ('94923','BODEGA BAY','CA','707','SALMON CREEK',NULL,'O','SONOMA',6,97,8,'Y',38.348,-123.048,342),
 ('94924','BOLINAS','CA','415','BOLINAS',NULL,'P','MARIN',6,41,8,'Y',37.9143,-122.705,223),
 ('94925','CORTE MADERA','CA','415','CORTE MADERA',NULL,'P','MARIN',6,41,8,'Y',37.9229,-122.517,80),
 ('94926','ROHNERT PARK','CA','707','COTATI',NULL,'N','SONOMA',6,97,8,'Y',38.3278,-122.709,110),
 ('94926','ROHNERT PARK','CA','707','ROHNERT PARK',NULL,'P','SONOMA',6,97,8,'Y',38.3278,-122.709,110),
 ('94926','ROHNERT PARK','CA','707','`state` FARM INSURANCE',NULL,'O','SONOMA',6,97,8,'Y',38.3278,-122.709,110),
 ('94927','ROHNERT PARK','CA','707','COTATI',NULL,'N','SONOMA',6,97,8,'Y',38.349,-122.698,104),
 ('94927','ROHNERT PARK','CA','707','ROHNERT PARK',NULL,'P','SONOMA',6,97,8,'Y',38.349,-122.698,104),
 ('94928','ROHNERT PARK','CA','707','COTATI',NULL,'N','SONOMA',6,97,8,'Y',38.3461,-122.7,103),
 ('94928','ROHNERT PARK','CA','707','ROHNERT PARK',NULL,'P','SONOMA',6,97,8,'Y',38.3461,-122.7,103),
 ('94929','DILLON BEACH','CA','707','DILLON BEACH',NULL,'P','MARIN',6,41,8,'Y',38.2526,-122.964,128),
 ('94930','FAIRFAX','CA','415','FAIRFAX',NULL,'P','MARIN',6,41,8,'Y',37.9636,-122.62,1098),
 ('94931','COTATI','CA','707','COTATI',NULL,'P','SONOMA',6,97,8,'Y',38.3254,-122.708,113),
 ('94933','FOREST KNOLLS','CA','415','FOREST KNOLLS',NULL,'P','MARIN',6,41,8,'Y',38.0169,-122.692,305),
 ('94937','INVERNESS','CA','415','INVERNESS',NULL,'P','MARIN',6,41,8,'Y',38.0963,-122.857,108),
 ('94938','LAGUNITAS','CA','415','LAGUNITAS',NULL,'P','MARIN',6,41,8,'Y',38.0131,-122.694,504),
 ('94939','LARKSPUR','CA','415','LARKSPUR',NULL,'P','MARIN',6,41,8,'Y',37.9378,-122.536,120),
 ('94940','MARSHALL','CA','415','MARSHALL',NULL,'P','MARIN',6,41,8,'Y',38.1947,-122.889,235),
 ('94941','MILL VALLEY','CA','415','MILL VALLEY',NULL,'P','MARIN',6,41,8,'Y',37.8903,-122.568,140),
 ('94941','MILL VALLEY','CA','415','MUIR WOODS',NULL,'O','MARIN',6,41,8,'Y',37.8903,-122.568,140),
 ('94941','MILL VALLEY','CA','415','STRAWBERRY POINT',NULL,'O','MARIN',6,41,8,'Y',37.8903,-122.568,140),
 ('94941','MILL VALLEY','CA','415','TAMALPAIS VALLEY',NULL,'O','MARIN',6,41,8,'Y',37.8903,-122.568,140),
 ('94942','MILL VALLEY','CA','415','MILL VALLEY',NULL,'P','MARIN',6,41,8,'Y',37.9026,-122.523,112),
 ('94945','NOVATO','CA','415','BLACK POINT',NULL,'O','MARIN',6,41,8,'Y',38.1257,-122.55,214),
 ('94945','NOVATO','CA','415','NOVATO',NULL,'P','MARIN',6,41,8,'Y',38.1257,-122.55,214),
 ('94945','NOVATO','CA','415','SAN MARIN',NULL,'O','MARIN',6,41,8,'Y',38.1257,-122.55,214),
 ('94946','NICASIO','CA','415','NICASIO',NULL,'P','MARIN',6,41,8,'Y',38.0586,-122.68,1011),
 ('94947','NOVATO','CA','415','NOVATO',NULL,'P','MARIN',6,41,8,'Y',38.1032,-122.617,167),
 ('94948','NOVATO','CA','415','NOVATO',NULL,'P','MARIN',6,41,8,'Y',38.1376,-122.563,5),
 ('94949','NOVATO','CA','415','BEL MARIN KEYES',NULL,'O','MARIN',6,41,8,'Y',38.0639,-122.543,126),
 ('94949','NOVATO','CA','415','IGNACIO',NULL,'O','MARIN',6,41,8,'Y',38.0639,-122.543,126),
 ('94949','NOVATO','CA','415','NOVATO',NULL,'P','MARIN',6,41,8,'Y',38.0639,-122.543,126),
 ('94950','OLEMA','CA','415','OLEMA',NULL,'P','MARIN',6,41,8,'Y',38.0417,-122.771,365),
 ('94951','PENNGROVE','CA','707','PENNGROVE',NULL,'P','SONOMA',6,97,8,'Y',38.3149,-122.661,140),
 ('94952','PETALUMA','CA','707','BLOOMFIELD',NULL,'O','SONOMA',6,97,8,'Y',38.2458,-122.661,122),
 ('94952','PETALUMA','CA','707','FALLON',NULL,'O','SONOMA',6,97,8,'Y',38.2458,-122.661,122),
 ('94952','PETALUMA','CA','707','LAKEVILLE',NULL,'O','SONOMA',6,97,8,'Y',38.2458,-122.661,122),
 ('94952','PETALUMA','CA','707','PETALUMA',NULL,'P','SONOMA',6,97,8,'Y',38.2458,-122.661,122),
 ('94952','PETALUMA','CA','707','TWO ROCK COAST GUARD STATION',NULL,'O','SONOMA',6,97,8,'Y',38.2458,-122.661,122),
 ('94952','PETALUMA','CA','707','TWO ROCK RANCH STA',NULL,'O','SONOMA',6,97,8,'Y',38.2458,-122.661,122),
 ('94953','PETALUMA','CA','707','PETALUMA',NULL,'P','SONOMA',6,97,8,'Y',38.2606,-122.637,45),
 ('94954','PETALUMA','CA','707','PETALUMA',NULL,'P','SONOMA',6,97,8,'Y',38.2518,-122.615,48),
 ('94955','PETALUMA','CA','707','PETALUMA',NULL,'P','SONOMA',6,97,8,'Y',38.2252,-122.557,100),
 ('94956','POINT REYES STATION','CA','415','POINT REYES STATION','PT REYES STA','P','MARIN',6,41,8,'Y',38.0653,-122.811,20),
 ('94956','POINT REYES STATION','CA','415','PT REYES STA',NULL,'N','MARIN',6,41,8,'Y',38.0653,-122.811,20),
 ('94956','POINT REYES STATION','CA','415','PT REYES STATION',NULL,'O','MARIN',6,41,8,'Y',38.0653,-122.811,20),
 ('94957','ROSS','CA','415','ROSS',NULL,'P','MARIN',6,41,8,'Y',37.9642,-122.558,26),
 ('94960','SAN ANSELMO','CA','415','SAN ANSELMO',NULL,'P','MARIN',6,41,8,'Y',37.9821,-122.569,86),
 ('94963','SAN GERONIMO','CA','415','SAN GERONIMO',NULL,'P','MARIN',6,41,8,'Y',38.0136,-122.662,308),
 ('94964','SAN QUENTIN','CA','415','SAN QUENTIN',NULL,'P','MARIN',6,41,8,'Y',37.9421,-122.482,31),
 ('94965','SAUSALITO','CA','415','MARIN `city`',NULL,'O','MARIN',6,41,8,'Y',37.8651,-122.531,301),
 ('94965','SAUSALITO','CA','415','MUIR BEACH',NULL,'N','MARIN',6,41,8,'Y',37.8651,-122.531,301),
 ('94965','SAUSALITO','CA','415','SAUSALITO',NULL,'P','MARIN',6,41,8,'Y',37.8651,-122.531,301),
 ('94966','SAUSALITO','CA','415','SAUSALITO',NULL,'P','MARIN',6,41,8,'Y',37.8679,-122.499,12),
 ('94970','STINSON BEACH','CA','415','STINSON BEACH',NULL,'P','MARIN',6,41,8,'Y',37.9051,-122.646,294),
 ('94971','TOMALES','CA','707','TOMALES',NULL,'P','MARIN',6,41,8,'Y',38.2476,-122.9,200),
 ('94972','VALLEY FORD','CA','707','VALLEY FORD',NULL,'P','SONOMA',6,97,8,'Y',38.2966,-122.943,363),
 ('94973','WOODACRE','CA','415','WOODACRE',NULL,'P','MARIN',6,41,8,'Y',38.0075,-122.639,456),
 ('94974','SAN QUENTIN','CA','415','SAN QUENTIN',NULL,'P','MARIN',6,41,8,'Y',37.9566,-122.541,32),
 ('94975','PETALUMA','CA','707','PETALUMA',NULL,'P','SONOMA',6,97,8,'Y',38.3222,-122.644,238),
 ('94976','CORTE MADERA','CA','415','CORTE MADERA',NULL,'P','MARIN',6,41,8,'Y',37.9256,-122.526,35),
 ('94977','LARKSPUR','CA','415','LARKSPUR',NULL,'P','MARIN',6,41,8,'Y',37.9362,-122.535,33),
 ('94978','FAIRFAX','CA','415','FAIRFAX',NULL,'P','MARIN',6,41,8,'Y',37.9857,-122.582,93),
 ('94979','SAN ANSELMO','CA','415','SAN ANSELMO',NULL,'P','MARIN',6,41,8,'Y',37.9706,-122.561,34),
 ('94998','NOVATO','CA','415','FIREMANS FUND INS',NULL,'O','MARIN',6,41,8,'Y',38.1009,-122.571,17),
 ('94998','NOVATO','CA','415','NOVATO',NULL,'P','MARIN',6,41,8,'Y',38.1009,-122.571,17),
 ('94999','PETALUMA','CA','707','PETALUMA',NULL,'P','SONOMA',6,97,8,'Y',38.3222,-122.644,238);
/*!40000 ALTER TABLE `data_state_zipcodes` ENABLE KEYS */;


--
-- Definition of table `data_sys_config`
--

DROP TABLE IF EXISTS `data_sys_config`;
CREATE TABLE `data_sys_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `value` varchar(500) NOT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_sys_config`
--

/*!40000 ALTER TABLE `data_sys_config` DISABLE KEYS */;
INSERT INTO `data_sys_config` (`id`,`name`,`value`,`dt`) VALUES 
 (1,'last_run_add_sched_at','2011-01-22','2011-01-22 01:00:00'),
 (2,'smtp_host','192.168.1.45','2012-11-20 22:04:36'),
 (3,'domain','localhost:8080','2012-08-03 22:56:49'),
 (4,'uploaded_images_path','/Profile KA/workspace/ROOT/WebContent/static/uploads/images/','2012-11-20 21:32:45'),
 (5,'uploaded_images_domain','localhost:8080/static/uploads/images/','2012-11-20 21:27:07');
/*!40000 ALTER TABLE `data_sys_config` ENABLE KEYS */;


--
-- Definition of table `data_user`
--

DROP TABLE IF EXISTS `data_user`;
CREATE TABLE `data_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `status` bigint(20) unsigned NOT NULL,
  `password` varchar(10) DEFAULT NULL,
  `version` bigint(20) unsigned NOT NULL DEFAULT '0',
  `phone` varchar(15) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(2) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `uuid` varchar(45) NOT NULL,
  `biz_owner` int(10) unsigned NOT NULL DEFAULT '0',
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=350 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `data_user`
--

/*!40000 ALTER TABLE `data_user` DISABLE KEYS */;
INSERT INTO `data_user` (`id`,`first_name`,`last_name`,`email`,`status`,`password`,`version`,`phone`,`city`,`state`,`zipcode`,`uuid`,`biz_owner`,`dt`) VALUES 
 (1,'admin','portnoy','kirill_avramenko@sbcglobal.net',1,'kirakir',51,NULL,'san francisco','AL','94122','31869747-ec73-427e-9509-7534642885a2828',0,'2012-09-02 13:21:04'),
 (77,'kirill','avr','kirill_avramenko@yahoo.com',1,'111111',0,NULL,NULL,NULL,'94122','31869747-ec73-427e-9509-7534642885a2',3,'2013-01-10 22:46:23'),
 (90,'dima','kaljagin','dima_kaljagin@mail.ru',0,'dimadim',0,'415 990 0812','SF','CA','94103','6d6ecec1-3593-4fd4-a12c-d77582dafbb5djrig',1,'2012-09-17 14:52:21'),
 (344,'kir','gmail','kirill.avramenko@gmail.com',1,'111111',0,NULL,NULL,NULL,'94122','48e3c45f-40b6-4b70-b5d0-0837876fca7b',0,'2012-11-24 12:18:08'),
 (345,'kir','test','kir@test.com',0,'1111',0,NULL,NULL,NULL,NULL,'3b7b9c7e-b924-467e-9cb0-043cee76050b',2,'2013-01-03 17:23:42'),
 (346,'kir','test','kir2@test.com',0,'1111',0,NULL,NULL,NULL,NULL,'1b21a1e6-6930-49e7-8b18-34f50d28ff27',0,'2012-12-27 14:16:56'),
 (347,'kir','test','kir3@test.com',0,'1111',0,NULL,NULL,NULL,NULL,'70a069d0-7ab7-4024-ae87-5bca47031d22',0,'2012-12-27 14:35:07'),
 (348,'kir','test','kir55@test.com',0,'1111',0,NULL,NULL,NULL,NULL,'47abe276-4268-451a-9f02-17ef62d412b5',0,'2012-12-27 15:11:42'),
 (349,'kir','test','kir7@test.com',0,'1111',0,NULL,NULL,NULL,NULL,'00136786-736b-4320-8cc7-cc8ff512816c',0,'2012-12-27 15:19:13');
/*!40000 ALTER TABLE `data_user` ENABLE KEYS */;


--
-- Definition of table `meta_data_types`
--

DROP TABLE IF EXISTS `meta_data_types`;
CREATE TABLE `meta_data_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `db_type` varchar(45) NOT NULL,
  `java_type` varchar(45) NOT NULL,
  `format_string` varchar(45) DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_data_types`
--

/*!40000 ALTER TABLE `meta_data_types` DISABLE KEYS */;
INSERT INTO `meta_data_types` (`id`,`name`,`description`,`db_type`,`java_type`,`format_string`,`dt`) VALUES 
 (1,'Long Number',NULL,'BIGINT','Long',NULL,'2011-02-04 13:37:27'),
 (2,'Text - 2 char.',NULL,'VARCHAR(2)','String',NULL,'2011-02-04 13:42:11'),
 (3,'Text - 5 char.',NULL,'VARCHAR(5)','String',NULL,'2011-02-04 13:42:11'),
 (4,'Text - 15 char.',NULL,'VARCHAR(15)','String',NULL,'2011-02-04 13:42:11'),
 (5,'Text - 50 char.',NULL,'VARCHAR(50)','String',NULL,'2011-02-04 13:42:11'),
 (6,'Integer',NULL,'INT','Integer',NULL,'2011-02-04 13:42:11'),
 (7,'Text - 250 char.',NULL,'VARCHAR(250)','String',NULL,'2011-02-04 15:03:57'),
 (8,'Text - 1000 char.',NULL,'VARCHAR(1000)','String',NULL,'2011-02-04 15:03:57'),
 (9,'Time',NULL,'TIME','Time','h:mm a','2011-02-04 15:03:57'),
 (10,'Date',NULL,'DATE','Date','MM/dd/yy','2011-02-04 15:03:57'),
 (11,'Text - 10 char.',NULL,'VARCHAR(10)','String',NULL,'2011-02-04 15:03:57'),
 (12,'Timestamp',NULL,'TIMESTAMP','Timestamp','MM/dd/yyyy h:mm a','2012-07-03 16:53:06'),
 (13,'Text - 500 char.',NULL,'VARCHAR(500)','String',NULL,'2011-02-04 15:03:57'),
 (14,'Text - 100 char.',NULL,'VARCHAR(100)','String',NULL,'2011-02-04 15:03:57'),
 (15,'Text - 200 char.',NULL,'VARCHAR(200)','String',NULL,'2011-02-04 15:03:57'),
 (16,'Text - 45 char.',NULL,'VARCHAR(45)','String',NULL,'2011-02-04 15:03:57'),
 (17,'Long Text',NULL,'TEXT','Text',NULL,'2011-02-04 15:30:10'),
 (18,'Datetime',NULL,'DATETIME','Timestamp','MM/dd/yyyy h:mm a','2011-02-04 15:31:37'),
 (19,'Decimal',NULL,'DECIMAL','BigDecimal',NULL,'2012-01-31 16:43:14'),
 (20,'Text - 2000 char.',NULL,'VARCHAR(2000)','String',NULL,'2012-02-10 14:17:57'),
 (21,'Text - 7 char',NULL,'VARCHAR(7)','String',NULL,'2012-02-11 10:26:10'),
 (22,'JSONObject',NULL,'VARCHAR(2000)','JSONObject',NULL,'2012-05-25 11:50:08'),
 (23,'JSONArray',NULL,'VARCHAR(2000)','JSONArray',NULL,'2012-05-25 11:50:08'),
 (24,'PaddedPipeSeparatedString',NULL,'VARCHAR(250)','PaddedPipeSeparatedStr',NULL,'2012-08-16 15:25:09');
/*!40000 ALTER TABLE `meta_data_types` ENABLE KEYS */;


--
-- Definition of table `meta_html_templates`
--

DROP TABLE IF EXISTS `meta_html_templates`;
CREATE TABLE `meta_html_templates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `template` varchar(45) NOT NULL,
  `ops` varchar(45) DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_html_templates`
--

/*!40000 ALTER TABLE `meta_html_templates` DISABLE KEYS */;
INSERT INTO `meta_html_templates` (`id`,`template`,`ops`,`dt`) VALUES 
 (1,'offers_landing_page.vm','1,10','2012-09-12 21:58:23'),
 (2,'myoffers.vm','1,11','2012-09-12 21:58:24'),
 (3,'myorders.vm','1,12','2012-09-12 21:58:24'),
 (4,'signin.vm',NULL,'2012-07-24 16:33:44'),
 (5,'register.vm',NULL,'2012-04-21 13:11:31'),
 (6,'not_found.vm','1','2012-08-01 13:51:27'),
 (7,'reset_password.vm','1','2012-07-25 21:24:42'),
 (8,'forgot_password.vm',NULL,'2012-07-25 21:21:35'),
 (9,'authorize.vm','2','2012-04-28 20:54:39'),
 (10,'biz_register.vm','1','2012-07-28 22:38:28'),
 (11,'newoffer.vm','1,5,6','2012-09-12 21:58:24'),
 (12,'signout.vm','7','2012-07-19 17:25:25'),
 (13,'myaccount.vm','1','2012-07-27 14:00:12'),
 (14,'mybizaccount.vm','1,5','2012-09-12 21:58:24'),
 (15,'offer.vm','1,9','2012-09-12 21:58:24'),
 (16,'offer_html.vm',NULL,'2012-08-20 21:11:02'),
 (17,'newdeal.vm',NULL,'2013-01-19 22:16:59'),
 (18,'updatemybiz.vm','1,5','2012-09-12 21:58:24');
/*!40000 ALTER TABLE `meta_html_templates` ENABLE KEYS */;


--
-- Definition of table `meta_node_values`
--

DROP TABLE IF EXISTS `meta_node_values`;
CREATE TABLE `meta_node_values` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `node_id` bigint(20) unsigned NOT NULL,
  `value_id` bigint(20) unsigned NOT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_node_values`
--

/*!40000 ALTER TABLE `meta_node_values` DISABLE KEYS */;
INSERT INTO `meta_node_values` (`id`,`node_id`,`value_id`,`dt`) VALUES 
 (1,14,1,'2011-02-04 16:58:55'),
 (2,14,2,'2011-02-04 16:58:55'),
 (3,14,3,'2011-02-04 16:58:55'),
 (4,14,4,'2011-02-04 16:58:55'),
 (5,29,5,'2011-02-04 16:58:55'),
 (6,29,6,'2011-02-04 16:58:55'),
 (7,29,7,'2011-02-04 16:58:55'),
 (8,74,8,'2011-02-04 16:58:55'),
 (9,74,9,'2011-02-04 16:58:55'),
 (10,68,21,'2011-02-04 16:58:55'),
 (11,68,22,'2011-02-04 16:58:55'),
 (12,69,23,'2011-02-04 16:58:55'),
 (13,69,24,'2011-02-04 16:58:55'),
 (14,114,60,'2011-02-04 16:58:55'),
 (15,114,61,'2011-02-04 16:58:55'),
 (16,14,62,'2011-02-04 16:58:55'),
 (17,69,63,'2011-02-04 16:58:55'),
 (18,4,25,'2011-02-04 17:23:37'),
 (19,4,26,'2011-02-04 17:23:37'),
 (20,4,27,'2011-02-04 17:23:37'),
 (21,4,28,'2011-02-04 17:23:37'),
 (22,4,29,'2011-02-04 17:23:37'),
 (23,4,30,'2011-02-04 17:23:37'),
 (24,4,31,'2011-02-04 17:23:37'),
 (25,4,32,'2011-02-04 17:23:37'),
 (26,4,33,'2011-02-04 17:23:37'),
 (27,4,34,'2011-02-04 17:23:37'),
 (28,4,35,'2011-02-04 17:23:37'),
 (29,4,36,'2011-02-04 17:23:37'),
 (30,4,37,'2011-02-04 17:23:37'),
 (31,4,38,'2011-02-04 17:23:37'),
 (32,4,39,'2011-02-04 17:23:37'),
 (33,4,40,'2011-02-04 17:23:37'),
 (34,4,41,'2011-02-04 17:23:37'),
 (35,4,42,'2011-02-04 17:23:37'),
 (36,4,43,'2011-02-04 17:23:37'),
 (37,4,44,'2011-02-04 17:23:37'),
 (38,4,45,'2011-02-04 17:23:37'),
 (39,4,46,'2011-02-04 17:23:37'),
 (40,4,47,'2011-02-04 17:23:37'),
 (41,4,48,'2011-02-04 17:23:37'),
 (42,4,49,'2011-02-04 17:23:37'),
 (43,4,50,'2011-02-04 17:23:37'),
 (44,4,51,'2011-02-04 17:23:37'),
 (45,4,52,'2011-02-04 17:23:37'),
 (46,4,53,'2011-02-04 17:23:37'),
 (47,4,54,'2011-02-04 17:23:37'),
 (48,4,55,'2011-02-04 17:23:37'),
 (49,4,56,'2011-02-04 17:23:37'),
 (50,4,57,'2011-02-04 17:23:37'),
 (51,4,58,'2011-02-04 17:23:37'),
 (52,4,59,'2011-02-04 17:23:37'),
 (53,85,25,'2011-02-04 17:20:47'),
 (54,85,26,'2011-02-04 17:20:47'),
 (55,85,27,'2011-02-04 17:20:47'),
 (56,85,28,'2011-02-04 17:20:47'),
 (57,85,29,'2011-02-04 17:20:47'),
 (58,85,30,'2011-02-04 17:20:47'),
 (59,85,31,'2011-02-04 17:20:47'),
 (60,85,32,'2011-02-04 17:20:47'),
 (61,85,33,'2011-02-04 17:20:47'),
 (62,85,34,'2011-02-04 17:20:47'),
 (63,85,35,'2011-02-04 17:20:47'),
 (64,85,36,'2011-02-04 17:20:47'),
 (65,85,37,'2011-02-04 17:20:47'),
 (66,85,38,'2011-02-04 17:20:48'),
 (67,85,39,'2011-02-04 17:20:48'),
 (68,85,40,'2011-02-04 17:20:48'),
 (69,85,41,'2011-02-04 17:20:48'),
 (70,85,42,'2011-02-04 17:20:48'),
 (71,85,43,'2011-02-04 17:20:48'),
 (72,85,44,'2011-02-04 17:20:48'),
 (73,85,45,'2011-02-04 17:20:48'),
 (74,85,46,'2011-02-04 17:20:48'),
 (75,85,47,'2011-02-04 17:20:48'),
 (76,85,48,'2011-02-04 17:20:48'),
 (77,85,49,'2011-02-04 17:20:48'),
 (78,85,50,'2011-02-04 17:20:48'),
 (79,85,51,'2011-02-04 17:20:48'),
 (80,85,52,'2011-02-04 17:20:48'),
 (81,85,53,'2011-02-04 17:20:48'),
 (82,85,54,'2011-02-04 17:20:48'),
 (83,85,55,'2011-02-04 17:20:48'),
 (84,85,56,'2011-02-04 17:20:48'),
 (85,85,57,'2011-02-04 17:20:48'),
 (86,85,58,'2011-02-04 17:20:48'),
 (87,85,59,'2011-02-04 17:20:48'),
 (88,102,25,'2011-02-04 17:31:35'),
 (89,102,26,'2011-02-04 17:31:35'),
 (90,102,27,'2011-02-04 17:31:35'),
 (91,102,28,'2011-02-04 17:31:35'),
 (92,102,29,'2011-02-04 17:31:35'),
 (93,102,30,'2011-02-04 17:31:35'),
 (94,102,31,'2011-02-04 17:31:35'),
 (95,102,32,'2011-02-04 17:31:35'),
 (96,102,33,'2011-02-04 17:31:35'),
 (97,102,34,'2011-02-04 17:31:36'),
 (98,102,35,'2011-02-04 17:31:36'),
 (99,102,36,'2011-02-04 17:31:36'),
 (100,102,37,'2011-02-04 17:31:36'),
 (101,102,38,'2011-02-04 17:31:36'),
 (102,102,39,'2011-02-04 17:31:36'),
 (103,102,40,'2011-02-04 17:31:36'),
 (104,102,41,'2011-02-04 17:31:36'),
 (105,102,42,'2011-02-04 17:31:36'),
 (106,102,43,'2011-02-04 17:31:36'),
 (107,102,44,'2011-02-04 17:31:36'),
 (108,102,45,'2011-02-04 17:31:36'),
 (109,102,46,'2011-02-04 17:31:36'),
 (110,102,47,'2011-02-04 17:31:36'),
 (111,102,48,'2011-02-04 17:31:36'),
 (112,102,49,'2011-02-04 17:31:36'),
 (113,102,50,'2011-02-04 17:31:36'),
 (114,102,51,'2011-02-04 17:31:36'),
 (115,102,52,'2011-02-04 17:31:36'),
 (116,102,53,'2011-02-04 17:31:36'),
 (117,102,54,'2011-02-04 17:31:36'),
 (118,102,55,'2011-02-04 17:31:36'),
 (119,102,56,'2011-02-04 17:31:36'),
 (120,102,57,'2011-02-04 17:31:36'),
 (121,102,58,'2011-02-04 17:31:36'),
 (122,102,59,'2011-02-04 17:31:36');
/*!40000 ALTER TABLE `meta_node_values` ENABLE KEYS */;


--
-- Definition of table `meta_nodes`
--

DROP TABLE IF EXISTS `meta_nodes`;
CREATE TABLE `meta_nodes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_object_id` bigint(20) unsigned NOT NULL,
  `node_name` varchar(100) NOT NULL,
  `node_type` int(10) unsigned NOT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  `required` bigint(20) DEFAULT NULL,
  `cardinality` bigint(20) DEFAULT NULL,
  `customizable` int(10) unsigned DEFAULT NULL,
  `html_type` varchar(45) DEFAULT NULL,
  `html_label` varchar(45) DEFAULT NULL,
  `validation` varchar(255) DEFAULT NULL,
  `ref_obj_id` bigint(20) unsigned DEFAULT NULL,
  `key_field` varchar(100) DEFAULT NULL,
  `ref_obj_key_field` varchar(45) DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_nodes`
--

/*!40000 ALTER TABLE `meta_nodes` DISABLE KEYS */;
INSERT INTO `meta_nodes` (`id`,`parent_object_id`,`node_name`,`node_type`,`type_id`,`required`,`cardinality`,`customizable`,`html_type`,`html_label`,`validation`,`ref_obj_id`,`key_field`,`ref_obj_key_field`,`dt`) VALUES 
 (1,3,'id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-12-30 21:42:24'),
 (2,3,'name',0,11,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-12-30 21:42:25'),
 (3,3,'status',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-12-30 21:42:25'),
 (4,3,'dt',0,12,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-12-30 21:42:25'),
 (5,4,'id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-12-30 21:45:44'),
 (6,4,'category_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-12-30 21:45:44'),
 (7,4,'name',0,11,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-12-30 21:45:44'),
 (8,2,'first_name',0,5,1,0,0,'TEXTBOX',NULL,NULL,NULL,NULL,NULL,'2007-08-26 09:00:00'),
 (9,2,'last_name',0,5,1,0,0,'TEXTBOX',NULL,NULL,NULL,NULL,NULL,'2007-08-26 09:00:00'),
 (10,4,'status',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-12-30 21:45:44'),
 (11,2,'email',0,5,1,0,0,'TEXTBOX',NULL,NULL,NULL,NULL,NULL,'2007-08-26 09:00:00'),
 (12,2,'password',0,11,1,0,0,'PASSWORD',NULL,NULL,NULL,NULL,NULL,'2007-08-26 09:00:00'),
 (13,4,'dt',0,12,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-12-30 21:45:44'),
 (14,2,'status',0,6,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2007-08-26 09:00:00'),
 (15,10,'subcategory_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-12-30 21:56:59'),
 (18,2,'version',0,6,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2007-09-12 13:00:00'),
 (19,2,'id',3,1,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2007-10-06 09:00:00'),
 (20,1,'id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 12:32:12'),
 (21,1,'user_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 12:32:13'),
 (22,1,'biz_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 12:32:13'),
 (23,1,'status',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 12:32:13'),
 (24,1,'type',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 12:32:13'),
 (25,1,'name',0,14,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 12:32:13'),
 (26,1,'description',0,7,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 12:32:13'),
 (27,1,'expiration',0,18,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 12:32:13'),
 (28,1,'latitude',0,19,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 12:32:13'),
 (29,1,'longitude',0,19,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 12:32:13'),
 (30,1,'dt',0,12,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 12:32:13'),
 (31,1,'category_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 15:28:50'),
 (32,1,'subcategory_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 15:28:50'),
 (33,1,'address_name',0,14,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 15:28:50'),
 (34,1,'street',0,14,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 15:28:50'),
 (35,1,'city',0,14,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 15:28:50'),
 (36,1,'state',0,2,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 15:28:50'),
 (37,1,'zipcode',0,3,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-16 15:28:50'),
 (38,11,'longitude',0,19,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-20 22:58:48'),
 (39,11,'latitude',0,19,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-20 22:58:48'),
 (40,1,'regular_price',0,19,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-24 17:25:01'),
 (41,10,'category_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-10-02 15:57:10'),
 (42,10,'id',3,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2007-10-27 10:00:00'),
 (43,10,'name',0,7,0,0,0,'TEXTBOX',NULL,NULL,NULL,NULL,NULL,'2007-10-27 10:00:00'),
 (44,10,'description',0,13,1,0,0,'TEXTBOX',NULL,NULL,NULL,NULL,NULL,'2007-10-27 10:00:00'),
 (45,10,'logo',0,14,1,0,0,'IMAGE',NULL,NULL,NULL,NULL,NULL,'2007-10-27 10:00:00'),
 (46,10,'phone',0,3,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2007-10-27 10:00:00'),
 (47,10,'fax',0,3,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2007-10-27 10:00:00'),
 (48,10,'email',0,5,1,0,0,'',NULL,NULL,NULL,NULL,NULL,'2007-10-27 10:00:00'),
 (49,10,'web',0,14,1,0,0,'TEXTBOX',NULL,NULL,NULL,NULL,NULL,'2007-10-27 10:00:00'),
 (50,10,'web_name',0,14,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-10-02 15:57:11'),
 (51,10,'status',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2007-11-17 13:00:00'),
 (52,1,'deal_price',0,19,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-01-24 17:25:01'),
 (79,10,'locations',2,NULL,1,1,0,NULL,NULL,NULL,11,NULL,NULL,'2010-01-01 18:14:38'),
 (80,11,'id',3,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-01-01 18:37:55'),
 (81,11,'biz_id',4,1,0,0,0,NULL,NULL,NULL,10,NULL,'id','2010-01-01 18:37:55'),
 (82,11,'name',0,14,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-01-01 18:37:55'),
 (83,11,'street',0,14,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-01-01 18:37:55'),
 (84,11,'city',0,5,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-01-01 18:37:55'),
 (85,11,'state',0,2,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-01-01 18:37:55'),
 (86,11,'zipcode',0,3,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-01-01 18:37:55'),
 (87,11,'phone',0,4,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-01-01 18:37:55'),
 (88,11,'fax',0,5,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-01-01 18:44:13'),
 (89,1,'pics',0,23,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-03-11 16:38:53'),
 (90,1,'phone',0,21,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2013-03-11 16:38:53'),
 (101,2,'city',0,5,1,0,0,'',NULL,NULL,NULL,NULL,NULL,'2008-09-15 19:00:00'),
 (102,2,'state',0,2,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2008-09-15 19:00:00'),
 (103,2,'zipcode',0,3,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2008-09-15 19:00:00'),
 (104,19,'id',3,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-11-05 20:19:50'),
 (105,19,'status',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-11-05 20:19:51'),
 (106,19,'recip_to',0,14,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-11-05 20:19:51'),
 (107,19,'subj',0,15,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-11-05 20:19:51'),
 (108,19,'body',0,17,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-11-05 20:19:51'),
 (112,19,'send_date',0,18,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-11-05 20:19:51'),
 (113,19,'dt',0,12,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-11-05 20:19:51'),
 (126,2,'phone',0,4,0,0,0,'TEXTBOX',NULL,NULL,NULL,NULL,NULL,'2010-12-05 14:13:25'),
 (128,22,'id',3,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-12-20 21:28:19'),
 (129,22,'name',0,16,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-12-20 21:28:19'),
 (130,22,'value',0,16,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2010-12-20 21:28:19'),
 (136,10,'owner_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2011-02-02 09:56:57'),
 (137,23,'id',3,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-30 22:58:49'),
 (138,23,'name',0,14,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-30 22:58:49'),
 (139,23,'description',0,7,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-30 22:58:49'),
 (140,23,'status',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-30 22:58:49'),
 (141,23,'pickup_type',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-30 22:58:49'),
 (142,23,'close_date',0,18,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-30 22:58:49'),
 (143,23,'discounts',0,22,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-30 22:58:49'),
 (144,23,'items',0,23,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-30 22:58:49'),
 (145,23,'items_ordered',0,24,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-30 22:58:49'),
 (148,23,'di_type',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-30 22:58:49'),
 (149,23,'total_ordered',0,6,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-30 22:58:49'),
 (150,23,'user_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 17:15:47'),
 (151,23,'dt',0,12,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 17:15:47'),
 (152,24,'id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 17:15:47'),
 (153,24,'offer_id',4,1,0,0,0,NULL,NULL,NULL,23,NULL,'id','2012-01-31 17:15:47'),
 (154,24,'status',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 17:15:47'),
 (155,24,'name',0,14,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 17:15:47'),
 (156,24,'description',0,7,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 17:15:47'),
 (157,24,'price',0,19,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 17:15:47'),
 (158,24,'total',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 17:15:47'),
 (159,24,'ordered',0,6,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 17:15:47'),
 (160,24,'user_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 17:15:47'),
 (161,24,'dt',0,12,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 20:24:44'),
 (162,25,'id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 20:33:54'),
 (163,25,'offer',2,1,0,0,0,NULL,NULL,NULL,23,'offer_id','id','2012-01-31 20:33:54'),
 (164,25,'user_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 20:33:54'),
 (165,25,'status',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 20:33:54'),
 (166,25,'items',0,24,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 20:33:54'),
 (167,25,'dt',0,12,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-01-31 20:33:54'),
 (173,23,'offer_items',2,NULL,0,1,0,NULL,NULL,NULL,24,NULL,NULL,'2012-02-01 23:13:43'),
 (175,25,'user_details',0,22,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-02-11 10:39:15'),
 (176,23,'biz_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-02-19 14:26:23'),
 (177,23,'biz_name',0,22,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-02-19 22:30:16'),
 (178,23,'pickup',0,22,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-02-19 22:32:59'),
 (179,23,'total',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-02-25 20:15:48'),
 (180,27,'id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-03-01 19:37:27'),
 (181,27,'offer_id',4,1,0,0,0,NULL,NULL,NULL,23,NULL,'id','2012-03-01 19:37:27'),
 (182,27,'location_type',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-03-01 19:37:27'),
 (183,27,'name',0,14,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-03-01 19:37:28'),
 (184,27,'address',0,14,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-03-01 19:37:28'),
 (185,27,'city',0,16,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-03-01 19:37:28'),
 (186,27,'state',0,3,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-03-01 19:37:28'),
 (187,27,'zip',0,3,1,0,0,'',NULL,NULL,NULL,NULL,NULL,'2012-03-01 19:37:28'),
 (188,27,'dt',0,12,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-03-01 19:37:28'),
 (189,25,'offer_id',4,1,0,0,0,NULL,NULL,NULL,23,NULL,'id','2012-03-19 10:32:01'),
 (190,23,'op',2,NULL,1,1,0,NULL,NULL,NULL,25,NULL,NULL,'2012-03-19 10:37:32'),
 (193,2,'uuid',0,16,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-04-11 20:54:03'),
 (194,2,'biz_owner',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-05-08 15:15:48'),
 (195,24,'unit',0,4,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-05-24 13:23:31'),
 (196,23,'ol',2,NULL,0,1,0,NULL,NULL,NULL,27,NULL,'id','2012-06-04 22:20:46'),
 (197,27,'latitude',0,19,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-04 22:26:33'),
 (198,27,'longitude',0,19,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-04 22:26:34'),
 (199,28,'zipcode',0,3,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-04 22:33:41'),
 (200,28,'longitude',0,19,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-04 22:33:41'),
 (201,28,'latitude',0,19,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-04 22:33:41'),
 (202,27,'user_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-05 16:51:37'),
 (203,29,'items',0,24,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-23 21:28:47'),
 (204,29,'status',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-10-28 01:00:03'),
 (206,29,'total',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-23 21:34:43'),
 (207,29,'total_ordered',0,6,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-06-23 21:34:43'),
 (208,25,'status_change_dt',0,12,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-07-05 17:06:38'),
 (209,25,'closed_discount',0,19,1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-07-05 17:07:33'),
 (210,30,'message',0,7,0,1,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-07-26 15:08:17'),
 (211,31,'from',0,5,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-10-16 15:37:25'),
 (212,31,'to',0,5,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-10-16 15:37:25'),
 (213,31,'subject',0,5,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-10-16 15:37:25'),
 (214,31,'message',0,7,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-10-16 15:37:25'),
 (215,31,'offer_id',0,1,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-10-21 12:13:42'),
 (216,19,'from_email',0,14,0,0,0,NULL,NULL,NULL,NULL,NULL,NULL,'2012-10-21 20:57:21');
/*!40000 ALTER TABLE `meta_nodes` ENABLE KEYS */;


--
-- Definition of table `meta_objects`
--

DROP TABLE IF EXISTS `meta_objects`;
CREATE TABLE `meta_objects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `data_table_name` varchar(256) NOT NULL,
  `custom_nodes` int(10) unsigned NOT NULL DEFAULT '0',
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_objects`
--

/*!40000 ALTER TABLE `meta_objects` DISABLE KEYS */;
INSERT INTO `meta_objects` (`id`,`name`,`data_table_name`,`custom_nodes`,`dt`) VALUES 
 (1,'deal','data_deal',0,'2013-01-16 11:47:16'),
 (2,'user','data_user',0,'2007-05-28 18:00:00'),
 (3,'biz_category','data_biz_category',0,'2012-12-30 21:31:34'),
 (4,'biz_subcategory','data_biz_subcategory',0,'2012-12-30 21:31:34'),
 (10,'biz','data_biz',0,'2007-10-27 13:00:00'),
 (11,'locations','data_biz_location',0,'2010-01-01 18:12:34'),
 (19,'email','data_email',0,'2010-11-05 19:12:00'),
 (22,'sys_conf','data_sys_config',0,'2010-12-20 21:25:17'),
 (23,'offers','data_offers',0,'2012-01-30 21:33:05'),
 (24,'offer_items','data_offer_items',0,'2012-01-30 21:33:05'),
 (25,'op','data_offer_participants',0,'2012-01-30 21:33:05'),
 (27,'ol','data_offer_locations',0,'2012-03-01 19:25:42'),
 (28,'state_zipcodes','data_state_zipcodes',0,'2012-06-04 22:29:32'),
 (29,'offer_order_ret','no_table',0,'2012-06-23 21:25:10'),
 (30,'error','no_table',0,'2012-07-26 15:05:52'),
 (31,'email_message','no_table',0,'2012-10-16 14:58:36');
/*!40000 ALTER TABLE `meta_objects` ENABLE KEYS */;


--
-- Definition of table `meta_operation_params`
--

DROP TABLE IF EXISTS `meta_operation_params`;
CREATE TABLE `meta_operation_params` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `operation_id` bigint(20) unsigned DEFAULT NULL,
  `parent_oper_param_id` bigint(20) unsigned DEFAULT NULL,
  `type` int(10) unsigned NOT NULL,
  `type_id` bigint(20) unsigned NOT NULL,
  `value_type` int(10) unsigned NOT NULL,
  `value` varchar(40) DEFAULT NULL,
  `operand` varchar(10) DEFAULT NULL,
  `required` int(11) NOT NULL DEFAULT '0',
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=533 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_operation_params`
--

/*!40000 ALTER TABLE `meta_operation_params` DISABLE KEYS */;
INSERT INTO `meta_operation_params` (`id`,`operation_id`,`parent_oper_param_id`,`type`,`type_id`,`value_type`,`value`,`operand`,`required`,`dt`) VALUES 
 (1,1,NULL,0,138,0,NULL,NULL,0,'2012-04-06 14:09:22'),
 (2,1,NULL,0,139,0,NULL,NULL,1,'2012-05-25 15:26:39'),
 (3,1,NULL,0,140,3,'0',NULL,0,'2012-05-24 14:25:56'),
 (4,1,NULL,0,141,0,NULL,NULL,0,'2012-04-06 14:17:27'),
 (5,1,NULL,0,142,0,NULL,NULL,0,'2012-04-06 14:17:27'),
 (6,1,NULL,0,143,0,NULL,NULL,0,'2012-04-06 14:17:27'),
 (7,NULL,16,0,153,0,NULL,NULL,0,'2012-04-07 10:18:13'),
 (8,2,NULL,0,144,0,NULL,NULL,0,'2012-04-07 22:01:34'),
 (9,1,NULL,0,148,0,NULL,NULL,0,'2012-04-06 14:17:27'),
 (10,1,NULL,0,149,3,'0',NULL,0,'2012-08-31 12:04:04'),
 (11,1,NULL,0,150,1,'user/id',NULL,0,'2012-05-24 14:25:56'),
 (12,1,NULL,0,176,0,NULL,NULL,0,'2012-04-06 14:17:27'),
 (13,1,NULL,0,177,0,NULL,NULL,0,'2012-04-06 14:17:27'),
 (14,1,NULL,0,178,0,NULL,NULL,0,'2012-04-06 14:17:27'),
 (15,1,NULL,0,179,0,NULL,NULL,0,'2012-04-06 14:17:27'),
 (16,1,NULL,0,173,0,NULL,NULL,0,'2012-04-06 14:41:58'),
 (17,NULL,16,0,154,3,'0',NULL,0,'2012-05-24 14:36:44'),
 (18,NULL,16,0,155,0,NULL,NULL,0,'2012-04-06 17:25:09'),
 (19,NULL,16,0,156,0,NULL,NULL,1,'2012-05-25 15:27:07'),
 (20,NULL,16,0,157,0,NULL,NULL,0,'2012-04-06 17:25:09'),
 (21,NULL,16,0,158,0,NULL,NULL,0,'2012-04-06 17:25:09'),
 (22,NULL,16,0,159,3,'0',NULL,0,'2012-08-31 12:20:15'),
 (23,NULL,16,0,160,1,'user/id',NULL,0,'2012-05-24 14:36:44'),
 (25,2,NULL,1,137,0,NULL,'=',0,'2012-04-07 22:52:09'),
 (26,2,NULL,1,150,1,'user/id','=',0,'2012-05-26 14:26:39'),
 (27,3,NULL,0,137,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (28,3,NULL,0,138,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (29,3,NULL,0,139,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (30,3,NULL,0,140,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (31,3,NULL,0,141,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (32,3,NULL,0,142,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (33,3,NULL,0,143,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (34,3,NULL,0,144,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (35,3,NULL,0,145,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (36,3,NULL,0,148,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (37,3,NULL,0,149,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (38,3,NULL,0,176,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (39,3,NULL,0,177,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (40,3,NULL,0,178,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (41,3,NULL,0,179,0,NULL,NULL,0,'2012-04-09 13:15:44'),
 (42,3,NULL,1,150,0,NULL,'=',0,'2012-04-09 13:35:28'),
 (43,3,NULL,0,173,0,NULL,NULL,0,'2012-04-09 13:51:00'),
 (44,3,NULL,0,190,0,NULL,NULL,0,'2012-04-09 13:51:00'),
 (45,NULL,43,0,152,0,NULL,NULL,0,'2012-04-09 13:55:02'),
 (46,NULL,43,0,153,0,NULL,NULL,0,'2012-04-09 13:55:02'),
 (47,NULL,43,0,154,0,NULL,NULL,0,'2012-04-09 13:55:02'),
 (48,NULL,43,0,155,0,NULL,NULL,0,'2012-04-09 13:55:02'),
 (49,NULL,43,0,156,0,NULL,NULL,0,'2012-04-09 13:55:02'),
 (50,NULL,43,0,157,0,NULL,NULL,0,'2012-04-09 13:55:02'),
 (51,NULL,43,0,158,0,NULL,NULL,0,'2012-04-09 13:55:02'),
 (52,NULL,43,0,159,0,NULL,NULL,0,'2012-04-09 13:55:02'),
 (53,NULL,44,0,162,0,NULL,NULL,0,'2012-04-09 13:58:09'),
 (54,NULL,44,0,165,0,NULL,NULL,0,'2012-04-09 13:58:09'),
 (55,NULL,44,0,166,0,NULL,NULL,0,'2012-04-09 13:58:09'),
 (56,NULL,44,0,175,0,NULL,NULL,0,'2012-04-09 13:58:09'),
 (57,NULL,44,0,189,0,NULL,NULL,0,'2012-04-09 13:58:09'),
 (64,5,NULL,2,39,1,'user/id',NULL,0,'2012-05-03 13:06:10'),
 (65,5,NULL,2,40,0,NULL,NULL,0,'2012-04-09 16:10:30'),
 (66,5,NULL,2,41,0,NULL,NULL,0,'2012-04-09 16:10:30'),
 (67,5,NULL,2,42,3,'0',NULL,0,'2012-05-15 20:48:21'),
 (68,6,NULL,0,162,0,NULL,NULL,0,'2012-04-10 15:32:32'),
 (69,6,NULL,0,163,0,NULL,NULL,0,'2012-04-10 15:32:32'),
 (70,6,NULL,0,165,0,NULL,NULL,0,'2012-04-10 15:32:32'),
 (71,6,NULL,0,166,0,NULL,NULL,0,'2012-04-10 15:32:32'),
 (72,6,NULL,0,175,0,NULL,NULL,0,'2012-04-10 15:32:32'),
 (73,6,NULL,1,164,1,'user/id','=',0,'2012-05-15 20:33:57'),
 (74,7,NULL,0,137,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (75,7,NULL,0,138,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (76,7,NULL,0,139,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (77,7,NULL,0,140,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (78,7,NULL,0,141,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (79,7,NULL,0,142,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (80,7,NULL,0,143,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (81,7,NULL,0,144,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (82,7,NULL,0,145,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (83,7,NULL,0,148,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (84,7,NULL,0,149,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (85,7,NULL,0,173,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (86,7,NULL,0,177,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (87,7,NULL,0,178,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (88,7,NULL,0,179,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (89,7,NULL,0,190,0,NULL,NULL,0,'2012-04-10 17:28:24'),
 (90,7,NULL,1,150,1,'user/id','=',0,'2012-05-16 21:32:14'),
 (91,8,NULL,0,8,0,NULL,NULL,0,'2012-04-10 22:55:41'),
 (92,8,NULL,0,9,0,NULL,NULL,0,'2012-04-10 22:55:41'),
 (93,8,NULL,0,11,0,NULL,NULL,0,'2012-04-10 22:55:41'),
 (94,8,NULL,0,12,0,NULL,NULL,0,'2012-04-10 22:55:41'),
 (95,8,NULL,0,14,3,'0',NULL,0,'2012-04-27 13:43:38'),
 (96,4,NULL,1,10,3,'0','=',0,'2012-12-31 19:46:26'),
 (97,4,NULL,0,5,0,NULL,NULL,0,'2012-12-31 19:46:26'),
 (98,8,NULL,0,103,0,NULL,NULL,1,'2012-12-27 14:07:28'),
 (99,34,NULL,1,3,3,'0','=',0,'2012-12-31 19:50:43'),
 (100,8,NULL,0,193,2,NULL,NULL,0,'2012-04-11 22:35:23'),
 (101,9,NULL,0,19,0,NULL,NULL,0,'2012-04-15 21:44:52'),
 (102,9,NULL,0,14,0,NULL,NULL,0,'2012-04-15 21:44:52'),
 (103,9,NULL,1,19,0,NULL,'=',0,'2012-04-15 21:44:52'),
 (104,9,NULL,1,193,0,NULL,'=',0,'2012-04-15 21:44:52'),
 (105,10,NULL,1,11,0,NULL,'=',0,'2012-04-16 13:10:36'),
 (106,10,NULL,1,12,0,NULL,'=',0,'2012-04-16 13:10:36'),
 (107,10,NULL,0,8,0,NULL,NULL,0,'2012-04-16 13:10:36'),
 (108,10,NULL,0,9,0,NULL,NULL,0,'2012-04-16 13:10:36'),
 (109,10,NULL,0,11,0,NULL,NULL,0,'2012-04-16 13:10:36'),
 (110,10,NULL,0,14,0,NULL,NULL,0,'2012-04-16 13:10:36'),
 (111,10,NULL,0,19,0,NULL,NULL,0,'2012-04-16 13:10:36'),
 (112,10,NULL,0,193,0,NULL,NULL,0,'2012-04-16 13:10:36'),
 (113,10,NULL,1,14,3,'3','!=',0,'2012-04-16 13:44:44'),
 (114,11,NULL,0,8,0,NULL,NULL,0,'2012-04-23 17:12:02'),
 (115,11,NULL,0,9,0,NULL,NULL,0,'2012-04-23 17:12:03'),
 (116,11,NULL,1,19,0,NULL,'=',0,'2012-04-23 17:12:16'),
 (117,12,NULL,1,11,0,NULL,'=',0,'2012-04-27 14:21:15'),
 (118,12,NULL,1,14,3,'0,1,2','=',0,'2012-04-27 16:41:11'),
 (119,12,NULL,0,11,0,NULL,NULL,0,'2012-04-27 14:24:09'),
 (120,11,NULL,0,103,0,NULL,NULL,0,'2012-04-27 17:15:31'),
 (121,13,NULL,2,43,0,NULL,NULL,0,'2012-04-27 17:40:14'),
 (122,11,NULL,0,19,0,NULL,NULL,0,'2012-04-27 19:14:27'),
 (123,14,NULL,1,193,0,NULL,'=',0,'2012-04-28 21:03:54'),
 (124,14,NULL,1,19,0,NULL,'=',0,'2012-04-28 21:03:55'),
 (125,14,NULL,1,14,3,'0','=',0,'2012-04-28 21:03:55'),
 (126,14,NULL,0,19,0,NULL,NULL,0,'2012-04-28 21:03:55'),
 (127,15,NULL,1,193,0,NULL,'=',0,'2012-04-28 21:26:05'),
 (128,15,NULL,1,19,0,NULL,'=',0,'2012-04-28 21:26:06'),
 (129,15,NULL,1,14,3,'0','=',0,'2012-04-28 21:26:06'),
 (130,15,NULL,0,14,3,'1',NULL,0,'2012-04-28 21:26:06'),
 (131,16,NULL,1,193,0,NULL,'=',0,'2012-04-28 21:26:06'),
 (132,16,NULL,1,19,0,NULL,'=',0,'2012-04-28 21:26:06'),
 (133,16,NULL,1,14,3,'0','=',0,'2012-04-28 21:26:06'),
 (134,16,NULL,0,14,3,'3',NULL,0,'2012-04-28 21:26:06'),
 (135,13,NULL,2,44,3,'-1',NULL,0,'2012-04-30 12:55:25'),
 (136,17,NULL,2,43,0,NULL,NULL,0,'2012-04-30 12:58:18'),
 (137,17,NULL,2,44,1,'user/id',NULL,0,'2012-04-30 14:14:19'),
 (138,5,NULL,0,203,0,NULL,NULL,0,'2012-06-24 20:44:53'),
 (139,4,NULL,0,6,0,NULL,NULL,0,'2012-12-31 19:46:26'),
 (140,34,NULL,0,1,0,NULL,NULL,0,'2012-12-31 19:50:43'),
 (141,5,NULL,0,206,0,NULL,NULL,0,'2012-06-24 20:44:53'),
 (142,13,NULL,0,137,0,NULL,NULL,0,'2012-05-03 21:06:22'),
 (143,13,NULL,0,138,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (144,13,NULL,0,139,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (145,13,NULL,0,140,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (146,13,NULL,0,141,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (147,13,NULL,0,142,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (148,13,NULL,0,143,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (149,13,NULL,0,144,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (150,13,NULL,0,145,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (151,13,NULL,0,148,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (152,13,NULL,0,149,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (153,13,NULL,0,176,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (154,13,NULL,0,177,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (155,13,NULL,0,178,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (156,13,NULL,0,179,0,NULL,NULL,0,'2012-05-03 21:06:23'),
 (157,17,NULL,0,137,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (158,17,NULL,0,138,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (159,17,NULL,0,139,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (160,17,NULL,0,140,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (161,17,NULL,0,141,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (162,17,NULL,0,142,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (163,17,NULL,0,143,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (164,17,NULL,0,144,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (165,17,NULL,0,145,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (166,17,NULL,0,148,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (167,17,NULL,0,149,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (168,17,NULL,0,176,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (169,17,NULL,0,177,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (170,17,NULL,0,178,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (171,17,NULL,0,179,0,NULL,NULL,0,'2012-05-03 22:05:44'),
 (172,18,NULL,1,19,1,'user/id','=',0,'2012-05-08 22:26:48'),
 (173,18,NULL,1,194,3,'1','=',0,'2012-05-08 17:04:00'),
 (174,18,NULL,0,19,0,NULL,NULL,0,'2012-05-08 17:04:00'),
 (175,11,NULL,0,194,0,NULL,NULL,0,'2012-05-08 22:50:54'),
 (176,19,NULL,0,43,0,NULL,NULL,0,'2012-05-09 15:15:31'),
 (177,19,NULL,0,44,0,NULL,NULL,1,'2013-01-02 22:54:23'),
 (178,19,NULL,0,46,0,NULL,NULL,0,'2012-05-09 15:15:31'),
 (179,19,NULL,0,48,0,NULL,NULL,0,'2012-05-09 15:15:31'),
 (180,19,NULL,0,136,0,NULL,NULL,0,'2013-01-02 22:54:23'),
 (181,19,NULL,0,51,3,'0',NULL,0,'2012-05-09 15:15:31'),
 (183,19,NULL,0,79,0,NULL,NULL,0,'2012-05-09 15:20:34'),
 (184,NULL,183,0,83,0,NULL,NULL,0,'2012-05-09 15:20:34'),
 (185,NULL,183,0,84,0,NULL,NULL,0,'2012-05-09 15:20:34'),
 (186,NULL,183,0,85,0,NULL,NULL,0,'2012-05-09 15:20:34'),
 (187,NULL,183,0,86,0,NULL,NULL,0,'2012-05-09 15:20:34'),
 (188,NULL,183,0,81,0,NULL,NULL,0,'2012-05-09 22:02:22'),
 (189,20,NULL,1,19,0,NULL,'=',0,'2013-01-03 17:16:10'),
 (190,20,NULL,0,194,3,'2',NULL,0,'2012-05-09 22:39:29'),
 (191,21,NULL,2,39,1,'user/id',NULL,0,'2012-05-15 21:07:28'),
 (192,21,NULL,2,40,0,NULL,NULL,0,'2012-05-15 21:07:28'),
 (193,21,NULL,2,41,3,NULL,NULL,0,'2012-05-15 21:07:28'),
 (194,21,NULL,2,42,3,'1',NULL,0,'2012-05-15 21:07:28'),
 (195,22,NULL,2,39,1,'user/id',NULL,0,'2012-05-22 20:29:59'),
 (196,22,NULL,2,40,0,NULL,NULL,0,'2012-05-22 20:29:59'),
 (197,22,NULL,2,41,3,NULL,NULL,0,'2012-05-22 20:29:59'),
 (198,22,NULL,2,42,3,'2',NULL,0,'2012-05-22 20:29:59'),
 (199,23,NULL,0,43,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (200,23,NULL,0,46,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (201,23,NULL,0,49,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (202,23,NULL,0,79,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (203,23,NULL,0,42,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (204,NULL,202,0,80,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (205,NULL,202,0,81,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (206,NULL,202,0,82,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (207,NULL,202,0,83,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (208,NULL,202,0,84,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (209,NULL,202,0,85,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (210,NULL,202,0,86,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (211,NULL,202,0,87,0,NULL,NULL,0,'2012-05-23 20:55:04'),
 (212,23,NULL,1,136,0,NULL,'=',0,'2013-01-19 21:46:11'),
 (213,NULL,16,0,195,0,NULL,NULL,0,'2012-05-24 14:38:38'),
 (214,24,NULL,0,137,0,NULL,NULL,0,'2012-05-31 17:44:49'),
 (215,24,NULL,0,138,0,NULL,NULL,0,'2012-05-31 17:44:49'),
 (216,24,NULL,0,139,0,NULL,NULL,0,'2012-05-31 17:44:49'),
 (217,24,NULL,0,140,0,NULL,NULL,0,'2012-05-31 17:49:11'),
 (218,24,NULL,0,141,0,NULL,NULL,0,'2012-05-31 17:49:11'),
 (219,24,NULL,0,142,0,NULL,NULL,0,'2012-05-31 17:49:11'),
 (220,24,NULL,0,143,0,NULL,NULL,0,'2012-05-31 17:49:11'),
 (221,24,NULL,0,144,0,NULL,NULL,0,'2012-05-31 17:49:11'),
 (222,24,NULL,0,145,0,NULL,NULL,0,'2012-05-31 17:49:11'),
 (223,24,NULL,0,148,0,NULL,NULL,0,'2012-05-31 20:39:58'),
 (224,24,NULL,0,149,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (225,24,NULL,0,150,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (226,24,NULL,0,173,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (227,24,NULL,0,176,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (228,24,NULL,0,177,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (229,24,NULL,0,178,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (230,24,NULL,0,179,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (231,NULL,226,0,152,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (232,NULL,226,0,153,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (233,NULL,226,0,154,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (234,NULL,226,0,155,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (235,NULL,226,0,156,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (236,NULL,226,0,157,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (237,NULL,226,0,158,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (238,NULL,226,0,159,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (239,NULL,226,0,160,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (240,NULL,226,0,195,0,NULL,NULL,0,'2012-05-31 20:39:59'),
 (241,24,NULL,1,137,0,NULL,'=',0,'2012-05-31 20:41:41'),
 (242,24,NULL,1,150,1,'user/id','=',0,'2012-05-31 20:41:41'),
 (243,25,NULL,0,138,0,NULL,'',0,'2012-06-02 22:39:05'),
 (244,25,NULL,0,139,0,NULL,NULL,1,'2012-06-03 22:05:46'),
 (245,25,NULL,0,141,0,NULL,NULL,0,'2012-06-02 22:39:05'),
 (246,25,NULL,0,142,0,NULL,NULL,0,'2012-06-02 22:39:05'),
 (247,25,NULL,0,143,0,NULL,NULL,0,'2012-06-02 22:39:05'),
 (248,25,NULL,0,144,0,NULL,NULL,0,'2012-06-02 22:39:05'),
 (250,25,NULL,0,148,0,NULL,NULL,0,'2012-06-02 22:39:05'),
 (251,34,NULL,0,2,0,NULL,NULL,0,'2012-12-31 19:50:43'),
 (252,25,NULL,0,177,0,NULL,NULL,0,'2012-06-02 22:39:05'),
 (253,25,NULL,0,178,0,NULL,NULL,0,'2012-06-02 22:39:05'),
 (254,25,NULL,0,179,0,NULL,NULL,0,'2012-06-02 22:39:05'),
 (255,25,NULL,1,137,0,NULL,'=',0,'2012-06-02 22:40:26'),
 (256,25,NULL,1,150,1,'user/id','=',0,'2012-06-02 22:40:26'),
 (257,26,NULL,0,155,0,NULL,NULL,0,'2012-06-02 22:46:02'),
 (258,26,NULL,0,156,0,NULL,NULL,1,'2012-06-03 22:06:21'),
 (259,26,NULL,0,157,0,NULL,NULL,0,'2012-06-02 22:46:03'),
 (260,26,NULL,0,158,0,NULL,NULL,0,'2012-06-02 22:46:03'),
 (261,26,NULL,1,152,0,NULL,'=',0,'2012-06-02 22:46:03'),
 (262,26,NULL,1,160,1,'user/id','=',0,'2012-06-02 22:46:03'),
 (263,28,NULL,0,199,0,NULL,NULL,0,'2012-06-04 22:38:37'),
 (264,28,NULL,0,200,0,NULL,NULL,0,'2012-06-04 22:38:37'),
 (265,28,NULL,0,201,0,NULL,NULL,0,'2012-06-04 22:38:37'),
 (266,28,NULL,1,199,0,NULL,'=',0,'2012-06-04 22:38:37'),
 (267,1,NULL,0,196,0,NULL,NULL,0,'2012-06-04 22:43:48'),
 (268,NULL,267,0,182,0,NULL,NULL,0,'2012-06-04 22:50:27'),
 (269,NULL,267,0,183,0,NULL,NULL,1,'2012-06-04 22:50:28'),
 (270,NULL,267,0,184,0,NULL,NULL,1,'2012-06-04 22:50:28'),
 (271,NULL,267,0,185,0,NULL,NULL,1,'2012-06-04 22:50:28'),
 (272,NULL,267,0,186,0,NULL,NULL,1,'2012-06-04 22:50:28'),
 (273,NULL,267,0,187,0,NULL,NULL,1,'2012-06-04 22:50:28'),
 (274,NULL,267,0,198,0,NULL,NULL,1,'2012-06-04 22:50:28'),
 (275,NULL,267,0,197,0,NULL,NULL,1,'2012-06-04 22:50:28'),
 (276,NULL,267,0,202,1,'user/id',NULL,0,'2012-06-05 16:53:47'),
 (277,NULL,267,0,181,0,NULL,NULL,0,'2012-06-05 22:18:08'),
 (278,24,NULL,0,196,0,NULL,NULL,0,'2012-06-06 12:32:27'),
 (280,29,NULL,2,46,0,NULL,NULL,0,'2012-07-06 21:53:55'),
 (281,29,NULL,2,45,1,'user/id',NULL,0,'2012-07-06 21:53:55'),
 (282,30,NULL,0,140,3,'1',NULL,0,'2012-06-06 14:02:26'),
 (283,30,NULL,1,137,0,NULL,'=',0,'2012-06-06 14:02:26'),
 (284,30,NULL,1,150,1,'user/id','=',0,'2012-06-06 14:02:26'),
 (285,31,NULL,0,140,3,'0',NULL,0,'2012-06-06 14:02:26'),
 (286,31,NULL,1,137,0,NULL,'=',0,'2012-06-06 14:02:26'),
 (287,31,NULL,1,150,1,'user/id','=',0,'2012-06-06 14:02:26'),
 (288,7,NULL,1,140,3,'0,1','=',0,'2012-06-06 14:07:31'),
 (290,27,NULL,1,152,0,NULL,'=',0,'2012-06-10 21:58:52'),
 (291,27,NULL,1,160,1,'user/id','=',0,'2012-06-10 21:58:52'),
 (292,32,NULL,0,153,0,NULL,NULL,0,'2012-06-11 13:47:36'),
 (293,32,NULL,0,154,3,'0',NULL,0,'2012-06-11 13:47:36'),
 (294,32,NULL,0,155,0,NULL,NULL,0,'2012-06-11 13:47:36'),
 (295,32,NULL,0,156,0,NULL,NULL,1,'2012-06-11 13:47:36'),
 (296,32,NULL,0,157,0,NULL,NULL,0,'2012-06-11 13:47:36'),
 (297,32,NULL,0,158,0,NULL,NULL,0,'2012-06-11 13:47:36'),
 (298,32,NULL,0,159,3,'0',NULL,0,'2012-08-31 14:26:55'),
 (299,32,NULL,0,160,1,'user/id',NULL,0,'2012-06-11 13:47:36'),
 (300,32,NULL,0,195,0,NULL,NULL,0,'2012-06-11 13:47:37'),
 (301,5,NULL,0,207,0,NULL,NULL,0,'2012-06-24 20:46:24'),
 (302,21,NULL,0,203,0,NULL,NULL,0,'2012-07-01 23:15:23'),
 (303,21,NULL,0,206,0,NULL,NULL,0,'2012-07-01 23:15:24'),
 (304,21,NULL,0,207,0,NULL,NULL,0,'2012-07-01 23:15:24'),
 (305,33,NULL,2,39,1,'user/id',NULL,0,'2012-10-13 12:15:32'),
 (306,33,NULL,2,40,0,NULL,NULL,0,'2012-07-05 13:50:19'),
 (307,33,NULL,2,41,3,NULL,NULL,0,'2012-07-05 13:50:19'),
 (308,33,NULL,2,42,3,'2',NULL,0,'2012-07-05 13:50:19'),
 (315,35,NULL,0,209,0,NULL,NULL,0,'2012-07-05 17:29:24'),
 (316,35,NULL,0,165,3,'4',NULL,0,'2012-07-05 17:29:24'),
 (317,35,NULL,0,208,4,NULL,NULL,0,'2012-07-05 17:32:30'),
 (318,35,NULL,1,162,0,NULL,'=',0,'2012-07-05 17:58:21'),
 (319,36,NULL,0,137,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (320,36,NULL,0,138,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (321,36,NULL,0,140,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (322,36,NULL,0,141,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (323,36,NULL,0,142,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (324,36,NULL,0,143,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (325,36,NULL,0,144,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (326,36,NULL,0,145,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (327,36,NULL,0,148,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (328,36,NULL,0,149,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (329,36,NULL,0,173,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (330,36,NULL,0,177,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (331,36,NULL,0,178,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (332,36,NULL,0,179,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (333,36,NULL,0,190,0,NULL,NULL,0,'2012-07-07 12:13:16'),
 (334,36,NULL,1,150,1,'user/id','=',0,'2012-07-07 12:13:16'),
 (335,36,NULL,1,140,3,'3','=',0,'2012-07-07 12:13:16'),
 (336,6,NULL,1,165,3,'0,3','=',0,'2012-08-24 22:34:45'),
 (337,6,NULL,0,208,0,NULL,NULL,0,'2012-07-08 12:18:26'),
 (338,6,NULL,0,209,0,NULL,NULL,0,'2012-07-08 12:18:26'),
 (339,37,NULL,0,162,0,NULL,NULL,0,'2012-07-08 12:24:11'),
 (340,37,NULL,0,163,0,NULL,NULL,0,'2012-07-08 12:24:11'),
 (341,37,NULL,0,165,0,NULL,NULL,0,'2012-07-08 12:24:11'),
 (342,37,NULL,0,166,0,NULL,NULL,0,'2012-07-08 12:24:11'),
 (343,37,NULL,0,175,0,NULL,NULL,0,'2012-07-08 12:24:11'),
 (344,37,NULL,1,164,1,'user/id','=',0,'2012-07-08 12:32:20'),
 (345,37,NULL,1,165,3,'4','=',0,'2012-07-08 12:32:20'),
 (346,37,NULL,0,208,0,NULL,NULL,0,'2012-07-08 12:24:11'),
 (347,37,NULL,0,209,0,NULL,NULL,0,'2012-07-08 12:24:11'),
 (348,38,NULL,1,162,0,NULL,'=',0,'2012-07-08 21:37:36'),
 (349,38,NULL,1,164,1,'user/id','=',0,'2012-07-08 21:37:36'),
 (350,38,NULL,1,165,3,'4','=',0,'2012-07-08 21:37:36'),
 (351,38,NULL,0,165,3,'5',NULL,0,'2012-07-08 21:37:36'),
 (352,38,NULL,0,208,4,NULL,NULL,0,'2012-07-08 21:37:36'),
 (353,39,NULL,1,140,3,'0,1','=',0,'2012-07-09 15:25:04'),
 (354,39,NULL,1,142,4,NULL,'<=',0,'2012-07-09 15:31:18'),
 (355,39,NULL,0,137,0,NULL,NULL,0,'2012-07-09 15:25:05'),
 (356,39,NULL,0,138,0,NULL,NULL,0,'2012-07-09 16:08:12'),
 (357,39,NULL,0,141,0,NULL,NULL,0,'2012-07-09 16:08:13'),
 (358,39,NULL,0,142,0,NULL,NULL,0,'2012-07-09 16:08:13'),
 (359,39,NULL,0,143,0,NULL,NULL,0,'2012-07-09 16:08:13'),
 (360,39,NULL,0,148,0,NULL,NULL,0,'2012-07-09 16:08:13'),
 (361,39,NULL,0,149,0,NULL,NULL,0,'2012-07-09 16:08:13'),
 (362,39,NULL,0,173,0,NULL,NULL,0,'2012-07-09 16:08:13'),
 (363,39,NULL,0,177,0,NULL,NULL,0,'2012-07-09 16:08:13'),
 (364,39,NULL,0,178,0,NULL,NULL,0,'2012-07-09 16:08:13'),
 (365,39,NULL,0,179,0,NULL,NULL,0,'2012-07-09 16:08:13'),
 (367,40,NULL,1,165,3,'0','=',0,'2012-07-09 20:54:20'),
 (368,40,NULL,1,189,0,NULL,'=',0,'2012-07-09 17:47:19'),
 (369,40,NULL,0,162,0,NULL,NULL,0,'2012-07-09 16:18:18'),
 (370,40,NULL,0,164,0,NULL,NULL,0,'2012-07-09 16:18:18'),
 (371,40,NULL,0,166,0,NULL,NULL,0,'2012-07-09 16:18:18'),
 (372,11,NULL,0,11,0,NULL,NULL,0,'2012-07-09 22:13:23'),
 (373,42,NULL,0,105,3,'0',NULL,0,'2012-07-13 17:01:45'),
 (374,42,NULL,0,106,0,NULL,NULL,0,'2012-07-13 17:01:45'),
 (375,42,NULL,0,107,0,NULL,NULL,0,'2012-07-13 17:01:45'),
 (376,42,NULL,0,108,0,NULL,NULL,0,'2012-07-13 17:01:45'),
 (377,43,NULL,1,105,3,'0','=',0,'2012-07-13 17:08:40'),
 (378,43,NULL,0,106,0,NULL,NULL,0,'2012-07-13 17:08:40'),
 (379,43,NULL,0,107,0,NULL,NULL,0,'2012-07-13 17:08:40'),
 (380,43,NULL,0,108,0,NULL,NULL,0,'2012-07-13 17:08:40'),
 (381,43,NULL,0,104,0,NULL,NULL,0,'2012-07-13 17:08:40'),
 (382,43,NULL,0,105,0,NULL,NULL,0,'2012-07-13 17:08:40'),
 (383,44,NULL,1,104,0,NULL,'=',0,'2012-07-13 17:08:40'),
 (384,44,NULL,0,105,3,'1',NULL,0,'2012-07-13 17:08:40'),
 (385,44,NULL,0,112,4,NULL,NULL,0,'2012-07-13 17:08:40'),
 (386,45,NULL,1,129,0,NULL,'=',0,'2012-07-13 17:36:36'),
 (387,45,NULL,0,130,0,NULL,NULL,0,'2012-07-13 17:38:26'),
 (388,41,NULL,1,162,0,NULL,'=',0,'2012-07-14 11:52:08'),
 (389,41,NULL,1,165,3,'0','=',0,'2012-07-14 11:52:08'),
 (390,41,NULL,0,165,3,'3',NULL,0,'2012-07-14 11:52:08'),
 (391,41,NULL,0,208,4,NULL,NULL,0,'2012-07-14 11:52:08'),
 (392,41,NULL,0,209,0,NULL,NULL,1,'2012-08-13 15:07:09'),
 (393,46,NULL,1,137,0,NULL,'=',0,'2012-07-14 22:04:33'),
 (394,46,NULL,1,140,3,'0,1','=',0,'2012-07-14 11:59:40'),
 (395,46,NULL,0,140,3,'3',NULL,0,'2012-07-14 11:59:40'),
 (396,47,NULL,1,11,0,NULL,'=',0,'2012-07-17 21:47:45'),
 (397,47,NULL,1,14,3,'0,1,2','=',0,'2012-07-25 12:12:33'),
 (398,47,NULL,0,19,0,NULL,NULL,0,'2012-07-17 21:47:45'),
 (399,48,NULL,1,14,3,'0,1','=',0,'2012-07-23 17:02:47'),
 (400,48,NULL,1,11,0,NULL,'=',0,'2012-07-23 17:02:47'),
 (401,48,NULL,0,12,5,NULL,NULL,0,'2012-07-23 17:02:47'),
 (402,49,NULL,1,19,1,'user/id','=',0,'2012-07-25 22:12:26'),
 (403,49,NULL,1,12,0,NULL,'=',0,'2012-07-25 22:12:26'),
 (404,49,NULL,0,12,0,NULL,NULL,0,'2012-07-25 22:12:26'),
 (405,51,NULL,1,19,1,'user/id','=',0,'2012-07-26 14:40:26'),
 (406,50,NULL,1,11,0,NULL,'=',0,'2012-07-24 15:05:11'),
 (407,50,NULL,1,14,3,'0,1','=',0,'2012-07-25 12:16:02'),
 (408,50,NULL,0,8,0,NULL,NULL,0,'2012-07-24 15:05:12'),
 (409,50,NULL,0,9,0,NULL,NULL,0,'2012-07-24 15:05:12'),
 (410,50,NULL,0,11,0,NULL,NULL,0,'2012-07-24 15:05:12'),
 (411,50,NULL,0,12,0,NULL,NULL,0,'2012-07-24 15:05:12'),
 (412,11,NULL,0,14,0,NULL,NULL,0,'2012-07-24 16:20:56'),
 (413,51,NULL,1,12,0,NULL,'=',0,'2012-07-26 14:40:26'),
 (414,51,NULL,0,19,0,NULL,NULL,0,'2012-07-26 14:40:26'),
 (415,52,NULL,1,19,1,'user/id','=',0,'2012-07-27 16:44:52'),
 (416,52,NULL,0,8,0,NULL,NULL,0,'2012-07-27 16:44:52'),
 (417,52,NULL,0,9,0,NULL,NULL,0,'2012-07-27 16:44:52'),
 (418,52,NULL,0,11,0,NULL,NULL,0,'2012-07-27 16:44:52'),
 (419,52,NULL,0,103,0,NULL,NULL,0,'2012-07-27 16:44:52'),
 (420,53,NULL,1,19,1,'user/id','=',0,'2012-07-27 21:03:26'),
 (421,53,NULL,0,14,3,'0',NULL,0,'2012-07-27 21:03:26'),
 (422,54,NULL,1,42,0,NULL,'=',0,'2012-07-31 14:57:47'),
 (423,54,NULL,1,136,1,'user/id','=',0,'2012-07-31 14:57:47'),
 (424,54,NULL,0,43,0,NULL,NULL,0,'2012-07-31 14:57:47'),
 (425,54,NULL,0,44,0,NULL,NULL,1,'2012-07-31 14:57:47'),
 (426,54,NULL,0,46,0,NULL,NULL,1,'2012-07-31 14:57:47'),
 (427,54,NULL,0,48,0,NULL,NULL,1,'2012-07-31 14:57:47'),
 (428,55,NULL,1,80,0,NULL,'=',0,'2012-07-31 14:57:47'),
 (429,55,NULL,0,82,0,NULL,NULL,1,'2012-07-31 14:57:47'),
 (430,55,NULL,0,83,0,NULL,NULL,1,'2012-07-31 14:57:47'),
 (431,55,NULL,0,84,0,NULL,NULL,1,'2012-07-31 14:57:47'),
 (432,55,NULL,0,85,0,NULL,NULL,1,'2012-07-31 14:57:47'),
 (433,55,NULL,0,86,0,NULL,NULL,1,'2012-07-31 14:57:47'),
 (434,55,NULL,0,87,0,NULL,NULL,1,'2012-07-31 14:57:47'),
 (435,55,NULL,0,88,0,NULL,NULL,1,'2012-07-31 14:57:47'),
 (436,56,NULL,1,137,0,NULL,'=',0,'2012-08-01 22:20:21'),
 (437,56,NULL,1,140,3,'1','=',0,'2012-08-01 22:20:21'),
 (438,56,NULL,0,137,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (439,56,NULL,0,138,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (440,56,NULL,0,139,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (441,56,NULL,0,140,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (442,56,NULL,0,141,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (443,56,NULL,0,142,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (444,56,NULL,0,143,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (445,56,NULL,0,144,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (446,56,NULL,0,145,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (447,56,NULL,0,148,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (449,56,NULL,0,149,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (450,56,NULL,0,176,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (451,56,NULL,0,177,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (452,56,NULL,0,178,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (453,56,NULL,0,179,0,NULL,NULL,0,'2012-08-01 22:20:21'),
 (456,9,NULL,0,8,0,NULL,NULL,0,'2012-08-04 11:52:55'),
 (457,9,NULL,0,9,0,NULL,NULL,0,'2012-08-04 11:52:55'),
 (458,9,NULL,0,11,0,NULL,NULL,0,'2012-08-04 11:52:55'),
 (459,9,NULL,0,103,0,NULL,NULL,0,'2012-08-04 11:52:55'),
 (460,9,NULL,0,194,0,NULL,NULL,0,'2012-08-04 12:02:28'),
 (461,10,NULL,0,194,0,NULL,NULL,0,'2012-08-04 12:19:02'),
 (462,10,NULL,0,103,0,NULL,NULL,0,'2012-08-05 12:44:27'),
 (463,19,NULL,0,45,0,NULL,NULL,1,'2012-09-10 16:18:15'),
 (464,23,NULL,0,45,0,NULL,NULL,0,'2012-09-10 22:49:25'),
 (465,54,NULL,0,45,0,NULL,NULL,1,'2012-09-12 17:19:58'),
 (466,23,NULL,0,44,0,NULL,NULL,0,'2012-09-13 12:24:53'),
 (467,23,NULL,0,48,0,NULL,NULL,0,'2012-09-13 12:24:53'),
 (468,58,NULL,1,150,1,'user/id','=',0,'2012-09-13 12:35:42'),
 (469,58,NULL,0,177,0,NULL,NULL,0,'2012-09-13 12:35:42'),
 (470,59,NULL,1,162,0,NULL,'=',0,'2012-09-14 17:08:28'),
 (471,59,NULL,1,164,1,'user/id','=',0,'2012-09-14 17:08:28'),
 (472,59,NULL,1,165,3,'3','=',0,'2012-09-14 17:08:28'),
 (473,59,NULL,0,165,3,'0',NULL,0,'2012-09-14 17:08:28'),
 (474,33,NULL,2,47,0,NULL,NULL,0,'2012-10-13 12:17:36'),
 (475,5,NULL,2,47,0,NULL,NULL,0,'2012-09-23 21:56:00'),
 (476,33,NULL,2,48,0,NULL,NULL,0,'2012-10-13 21:51:12'),
 (477,5,NULL,2,48,3,NULL,NULL,0,'2012-10-13 21:55:06'),
 (478,22,NULL,2,48,3,NULL,NULL,0,'2012-10-13 21:55:06'),
 (479,21,NULL,2,48,3,NULL,NULL,0,'2012-10-13 21:55:06'),
 (480,57,NULL,0,211,0,NULL,NULL,0,'2012-10-21 12:10:23'),
 (481,57,NULL,0,212,0,NULL,NULL,0,'2012-10-21 12:10:23'),
 (482,57,NULL,0,215,0,NULL,NULL,0,'2012-10-21 12:44:28'),
 (483,22,NULL,2,47,0,NULL,NULL,0,'2012-09-24 13:47:45'),
 (484,57,NULL,0,214,0,NULL,NULL,1,'2012-10-21 12:46:35'),
 (485,43,NULL,0,216,0,NULL,NULL,0,'2012-10-21 21:07:07'),
 (486,42,NULL,0,216,0,NULL,NULL,0,'2012-10-21 21:12:12'),
 (487,5,NULL,0,204,0,NULL,NULL,0,'2012-10-28 01:11:25'),
 (488,56,NULL,0,150,0,NULL,NULL,0,'2012-10-28 20:22:48'),
 (489,22,NULL,0,204,0,NULL,NULL,0,'2012-10-29 22:30:10'),
 (490,33,NULL,0,204,0,NULL,NULL,0,'2012-11-04 11:41:03'),
 (491,21,NULL,2,47,0,NULL,NULL,0,'2012-09-24 16:46:07'),
 (492,60,NULL,1,165,3,'0,3','=',0,'2012-11-21 22:06:01'),
 (493,60,NULL,1,189,0,NULL,'=',0,'2012-11-21 22:06:02'),
 (494,60,NULL,0,162,0,NULL,NULL,0,'2012-11-21 22:06:02'),
 (495,60,NULL,0,164,0,NULL,NULL,0,'2012-11-21 22:06:02'),
 (496,60,NULL,0,166,0,NULL,NULL,0,'2012-11-21 22:06:02'),
 (497,61,NULL,1,162,0,NULL,'=',0,'2012-11-24 23:16:04'),
 (498,61,NULL,0,162,0,NULL,NULL,0,'2012-11-24 23:16:04'),
 (499,61,NULL,0,166,0,NULL,NULL,0,'2012-11-24 23:16:05'),
 (500,61,NULL,0,164,0,NULL,NULL,0,'2012-11-24 23:16:05'),
 (501,61,NULL,0,165,0,NULL,NULL,0,'2012-11-24 23:16:05'),
 (502,4,NULL,0,7,0,NULL,NULL,0,'2012-12-31 19:46:26'),
 (503,19,NULL,0,15,0,NULL,NULL,0,'2013-01-02 22:54:23'),
 (504,19,NULL,0,41,0,NULL,NULL,0,'2013-01-02 22:54:23'),
 (505,20,NULL,1,193,0,NULL,'=',0,'2013-01-03 17:16:10'),
 (507,62,NULL,0,21,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (508,62,NULL,0,22,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (509,62,NULL,0,23,3,'0',NULL,0,'2013-01-17 23:20:17'),
 (510,62,NULL,0,24,3,'0',NULL,0,'2013-01-17 23:20:17'),
 (511,62,NULL,0,25,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (512,62,NULL,0,26,0,NULL,NULL,1,'2013-01-17 23:20:17'),
 (513,62,NULL,0,27,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (514,62,NULL,0,28,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (515,62,NULL,0,29,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (516,62,NULL,0,31,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (517,62,NULL,0,32,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (518,62,NULL,0,33,0,NULL,NULL,1,'2013-01-17 23:20:17'),
 (519,62,NULL,0,34,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (520,62,NULL,0,35,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (521,62,NULL,0,36,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (522,62,NULL,0,37,0,NULL,NULL,0,'2013-01-17 23:20:17'),
 (523,23,NULL,0,15,0,NULL,NULL,0,'2013-01-19 21:43:18'),
 (524,23,NULL,0,41,0,NULL,NULL,0,'2013-01-19 21:43:18'),
 (525,NULL,183,0,38,0,NULL,NULL,0,'2013-01-20 23:05:30'),
 (526,NULL,183,0,39,0,NULL,NULL,0,'2013-01-20 23:05:30'),
 (527,NULL,202,0,38,0,NULL,NULL,0,'2013-01-21 12:33:21'),
 (528,NULL,202,0,39,0,NULL,NULL,0,'2013-01-21 12:33:22'),
 (529,62,NULL,0,40,0,NULL,NULL,0,'2013-01-24 17:26:54'),
 (530,62,NULL,0,52,0,NULL,NULL,0,'2013-01-24 17:26:54'),
 (531,62,NULL,0,89,0,NULL,NULL,1,'2013-03-11 16:45:22'),
 (532,62,NULL,0,90,0,NULL,NULL,0,'2013-03-11 16:45:22');
/*!40000 ALTER TABLE `meta_operation_params` ENABLE KEYS */;


--
-- Definition of table `meta_operations`
--

DROP TABLE IF EXISTS `meta_operations`;
CREATE TABLE `meta_operations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(10) unsigned NOT NULL,
  `object_id` bigint(20) unsigned DEFAULT NULL,
  `sp_id` bigint(20) unsigned DEFAULT NULL,
  `pre_ops` varchar(45) DEFAULT NULL,
  `post_ops` varchar(45) DEFAULT NULL,
  `comments` varchar(250) DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_operations`
--

/*!40000 ALTER TABLE `meta_operations` DISABLE KEYS */;
INSERT INTO `meta_operations` (`id`,`type`,`object_id`,`sp_id`,`pre_ops`,`post_ops`,`comments`,`dt`) VALUES 
 (1,0,23,NULL,NULL,'17,14','insert new offer','2012-08-29 15:56:18'),
 (2,1,23,NULL,NULL,NULL,NULL,'2012-08-29 15:30:48'),
 (3,4,23,NULL,NULL,NULL,NULL,'2012-04-09 12:57:31'),
 (4,4,4,NULL,NULL,NULL,'get biz subcategories','2012-12-31 19:47:42'),
 (5,3,NULL,12,'10,20','13,22','insert new order','2012-10-28 00:38:31'),
 (6,4,25,NULL,NULL,'15','get my pending orders','2012-08-23 15:42:24'),
 (7,4,23,NULL,NULL,'16','get active biz offers','2012-08-27 12:26:29'),
 (8,0,2,NULL,'5','4,0','insert user','2012-10-16 21:39:31'),
 (9,4,2,NULL,NULL,NULL,'get user by id and uuid','2013-01-03 16:19:55'),
 (10,4,2,NULL,NULL,'2','user signin','2012-04-16 12:56:42'),
 (11,4,2,NULL,NULL,NULL,'get user\'s header data','2012-04-23 15:49:43'),
 (12,4,2,NULL,NULL,NULL,'check user\'s email','2012-04-27 14:05:31'),
 (13,3,NULL,13,NULL,'14','get offers - no user','2012-08-21 21:46:37'),
 (14,4,2,NULL,NULL,NULL,'check authorization reply','2012-04-28 20:57:32'),
 (15,1,2,NULL,NULL,'11','confirm authorization','2012-08-04 21:52:18'),
 (16,1,2,NULL,NULL,NULL,'deny authorization','2012-04-28 21:21:35'),
 (17,3,NULL,13,NULL,'14','get offers - user in session','2012-08-21 21:46:37'),
 (18,4,2,NULL,NULL,NULL,'check user can reg biz','2012-05-08 23:18:09'),
 (19,0,10,NULL,'27','3','insert biz','2013-01-03 15:47:51'),
 (20,1,2,NULL,NULL,NULL,'update user biz_owner','2012-05-09 22:48:39'),
 (21,3,NULL,12,NULL,'13,26','update order','2012-11-25 12:17:36'),
 (22,3,NULL,12,'24','13','cancel order','2012-11-24 12:32:37'),
 (23,4,10,NULL,'28',NULL,'get biz details by owner id','2013-01-19 22:20:14'),
 (24,4,23,NULL,NULL,NULL,'get offer by id and user id','2012-05-31 17:41:17'),
 (25,1,23,NULL,'18','19,14','update offer','2012-08-31 16:21:38'),
 (26,1,24,NULL,NULL,NULL,'update offer item','2012-06-02 22:29:17'),
 (27,2,24,NULL,NULL,NULL,'delete offer item','2012-06-02 22:29:17'),
 (28,4,28,NULL,NULL,NULL,'get zipcode longitude, latitude','2012-06-04 22:36:10'),
 (29,3,NULL,14,'23',NULL,'cancel offer','2012-11-21 22:27:27'),
 (30,1,23,NULL,NULL,NULL,'publish offer','2012-06-06 13:00:32'),
 (31,1,23,NULL,NULL,NULL,'unpublish offer','2012-06-06 13:00:32'),
 (32,0,24,NULL,NULL,NULL,'insert offer\'s item','2012-06-11 13:39:35'),
 (33,3,NULL,12,'25','13','cancel order by offer creator','2012-11-24 22:12:46'),
 (34,4,3,NULL,NULL,NULL,'get biz categories','2012-12-31 19:52:51'),
 (35,1,25,NULL,NULL,NULL,'complete order by offer creator','2012-07-05 17:24:05'),
 (36,4,23,NULL,NULL,'16','get closed biz offers','2012-08-27 12:26:29'),
 (37,4,25,NULL,NULL,'15','get user\'s completed orders','2012-08-23 15:42:24'),
 (38,1,25,NULL,NULL,NULL,'delete order by user','2012-07-08 21:30:29'),
 (39,4,23,NULL,NULL,NULL,'get offers to close','2012-07-09 15:09:47'),
 (40,4,25,NULL,NULL,NULL,'get offer\'s orders to close','2012-07-14 12:11:00'),
 (41,1,25,NULL,NULL,NULL,'close offer\'s order','2012-07-14 12:11:00'),
 (42,0,19,NULL,NULL,NULL,'insert pending email','2012-07-13 16:55:37'),
 (43,4,19,NULL,NULL,NULL,'get pending email','2012-07-13 16:55:37'),
 (44,1,19,NULL,NULL,NULL,'update email to sent','2012-07-13 16:55:37'),
 (45,4,22,NULL,NULL,NULL,'get system param value','2012-07-13 17:34:50'),
 (46,1,23,NULL,NULL,NULL,'close offer','2012-07-14 11:56:31'),
 (47,4,2,NULL,NULL,NULL,'check if user exists in db','2012-07-17 21:43:55'),
 (48,1,2,NULL,NULL,'7','user forgot password','2012-07-26 15:49:00'),
 (49,1,2,NULL,'6',NULL,'user changes his password','2012-07-26 15:50:45'),
 (50,4,2,NULL,NULL,NULL,'get user for the forgot pass email','2012-07-24 15:01:13'),
 (51,4,2,NULL,NULL,NULL,'check user\'s current password for password update','2012-07-26 14:36:36'),
 (52,1,2,NULL,'8','12','user updates his data','2012-08-04 21:54:06'),
 (53,1,2,NULL,NULL,NULL,'set user status to new when user changes his email, need for email verification','2012-07-27 21:01:07'),
 (54,1,10,NULL,NULL,NULL,'update biz','2012-07-31 14:45:15'),
 (55,1,11,NULL,NULL,NULL,'update biz location','2012-07-31 14:45:15'),
 (56,4,23,NULL,NULL,'14','get active offer by id and status','2012-08-23 13:29:08'),
 (57,0,31,NULL,'21',NULL,'send offer email to friend','2012-10-21 12:29:00'),
 (58,1,23,NULL,NULL,NULL,'update biz data when biz is updated','2012-09-13 12:32:18'),
 (59,1,25,NULL,NULL,'13,22','customer confirms his order','2012-10-28 16:00:10'),
 (60,4,25,NULL,NULL,NULL,'get offer\'s active, closed orders','2012-11-21 21:58:19'),
 (61,4,25,NULL,NULL,NULL,'get order by id','2012-11-24 23:13:18'),
 (62,0,1,NULL,NULL,NULL,'insert new deal','2013-01-17 23:09:26');
/*!40000 ALTER TABLE `meta_operations` ENABLE KEYS */;


--
-- Definition of table `meta_ref_object_nodes`
--

DROP TABLE IF EXISTS `meta_ref_object_nodes`;
CREATE TABLE `meta_ref_object_nodes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_node_id` bigint(20) unsigned NOT NULL,
  `node_name` varchar(45) NOT NULL,
  `permission` varchar(45) NOT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_ref_object_nodes`
--

/*!40000 ALTER TABLE `meta_ref_object_nodes` DISABLE KEYS */;
INSERT INTO `meta_ref_object_nodes` (`id`,`parent_node_id`,`node_name`,`permission`,`dt`) VALUES 
 (1,119,'first_name','read','2010-09-14 23:25:23'),
 (2,119,'last_name','read','2010-09-14 23:25:23'),
 (3,66,'first_name','read','2010-09-23 13:03:29'),
 (4,66,'last_name','read','2010-09-23 13:03:29'),
 (5,66,'email','read','2010-09-23 13:03:29'),
 (6,25,'first_name','read','2010-10-21 21:21:33'),
 (7,25,'last_name','read','2010-10-21 21:21:33'),
 (8,111,'id','read','2010-11-14 14:08:28'),
 (9,111,'first_name','read','2010-11-14 14:08:28'),
 (10,111,'last_name','read','2010-11-14 14:08:28'),
 (11,111,'email','read','2010-11-14 14:08:28'),
 (12,121,'name','read','2010-11-24 20:19:09'),
 (13,121,'id','read','2010-11-24 20:19:09'),
 (14,122,'id','read','2010-11-24 20:19:09'),
 (15,122,'first_name','read','2010-11-24 20:19:10'),
 (16,122,'last_name','read','2010-11-24 20:19:10'),
 (17,125,'id','read','2010-11-24 20:19:10'),
 (18,125,'first_name','read','2010-11-24 20:19:10'),
 (19,125,'last_name','read','2010-11-24 20:19:10'),
 (20,125,'phone','read','2010-12-05 14:43:17'),
 (21,66,'id','read','2010-12-06 18:36:44'),
 (22,125,'email','read','2010-12-08 23:02:34'),
 (23,121,'phone','read','2010-12-12 13:21:29'),
 (24,121,'web_name','read','2010-12-12 13:21:29'),
 (25,121,'locations','read','2010-12-12 13:21:29'),
 (26,121,'email','read','2010-12-12 13:49:14'),
 (27,163,'id','read','2012-03-15 15:35:19'),
 (28,163,'name','read','2012-03-15 15:35:19'),
 (29,163,'description','read','2012-03-15 15:35:19'),
 (30,163,'status','read','2012-03-15 15:35:19'),
 (31,163,'pickup_type','read','2012-03-15 15:35:19'),
 (32,163,'close_date','read','2012-03-15 15:35:19'),
 (33,163,'discounts','read','2012-03-15 15:35:19'),
 (34,163,'items','read','2012-03-15 15:35:19'),
 (35,163,'items_ordered','read','2012-09-02 12:28:17'),
 (36,163,'di_type','read','2012-03-15 15:35:19'),
 (37,163,'total','read','2012-03-15 15:35:19'),
 (38,163,'total_ordered','read','2012-09-02 12:28:17'),
 (39,163,'biz_id','read','2012-03-15 15:35:19'),
 (40,163,'biz_name','read','2012-03-15 15:35:19'),
 (41,163,'pickup','read','2012-03-15 15:35:19'),
 (42,190,'offer_id','read','2012-03-19 10:45:07'),
 (43,190,'user_details','read','2012-03-19 10:45:07'),
 (44,190,'status','read','2012-03-19 10:45:07'),
 (45,190,'items','read','2012-03-19 10:45:07'),
 (46,190,'dt','read','2012-07-03 16:50:14'),
 (47,190,'id','read','2012-07-04 14:50:07');
/*!40000 ALTER TABLE `meta_ref_object_nodes` ENABLE KEYS */;


--
-- Definition of table `meta_sp_parameters`
--

DROP TABLE IF EXISTS `meta_sp_parameters`;
CREATE TABLE `meta_sp_parameters` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sp_id` bigint(20) unsigned NOT NULL,
  `parameter_name` varchar(45) NOT NULL,
  `parameter_type` varchar(45) NOT NULL,
  `format_string` varchar(45) DEFAULT NULL,
  `parameter_sql_type` int(11) NOT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_sp_parameters`
--

/*!40000 ALTER TABLE `meta_sp_parameters` DISABLE KEYS */;
INSERT INTO `meta_sp_parameters` (`id`,`sp_id`,`parameter_name`,`parameter_type`,`format_string`,`parameter_sql_type`,`dt`) VALUES 
 (1,1,'user_id','bigint',NULL,-5,'2010-09-28 21:18:22'),
 (2,1,'sdate','date','MM/dd/yy',91,'2010-09-28 21:18:22'),
 (3,1,'edate','date','MM/dd/yy',91,'2010-09-28 21:18:22'),
 (4,1,'stime','time','h:mm a',92,'2010-09-28 21:18:22'),
 (5,1,'etime','time','h:mm a',92,'2010-09-28 21:18:22'),
 (6,1,'weekday','varchar',NULL,12,'2010-09-28 21:18:22'),
 (7,2,'user_id','bigint',NULL,-5,'2010-10-19 23:12:26'),
 (8,2,'sd','date','MM/dd/yy',91,'2010-10-19 23:12:26'),
 (9,2,'ed','date','MM/dd/yy',91,'2010-10-19 23:12:26'),
 (10,2,'duration','time','h:mm',92,'2010-10-19 23:12:26'),
 (11,3,'user_id','bigint',NULL,-5,'2010-10-24 13:51:09'),
 (12,3,'sd','date','MM/dd/yy',91,'2010-10-24 13:51:09'),
 (13,3,'ed','date','MM/dd/yy',91,'2010-10-24 13:51:09'),
 (14,3,'st','time','hh:mm a',92,'2010-10-24 13:51:09'),
 (15,4,'user_id','bigint',NULL,-5,'2010-11-10 21:48:11'),
 (16,4,'sd','date','MM/dd/yy',91,'2010-11-10 21:48:12'),
 (17,4,'st','time','hh:mm a',92,'2010-11-10 21:48:12'),
 (18,4,'et','time','hh:mm a',92,'2010-11-10 21:48:12'),
 (19,5,'user_id','bigint',NULL,-5,'2010-11-10 22:27:12'),
 (20,5,'sd','date','MM/dd/yy',91,'2010-11-10 22:27:12'),
 (21,5,'st','time','hh:mm a',92,'2010-11-10 22:27:12'),
 (22,5,'et','time','hh:mm a',92,'2010-11-10 22:27:12'),
 (23,6,'user_id','bigint',NULL,-5,'2010-11-15 20:03:35'),
 (24,6,'sdate','date','MM/dd/yy',91,'2010-11-15 20:03:35'),
 (25,6,'edate','date','MM/dd/yy',91,'2010-11-15 20:03:35'),
 (26,6,'stime','time','hh:mm a',92,'2010-11-15 20:03:35'),
 (27,6,'etime','time','hh:mm a',92,'2010-11-15 20:03:35'),
 (28,6,'weekday','varchar',NULL,12,'2010-11-15 20:03:35'),
 (29,7,'user_id','bigint',NULL,-5,'2010-11-28 16:35:53'),
 (30,7,'sd','date','MM/dd/yy',91,'2010-11-28 16:35:53'),
 (31,7,'ed','date','MM/dd/yy',91,'2010-11-28 16:35:53'),
 (32,7,'biz_id','bigint',NULL,-5,'2010-11-28 21:33:02'),
 (33,3,'et','time','hh:mm a',92,'2010-12-16 22:38:27'),
 (34,11,'user_id','bigint',NULL,-5,'2010-12-16 23:04:42'),
 (35,11,'sd','date','MM/dd/yy',91,'2010-12-16 23:04:42'),
 (36,11,'ed','date','MM/dd/yy',91,'2010-12-16 23:04:42'),
 (37,11,'st','time','hh:mm a',92,'2010-12-16 23:04:42'),
 (38,11,'et','time','hh:mm a',92,'2010-12-16 23:07:59'),
 (39,12,'uid','bigint',NULL,-5,'2012-02-11 14:53:17'),
 (40,12,'oid','bigint',NULL,-5,'2012-02-11 14:53:17'),
 (41,12,'user_details','varchar',NULL,12,'2012-03-14 22:28:16'),
 (42,12,'oper','bigint',NULL,-5,'2012-03-24 21:20:56'),
 (43,13,'zip','varchar',NULL,12,'2012-04-27 17:37:16'),
 (44,13,'userid','bigint',NULL,-5,'2012-04-30 12:52:41'),
 (45,14,'uid','bigint',NULL,-5,'2012-07-06 21:49:42'),
 (46,14,'oid','bigint',NULL,-5,'2012-07-06 21:49:42'),
 (47,12,'ordr','varchar',NULL,12,'2012-09-23 21:55:12'),
 (48,12,'ordrid','bigint',NULL,-5,'2012-10-13 21:46:37'),
 (100,31,'user_id','bigint',NULL,-5,'2007-12-21 12:00:00'),
 (101,31,'sd','date','MM/dd/yy',91,'2007-12-21 12:00:00'),
 (102,31,'ed','date','MM/dd/yy',91,'2007-12-21 12:00:00'),
 (104,31,'duration','time','h:mm',92,'2007-12-21 12:00:00');
/*!40000 ALTER TABLE `meta_sp_parameters` ENABLE KEYS */;


--
-- Definition of table `meta_stored_procedures`
--

DROP TABLE IF EXISTS `meta_stored_procedures`;
CREATE TABLE `meta_stored_procedures` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sp_name` varchar(100) NOT NULL,
  `result_object_id` int(10) unsigned DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_stored_procedures`
--

/*!40000 ALTER TABLE `meta_stored_procedures` DISABLE KEYS */;
INSERT INTO `meta_stored_procedures` (`id`,`sp_name`,`result_object_id`,`dt`) VALUES 
 (4,'TAKE_AT',3,'2007-12-22 17:00:00'),
 (12,'OFFER_ORDER',29,'2012-02-11 14:51:05'),
 (13,'GET_OFFERS',23,'2012-04-27 17:35:54'),
 (14,'CANCEL_OFFER',NULL,'2012-07-06 21:46:41');
/*!40000 ALTER TABLE `meta_stored_procedures` ENABLE KEYS */;


--
-- Definition of table `meta_url_mappings`
--

DROP TABLE IF EXISTS `meta_url_mappings`;
CREATE TABLE `meta_url_mappings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `element` varchar(100) NOT NULL,
  `parent_element_id` bigint(20) unsigned DEFAULT NULL,
  `template_id` bigint(20) unsigned DEFAULT NULL,
  `get_pre_ops` varchar(45) DEFAULT NULL,
  `post_ops` varchar(45) DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_url_mappings`
--

/*!40000 ALTER TABLE `meta_url_mappings` DISABLE KEYS */;
INSERT INTO `meta_url_mappings` (`id`,`element`,`parent_element_id`,`template_id`,`get_pre_ops`,`post_ops`,`dt`) VALUES 
 (1,'/',0,1,NULL,NULL,'2012-04-27 13:38:42'),
 (2,'myoffers',1,2,'1',NULL,'2012-09-12 21:54:35'),
 (3,'myorders',1,3,'1',NULL,'2012-09-12 21:54:35'),
 (4,'signin',1,4,NULL,NULL,'2012-04-23 20:40:33'),
 (6,'register',1,5,NULL,NULL,'2012-04-21 13:11:35'),
 (7,'not-found',1,6,NULL,NULL,'2012-04-21 13:14:04'),
 (8,'update-password',1,7,'0',NULL,'2012-09-12 21:54:35'),
 (9,'forgot-password',1,8,NULL,NULL,'2012-04-21 13:14:04'),
 (10,'offers',1,NULL,NULL,NULL,'2012-04-22 22:37:18'),
 (11,'food',10,7,NULL,NULL,'2012-04-22 22:37:18'),
 (12,'wine',11,NULL,NULL,NULL,'2012-04-22 22:37:18'),
 (13,'authorize',1,9,'3',NULL,'2012-09-12 21:54:35'),
 (14,'newbiz',1,10,'0,4','13','2013-01-07 14:08:42'),
 (15,'new-offer',1,11,'0',NULL,'2012-09-12 21:54:35'),
 (16,'edit-offer',1,11,NULL,NULL,'2012-05-31 15:09:05'),
 (17,'signout',1,12,NULL,NULL,'2012-07-19 17:26:04'),
 (18,'myaccount',1,13,'0',NULL,'2012-09-12 21:54:35'),
 (19,'mybizaccount',1,14,'0,8',NULL,'2012-09-12 21:54:36'),
 (20,'offer',1,15,NULL,NULL,'2012-08-01 22:12:00'),
 (21,'html',1,NULL,NULL,NULL,'2012-08-20 21:10:19'),
 (22,'offer',21,16,NULL,NULL,'2012-08-20 21:31:40'),
 (23,'newdeal',1,17,NULL,'15','2013-01-23 22:23:05'),
 (24,'updatemybiz',1,18,'0,8',NULL,'2012-09-12 21:54:36'),
 (25,'bizupdated',1,14,'14',NULL,'2012-09-12 22:47:53');
/*!40000 ALTER TABLE `meta_url_mappings` ENABLE KEYS */;


--
-- Definition of table `meta_user_custom_nodes`
--

DROP TABLE IF EXISTS `meta_user_custom_nodes`;
CREATE TABLE `meta_user_custom_nodes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `obj_id` bigint(20) unsigned NOT NULL,
  `node_id` bigint(20) unsigned NOT NULL,
  `owner_id` bigint(20) unsigned NOT NULL,
  `node_label` varchar(100) DEFAULT NULL,
  `status` int(10) unsigned NOT NULL DEFAULT '0',
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_user_custom_nodes`
--

/*!40000 ALTER TABLE `meta_user_custom_nodes` DISABLE KEYS */;
INSERT INTO `meta_user_custom_nodes` (`id`,`obj_id`,`node_id`,`owner_id`,`node_label`,`status`,`dt`) VALUES 
 (1,10,131,1,'Category',0,'2011-02-06 18:37:52'),
 (2,10,132,1,'Note',0,'2011-02-06 18:37:52');
/*!40000 ALTER TABLE `meta_user_custom_nodes` ENABLE KEYS */;


--
-- Definition of table `meta_values`
--

DROP TABLE IF EXISTS `meta_values`;
CREATE TABLE `meta_values` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(256) NOT NULL,
  `value` varchar(256) NOT NULL,
  `label` varchar(256) DEFAULT NULL,
  `dt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `meta_values`
--

/*!40000 ALTER TABLE `meta_values` DISABLE KEYS */;
INSERT INTO `meta_values` (`id`,`name`,`value`,`label`,`dt`) VALUES 
 (1,'nw','1',NULL,'2010-12-14 20:17:14'),
 (2,'confirmed','2',NULL,'2010-11-27 21:05:28'),
 (3,'deleted','3',NULL,'2010-11-27 21:05:28'),
 (4,'reset','4',NULL,'2010-11-27 21:05:28'),
 (5,'apprequest','0',NULL,'2010-11-26 17:14:11'),
 (6,'appconfirmed','1',NULL,'2010-11-26 17:14:11'),
 (7,'appcancelled','2',NULL,'2010-11-26 17:14:11'),
 (8,'appointment','0',NULL,'2010-11-26 18:13:53'),
 (9,'event','1',NULL,'2010-11-24 20:43:50'),
 (10,'Alabama','AL','Alabama','2007-12-02 11:00:00'),
 (11,'Alaska','AK','Alaska','2007-12-02 11:00:00'),
 (12,'American Samoa','AS','American Samoa','2007-12-02 11:00:00'),
 (13,'Arizona','AZ','Arizona','2010-11-27 16:42:56'),
 (14,'Sunday','sunday','Sunday','2007-12-10 15:00:00'),
 (15,'Monday','monday','Monday','2007-12-10 15:00:00'),
 (16,'Tuesday','tuesday','Tuesday','2007-12-10 15:00:00'),
 (17,'Wednesday','wednesday','Wednesday','2007-12-10 15:00:00'),
 (18,'Thursday','thursday','Thursday','2010-11-27 16:28:21'),
 (19,'Friday','friday','Friday','2010-11-27 16:28:21'),
 (20,'Saturday','saturday','Saturday','2010-11-27 16:28:21'),
 (21,'active','0',NULL,'2010-11-24 20:43:50'),
 (22,'cancelled','1',NULL,'2010-11-24 20:43:50'),
 (23,'personnel','0',NULL,'2010-11-24 20:43:50'),
 (24,'customer','1',NULL,'2010-11-24 20:43:50'),
 (25,'Arkansas','AR','Arkansas','2010-11-27 16:42:55'),
 (26,'California','CA','California','2010-11-27 16:42:56'),
 (27,'Colorado','CO','Colorado','2010-11-27 16:42:56'),
 (28,'Connecticut','CT','Connecticut','2010-11-27 16:42:56'),
 (29,'Delaware','DE','Delaware','2010-11-27 16:42:56'),
 (30,'District of Columbia','DC','District of Columbia','2010-11-27 16:42:56'),
 (31,'Florida','FL','Florida','2010-11-27 16:42:56'),
 (32,'Georgia','GA','Georgia','2010-11-27 16:42:56'),
 (33,'Hawaii','HI','Hawaii','2010-11-27 16:42:56'),
 (34,'Idaho','ID','Idaho','2010-11-27 16:42:56'),
 (35,'Illinois','IL','Illinois','2010-11-27 16:42:56'),
 (36,'Massachusetts','MA','Massachusetts','2010-11-27 16:42:56'),
 (37,'Michigan','MI','Michigan','2010-11-27 16:42:56'),
 (38,'Minnesota','MN','Minnesota','2010-11-27 16:42:56'),
 (39,'Mississippi','MS','Mississippi','2010-11-27 16:42:56'),
 (40,'Missouri','MO','Missouri','2010-11-27 16:42:56'),
 (41,'Montana','MT','Montana','2010-11-27 16:42:56'),
 (42,'North Carolina','NC','North Carolina','2010-11-27 16:42:56'),
 (43,'North Dakota','ND','North Dakota','2010-11-27 16:42:56'),
 (44,'Ohio','OH','Ohio','2010-11-27 16:42:56'),
 (45,'Oklahoma','OK','Oklahoma','2010-11-27 16:42:57'),
 (46,'Oregon','OR','Oregon','2010-11-27 16:42:57'),
 (47,'Pennsylvania','PA','Pennsylvania','2010-11-27 16:42:57'),
 (48,'Rhode Island','RI','Rhode Island','2010-11-27 16:42:57'),
 (49,'South Carolina','SC','South Carolina','2010-11-27 16:42:57'),
 (50,'South Dakota','SD','South Dakota','2010-11-27 16:42:57'),
 (51,'Tennessee','TN','Tennessee','2010-11-27 16:42:57'),
 (52,'Texas','TX','Texas','2010-11-27 16:42:57'),
 (53,'Utah','UT','Utah','2010-11-27 16:42:57'),
 (54,'Vermont','VT','Vermont','2010-11-27 16:42:57'),
 (55,'Virginia','VA','Virginia','2010-11-27 16:42:57'),
 (56,'Washington','WA','Washington','2010-11-27 16:42:57'),
 (57,'West Virginia','WV','West Virginia','2010-11-27 16:42:57'),
 (58,'Wisconsin','WI','Wisconsin','2010-11-27 16:42:57'),
 (59,'Wyoming','WY','Wyoming','2010-11-27 16:42:57'),
 (60,'active','0',NULL,'2010-11-29 15:40:41'),
 (61,'deleted','1',NULL,'2010-11-29 15:40:41'),
 (62,'disabled','0',NULL,'2010-12-05 14:08:15'),
 (63,'evcreator','2',NULL,'2010-12-16 22:13:35');
/*!40000 ALTER TABLE `meta_values` ENABLE KEYS */;


--
-- Definition of function `GET_DISTANCE`
--

DROP FUNCTION IF EXISTS `GET_DISTANCE`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`admin`@`localhost` FUNCTION `GET_DISTANCE`(lat1 real, lon1 real, lat2 real, lon2 real) RETURNS double
BEGIN
 declare theta real;
 declare dist real;
 set theta = lon1 - lon2;
 set dist = sin(radians(lat1))* sin(radians(lat2)) + cos(radians(lat1)) * cos(radians(lat2)) * cos(radians(theta));
 set dist = acos(dist);
 set dist = degrees(dist);
 set dist = round(dist * 60 * 1.1515, 1);

 return dist;
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `CANCEL_OFFER`
--

DROP PROCEDURE IF EXISTS `CANCEL_OFFER`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `CANCEL_OFFER`(in uid bigint, in oid bigint)
BEGIN

  update data_offers set status = 2 where status in (0,3) and id = oid and user_id = uid;

  update data_offer_participants set status = 2, status_change_dt = curdate() where status in (0,3) and
  offer_id = (select id from data_offers where id = oid and user_id = uid);


END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `GET_METADATA`
--

DROP PROCEDURE IF EXISTS `GET_METADATA`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER' */ $$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `GET_METADATA`(in meta_data varchar(32), in id bigint)
BEGIN
if meta_data = 'object' THEN
  select * from meta_objects;
ELSEIF meta_data = 'node' THEN
  select * from meta_nodes where parent_object_id = id;
ELSEIF meta_data = 'data_type' THEN
  select * from meta_data_types s;
ELSEIF meta_data = 'node_value' THEN
  select v.id, v.name, v.value, v.label from meta_values v
  inner join meta_node_values nv on v.id = nv.value_id
  where nv.node_id = id;
ELSEIF meta_data = 'sp_parameters' THEN
  select * from meta_sp_parameters s where sp_id = id;
ELSEIF meta_data = 'stored_procedure' THEN
  select * from meta_stored_procedures;
ELSEIF meta_data = 'node_operations' THEN
  select * from meta_node_operations s where node_id = id;
ELSEIF meta_data = 'ref_obj_nodes' THEN
  select * from meta_ref_object_nodes s where parent_node_id = id;
ELSEIF meta_data = 'custom_node' THEN
  select * from meta_user_custom_nodes where obj_id = id;
ELSEIF meta_data = 'urlmap' THEN
  select * from meta_url_mappings;
ELSEIF meta_data = 'jscomps' THEN
  select * from meta_js_components;
ELSEIF meta_data = 'pagejscomps' THEN
  select component_id from meta_page_js_component where page_id = id;
ELSEIF meta_data = 'operations' THEN
  select * from meta_operations;
ELSEIF meta_data = 'operation_params' THEN
  select * from meta_operation_params where operation_id = id;
ELSEIF meta_data = 'ref_operation_params' THEN
  select * from meta_operation_params where parent_oper_param_id = id;
ELSEIF meta_data = 'urlelement' THEN
  select m.* from meta_url_mappings m where m.parent_element_id = id;
ELSEIF meta_data = 'html_template' THEN
  select m.* from meta_html_templates m where m.id = id;


END IF;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `GET_OFFERS`
--

DROP PROCEDURE IF EXISTS `GET_OFFERS`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `GET_OFFERS`(in zip varchar(5), in userid bigint)
BEGIN

  declare zip_lat, zip_lon real;

  if length(zip) > 0 then
    select latitude, longitude into  zip_lat, zip_lon from data_state_zipcodes where zipcode = zip;
    if userid = -1 then
      select distinct o.* from data_offers o join data_offer_locations ol on o.id = ol.offer_id where
      GET_DISTANCE(zip_lat, zip_lon, ol.latitude, ol.longitude) < 20 and o.status = 1 and o.close_date >= CURDATE();
    else
      select distinct o.* from data_offers o join data_offer_locations ol on o.id = ol.offer_id where
      GET_DISTANCE(zip_lat, zip_lon, ol.latitude, ol.longitude) < 20 and o.id not in (select offer_id
      from data_offer_participants where user_id = userid and status = 0) and o.status = 1 and o.close_date >= CURDATE();
    end if;
  else
    select distinct o.* from data_offers o where o.status = 1 and o.close_date >= CURDATE() order by o.dt asc;
  end if;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `OFFER_ORDER`
--

DROP PROCEDURE IF EXISTS `OFFER_ORDER`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `OFFER_ORDER`(in oper bigint, in uid bigint, in oid bigint, in user_details varchar(250),
in ordr varchar(250), in ordrid bigint)
BEGIN

  declare itemid, offer_creat_user_id bigint;
  declare curpos, nextordpos, ordpos, itempos, item_total, item_ordered, qty, p_oqty, p_nqty int;
  declare itemlft, newiordered, order_status int;
  declare user_items varchar(100);
  declare vchar_id, item_qty varchar(7);
  declare ind int default 0;

  set nextordpos = 1;
  set curpos = 1;
  set ordpos = 1;
  set itempos = 1;
  set user_items = '';
  set order_status = 0;

  while nextordpos < length(ordr) do
    set nextordpos = locate(',', ordr, ordpos);
    if nextordpos = 0 then
      set nextordpos = length(ordr) + 1;
    end if;
    set itempos = locate('|', ordr, itempos);
    set itemid = cast(substr(ordr, curpos, itempos - curpos) as signed);
    set curpos = itempos + 1;
    if oper = 0 then
      set p_nqty = cast(substr(ordr, curpos, nextordpos - curpos) as signed);
    elseif oper = 2 then
      set p_oqty = cast(substr(ordr, curpos, nextordpos - curpos) as signed);
    elseif oper = 1 then
      set itempos = locate('|', ordr, itempos + 1);
      set p_oqty = cast(substr(ordr, curpos, itempos - curpos) as signed);
      set curpos = itempos;
      set p_nqty = cast(substr(ordr, itempos + 1, nextordpos - itempos - 1) as signed);
    end if;
    if nextordpos < length(ordr) then
      set itempos = nextordpos + 1;
      set curpos = nextordpos + 1;
      set ordpos = nextordpos + 1;
    end if;

    select oi.ordered, oi.total into item_ordered, item_total from data_offer_items oi where oi.id = itemid and oi.offer_id = oid FOR UPDATE;
    if oper = 0 then
      if item_ordered < item_total then
        set newiordered = item_ordered + p_nqty;
        if newiordered > item_total then
          set p_nqty = item_total - item_ordered;
          set newiordered = item_total;
          set order_status = 3;
        end if;
        update data_offer_items set ordered = newiordered where id = itemid;
      else
        set p_nqty = 0;
        set order_status = 3;
      end if;
    end if;
    if oper = 1 then
      if p_oqty > 0 then
        if item_ordered - p_oqty + p_nqty < item_total then
           set newiordered = item_ordered - p_oqty + p_nqty;
           update data_offer_items set ordered = newiordered where id = itemid;
        end if;
      else
        set newiordered = item_ordered + p_nqty;
        if newiordered > item_total then
           set p_nqty = item_total - item_ordered;
           set newiordered = item_total;
        end if;
        update data_offer_items set ordered = newiordered where id = itemid;
      end if;
    end if;
    if oper = 2 then
      set newiordered = item_ordered - p_oqty;
      update data_offer_items set ordered = newiordered where id = itemid;
    end if;
    if p_nqty > 0 then
      set vchar_id = cast(itemid as char(7));
      set vchar_id = LPAD(vchar_id, 7, '0');
      set item_qty = cast(p_nqty as char(7));
      set item_qty = LPAD(item_qty, 7, '0');
      if length(user_items) = 0 then
         set user_items = concat(vchar_id, '|', item_qty);
      else
        set user_items = concat(user_items, '^', vchar_id, '|', item_qty);
      end if;
    end if;

  end while;

  if oper = 0 and length(user_items) > 0 then
    insert into data_offer_participants(offer_id, user_id, user_details, status, items, status_change_dt) values (oid, uid,  user_details, order_status, user_items, curdate());
  end if;
  if oper = 1 then
    if length(user_items) > 0 then
      update data_offer_participants set items = user_items where offer_id = oid and user_id = uid and status = 0;
    else
      update data_offer_participants set status = 1, status_change_dt=now() where offer_id = oid and user_id = uid and status = 0;
    end if;
  end if;
  if oper = 2 then
    select user_id into offer_creat_user_id from data_offers where id = oid;
    if offer_creat_user_id = uid then
      if ordrid is not null then
        update data_offer_participants set status = 2, status_change_dt=now() where offer_id = oid and id = ordrid and status in (0,3);
      else
        update data_offer_participants set status = 2, status_change_dt=now() where offer_id = oid and user_id = uid and status in (0,3);
      end if;
    else
      update data_offer_participants set status = 1, status_change_dt=now() where offer_id = oid and user_id = uid and status in (0,3);
    end if;
  end if;
  call UPDATE_OFFER_ITEMS(oid);


  select order_status as status, user_items as items, of.total, of.total_ordered from data_offers of where of.id = oid;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;

--
-- Definition of procedure `UPDATE_OFFER_ITEMS`
--

DROP PROCEDURE IF EXISTS `UPDATE_OFFER_ITEMS`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`admin`@`localhost` PROCEDURE `UPDATE_OFFER_ITEMS`(in offer_id bigint)
BEGIN

  declare done int default 0;
  declare itemid bigint;
  declare item_ordered, tordered int;
  declare updated_items varchar(100);
  declare vchar_id, item_ord varchar(7);
  declare ind int default 0;
  declare cur cursor for select a.id, a.ordered from data_offer_items a where a.offer_id = offer_id FOR UPDATE;

  declare continue handler for sqlstate '02000' set done = 1;

  set updated_items = '';
  set tordered = 0;
  open cur;
  repeat
    fetch cur into itemid, item_ordered;
    if not done then
      if item_ordered > 0 then
        set vchar_id = cast(itemid as char(7));
        set vchar_id = LPAD(vchar_id, 7, '0');
        set item_ord = cast(item_ordered as char(7));
        set item_ord = LPAD(item_ordered, 7, '0');
        if length(updated_items) = 0 then
          set updated_items = concat(vchar_id, '|', item_ord);
        else
          set updated_items = concat(updated_items, '^', vchar_id, '|', item_ord);
        end if;
        set tordered = tordered + item_ordered;
      end if;
    end if;
  until done end repeat;
  close cur;

  update data_offers set items_ordered = updated_items, total_ordered = tordered where id = offer_id;

END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
