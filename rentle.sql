CREATE DATABASE  IF NOT EXISTS `rentle` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `rentle`;
-- MySQL dump 10.13  Distrib 8.0.36, for macos14 (arm64)
--
-- Host: 127.0.0.1    Database: rentle
-- ------------------------------------------------------
-- Server version	8.0.37

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
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
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `address_id` int NOT NULL AUTO_INCREMENT,
  `address_line_1` varchar(45) NOT NULL,
  `address_line_2` varchar(45) DEFAULT NULL,
  `zipcode` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'1 Washington Sq',NULL,'95192','San Jose','CA'),(2,'1 Infinite Loop',NULL,'95014','Cupertino','CA'),(3,'1600 Amphitheatre Parkway',NULL,'94043','Mountain View','CA'),(4,'1 Hacker Way',NULL,'94025','Menlo Park','CA'),(5,'3500 Deer Creek Road',NULL,'94304','Palo Alto','CA'),(6,'415 Mission Street',NULL,'94105','San Francisco','CA'),(7,'1355 Market Street','Suite 900','94103','San Francisco','CA'),(8,'500 Oracle Parkway',NULL,'94065','Redwood City','CA'),(9,'2200 Mission College Blvd',NULL,'95054','Santa Clara','CA'),(10,'1455 Market Street',NULL,'94103','San Francisco','CA'),(11,'1 Infinite Loop',NULL,'95014','Cupertino','CA'),(12,'1600 Amphitheatre Parkway',NULL,'94043','Mountain View','CA'),(13,'1 Hacker Way',NULL,'94025','Menlo Park','CA'),(14,'3500 Deer Creek Road',NULL,'94304','Palo Alto','CA'),(15,'415 Mission Street',NULL,'94105','San Francisco','CA'),(16,'1355 Market Street','Suite 900','94103','San Francisco','CA'),(17,'500 Oracle Parkway',NULL,'94065','Redwood City','CA'),(18,'2200 Mission College Blvd',NULL,'95054','Santa Clara','CA'),(19,'1455 Market Street',NULL,'94103','San Francisco','CA'),(20,'701 First Avenue',NULL,'94089','Sunnyvale','CA');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alsohave`
--

DROP TABLE IF EXISTS `alsohave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alsohave` (
  `item_id` int NOT NULL,
  `features_id` varchar(45) NOT NULL,
  PRIMARY KEY (`item_id`,`features_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alsohave`
--

LOCK TABLES `alsohave` WRITE;
/*!40000 ALTER TABLE `alsohave` DISABLE KEYS */;
INSERT INTO `alsohave` VALUES (1,'1'),(1,'2'),(1,'3'),(2,'4'),(2,'9'),(3,'7'),(3,'9'),(4,'8'),(5,'2'),(6,'2'),(7,'3'),(8,'10'),(9,'9'),(10,'3');
/*!40000 ALTER TABLE `alsohave` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `UserID` int NOT NULL,
  `ItemID` int NOT NULL,
  `duration` int NOT NULL,
  `quantity` int NOT NULL,
  `UserRentID` int NOT NULL,
  `price_per_item` varchar(45) NOT NULL,
  PRIMARY KEY (`UserID`,`ItemID`,`duration`,`quantity`,`UserRentID`,`price_per_item`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (2,1,180,2,1,'0.05'),(2,2,300,3,1,'0.16666666666666666'),(14,2,172800,1,2,'20'),(14,7,259200,1,7,'240'),(14,9,259200,1,9,'75'),(21,4,259200,1,4,'300'),(21,6,259200,1,6,'60'),(21,9,259200,1,9,'75'),(22,7,1814400,1,7,'1680'),(22,8,2592000,1,8,'3000');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Bikes'),(2,'Scooters'),(3,'Google Cars'),(4,'Trucks'),(5,'SUVs'),(6,'Skateboards'),(7,'Car'),(8,'Roller blades'),(9,'Autonomous Car'),(10,'Waymo Cars');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consistsof`
