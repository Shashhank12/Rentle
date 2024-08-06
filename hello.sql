-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: rentle
-- ------------------------------------------------------
-- Server version	8.0.39

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
  `address_id` int NOT NULL,
  `address_line_1` varchar(45) NOT NULL,
  `address_line_2` varchar(45) DEFAULT NULL,
  `zipcode` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'238 West Tyson Ave',NULL,'95121','San Jose','CA'),(2,'158 Meep Blvd','Apt 100','95121','San Jose','CA');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `MessageID` int NOT NULL,
  `UserID` int NOT NULL,
  PRIMARY KEY (`MessageID`,`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
INSERT INTO `answers` VALUES (3,1),(4,2);
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asks`
--

DROP TABLE IF EXISTS `asks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asks` (
  `MessageID` int NOT NULL,
  `UserID` int NOT NULL,
  PRIMARY KEY (`MessageID`,`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asks`
--

LOCK TABLES `asks` WRITE;
/*!40000 ALTER TABLE `asks` DISABLE KEYS */;
INSERT INTO `asks` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `asks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blocks` (
  `BlockerUserID` int NOT NULL,
  `BlockedUserID` int NOT NULL,
  `Reason` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`BlockerUserID`,`BlockedUserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
INSERT INTO `blocks` VALUES (2,1,NULL),(2,3,'Bad man');
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;
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
  `duration` int DEFAULT NULL,
  PRIMARY KEY (`UserID`,`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (2,3,256000),(3,1,24000);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Bikes'),(2,'Scooters'),(3,'Google Cars'),(4,'Scooter'),(5,'Car'),(6,'Car'),(7,'Car'),(8,'Car');
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
INSERT INTO `consistsof` VALUES (1,3),(2,2),(2,4),(3,1),(5,6),(5,7),(5,8),(5,9);
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
INSERT INTO `contains` VALUES (1,2),(2,1),(2,4),(2,5),(3,3),(3,6),(3,7),(4,2),(4,8),(4,9),(5,10),(5,11);
/*!40000 ALTER TABLE `contains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `user_id` int NOT NULL,
  `LastRental` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'2024-07-15 03:02:11'),(2,'2023-07-17 05:02:11'),(3,'2024-01-08 13:50:01');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `features_id` int NOT NULL,
  `features_name` varchar(45) NOT NULL,
  PRIMARY KEY (`features_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,'Four-wheel'),(2,'Electric'),(3,'Tough Terrains'),(4,'Good-looking'),(5,'Auto-pilot'),(6,'gfgfg'),(7,'hfhfhf'),(8,'gfgf'),(9,'fdfdfd');
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
  PRIMARY KEY (`FriendUserID1`,`FriendUserID2`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
INSERT INTO `friends` VALUES (1,2),(1,3),(2,3),(2,4),(3,1),(4,2);
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gets`
--

DROP TABLE IF EXISTS `gets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gets` (
  `UserID` int NOT NULL,
  `NotificationID` int NOT NULL,
  PRIMARY KEY (`UserID`,`NotificationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gets`
--

LOCK TABLES `gets` WRITE;
/*!40000 ALTER TABLE `gets` DISABLE KEYS */;
INSERT INTO `gets` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `gets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_chat`
--

DROP TABLE IF EXISTS `group_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_chat` (
  `group_id` int NOT NULL,
  `group_users` varchar(45) DEFAULT NULL,
  `group_chat_status` varchar(45) DEFAULT NULL COMMENT '1 means active, 0 is pending',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_chat`
--

LOCK TABLES `group_chat` WRITE;
/*!40000 ALTER TABLE `group_chat` DISABLE KEYS */;
INSERT INTO `group_chat` VALUES (1,'1,2','1'),(2,'1,3','1');
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
INSERT INTO `has` VALUES (1,3),(2,1),(2,5),(3,2),(3,5),(4,3),(4,5),(5,5);
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
INSERT INTO `holds` VALUES (1,3),(2,4);
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
INSERT INTO `isbeing` VALUES (1,1),(2,2);
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
INSERT INTO `islocatedat` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `islocatedat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_id` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `condition` varchar(45) NOT NULL,
  `description` varchar(45) NOT NULL,
  `location` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL,
  `quantity` int DEFAULT '1',
  `payment_method` varchar(45) NOT NULL,
  `posted_date` datetime NOT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Y','Good','hmm','1905 Hey','Open',1,'Card','2024-08-05 14:07:47'),(2,'I want to know','Excellent','gfgfgf','1191 E Santa Clara St, San Jose, CA, 95116','Open',1,'Card','2024-08-05 15:33:55'),(3,'I want to know','Excellent','hfhf','1191 E Santa Clara St, San Jose, CA, 95116','Open',1,'Card','2024-08-05 15:38:03'),(4,'I want to know','Excellent','gfgf','1191 E Santa Clara St, San Jose, CA, 95116','Open',1,'Card','2024-08-05 15:43:28'),(5,'I want to know','Excellent','fdfdfd','1191 E Santa Clara St, San Jose, CA, 95116','Open',1,'Card','2024-08-05 15:47:20');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookfor`
--

DROP TABLE IF EXISTS `lookfor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lookfor` (
  `UserID` int NOT NULL,
  `ItemID` int NOT NULL,
  PRIMARY KEY (`UserID`,`ItemID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lookfor`
--

LOCK TABLES `lookfor` WRITE;
/*!40000 ALTER TABLE `lookfor` DISABLE KEYS */;
INSERT INTO `lookfor` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `lookfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `message_id` int NOT NULL,
  `message_content` varchar(45) NOT NULL,
  `group_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'Hello there!',1,1),(2,'Hey, how are you doing?',1,2),(3,'hey',1,1),(4,'Hey, any plans for today?',1,1),(5,'lmaooo',2,1),(6,'go!',1,1),(7,'hmm let me check',2,1),(8,'hmm',1,1),(9,'hey how are you doing',1,1),(10,'nothing much wbu',1,2);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notifications_id` int NOT NULL,
  `title` varchar(45) NOT NULL,
  `description` varchar(45) NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`notifications_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'New Item Listed','A new item has been listed','2024-06-25 22:30:27'),(2,'Check out this item','We recommend this item','2023-09-25 22:30:27'),(3,'Time to return!','You have 30 minutes left!','2024-03-18 22:30:27');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photos` (
  `photo_id` int NOT NULL,
  `photo` varchar(45) NOT NULL,
  PRIMARY KEY (`photo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (1,'image3.png'),(2,'image7.png'),(3,'image5.png'),(4,'./images/image2.png'),(5,'./images/image3.png'),(6,'./images/kkkk.png'),(7,'./images/kkkkk.png'),(8,'./images/kkkk.png'),(9,'./images/kkkkk.png'),(10,'./images/kkkk.png'),(11,'./images/kkkkk.png');
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices` (
  `prices_id` int NOT NULL,
  `price_per_hour` varchar(45) DEFAULT NULL,
  `price_per_day` varchar(45) DEFAULT NULL,
  `price_per_week` varchar(45) DEFAULT NULL,
  `price_per_month` varchar(45) DEFAULT NULL,
  `priced_date` datetime NOT NULL,
  PRIMARY KEY (`prices_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES (1,'60','100','500','1500','2024-07-15 03:02:11'),(2,'50','200','80','124','2024-07-15 14:34:35'),(3,'10','50',NULL,NULL,'2024-07-15 23:15:34'),(4,'5','30',NULL,NULL,'2024-07-15 23:15:34'),(5,'11.0','12.0','13.0','14.0','2024-08-05 15:33:55'),(6,'11.0','12.0','13.0','14.0','2024-08-05 15:38:03'),(7,'1.0','2.0','3.0','4.0','2024-08-05 15:43:28'),(8,'11.0','12.0','13.0','14.0','2024-08-05 15:47:20');
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recieves`
--

DROP TABLE IF EXISTS `recieves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recieves` (
  `ReviewID` int NOT NULL,
  `UserID` int NOT NULL,
  PRIMARY KEY (`ReviewID`,`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recieves`
--

LOCK TABLES `recieves` WRITE;
/*!40000 ALTER TABLE `recieves` DISABLE KEYS */;
INSERT INTO `recieves` VALUES (2,2);
/*!40000 ALTER TABLE `recieves` ENABLE KEYS */;
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
INSERT INTO `rent` VALUES (1,2),(2,1);
/*!40000 ALTER TABLE `rent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rent_history`
--

DROP TABLE IF EXISTS `rent_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rent_history` (
  `history_id` int NOT NULL,
  `rentdate` datetime NOT NULL,
  `ItemID` int DEFAULT NULL,
  `rentexpiration` datetime DEFAULT NULL,
  PRIMARY KEY (`history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rent_history`
--

LOCK TABLES `rent_history` WRITE;
/*!40000 ALTER TABLE `rent_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `rent_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `renter`
--

DROP TABLE IF EXISTS `renter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `renter` (
  `user_id` int NOT NULL,
  `ActiveStatus` tinyint DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `renter`
--

LOCK TABLES `renter` WRITE;
/*!40000 ALTER TABLE `renter` DISABLE KEYS */;
INSERT INTO `renter` VALUES (1,0),(2,1),(3,1);
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
INSERT INTO `rentsfor` VALUES (1,1),(2,4),(2,5),(3,3),(3,6),(4,2),(4,7),(5,8);
/*!40000 ALTER TABLE `rentsfor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `review_id` int NOT NULL,
  `stars` varchar(45) NOT NULL,
  `description` varchar(45) NOT NULL,
  PRIMARY KEY (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'5','Easy and cheap!'),(2,'3','Was unresponsive and damaged bike.');
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
INSERT INTO `saves` VALUES (1,2),(2,1);
/*!40000 ALTER TABLE `saves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `email` varchar(45) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `salt` varchar(45) NOT NULL,
  `phone_number` varchar(45) DEFAULT NULL,
  `profile_picture` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `salt_UNIQUE` (`salt`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'alicia@gmail.com','Alicia','Shi','password1','AAAA','1234567890','images\\profilepic1.png'),(2,'shashhank@gmail.com','Shashhank','Seethula','password2','BBBB','2345678901','images\\profilepic2.png'),(3,'scott@gmail.com','Scott','Nguyen','password3','CCCC','3456789012','images\\profilepic3.png'),(4,'user4@example.com','Bob','Williams','password4','salt4','1234567893','images\\profilepic4.png'),(5,'user5@example.com','Charlie','Brown','password5','salt5','1234567894','images\\profilepic5.png'),(6,'user6@example.com','David','Davis','password6','salt6','1234567895','images\\profilepic6.png'),(7,'user7@example.com','Eve','Miller','password7','salt7','1234567896','images\\profilepic7.png'),(8,'user8@example.com','Frank','Wilson','password8','salt8','1234567897','images\\profilepic8.png'),(9,'user9@example.com','Grace','Moore','password9','salt9','1234567898','images\\profilepic9.png'),(10,'user10@example.com','Hannah','Taylor','password10','salt10','1234567899','images\\profilepic10.png'),(11,'user11@example.com','Alice','Johnson','password11','salt11','1234567892','images\\profilepic11.png');
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
INSERT INTO `writes` VALUES (1,1);
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

-- Dump completed on 2024-08-05 18:40:13
