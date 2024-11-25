-- MySQL dump 10.13  Distrib 8.0.40, for macos14 (arm64)
--
-- Host: localhost    Database: db
-- ------------------------------------------------------
-- Server version	9.1.0

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
-- Table structure for table `DiscountedItem`
--

DROP TABLE IF EXISTS `DiscountedItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `DiscountedItem` (
  `promotionName` varchar(50) NOT NULL,
  `itemName` varchar(50) NOT NULL,
  `restaurantId` int NOT NULL,
  PRIMARY KEY (`promotionName`,`itemName`,`restaurantId`),
  KEY `promotionName` (`promotionName`,`restaurantId`),
  KEY `itemName` (`itemName`,`restaurantId`),
  CONSTRAINT `discounteditem_ibfk_1` FOREIGN KEY (`promotionName`, `restaurantId`) REFERENCES `Promotion` (`promotionName`, `restaurantId`) ON DELETE CASCADE,
  CONSTRAINT `discounteditem_ibfk_2` FOREIGN KEY (`itemName`, `restaurantId`) REFERENCES `MenuItem` (`itemName`, `restaurantId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DiscountedItem`
--

LOCK TABLES `DiscountedItem` WRITE;
/*!40000 ALTER TABLE `DiscountedItem` DISABLE KEYS */;
INSERT INTO `DiscountedItem` VALUES ('Adaptive hybrid approach','Home also see.',2972),('Customizable scalable flexibility','Something away realize.',1156),('Enhanced tertiary framework','Item someone want.',296),('Extended solution-oriented function','Sometimes stay.',854),('Innovative system-worthy array','Unit impact address.',2741),('Multi-tiered web-enabled artificial intelligence','Stage under.',1352),('Proactive needs-based hierarchy','Black just appear east.',2980),('Reverse-engineered homogeneous website','Support data mind.',741),('Self-enabling fault-tolerant task-force','Store yes.',1531),('Visionary executive knowledgebase','Long.',1929);
/*!40000 ALTER TABLE `DiscountedItem` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-24 20:55:28