--

DROP TABLE IF EXISTS `consistsof`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consistsof` (
  `CategoryID` int NOT NULL,
  `FeaturesID` int NOT NULL,
  PRIMARY KEY (`CategoryID`,`FeaturesID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consistsof`
--

LOCK TABLES `consistsof` WRITE;
/*!40000 ALTER TABLE `consistsof` DISABLE KEYS */;
INSERT INTO `consistsof` VALUES (1,3),(2,7),(3,5),(4,10),(5,6),(6,9),(7,1),(8,4),(9,2),(10,8);
/*!40000 ALTER TABLE `consistsof` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contains`
--

DROP TABLE IF EXISTS `contains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contains` (
  `ItemID` int NOT NULL,
  `PhotoID` int NOT NULL,
  PRIMARY KEY (`ItemID`,`PhotoID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contains`
--

LOCK TABLES `contains` WRITE;
/*!40000 ALTER TABLE `contains` DISABLE KEYS */;
INSERT INTO `contains` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `contains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `LastRental` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (11,'2024-08-06 15:35:05'),(12,'2024-08-06 15:35:05'),(13,'2024-08-06 15:35:05'),(14,'2024-08-06 15:35:05'),(15,'2024-08-06 15:35:05'),(16,'2024-08-06 15:35:05'),(17,'2024-08-06 15:35:05'),(18,'2024-08-06 15:35:05'),(19,'2024-08-06 15:35:05'),(20,'2024-08-06 15:35:05');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `features_id` int NOT NULL AUTO_INCREMENT,
  `features_name` varchar(45) NOT NULL,
  PRIMARY KEY (`features_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,'Four-wheel'),(2,'Electric'),(3,'Tough terrains'),(4,'Good-looking'),(5,'Auto-pilot'),(6,'Trending'),(7,'Fast'),(8,'Comfortable'),(9,'Portable'),(10,'Lots of space');
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friends` (
  `FriendUserID1` int NOT NULL,
  `FriendUserID2` int NOT NULL,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`FriendUserID1`,`FriendUserID2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
INSERT INTO `friends` VALUES (1,20,'1'),(2,3,'0'),(2,21,'1'),(3,19,'1'),(4,18,'1'),(5,11,'0'),(5,14,'0'),(5,16,'0'),(5,17,'1'),(5,21,'0'),(6,16,'1'),(7,15,'1'),(8,14,'1'),(9,13,'1'),(10,12,'1'),(15,19,'0'),(18,17,'0'),(21,1,'0'),(21,22,'0');
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_chat`
--

DROP TABLE IF EXISTS `group_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_chat` (
  `group_id` int NOT NULL AUTO_INCREMENT,
  `group_users` varchar(45) DEFAULT NULL,
  `group_chat_status` varchar(45) DEFAULT NULL COMMENT '1 means active, 0 is pending',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_chat`
--

LOCK TABLES `group_chat` WRITE;
/*!40000 ALTER TABLE `group_chat` DISABLE KEYS */;
INSERT INTO `group_chat` VALUES (1,'1,2','1'),(2,'1,3','1'),(3,'1,4','1'),(4,'1,5,2','1'),(5,'1,12','1'),(6,'1,3,2','1'),(7,'1,13,18,20','1'),(8,'1,5,9','1'),(9,'1,21,17','1'),(10,'1,19,18','1'),(11,'21,12,10','1'),(12,'14,22,21','1');
/*!40000 ALTER TABLE `group_chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `has`
--

DROP TABLE IF EXISTS `has`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `has` (
  `ItemID` int NOT NULL,
  `CategoryID` int NOT NULL,
  PRIMARY KEY (`ItemID`,`CategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `has`
--

LOCK TABLES `has` WRITE;
/*!40000 ALTER TABLE `has` DISABLE KEYS */;
INSERT INTO `has` VALUES (1,3),(2,1),(3,2),(4,10),(5,1),(6,2),(7,4),(8,5),(9,6),(10,1);
/*!40000 ALTER TABLE `has` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holds`
--

DROP TABLE IF EXISTS `holds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `holds` (
  `UserID` int NOT NULL,
  `RentHistoryID` int NOT NULL,
  PRIMARY KEY (`UserID`,`RentHistoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holds`
--

LOCK TABLES `holds` WRITE;
/*!40000 ALTER TABLE `holds` DISABLE KEYS */;
INSERT INTO `holds` VALUES (1,1),(2,1),(14,5),(14,8),(14,10),(21,1),(21,9),(22,1),(22,6),(22,8),(22,10);
/*!40000 ALTER TABLE `holds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `isbeing`
--

DROP TABLE IF EXISTS `isbeing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `isbeing` (
  `ItemID` int NOT NULL,
  `ReviewID` int NOT NULL,
  PRIMARY KEY (`ItemID`,`ReviewID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `isbeing`
--

LOCK TABLES `isbeing` WRITE;
/*!40000 ALTER TABLE `isbeing` DISABLE KEYS */;
INSERT INTO `isbeing` VALUES (1,1),(1,11),(1,21),(1,31),(2,2),(2,12),(2,22),(2,32),(3,3),(3,13),(3,23),(3,33),(4,4),(4,14),(4,24),(4,34),(5,5),(5,15),(5,25),(5,35),(6,6),(6,16),(6,26),(6,36),(7,7),(7,17),(7,27),(7,37),(8,8),(8,18),(8,28),(8,38),(9,9),(9,19),(9,29),(9,39),(10,10),(10,20),(10,30),(10,40);
/*!40000 ALTER TABLE `isbeing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `islocatedat`
--

DROP TABLE IF EXISTS `islocatedat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `islocatedat` (
  `UserID` int NOT NULL,
  `AddressID` int NOT NULL,
  PRIMARY KEY (`UserID`,`AddressID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `islocatedat`
--

LOCK TABLES `islocatedat` WRITE;
/*!40000 ALTER TABLE `islocatedat` DISABLE KEYS */;
INSERT INTO `islocatedat` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),(13,13),(14,14),(15,15),(16,16),(17,17),(18,18),(19,19),(20,20);
/*!40000 ALTER TABLE `islocatedat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `condition` varchar(45) NOT NULL,
  `description` varchar(200) NOT NULL,
  `location` varchar(200) NOT NULL,
  `status` varchar(45) NOT NULL,
  `quantity` int DEFAULT '1',
  `payment_method` varchar(45) NOT NULL,
  `posted_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Google Car','Excellent','A self driving google car with a top speed of 80 MPH!','1600 Amphitheatre Parkway, Mountain View, CA 94043','Open',1,'Card','2024-09-03 13:18:44'),(2,'Bike','Good','A bike with multiple different gear levels!','1 Washington Sq, San Jose, CA, 95192','Open',1,'Card','2023-08-11 15:44:49'),(3,'Scooter','Fair','Manual scooter that has a maximum weight capacity of 200lbs.','1 Hacker Way, Menlo Park, CA 94025\n\n','Open',1,'Card','2024-01-13 14:30:40'),(4,'Waymo Car','Excellent','Fully autonomous and seats up to 5 people.','1 Infinite Loop, Cupertino, CA 95014\n\n','Open',1,'Card','2023-02-25 00:44:36'),(5,'Electric Bike','Good','Top speed of 20 mph.','3500 Deer Creek Road, Palo Alto, CA 94304\n\n','Open',1,'Card','2024-06-08 12:12:12'),(6,'Electric Scooter','Fair','Can go up to 10 mph and has a battery life of 5 hours.','415 Mission Street, San Francisco, CA 94105\n\n','Open',1,'Card','2024-02-20 14:45:30'),(7,'Truck','Excellent','Has a big trunk bed and seats 3 people','1355 Market Street, Suite 900, San Francisco, CA 94103\n\n','Open',1,'Card','2024-01-15 08:30:00'),(8,'Van','Good','Fits up to 7 people and has decent trunk space for vacation!','500 Oracle Parkway, Redwood City, CA 94065\n\n','Open',1,'Card','2024-03-18 15:44:49'),(9,'Skateboard','Fair','A long and nice qualiity skateboard.','2200 Mission College Blvd, Santa Clara, CA 95054\n\n','Open',1,'Card','2024-05-25 22:30:21'),(10,'Mountain Bike','Excellent','Bike with brand new tires and has 7 gears that work really well on tough terrain!','1455 Market Street, San Francisco, CA 94103\n\n','Open',1,'Card','2024-07-15 19:45:36');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `message_content` varchar(45) NOT NULL,
  `group_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'Hi there',1,2),(2,'How are you doing',1,2),(3,'Good, how about you',1,1),(4,'I\'m good! What\'s going on?',1,2),(5,'Did you have anything fun to do?',1,2),(6,'What kind of fun are you trying to look for?',1,1),(7,'Nothing much',1,2),(8,'Hi there!',2,1),(9,'Mr. Wu',3,1),(10,'what\'s up guysss',4,1),(11,'helloooo',4,2),(12,'ok let\'s talk',1,2),(13,'ok',1,2),(14,'ok',1,2),(15,'nvm',1,2),(16,'ok',4,2),(17,'see i told you',4,2),(18,'whattt',1,2),(19,'gdgdg',5,0),(20,'dirtee brown water',3,1),(21,'dr monsters appointment',3,4),(22,'Hi, can I rent your bike?',5,1),(23,'i just wanted my cheese',3,4),(24,'Good job on the project guys',6,1),(25,'Im a crypto bro i love crypto yes nfts',7,1),(26,'What are yall renting?',8,1),(27,'guys i love syngates solo',9,1),(28,'please hire me',10,1),(29,'guys im so famous',11,21),(30,'hey guys wanna be on my show',12,14),(31,'no',12,21);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photos` (
  `photo_id` int NOT NULL AUTO_INCREMENT,
  `photo` varchar(45) NOT NULL,
  PRIMARY KEY (`photo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,'images/image7.png'),(2,'images/image6.png'),(3,'images/image9.png'),(4,'images/image4.png'),(5,'images/image8.png'),(6,'images/image5.png'),(7,'images/image10.png'),(8,'images/image11.png'),(9,'images/image1.png'),(10,'images/image3.png');
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices` (
  `prices_id` int NOT NULL AUTO_INCREMENT,
  `price_per_hour` varchar(45) DEFAULT NULL,
  `price_per_day` varchar(45) DEFAULT NULL,
  `price_per_week` varchar(45) DEFAULT NULL,
  `price_per_month` varchar(45) DEFAULT NULL,
  `priced_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`prices_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES (1,'30','100','500','1500','2024-01-15 08:30:23'),(2,'3','10','40','120','2024-02-20 14:45:37'),(3,'3','15','60','180','2024-08-10 16:11:13'),(4,'25','100','450','1000','2024-03-10 09:15:52'),(5,'8','25','100','300','2024-06-30 11:00:15'),(6,'6','20','100','250','2024-05-25 22:30:48'),(7,'20','80',NULL,NULL,'2024-07-15 19:45:56'),(8,'22','100',NULL,NULL,'2024-08-01 12:30:29'),(9,'4','25',NULL,NULL,'2024-06-10 16:15:44'),(10,'6','30',NULL,NULL,'2024-01-22 20:00:11');
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receives`
--

DROP TABLE IF EXISTS `receives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receives` (
  `ReviewID` int NOT NULL,
  `UserID` int NOT NULL,
  PRIMARY KEY (`ReviewID`,`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receives`
--

LOCK TABLES `receives` WRITE;
/*!40000 ALTER TABLE `receives` DISABLE KEYS */;
INSERT INTO `receives` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,1),(12,2),(13,3),(14,4),(15,5),(16,6),(17,7),(18,8),(19,9),(20,10),(21,1),(22,2),(23,3),(24,4),(25,5),(26,6),(27,7),(28,8),(29,9),(30,10),(31,1),(32,2),(33,3),(34,4),(35,5),(36,6),(37,7),(38,8),(39,9),(40,10);
/*!40000 ALTER TABLE `receives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rent`
--

DROP TABLE IF EXISTS `rent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rent` (
  `UserID` int NOT NULL,
  `ItemID` int NOT NULL,
  PRIMARY KEY (`UserID`,`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rent`
--

LOCK TABLES `rent` WRITE;
/*!40000 ALTER TABLE `rent` DISABLE KEYS */;
INSERT INTO `rent` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `rent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rent_history`
--

