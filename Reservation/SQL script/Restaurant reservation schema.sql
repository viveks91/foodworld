CREATE DATABASE  IF NOT EXISTS `restaurant_reservation` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `restaurant_reservation`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: restaurant_reservation
-- ------------------------------------------------------
-- Server version	5.6.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `apt_No` varchar(10) DEFAULT NULL,
  `street` varchar(225) NOT NULL,
  `city` varchar(20) NOT NULL,
  `state` varchar(20) NOT NULL,
  `zip` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `city` (`city`),
  KEY `state` (`state`),
  KEY `zip` (`zip`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`city`) REFERENCES `city` (`city`),
  CONSTRAINT `address_ibfk_2` FOREIGN KEY (`state`) REFERENCES `state` (`state`),
  CONSTRAINT `address_ibfk_3` FOREIGN KEY (`zip`) REFERENCES `zip` (`zip`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'o0001','ewrwer','seattle','WA','98119'),(2,'234','we','seattle','WA','90109'),(3,'1806 12th ','asd','Seattle','WA','98122'),(4,'1531','14th Avenue',' Seattle','WA','98122'),(5,'602','19th Avenue East',' Seattle','WA','98112'),(6,'B306','2450 Aurora Ave','Seattle','WA','98109');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('Indian'),('Italian'),('Restaurant');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `city` varchar(20) NOT NULL,
  PRIMARY KEY (`city`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (' Seattle'),('asd'),('seattle');
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `userName` varchar(225) NOT NULL,
  `restaurantId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`userName`,`restaurantId`),
  KEY `restaurantId` (`restaurantId`),
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`restaurantId`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES ('harsh',5),('vivek',5);
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `following`
--

DROP TABLE IF EXISTS `following`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `following` (
  `userName` varchar(225) NOT NULL,
  `following` varchar(225) NOT NULL,
  PRIMARY KEY (`userName`,`following`),
  KEY `following` (`following`),
  CONSTRAINT `following_ibfk_1` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `following_ibfk_2` FOREIGN KEY (`following`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `following`
--

LOCK TABLES `following` WRITE;
/*!40000 ALTER TABLE `following` DISABLE KEYS */;
INSERT INTO `following` VALUES ('vivek','harsh'),('harsh','vivek');
/*!40000 ALTER TABLE `following` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `userName` varchar(225) NOT NULL,
  `password` varchar(225) NOT NULL,
  `firstName` varchar(250) NOT NULL,
  `lastName` varchar(250) NOT NULL,
  `dtype` varchar(225) NOT NULL DEFAULT '',
  PRIMARY KEY (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('harsh','harsh','Harshad','Sathe','User'),('pre2712','jack12','jack','pager','Person'),('pre2718','1233','ksjdfh','miss','User'),('pre284','1234','pret','mish','User'),('vivek','vivek','Vivekananda','Shankar Acharya','User');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservation` (
  `id` int(100) unsigned NOT NULL AUTO_INCREMENT,
  `people_count` int(5) NOT NULL DEFAULT '1',
  `date` varchar(15) NOT NULL,
  `restaurantId` int(11) unsigned NOT NULL,
  `userName` varchar(225) NOT NULL,
  `time` varchar(225) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `restaurantId` (`restaurantId`),
  KEY `userName` (`userName`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`restaurantId`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservation`
--

LOCK TABLES `reservation` WRITE;
/*!40000 ALTER TABLE `reservation` DISABLE KEYS */;
INSERT INTO `reservation` VALUES (12,5,'2014-12-20',5,'vivek','19:00'),(13,6,'2014-12-22',5,'vivek','19:00'),(14,9,'2014-12-20',5,'vivek','19:00'),(15,5,'2014-12-16',5,'vivek','20:00'),(16,5,'2014-12-12',5,'vivek','20:00'),(17,4,'2014-12-12',5,'vivek','12:00'),(18,5,'2014-12-26',5,'vivek','19:00');
/*!40000 ALTER TABLE `reservation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `restaurant` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(225) NOT NULL,
  `phoneNo` varchar(20) DEFAULT NULL,
  `website` varchar(500) DEFAULT NULL,
  `openingTime` varchar(100) DEFAULT NULL,
  `closingTime` varchar(100) DEFAULT NULL,
  `capacity` int(10) NOT NULL,
  `type` varchar(100) NOT NULL,
  `addressId` int(11) NOT NULL,
  `imageURL` varchar(500) DEFAULT NULL,
  `priceLevel` int(3) DEFAULT NULL,
  `rating` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `addressId` (`addressId`),
  CONSTRAINT `restaurant_ibfk_1` FOREIGN KEY (`type`) REFERENCES `category` (`type`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `restaurant_ibfk_2` FOREIGN KEY (`addressId`) REFERENCES `address` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (5,'The Kingfish Cafe','(206) 320-8757','http://thekingfishcafe.com/','10:00','14:00',50,'Restaurant',5,'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=CpQBhwAAAGcLwSC1_7PJn7lZu3RBfAO3o92G8vRO6EDk0fY-MHzdy9GxMhzv15k7w4wbjUH8mRTdeJJCwFii0_wLIsLateMCL9qRBETkyMfxG8lkiyMN7iur3Z2mC4clajswg6_dKBAICHFmA8vTYY8ev2_fBDKhWOX2B-3pK8CAmgPnCxbasprWC1gf8XfvKhgPd25TrBIQmExAsxByx_at5Trgcp2UPhoUXfLftAALIN-0pkFaFjqP76VYYuM&key=AIzaSyBK7757GStqJx2Xudqnm5IMViOBmGIdJFM',2,'4.2');
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `userName` varchar(225) DEFAULT NULL,
  `ratings` varchar(5) DEFAULT NULL,
  `comments` varchar(500) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `restaurantId` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `restaurantId` (`restaurantId`),
  KEY `userName` (`userName`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`restaurantId`) REFERENCES `restaurant` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,NULL,'2','bad',NULL,1),(2,NULL,'4','good',NULL,2),(3,'pre284','5','very nice',NULL,1),(4,'vivek','4','sdf','2014-12-11 00:00:00',5),(5,'vivek','5','Hi','2014-12-11 00:00:00',5),(6,'vivek','4','This is for test','2014-12-11 00:00:00',5),(7,'harsh','5','This is a good place for a foodie','2014-12-11 00:00:00',5);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `state` varchar(20) NOT NULL,
  PRIMARY KEY (`state`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES ('asd'),('WA');
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `phoneNo` varchar(12) DEFAULT NULL,
  `emailId` varchar(225) NOT NULL DEFAULT '',
  `userName` varchar(225) NOT NULL,
  `addressId` int(11) DEFAULT NULL,
  PRIMARY KEY (`userName`),
  KEY `addressId` (`addressId`),
  KEY `user_username_fk` (`phoneNo`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`addressId`) REFERENCES `address` (`id`) ON DELETE SET NULL,
  CONSTRAINT `username_fk` FOREIGN KEY (`userName`) REFERENCES `person` (`userName`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('2063340366','harsh.sathe89@gmail.com','harsh',6),('2876','jdhgf','pre2718',1),('1234','asd','pre284',1),('2068839077','s.vivekananda1991@gmail.com','vivek',3);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zip`
--

DROP TABLE IF EXISTS `zip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zip` (
  `zip` varchar(20) NOT NULL,
  PRIMARY KEY (`zip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zip`
--

LOCK TABLES `zip` WRITE;
/*!40000 ALTER TABLE `zip` DISABLE KEYS */;
INSERT INTO `zip` VALUES ('90109'),('98109'),('98112'),('98119'),('98122'),('asd');
/*!40000 ALTER TABLE `zip` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-12-11  7:45:57
