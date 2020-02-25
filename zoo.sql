-- MySQL dump 10.13  Distrib 8.0.19, for osx10.15 (x86_64)
--
-- Host: localhost    Database: zoo
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `email_address` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(20) NOT NULL,
  `date_registered` date NOT NULL,
  `credit_card_info` int NOT NULL,
  PRIMARY KEY (`email_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Diet`
--

DROP TABLE IF EXISTS `Diet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Diet` (
  `Animal_ID` int NOT NULL AUTO_INCREMENT,
  `Diet_type` varchar(100) NOT NULL,
  `Feedings_per_day` int NOT NULL,
  `Allergies` varchar(100) NOT NULL,
  `Food_ID` int NOT NULL,
  `Feeding_TImes` datetime NOT NULL,
  PRIMARY KEY (`Animal_ID`),
  KEY `Food_ID_idx` (`Food_ID`),
  CONSTRAINT `Food_ID` FOREIGN KEY (`Food_ID`) REFERENCES `Food` (`Food_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Diet`
--

LOCK TABLES `Diet` WRITE;
/*!40000 ALTER TABLE `Diet` DISABLE KEYS */;
/*!40000 ALTER TABLE `Diet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Food`
--

DROP TABLE IF EXISTS `Food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Food` (
  `Food_ID` int NOT NULL AUTO_INCREMENT,
  `Stock` int NOT NULL,
  PRIMARY KEY (`Food_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Food`
--

LOCK TABLES `Food` WRITE;
/*!40000 ALTER TABLE `Food` DISABLE KEYS */;
/*!40000 ALTER TABLE `Food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Health_Profile`
--

DROP TABLE IF EXISTS `Health_Profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Health_Profile` (
  `Animal_ID` int NOT NULL AUTO_INCREMENT,
  `Status` varchar(100) NOT NULL,
  `Medicine_ID` int NOT NULL,
  `Dose` int NOT NULL,
  `Diseases` varchar(100) NOT NULL,
  PRIMARY KEY (`Animal_ID`),
  KEY `Medicine_ID_idx` (`Medicine_ID`),
  CONSTRAINT `Medicine_ID` FOREIGN KEY (`Medicine_ID`) REFERENCES `Medicine` (`Medicine_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Health_Profile`
--

LOCK TABLES `Health_Profile` WRITE;
/*!40000 ALTER TABLE `Health_Profile` DISABLE KEYS */;
/*!40000 ALTER TABLE `Health_Profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Medicine`
--

DROP TABLE IF EXISTS `Medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Medicine` (
  `Medicine_ID` int NOT NULL,
  `Stock` int NOT NULL,
  PRIMARY KEY (`Medicine_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Medicine`
--

LOCK TABLES `Medicine` WRITE;
/*!40000 ALTER TABLE `Medicine` DISABLE KEYS */;
/*!40000 ALTER TABLE `Medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Orders` (
  `order_Id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `purchase_date` date NOT NULL,
  `price` int NOT NULL,
  `email_address` varchar(50) NOT NULL,
  PRIMARY KEY (`order_Id`),
  KEY `email_address_idx` (`email_address`),
  KEY `product_name_idx` (`product_name`),
  CONSTRAINT `email_address` FOREIGN KEY (`email_address`) REFERENCES `Customer` (`email_address`),
  CONSTRAINT `product_name` FOREIGN KEY (`product_name`) REFERENCES `Product` (`product_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `Product_ID` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `Stock` int NOT NULL,
  `Price` decimal(50,0) NOT NULL,
  PRIMARY KEY (`Product_ID`),
  KEY `Product_Name_idx` (`product_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-02-24 19:58:58
