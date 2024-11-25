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
-- Table structure for table `Promotion`
--

DROP TABLE IF EXISTS `Promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Promotion` (
  `promotionName` varchar(50) NOT NULL,
  `promotionStartDate` date DEFAULT NULL,
  `promotionEndDate` date DEFAULT NULL,
  `discountPercentage` decimal(5,2) DEFAULT NULL,
  `restaurantId` int NOT NULL,
  PRIMARY KEY (`promotionName`,`restaurantId`),
  KEY `restaurantId` (`restaurantId`),
  KEY `idx_promotion_composite` (`promotionName`,`restaurantId`),
  CONSTRAINT `promotion_ibfk_1` FOREIGN KEY (`restaurantId`) REFERENCES `Restaurant` (`restaurantId`) ON DELETE CASCADE,
  CONSTRAINT `promotion_chk_1` CHECK ((`discountPercentage` between 0 and 100)),
  CONSTRAINT `promotion_chk_2` CHECK ((`promotionEndDate` >= `promotionStartDate`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Promotion`
--

LOCK TABLES `Promotion` WRITE;
/*!40000 ALTER TABLE `Promotion` DISABLE KEYS */;
INSERT INTO `Promotion` VALUES ('Adaptive hybrid approach','2024-03-10','2024-04-05',0.48,2972),('Customizable scalable flexibility','2024-05-19','2024-05-31',0.58,1156),('Enhanced tertiary framework','2024-05-15','2024-06-08',0.44,296),('Extended solution-oriented function','2024-10-31','2024-11-12',0.35,854),('Innovative system-worthy array','2024-11-15','2024-11-24',0.15,2741),('Multi-tiered web-enabled artificial intelligence','2024-07-07','2024-07-30',0.94,1352),('Proactive needs-based hierarchy','2024-06-20','2024-07-04',0.52,2980),('Reverse-engineered homogeneous website','2024-03-29','2024-04-10',0.49,741),('Self-enabling fault-tolerant task-force','2024-10-03','2024-10-26',0.61,1531),('Visionary executive knowledgebase','2024-10-22','2024-10-31',0.12,1929);
/*!40000 ALTER TABLE `Promotion` ENABLE KEYS */;
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