DROP TABLE IF EXISTS `rent_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rent_history` (
  `history_id` int NOT NULL AUTO_INCREMENT,
  `rentdate` datetime NOT NULL,
  `ItemID` int DEFAULT NULL,
  `rentexpiration` datetime DEFAULT NULL,
  `rentprice` varchar(45) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rent_history`
--

LOCK TABLES `rent_history` WRITE;
/*!40000 ALTER TABLE `rent_history` DISABLE KEYS */;
INSERT INTO `rent_history` VALUES (1,'2024-08-08 12:32:49',1,'2024-08-08 12:35:49','0.05',2),(2,'2024-08-08 12:32:49',2,'2024-08-08 12:37:49','0.16666666666666666',3),(3,'2024-08-10 19:30:05',5,'2024-08-12 19:30:05','50',1),(4,'2024-08-10 19:30:05',8,'2024-08-31 19:30:05','2100',1),(5,'2024-08-10 19:30:05',10,'2024-08-14 19:30:05','120',1),(6,'2024-08-10 19:30:35',6,'2024-08-10 19:30:35','0',1),(7,'2024-08-10 19:30:50',1,'2024-08-10 21:30:50','60',1),(8,'2024-08-10 19:30:50',9,'2024-08-13 19:30:50','75',1),(9,'2024-08-10 19:31:22',1,'2024-08-13 19:31:22','300',1),(10,'2024-08-10 19:31:22',8,'2024-08-13 19:31:22','300',1),(11,'2024-08-10 19:31:22',10,'2024-08-13 19:31:22','90',1),(12,'2024-08-10 20:20:58',1,'2024-08-31 20:20:58','2100',1);
/*!40000 ALTER TABLE `rent_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `renter`
--

DROP TABLE IF EXISTS `renter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `renter` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `ActiveStatus` tinyint DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `renter`
--

LOCK TABLES `renter` WRITE;
/*!40000 ALTER TABLE `renter` DISABLE KEYS */;
INSERT INTO `renter` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1);
/*!40000 ALTER TABLE `renter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentsfor`
--

DROP TABLE IF EXISTS `rentsfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rentsfor` (
  `ItemID` int NOT NULL,
  `PricesID` int NOT NULL,
  PRIMARY KEY (`ItemID`,`PricesID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentsfor`
--

LOCK TABLES `rentsfor` WRITE;
/*!40000 ALTER TABLE `rentsfor` DISABLE KEYS */;
INSERT INTO `rentsfor` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `rentsfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `requests`
--

DROP TABLE IF EXISTS `requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `requests` (
  `FriendUserID1` int NOT NULL,
  `FriendUserID2` int NOT NULL,
  `RequestsID` int NOT NULL,
  PRIMARY KEY (`FriendUserID2`,`FriendUserID1`,`RequestsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `requests`
--

LOCK TABLES `requests` WRITE;
/*!40000 ALTER TABLE `requests` DISABLE KEYS */;
INSERT INTO `requests` VALUES (10,12,10),(9,13,9),(8,14,8),(7,15,7),(6,16,6),(5,17,5),(4,18,4),(3,19,3),(1,20,1),(2,21,2);
/*!40000 ALTER TABLE `requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL AUTO_INCREMENT,
  `stars` varchar(45) NOT NULL,
  `description` varchar(200) NOT NULL,
  `criteria` varchar(45) NOT NULL,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'1','Overcharged me and I feel for it!','Convenience'),(2,'3','Nice guy, a bit talkative. Still a good choice.','Comfortable'),(3,'5','My CS157A student is letting me rent one of his bikes! I love it!','Comfortable,Convenience'),(4,'4','Fantastic visit to San Jose thanks to the help of this guy!','Convenience'),(5,'5','Good to talk with him, but at the end, he did not give me more Japanese food!','Comfortable'),(6,'5','A funny man!','Comfortable'),(7,'4','Really good quality and was really excited!','Clean'),(8,'3','Decent quality and was too pushy.','Comfortable'),(9,'2','He is a bad person!','Clean'),(10,'5','Cleaned everything nicely!','Clean'),(11,'5','Very good quality!','Comfortable'),(12,'5','Fantastic experience! Highly recommend.','Comfortable,Clean'),(13,'4','Very good, just missing a bit of charm.','Convenience,Comfortable'),(14,'2','Not great. Could be much better.','Clean'),(15,'3','Average. It does the job but lacks excitement.','Convenience,Clean'),(16,'1','Very disappointing. Would not recommend.','Comfortable'),(17,'4','Good value, but a little noisy.','Comfortable,Clean'),(18,'5','Perfect! Exceeded all my expectations.','Convenience,Comfortable,Clean'),(19,'3','Okay, but nothing to write home about.','Convenience'),(20,'2','Too much hassle for the cost.','Clean'),(21,'4','Quite good, though not without flaws.','Comfortable'),(22,'5','Amazing experience! Couldn\'t be happier.','Comfortable,Clean'),(23,'3','Meh. Its alright but lacks something.','Convenience,Clean'),(24,'2','Disappointing. Not as expected.','Comfortable'),(25,'4','Pretty good, but could use some improvements.','Clean'),(26,'5','Exceeded all expectations. Perfect getaway!','Comfortable,Clean'),(27,'3','Average. Nothing special.','Convenience'),(28,'1','Terrible experience. Will not return.','Clean'),(29,'4','Great overall, just a bit of a letdown in some areas.','Comfortable,Clean'),(30,'5','Incredible! Everything was spot on.','Convenience,Comfortable'),(31,'3','Okay experience, but Ive had better.','Convenience,Clean'),(32,'2','Not worth the money. Disappointing.','Comfortable'),(33,'4','Very good, but a little more attention to detail needed.','Clean'),(34,'5','Amazing! Perfect for a relaxing break.','Comfortable,Clean'),(35,'3','Its fine, but not remarkable.','Convenience'),(36,'2','Quite poor. I expected more.','Clean'),(37,'4','Good experience overall, with minor issues.','Comfortable'),(38,'5','Absolutely superb. Highly recommend!','Convenience,Comfortable'),(39,'3','Decent but could be better.','Comfortable,Clean'),(40,'2','Disappointing. Would not recommend.','Clean');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saves`
--

DROP TABLE IF EXISTS `saves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saves` (
  `UserID` int NOT NULL,
  `RentHistoryID` int NOT NULL,
  PRIMARY KEY (`UserID`,`RentHistoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saves`
--

LOCK TABLES `saves` WRITE;
/*!40000 ALTER TABLE `saves` DISABLE KEYS */;
INSERT INTO `saves` VALUES (1,12),(2,1),(2,2),(14,3),(14,4),(14,5),(21,7),(21,8),(22,6),(22,9),(22,10),(22,11);
/*!40000 ALTER TABLE `saves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `salt` varchar(45) NOT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `profile_picture` varchar(45) DEFAULT NULL,
  `creation_date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `salt_UNIQUE` (`salt`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1@example.com','Alicia','Shi','password1','salt1','1234567890','images/profilepic4.png','2024-08-06 15:35:05'),(2,'user2@example.com','Shashhank','Seethula','password2','salt2','1234567891','images/profilepic2.png','2024-08-06 15:35:05'),(3,'user3@example.com','Scott','Nguyen','password3','salt3','1234567892','images/profilepic3.png','2024-08-06 15:35:05'),(4,'user4@example.com','Mike','Wu','password4','salt4','1234567893','images/profilepic4.png','2024-08-06 15:35:05'),(5,'user5@example.com','Mike','Tyson','password5','salt5','1234567894','images/profilepic1.png','2024-08-06 15:35:05'),(6,'user6@example.com','Lionel','Messi','password6','salt6','1234567895','images/profilepic2.png','2024-08-06 15:35:05'),(7,'user7@example.com','Dad','Dy','password7','salt7','1234567896','images/profilepic3.png','2024-08-06 15:35:05'),(8,'user8@example.com','Mom','My','password8','salt8','1234567897','images/profilepic4.png','2024-08-06 15:35:05'),(9,'user9@example.com','Antonio','Punzo','password9','salt9','1234567898','images/profilepic1.png','2024-08-06 15:35:05'),(10,'user10@example.com','Cristina','Tortora','password10','salt10','1234567899','images/profilepic2.png','2024-08-06 15:35:05'),(11,'user11@example.com','Leonardo','DiCaprio','password11','salt11','1234567121','images/profilepic3.png','2024-08-06 15:35:05'),(12,'user12@example.com','Serena','Williams','password12','salt12','1234567122','images/profilepic4.png','2024-08-06 15:35:05'),(13,'user13@example.com','Elon','Musk','password13','salt13','1234567123','images/profilepic1.png','2024-08-06 15:35:05'),(14,'user14@example.com','Oprah','Whitney','password14','salt14','1234567124','images/profilepic2.png','2024-08-06 15:35:05'),(15,'user15@example.com','Albert','Einstein','password15','salt15','1234567125','images/profilepic3.png','2024-08-06 15:35:05'),(16,'user16@example.com','Beyonce','Knowles','password16','salt16','1234567126','images/profilepic4.png','2024-08-06 15:35:05'),(17,'user17@example.com','Barack','Obama','password17','salt17','1234567127','images/profilepic1.png','2024-08-06 15:35:05'),(18,'user18@example.com','Tim','Cook','password18','salt18','1234567128','images/profilepic2.png','2024-08-06 15:35:05'),(19,'user19@example.com','Sundar','Pichai','password19','salt19','1234567129','images/profilepic3.png','2024-08-06 15:35:05'),(20,'user20@example.com','Jeff','Bezos','password20','salt20','1234567120','images/profilepic4.png','2024-08-06 15:35:05'),(21,'user21@example.com','Synyster','Gates','password21','salt21','1234567131','images/profilepic4.png','2024-08-06 15:35:05'),(22,'user22@example.com','Matt','Shadows','password22','salt22','1234567132','images/profilepic2.png','2024-08-06 15:35:05');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `writes`
--

DROP TABLE IF EXISTS `writes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `writes` (
  `ReviewID` int NOT NULL,
  `UserID` int NOT NULL,
  PRIMARY KEY (`ReviewID`,`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `writes`
--

LOCK TABLES `writes` WRITE;
/*!40000 ALTER TABLE `writes` DISABLE KEYS */;
INSERT INTO `writes` VALUES (1,11),(2,12),(3,13),(4,14),(5,15),(6,16),(7,17),(8,18),(9,19),(10,20),(11,11),(12,12),(13,13),(14,14),(15,15),(16,16),(17,17),(18,18),(19,19),(20,20),(21,11),(22,12),(23,13),(24,14),(25,15),(26,16),(27,17),(28,18),(29,19),(30,20),(31,11),(32,12),(33,13),(34,14),(35,15),(36,16),(37,17),(38,18),(39,19),(40,20);
/*!40000 ALTER TABLE `writes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-10 20:25:43
