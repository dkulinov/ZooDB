CREATE DATABASE  IF NOT EXISTS `zoo_schema` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `zoo_schema`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: zoo.c1jmiaqoplkv.us-east-2.rds.amazonaws.com    Database: zoo_schema
-- ------------------------------------------------------
-- Server version	5.7.22-log

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
-- Table structure for table `animal`
--

DROP TABLE IF EXISTS `animal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animal` (
  `animal_id` int(11) NOT NULL AUTO_INCREMENT,
  `animal_name` varchar(30) DEFAULT NULL,
  `species` varchar(30) DEFAULT NULL,
  `admission` date DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('M','F') NOT NULL,
  `enclosure_id` int(11) DEFAULT NULL,
  `status` enum('healthy','sick','pregnant','deceased') NOT NULL DEFAULT 'healthy',
  `diet_type` enum('Herbivorous','Carnivorous','Omnivorous') DEFAULT NULL,
  `feedings_per_day` int(11) NOT NULL,
  `image_path` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`animal_id`),
  KEY `animal_ibfk_1` (`enclosure_id`),
  CONSTRAINT `animal_ibfk_1` FOREIGN KEY (`enclosure_id`) REFERENCES `enclosure` (`enclosure_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2039600125 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal`
--

LOCK TABLES `animal` WRITE;
/*!40000 ALTER TABLE `animal` DISABLE KEYS */;
INSERT INTO `animal` VALUES (47234,'Bill','Goat','2020-04-19','2016-04-01','M',111119,'healthy','Omnivorous',4,'goat.jpg'),(63067,'Tim','Tiger','2020-04-19','2019-12-05','M',111113,'healthy','Carnivorous',5,'tiger.jpg'),(71138,'Kai','Lion','2020-04-19','2016-05-02','M',111117,'healthy','Carnivorous',4,'lion.jpg'),(78662,'Tony','Tiger','2020-04-19','2014-05-02','M',111113,'healthy',NULL,4,'tiger.jpg'),(341643,'James','Tiger','2020-04-19','2012-11-08','M',111113,'healthy','Carnivorous',4,'tiger.jpg'),(619513,'Bill','Goat','2020-04-19','2016-04-01','M',111119,'healthy',NULL,3,'goat.jpg'),(107777487,'Hop','Leopard ','2017-06-21','2016-01-20','M',111113,'sick','Carnivorous',3,'leopard.jpg'),(155344501,'Suzie','Anaconda','2019-03-05','2018-02-05','F',111120,'pregnant','Carnivorous',3,'anaconda.jpg'),(222252359,'Cherry','Artic Fox','2016-07-02','2019-05-28','F',111118,'healthy','Carnivorous',4,'arctic-fox.jpg'),(428427324,'Zeke','Zebra','2019-01-08','2017-01-31','M',111116,'healthy',NULL,3,'zebra.jpg'),(551854014,'Terri','Takin','2017-02-01','2017-04-03','F',111116,'healthy','Herbivorous',6,'takin.jpg'),(641287356,'Jason','Bateleur Eagle ','2019-08-07','2016-03-23','M',111117,'healthy',NULL,3,'bateleur-eagle.jpg'),(678157324,'Betty','Bee-eater','2018-04-08','2018-02-14','F',111117,'healthy',NULL,4,'bee-eater.jpg'),(774176458,'Melody','Black-headed weaver','2018-06-12','2019-07-02','F',111117,'healthy',NULL,3,'black-headed-weaver.jpg'),(787385654,'Millie','Bonobo','2019-09-08','2019-08-01','F',111111,'healthy',NULL,2,'bonobo.jpg'),(816182701,'Henry','California Condor','2019-02-14','2018-09-09','M',111117,'healthy',NULL,3,'california-condor.jpg'),(821941186,'Myon','Camel','2018-07-08','2018-01-09','M',111119,'healthy',NULL,3,'camel.jpg'),(846716372,'Alice','Capybara','2017-04-22','2019-12-20','F',111120,'healthy',NULL,3,'capybara.jpg'),(991225864,'Ginelle','Cheetah','2019-01-29','2019-11-13','F',111113,'healthy',NULL,3,'cheetah.jpg'),(1033951846,'Goof','Chinese Alligator ','2017-01-08','2017-01-28','M',111121,'healthy',NULL,3,'chinese-alligator.jpg'),(1198924616,'Brock','Clouded Leopard','2016-09-18','2018-02-17','M',111118,'healthy',NULL,3,'clouded-leopard.jpg'),(1293785687,'Tonya','Tiger','2018-05-07','2019-06-17','F',111113,'healthy',NULL,2,'tiger.jpg'),(1383883483,'Mew','Elephant','2018-09-03','2017-09-26','M',111116,'healthy',NULL,3,'elephant.jpg'),(1462799396,'Poppy','Panda','2016-08-17','2019-10-27','F',111119,'healthy','Herbivorous',10,'panda.jpg'),(1620537036,'Sandy','Galapagos Tortoise','2020-01-13','2018-05-27','F',111122,'healthy',NULL,3,'galapagos-tortoise.jpg'),(1706435231,'Angel','Gelada','2017-02-06','2016-09-18','F',111111,'healthy',NULL,3,'gelada.jpg'),(1775712850,'Lauryn','Giraffe','2017-04-28','2019-12-30','F',111114,'healthy',NULL,4,'giraffe-2.jpg'),(1912083108,'Paavo','Grizzly Bear','2017-05-21','2016-07-02','M',111112,'healthy',NULL,4,'grizzly-bear.jpg'),(2039600094,'King','Lion','2019-03-01','2019-07-07','M',111113,'healthy',NULL,3,'lion.jpg'),(2039600095,'Potter','Hippo','2019-04-17','2019-01-23','M',111117,'healthy','Herbivorous',8,'hippo.jpg'),(2039600096,'Ron','Panda','2020-04-21','2016-05-13','M',111119,'healthy',NULL,2,'panda.jpg'),(2039600097,'Charles','Cheetah','2020-04-22','2012-11-04','M',111113,'healthy',NULL,3,'cheetah.jpg'),(2039600098,'Poe','Artic Fox','2020-04-22','2020-04-20','M',111118,'healthy',NULL,3,'arctic-fox.jpg'),(2039600101,'King Kike','Clouded Leopard','2020-04-22','2019-04-19','M',111117,'healthy',NULL,3,'clouded-leopard.jpg'),(2039600117,'Rowdy','Gorilla','2020-04-24','2016-07-05','M',111111,'healthy','Herbivorous',2,'gorilla.jpg'),(2039600118,'Mike','Lizard','2020-04-24','2002-11-06','M',111119,'healthy','Carnivorous',4,'lizard.jpg');
/*!40000 ALTER TABLE `animal` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER animal_health_change 
AFTER UPDATE ON `animal` FOR EACH ROW
BEGIN
    DECLARE caretaker INT;
	DECLARE exit_loop BOOLEAN;
	DECLARE carers CURSOR FOR SELECT caretaker_id FROM takes_care_of WHERE NEW.animal_id = takes_care_of.animal_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop=TRUE;
    IF 
    NEW.`status` != OLD.`status` 
    THEN
		OPEN carers;
        myLoop: LOOP
        FETCH carers INTO caretaker;
        IF exit_loop THEN 
			CLOSE carers;
            LEAVE myLoop;
		END IF;
		INSERT INTO caretaker_alerts VALUES(NEW.animal_id, caretaker, (SELECT DATE(now())), NEW.status);
	END LOOP myLoop;
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `animal_diet`
--

DROP TABLE IF EXISTS `animal_diet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animal_diet` (
  `animal_id` int(11) NOT NULL,
  `food_id` int(11) NOT NULL,
  `serving_size_in_grams` int(11) NOT NULL,
  `servings_per_day` int(11) DEFAULT NULL,
  PRIMARY KEY (`animal_id`,`food_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `animal_diet_ibfk_2` FOREIGN KEY (`food_id`) REFERENCES `food_supply` (`food_id`),
  CONSTRAINT `animal_diet_ibfk_3` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animal_diet`
--

LOCK TABLES `animal_diet` WRITE;
/*!40000 ALTER TABLE `animal_diet` DISABLE KEYS */;
INSERT INTO `animal_diet` VALUES (47234,1,20,2),(47234,322691273,30,2),(47234,794122027,30,2),(47234,1899961941,10,2),(63067,322691273,30,2),(63067,422245607,100,6),(71138,794122027,30,6),(78662,792905148,20,3),(341643,1868820041,65,3),(107777487,322691273,30,3),(155344501,422245607,30,3),(222252359,792905148,30,3),(428427324,794122027,30,3),(551854014,804823626,30,3),(641287356,835113132,30,3),(641287356,2123834216,30,5),(678157324,839708572,30,3),(678157324,2123834216,30,6),(774176458,1106475763,30,3),(774176458,2123834216,30,12),(787385654,1257629409,30,3),(816182701,1298648319,30,3),(821941186,1351705792,30,3),(846716372,1491347236,30,3),(846716372,2123834217,50,3),(991225864,1531812139,30,3),(1033951846,1770563148,30,3),(1198924616,1868590879,30,3),(1293785687,1868820041,30,3),(1383883483,1899961941,30,3),(1462799396,2022450965,30,3),(1620537036,2123834211,30,3),(1620537036,2123834216,30,9);
/*!40000 ALTER TABLE `animal_diet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `animals_on_medicine`
--

DROP TABLE IF EXISTS `animals_on_medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `animals_on_medicine` (
  `animal_id` int(11) NOT NULL,
  `med_id` int(11) NOT NULL,
  `dose_amount_mg` int(11) NOT NULL,
  `dose_frequency` enum('2 a day','3 a day','daily','weekly','monthly','yearly') DEFAULT NULL,
  `last_prescribed` date NOT NULL,
  `duration_days` int(11) NOT NULL,
  `disease` varchar(100) NOT NULL,
  PRIMARY KEY (`animal_id`,`med_id`),
  KEY `animals_on_medicine_ibfk_2_idx` (`med_id`),
  KEY `animal_id_idx` (`animal_id`),
  CONSTRAINT `animals_on_medicine_ibfk_1` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE,
  CONSTRAINT `med_id` FOREIGN KEY (`med_id`) REFERENCES `medicine_supply` (`med_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `animals_on_medicine`
--

LOCK TABLES `animals_on_medicine` WRITE;
/*!40000 ALTER TABLE `animals_on_medicine` DISABLE KEYS */;
INSERT INTO `animals_on_medicine` VALUES (47234,100001,2,'3 a day','2020-04-19',2,'Diabetes'),(63067,100002,3,'weekly','2020-04-19',3,'Diabetes'),(63067,100003,5,'daily','2020-04-24',5,'Headaches'),(63067,100010,10,'2 a day','2020-04-24',30,'Headaches'),(63067,100012,10,'yearly','2020-04-24',1,'flu'),(107777487,100001,3,'daily','2020-04-19',60,'Heart Worms'),(107777487,100002,3,'weekly','2020-04-19',90,'Heart Worms'),(107777487,100003,3,'monthly','2020-04-19',30,'Heart Worms'),(155344501,100006,2,'2 a day','2020-04-19',2,'Diabetes'),(155344501,100010,5,'daily','2020-04-24',90,'Headaches');
/*!40000 ALTER TABLE `animals_on_medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attraction`
--

DROP TABLE IF EXISTS `attraction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attraction` (
  `attraction_id` int(11) NOT NULL,
  `attraction_name` varchar(50) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `attraction_status` enum('under construction','open','closed','under repair','needs repair') NOT NULL DEFAULT 'open',
  PRIMARY KEY (`attraction_id`),
  CONSTRAINT `attraction_ibfk_1` FOREIGN KEY (`attraction_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attraction`
--

LOCK TABLES `attraction` WRITE;
/*!40000 ALTER TABLE `attraction` DISABLE KEYS */;
INSERT INTO `attraction` VALUES (3,'Carousel',30,'open'),(4,'Ferris Wheel',40,'open');
/*!40000 ALTER TABLE `attraction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caretaker_alerts`
--

DROP TABLE IF EXISTS `caretaker_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caretaker_alerts` (
  `animal_id` int(11) NOT NULL,
  `caretaker_id` int(11) NOT NULL,
  `date_generated` date NOT NULL,
  `new_health_status` enum('healthy','sick','pregnant','deceased') NOT NULL,
  PRIMARY KEY (`animal_id`,`caretaker_id`,`date_generated`,`new_health_status`),
  KEY `caretaker_id` (`caretaker_id`),
  CONSTRAINT `caretaker_alerts_ibfk_2` FOREIGN KEY (`caretaker_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `caretaker_alerts_ibfk_3` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caretaker_alerts`
--

LOCK TABLES `caretaker_alerts` WRITE;
/*!40000 ALTER TABLE `caretaker_alerts` DISABLE KEYS */;
INSERT INTO `caretaker_alerts` VALUES (107777487,10009,'2020-04-11','sick'),(47234,10010,'2020-04-20','healthy'),(47234,10010,'2020-04-20','sick'),(47234,10010,'2020-04-23','healthy'),(47234,10010,'2020-04-23','sick'),(47234,10010,'2020-04-24','healthy'),(47234,10010,'2020-04-24','sick'),(107777487,10010,'2020-04-11','sick'),(107777487,10010,'2020-04-16','healthy'),(107777487,10010,'2020-04-16','sick'),(107777487,10010,'2020-04-20','healthy'),(107777487,10010,'2020-04-23','sick'),(155344501,10010,'2020-04-16','sick'),(155344501,10010,'2020-04-20','pregnant'),(155344501,10010,'2020-04-23','sick'),(155344501,10010,'2020-04-24','healthy'),(155344501,10010,'2020-04-24','pregnant'),(678157324,10010,'2020-04-23','healthy'),(787385654,10010,'2020-04-20','pregnant'),(787385654,10010,'2020-04-23','healthy'),(63067,10011,'2020-04-20',''),(63067,10011,'2020-04-20','healthy'),(63067,10011,'2020-04-20','sick'),(63067,10011,'2020-04-23','sick'),(63067,10011,'2020-04-24','healthy'),(107777487,10011,'2020-04-11','sick'),(551854014,10011,'2020-04-20','healthy'),(551854014,10011,'2020-04-20','pregnant'),(551854014,10011,'2020-04-23','healthy'),(991225864,10011,'2020-04-20','pregnant'),(991225864,10011,'2020-04-23','healthy'),(63067,10012,'2020-04-23','sick'),(63067,10012,'2020-04-24','healthy'),(107777487,10012,'2020-04-11','sick'),(222252359,10012,'2020-04-22','healthy'),(222252359,10012,'2020-04-22','pregnant'),(1198924616,10012,'2020-04-20','healthy'),(1462799396,10012,'2020-04-20','healthy'),(1462799396,10012,'2020-04-20','pregnant'),(1462799396,10012,'2020-04-23','healthy'),(47234,10014,'2020-04-23','healthy'),(47234,10014,'2020-04-23','sick'),(47234,10014,'2020-04-24','healthy'),(47234,10014,'2020-04-24','sick'),(63067,10014,'2020-04-20',''),(63067,10014,'2020-04-20','healthy'),(63067,10014,'2020-04-20','sick'),(63067,10014,'2020-04-23','sick'),(63067,10014,'2020-04-24','healthy'),(1620537036,10014,'2020-04-20','pregnant'),(1620537036,10014,'2020-04-23','healthy');
/*!40000 ALTER TABLE `caretaker_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `email` varchar(255) NOT NULL,
  `f_name` varchar(50) NOT NULL,
  `l_name` varchar(50) NOT NULL,
  `pswd` varchar(255) NOT NULL,
  `isMember` tinyint(1) NOT NULL DEFAULT '0',
  `date_registered` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `memberUntil` date DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('','Steve','','password',0,'2020-04-07 00:00:00',NULL),('ableas14@army.mil','Annalee','Bleas','password',1,'2019-08-09 00:00:00','2022-04-16'),('acapplemans@oakley.com','Ainsley','Cappleman','password',0,'2019-05-09 00:00:00',NULL),('adebeauchemp1z@usda.gov','Anna-diane','De Beauchemp','password',0,'2019-12-25 00:00:00',NULL),('afrissell9@umn.edu','Anastassia','Frissell','password',0,'2019-10-24 00:00:00',NULL),('agirardey2n@businesswire.com','Allyson','Girardey','password',0,'2019-04-23 00:00:00',NULL),('agratland1g@newsvine.com','Alexa','Gratland','password',0,'2020-03-06 00:00:00',NULL),('agrisedale23@biblegateway.com','Annemarie','Grisedale','password',0,'2019-08-15 00:00:00',NULL),('aknibley2d@wikipedia.org','Allsun','Knibley','password',0,'2019-11-25 00:00:00',NULL),('amossbee2@reuters.com','Ardine','Mossbee','password',0,'2019-11-23 00:00:00',NULL),('aroch2l@1688.com','Abbot','Roch','password',0,'2019-12-17 00:00:00',NULL),('bblanche1x@tuttocitta.it','Brent','Blanche','password',0,'2019-09-20 00:00:00',NULL),('bburet1d@nsw.gov.au','Berte','Buret','password',0,'2019-05-11 00:00:00',NULL),('bgatesman18@yolasite.com','Bron','Gatesman','password',0,'2020-02-28 00:00:00',NULL),('bklaff2b@arstechnica.com','Boonie','Klaff','password',0,'2019-09-05 00:00:00',NULL),('bsallings2i@51.la','Boycie','Sallings','password',0,'2020-03-26 00:00:00',NULL),('btomala28@blogtalkradio.com','Barron','Tomala','password',0,'2019-10-29 00:00:00',NULL),('cdoornbosn@buzzfeed.com','Creighton','Doornbos','password',0,'2019-08-10 00:00:00',NULL),('cgablew@kickstarter.com','Camala','Gable','password',0,'2020-02-04 00:00:00',NULL),('cguilloudj@hao123.com','Conny','Guilloud','password',0,'2020-02-13 00:00:00',NULL),('chasardp@google.com','Cissy','Hasard','password',0,'2019-04-05 00:00:00',NULL),('ckuhl1r@engadget.com','Cherye','Kuhl','password',0,'2019-07-11 00:00:00',NULL),('cragg2m@walmart.com','Courtnay','Ragg','password',0,'2019-11-27 00:00:00',NULL),('crye1n@wikia.com','Cleon','Rye','password',0,'2019-05-16 00:00:00',NULL),('cscraneyg@sakura.ne.jp','Cariotta','Scraney','password',0,'2020-02-25 00:00:00',NULL),('cstorch1k@e-recht24.de','Con','Storch','password',0,'2019-04-27 00:00:00',NULL),('daniel.evans17@outlook.com','Daniel','Evans','password',1,'2020-04-19 00:00:00','2025-04-19'),('david.long@gmail.com','David','Long','password',0,'2020-04-20 00:00:00',NULL),('dbunyardv@vistaprint.com','Dallas','Bunyard','password',0,'2020-03-05 00:00:00',NULL),('ddemeter4@wiley.com','Dulciana','Demeter','password',0,'2019-11-24 00:00:00',NULL),('dnoteyounga@mtv.com','Donaugh','Noteyoung','password',0,'2019-07-21 00:00:00',NULL),('dsallenger13@tripadvisor.com','Drucie','Sallenger','password',0,'2019-06-01 00:00:00',NULL),('eaddionizio1p@flavors.me','Eadie','Addionizio','password',0,'2019-07-09 00:00:00',NULL),('efluin11@ibm.com','Ellswerth','Fluin','password',0,'2019-10-05 00:00:00',NULL),('eizhaky25@columbia.edu','Elberta','Izhaky','password',0,'2019-09-18 00:00:00',NULL),('eoakeshott2a@cbc.ca','Elbert','Oakeshott','password',0,'2020-01-02 00:00:00',NULL),('fbatch17@newsvine.com','Francine','Batch','password',0,'2020-03-15 00:00:00',NULL),('fkochs2p@google.ru','Fidelia','Kochs','password',0,'2019-12-27 00:00:00',NULL),('fmccarney1a@sina.com.cn','Freddie','McCarney','password',0,'2019-07-07 00:00:00',NULL),('fsatterthwaitec@hhs.gov','Frank','Satterthwaite','password',0,'2019-04-09 00:00:00',NULL),('fskylett21@hexun.com','Feodora','Skylett','password',0,'2019-04-27 00:00:00',NULL),('gbaleine1o@acquirethisname.com','Gianna','Baleine','password',0,'2019-04-08 00:00:00',NULL),('gdedney19@nyu.edu','Germayne','Dedney','password',0,'2019-09-13 00:00:00',NULL),('gharber1h@sogou.com','Gregoor','Harber','password',0,'2019-05-04 00:00:00',NULL),('gpitman2o@google.pl','Gloriane','Pitman','password',0,'2019-12-15 00:00:00',NULL),('gtapem@sciencedirect.com','Gunar','Tape','password',0,'2019-11-20 00:00:00',NULL),('harmatage1m@ucla.edu','Hal','Armatage','password',0,'2020-03-02 00:00:00',NULL),('hnorheny6@disqus.com','Howie','Norheny','password',0,'2020-03-09 00:00:00',NULL),('hpeytonq@ycombinator.com','Hildegarde','Peyton','password',0,'2020-02-11 00:00:00',NULL),('hwimbush0@sciencedaily.com','Heath','Wimbush','password',0,'2019-11-25 00:00:00',NULL),('jaustingh@netvibes.com','Johnny','Austing','password',0,'2019-03-31 00:00:00',NULL),('jjwatt@texans.com','JJ','Watt','@JJwatt1',0,'2020-04-22 00:00:00',NULL),('johndoe@gmail.com','John','Doe','password',1,'2020-04-05 00:00:00','2025-04-23'),('jonesbones@gmail.com','Jones','Bones','password',0,'2020-04-18 00:00:00',NULL),('jpringi@a8.net','Jaine','Pring','password',0,'2019-11-16 00:00:00',NULL),('jspieck16@yolasite.com','Janeen','Spieck','password',0,'2019-06-08 00:00:00',NULL),('jvanvuuren1i@nature.com','Jillana','Van Vuuren','password',0,'2019-07-30 00:00:00',NULL),('jysson15@uol.com.br','Johanna','Ysson','password',0,'2019-10-15 00:00:00',NULL),('kmckeon12@furl.net','Kevon','McKeon','password',0,'2020-02-27 00:00:00',NULL),('kmethingam1@si.edu','Koren','Methingam','password',0,'2019-05-05 00:00:00',NULL),('kneller3@gnu.org','Keefe','Neller','password',0,'2019-11-17 00:00:00',NULL),('lbestwick2q@addthis.com','Livvie','Bestwick','password',0,'2019-10-12 00:00:00',NULL),('lclardge1j@cnet.com','Linet','Clardge','password',0,'2019-04-06 00:00:00',NULL),('ldesimoni29@wikimedia.org','Liza','De Simoni','password',0,'2019-09-30 00:00:00',NULL),('ldodridgek@xinhuanet.com','Lev','Dodridge','password',0,'2019-07-28 00:00:00',NULL),('lduns1v@google.nl','Leshia','Duns','password',0,'2019-04-05 00:00:00',NULL),('lkop7@mediafire.com','Lenee','Kop','password',0,'2019-08-30 00:00:00',NULL),('lnanninit@smugmug.com','Lisle','Nannini','password',0,'2019-12-19 00:00:00',NULL),('lnewbegin2e@usgs.gov','Leone','Newbegin','password',0,'2019-10-08 00:00:00',NULL),('lnice10@illinois.edu','Lorene','Nice','password',0,'2019-09-10 00:00:00',NULL),('lpaulack5@discovery.com','Lamond','Paulack','password',0,'2020-01-05 00:00:00',NULL),('mbompasx@devhub.com','Maressa','Bompas','password',0,'2019-10-02 00:00:00',NULL),('mdilnot1q@e-recht24.de','Mahalia','Dilnot','password',0,'2019-08-17 00:00:00',NULL),('medsall20@wikipedia.org','Morse','Edsall','password',0,'2019-12-04 00:00:00',NULL),('mflukes1c@yellowbook.com','Maritsa','Flukes','password',0,'2019-11-29 00:00:00',NULL),('miguelarodriguez7594@gmail.com','Migs','Rod','Bane602$',0,'2020-04-22 00:00:00',NULL),('mmaylam2g@histats.com','Mohandas','Maylam','password',0,'2019-04-16 00:00:00',NULL),('mmulhall22@who.int','Madelene','Mulhall','password',0,'2019-11-05 00:00:00',NULL),('mringsell2j@weibo.com','Mortimer','Ringsell','password',0,'2019-10-01 00:00:00',NULL),('mrockell24@simplemachines.org','Matteo','Rockell','password',0,'2019-11-25 00:00:00',NULL),('mrumens2f@state.gov','Monroe','Rumens','password',0,'2019-05-08 00:00:00',NULL),('narmatys2h@nydailynews.com','Nanice','Armatys','password',0,'2019-11-07 00:00:00',NULL),('new@gmail.com','new','new','password',1,'2020-04-24 00:00:00','2022-04-24'),('nmoizer1s@booking.com','Nata','Moizer','password',0,'2019-08-14 00:00:00',NULL),('npeniello1l@wikimedia.org','Nollie','Peniello','password',0,'2019-06-04 00:00:00',NULL),('oleedes26@arizona.edu','Orin','Leedes','password',0,'2020-03-17 00:00:00',NULL),('pgammage8@qq.com','Pate','Gammage','password',0,'2019-04-23 00:00:00',NULL),('pgligorijevic1w@netvibes.com','Padraic','Gligorijevic','password',0,'2019-08-15 00:00:00',NULL),('rbebbello@feedburner.com','Rosmunda','Bebbell','password',0,'2019-04-06 00:00:00',NULL),('rickyrick@gmail.com','ricky','rick','password',0,'2020-04-20 00:00:00',NULL),('rkilduffd@cbsnews.com','Roosevelt','Kilduff','password',0,'2019-04-24 00:00:00',NULL),('rscapensl@yellowpages.com','Rossy','Scapens','password',0,'2019-08-16 00:00:00',NULL),('rwalchr@uiuc.edu','Rowland','Walch','password',0,'2019-08-25 00:00:00',NULL),('sbiaggionib@tumblr.com','Saleem','Biaggioni','password',0,'2019-10-17 00:00:00',NULL),('sdonnan1u@vkontakte.ru','Salmon','Donnan','password',0,'2019-09-10 00:00:00',NULL),('sdunsire1b@seesaa.net','Sky','Dunsire','password',0,'2019-12-04 00:00:00',NULL),('sellulu@edublogs.org','Shandy','Ellul','password',0,'2019-12-01 00:00:00',NULL),('smarco2k@washington.edu','Stillmann','Marco','password',0,'2019-05-11 00:00:00',NULL),('sricharde@sbwire.com','Swen','Richard','password',0,'2020-01-27 00:00:00',NULL),('stevesmith@gmail.com','Steve','Smith','password',0,'2020-04-07 00:00:00',NULL),('tcowlz@homestead.com','Tami','Cowl','password',0,'2019-06-22 00:00:00',NULL),('test@gmail.com','test','test','password',1,'2020-04-24 00:00:00','2022-04-24'),('testaccount@gmail.com','test','account','password',1,'2020-04-24 00:00:00','2021-04-24'),('tgrichukhin1t@craigslist.org','Thorin','Grichukhin','password',0,'2019-07-02 00:00:00',NULL),('tmckellerf@tripod.com','Trent','McKeller','password',0,'2019-07-19 00:00:00',NULL),('toultramy@google.com.au','Terry','Oultram','password',0,'2019-12-21 00:00:00',NULL),('ttripet1e@bluehost.com','Tamar','Tripet','password',0,'2019-10-23 00:00:00',NULL),('vfancy2r@reuters.com','Vincenz','Fancy','password',0,'2019-10-20 00:00:00',NULL),('wdommerque1y@devhub.com','Warden','Dommerque','password',0,'2019-08-13 00:00:00',NULL),('wgrundle27@yandex.ru','Wallache','Grundle','password',0,'2019-04-25 00:00:00',NULL),('whemmingway1f@comcast.net','Warde','Hemmingway','password',0,'2019-05-22 00:00:00',NULL),('wjelf2c@newyorker.com','Wilona','Jelf','password',0,'2019-04-28 00:00:00',NULL);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(30) NOT NULL,
  `manager_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `employee` (`employee_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (2,'HR',10013),(3,'Carousel',NULL),(4,'Ferris Wheel',NULL),(5,'Clothing Gift Shop',10004),(6,'Kids\' Gift Shop',10009),(7,'Accessories Gift Shop',10003),(9,'Veterinary',10008),(11,'Ticketing',10020),(12,'Animal Nutrition',10001),(15,'Care Takers',10010);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL AUTO_INCREMENT,
  `pswd` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `supervisor_id` int(11) DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  PRIMARY KEY (`employee_id`),
  KEY `supervisor_id` (`supervisor_id`),
  KEY `department_id` (`department_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`supervisor_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10021 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (10001,'password','Andrew','Jones',10013,12),(10002,'password','Josh','Brown',10013,3),(10003,'password','Travis','Lee',10013,7),(10004,'password','Katherine','Gomez',10013,5),(10006,'password','Michael','Hite',10003,7),(10008,'password','Charlotte','De Witte',10013,9),(10009,'password','Daniel','Evans',10013,6),(10010,'password','Chris','Jamez',10013,15),(10011,'password','Lenny','Test',10010,15),(10012,'password','Paul','Miller',10010,15),(10013,'password','President','CEO',NULL,2),(10014,'password','Asucena','Ochoa',10010,15),(10015,'password','Alondra','Aguilar',10008,9),(10016,'password','John','Smith',10004,5),(10017,'password','Judy','Long',10009,6),(10018,'password','Sam','Arnold',10003,7),(10019,'password','Christopher','Tick',10013,11),(10020,'password','Jake','Brown',10013,11);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enclosure`
--

DROP TABLE IF EXISTS `enclosure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enclosure` (
  `enclosure_id` int(11) NOT NULL AUTO_INCREMENT,
  `enclosure_name` varchar(50) DEFAULT NULL,
  `enclosure_description` varchar(200) DEFAULT NULL,
  `enclosure_capacity` int(11) DEFAULT NULL,
  `ecosystem_type` enum('AQUATIC','RAINFOREST','ARCTIC','DESERT') DEFAULT NULL,
  PRIMARY KEY (`enclosure_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111123 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enclosure`
--

LOCK TABLES `enclosure` WRITE;
/*!40000 ALTER TABLE `enclosure` DISABLE KEYS */;
INSERT INTO `enclosure` VALUES (111111,'Gorillas in the African Forest',NULL,NULL,NULL),(111112,'Jungle Trails',NULL,NULL,NULL),(111113,'Cat Canyon',NULL,NULL,NULL),(111114,'Giraffe Ridge',NULL,NULL,NULL),(111115,'Hippo Outpost','This African watering hole habitat is home to 2 hippos and heard of their okapi friends ',24,NULL),(111116,'African Forest',NULL,NULL,NULL),(111117,'Wings of the world',NULL,NULL,NULL),(111118,'Ice Age',NULL,NULL,NULL),(111119,'Dry Desert',NULL,NULL,NULL),(111120,'Amazon Forest',NULL,NULL,NULL),(111121,'Swamp Lands',NULL,NULL,NULL),(111122,'Aquatic World',NULL,NULL,NULL);
/*!40000 ALTER TABLE `enclosure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `food_supply`
--

DROP TABLE IF EXISTS `food_supply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `food_supply` (
  `food_id` int(11) NOT NULL AUTO_INCREMENT,
  `food_name` varchar(50) NOT NULL,
  `stock` int(11) NOT NULL,
  `target_stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`food_id`),
  UNIQUE KEY `food_name` (`food_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2123834221 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `food_supply`
--

LOCK TABLES `food_supply` WRITE;
/*!40000 ALTER TABLE `food_supply` DISABLE KEYS */;
INSERT INTO `food_supply` VALUES (1,'Bread',1063,1000),(322691273,'carrots',909,1000),(422245607,'herring',700,1000),(792905148,'bananas',880,1000),(794122027,'apples',900,1000),(804823626,'romaine lettuce',1064,1000),(835113132,'primate biscuits ',900,1000),(839708572,'herbivore pellets ',900,1000),(1106475763,'bales of hay',900,1000),(1257629409,'squid',900,1000),(1298648319,'mackerel',900,1000),(1351705792,'smelt',900,1000),(1491347236,'adult crickets',900,1000),(1531812139,'earthworms',660,1000),(1770563148,'mealworms',900,1000),(1868590879,'waxworms',900,1000),(1868820041,'tuna',900,1000),(1899961941,'blue berries',890,1000),(2022450965,'kale',900,1000),(2123834211,'adult mice',548,1000),(2123834212,'Crackers',150,1000),(2123834213,'Salmon',150,1000),(2123834214,'Tilapia',250,1000),(2123834215,'Sunflower seeds',250,1000),(2123834216,'Berries',11798,5000),(2123834217,'Coconut',1500,2000),(2123834218,'Dried Kelp',100,100),(2123834219,'Black Beans',100,100),(2123834220,'Water',10000,10000);
/*!40000 ALTER TABLE `food_supply` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER low_food_supplies 
AFTER UPDATE ON `food_supply` FOR EACH ROW
BEGIN
	IF  -- if we are below 20% of the target stock and the same alert for the same product hasn't been created today 
    NEW.stock < (0.2*NEW.target_stock) 
    AND
    (NEW.food_id, (SELECT manager_id FROM department WHERE department.department_id = 12), DATE(now())) NOT IN (SELECT * FROM zoo_supply_alerts)
    THEN
		INSERT INTO zoo_supply_alerts VALUES(NEW.food_id, (SELECT manager_id FROM department WHERE department_id = 12), (SELECT DATE(now())));
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `medicine_supply`
--

DROP TABLE IF EXISTS `medicine_supply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicine_supply` (
  `med_id` int(11) NOT NULL AUTO_INCREMENT,
  `med_name` varchar(50) NOT NULL,
  `stock` int(11) NOT NULL,
  `target_stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`med_id`),
  UNIQUE KEY `med_name` (`med_name`)
) ENGINE=InnoDB AUTO_INCREMENT=100015 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine_supply`
--

LOCK TABLES `medicine_supply` WRITE;
/*!40000 ALTER TABLE `medicine_supply` DISABLE KEYS */;
INSERT INTO `medicine_supply` VALUES (100001,'Prednisollone',94,100),(100002,'Xylazine: Injection Solution',101,100),(100003,'Amikacin',79,100),(100004,'Atovaquone Oral Oil Suspension',99,100),(100005,'Pyrimethamine/ Sulfadiazine Capsule',99,100),(100006,'Atenolol TWIST-A-TASTE Flavored Oral Gel',100,100),(100007,'Fluoxetine Oral Gel',340,100),(100008,'PYRIMETHAMINE/SULFADIAZINE/FOLIC ACID: CAPSULE\n\n',99,100),(100009,'CALCIUM CHLORIDE/MAGNESIUM SULFATE/POTASSIUM CHLOR',101,100),(100010,'Tylenol',505,1000),(100011,'Advil',900,1000),(100012,'flu vaccine',130,1000),(100013,'Zyrtec',1000,1000),(100014,'Benadryl',100,1000);
/*!40000 ALTER TABLE `medicine_supply` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER low_med_supplies 
AFTER UPDATE ON `medicine_supply` FOR EACH ROW
BEGIN
	IF -- if we are below 20% of the target stock and the same alert for the same product hasn't been created today 
    NEW.stock < (0.2*NEW.target_stock) 
    AND
    (NEW.med_id, (SELECT manager_id FROM department WHERE department.department_id = 9), DATE(now())) NOT IN (SELECT * FROM zoo_supply_alerts)
    THEN
		INSERT INTO zoo_supply_alerts VALUES(NEW.med_id, (SELECT manager_id FROM department WHERE department_id = 9), (SELECT DATE(now())));
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `order_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `price_total` decimal(5,2) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '1',
  `email` varchar(255) DEFAULT NULL,
  `in_store` tinyint(1) NOT NULL DEFAULT '1',
  `product_size` enum('NA','XS','S','M','L','XL') DEFAULT NULL,
  `order_status` enum('placed','packed','shipped','delivered','NA') DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `city` varchar(40) DEFAULT NULL,
  `state` char(2) DEFAULT NULL,
  `zipcode` int(5) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `email` (`email`),
  KEY `order_ibfk_1` (`product_id`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2147483752 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (20896794,1000000,'2016-07-19 00:00:00',75.11,4,'ableas14@army.mil',1,'NA','delivered',NULL,NULL,NULL,NULL),(2147483650,1000000,'2020-04-06 02:09:08',39.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483651,1000000,'2020-04-06 02:11:07',39.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483652,1000004,'2020-04-06 02:15:57',109.89,11,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483653,1000004,'2020-04-06 02:17:57',109.89,11,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483654,1000004,'2020-04-06 02:23:17',9.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483655,1000004,'2020-04-06 02:24:28',9.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483656,1000004,'2020-04-06 02:24:46',9.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483657,1000004,'2020-04-06 02:26:46',9.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483658,1000001,'2020-04-06 02:27:44',45.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483659,1000001,'2020-04-06 02:28:07',45.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483660,1000002,'2020-04-06 02:31:06',19.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483661,1000002,'2020-04-06 02:31:08',19.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483662,1000002,'2020-04-06 02:31:37',19.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483663,1000002,'2020-04-06 02:32:26',19.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483664,1000002,'2020-04-06 02:32:49',19.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483665,1000000,'2020-04-06 02:33:17',39.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483666,1000000,'2020-04-06 02:43:28',39.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483667,1000003,'2020-04-06 02:44:33',29.97,3,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483668,1000002,'2020-04-06 02:49:14',29.97,3,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483669,1000002,'2020-04-06 02:52:53',9.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483670,1000001,'2020-04-06 02:54:14',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483671,309067027,'2020-04-06 02:55:15',41.16,3,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483672,1000001,'2020-04-06 03:51:10',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483673,1000001,'2020-04-06 18:59:37',45.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483674,1000001,'2020-04-06 19:00:37',45.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483675,1000001,'2020-04-06 19:04:21',45.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483676,1000001,'2020-04-06 19:04:50',45.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483677,1000001,'2020-04-06 19:05:45',45.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483678,1000001,'2020-04-06 19:05:57',45.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483679,1000001,'2020-04-06 19:06:09',45.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483680,1000001,'2020-04-06 19:07:12',45.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483681,1000001,'2020-04-06 19:07:37',45.98,2,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483682,1000001,'2020-04-06 19:08:48',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483683,1000001,'2020-04-06 19:09:32',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483684,1000001,'2020-04-06 19:09:45',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483685,1000001,'2020-04-06 19:10:16',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483686,1000001,'2020-04-06 19:10:44',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483687,1000001,'2020-04-06 19:11:33',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483688,1000001,'2020-04-06 19:11:47',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483689,1000001,'2020-04-06 19:11:56',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483690,1000001,'2020-04-06 19:12:05',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483691,309067027,'2020-04-06 19:19:50',54.88,4,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483692,1000001,'2020-04-06 21:28:25',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483693,1000001,'2020-04-07 03:09:13',22.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483694,1862821703,'2020-04-07 03:51:08',13.12,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483695,485198737,'2020-04-07 04:01:35',23.16,1,'daniel.evans17@outlook.com',0,'XS','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483696,2057483652,'2020-04-08 03:21:06',24.06,1,'miguelrdz759x@gmail.com',0,'XS','placed','14914 Merritt LN','Houston','TX',77060),(2147483697,37378708,'2020-04-08 03:39:54',40.21,1,'miguelrdz759x@gmail.com',0,'NA','placed','14914 Merritt LN','Houston','TX',77060),(2147483698,37378708,'2020-04-08 03:46:13',40.21,1,'miguelrdz759x@gmail.com',0,'NA','placed','14914 Merritt LN','Houston','TX',77060),(2147483699,37378708,'2020-04-08 03:46:20',40.21,1,'miguelrdz759x@gmail.com',0,'NA','placed','14914 Merritt LN','Houston','TX',77060),(2147483700,37378708,'2020-04-08 03:47:59',40.21,1,'miguelrdz759x@gmail.com',0,'NA','placed','14914 Merritt LN','Houston','TX',77060),(2147483701,37378708,'2020-04-08 03:49:42',40.21,1,'miguelrdz759x@gmail.com',0,'NA','placed','14914 Merritt LN','Houston','TX',77060),(2147483702,37378708,'2020-04-08 04:22:55',80.42,2,'miguelrdz759x@gmail.com',0,'NA','placed','14914 Merritt LN','Houston','TX',77060),(2147483703,1000000,'2020-04-08 17:03:14',19.99,1,'Doe',0,'NA','placed','1111 Lincoln Park','New York','NY',77439),(2147483704,1000000,'2020-04-08 17:08:57',19.99,1,'johnsmith@gmail.com',0,'NA','placed','1111 John St','New York','NY',77392),(2147483705,1000000,'2020-04-08 17:15:13',19.99,1,'stevesmith@gmail.com',0,'NA','placed','1111 Steve St','New York','NY',77392),(2147483706,309067027,'2020-04-08 17:23:03',13.72,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483707,99307447,'2020-04-10 17:17:33',68.96,2,'daniel.evans17@outlook.com',0,'S','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483708,1265934281,'2020-04-10 17:18:37',57.96,4,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483709,2022935798,'2020-04-10 17:19:46',48.21,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483710,1000000,'2020-04-10 17:21:29',19.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483711,3296169,'2020-04-11 15:00:05',92.64,4,'johnsmith@gmail.com',0,'L','placed','1111 John St','New York','NY',77392),(2147483715,99307447,'2020-04-11 17:14:40',137.92,4,'johnsmith@gmail.com',0,'S','placed','1111 John St','New York','NY',77392),(2147483716,1000004,'2020-04-11 20:02:56',9.99,1,NULL,1,'NA','NA',NULL,NULL,NULL,NULL),(2147483717,1000004,'2020-04-11 20:04:37',9.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483718,1000004,'2020-04-11 22:57:35',9.99,1,'johnsmith@gmail.com',0,'NA','placed','1111 John St','New York','NY',77392),(2147483719,1000000,'2020-04-13 15:17:55',19.99,1,'johnsmith@gmail.com',0,'NA','placed','1111 John St','New York','NY',77392),(2147483720,37378708,'2020-04-16 02:34:27',40.21,1,'ableas14@army.mil',0,'NA','placed','123 Gid ave','Houston','Tx',74782),(2147483721,37378708,'2020-04-16 02:44:00',40.21,1,'ableas14@army.mil',0,'NA','placed','123 Gid ave','Houston','Tx',74782),(2147483722,1323181244,'2020-04-17 02:14:07',46.96,2,'ableas14@army.mil',0,'NA','placed','123 Gid ave','Houston','Tx',74782),(2147483723,37378708,'2020-04-18 01:22:08',40.21,1,'ableas14@army.mil',0,'NA','placed','123 Gid ave','Houston','Tx',74782),(2147483724,37378708,'2020-04-19 01:08:59',99.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 D','SUGAR LAND','Te',77478),(2147483725,37378708,'2020-04-19 01:09:31',99.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483726,1189877359,'2020-04-19 01:10:52',28.98,2,NULL,1,'NA','NA',NULL,NULL,NULL,NULL),(2147483727,37378708,'2020-04-19 18:01:46',99.99,1,'daniel.evans17@outlook.com',0,'NA','placed','123 G','SUGAR LAND','Te',77478),(2147483728,2057483652,'2020-04-19 18:05:47',48.12,2,'daniel.evans17@outlook.com',0,'S','placed','1027 Goldfinch Avenue','SUGAR LAND','Te',77478),(2147483729,37378708,'2020-04-20 06:18:10',99.99,1,'daniel.evans17@outlook.com',0,'NA','placed','1027 Gold','SUGAR LAND','Te',77478),(2147483730,1000000,'2020-04-20 20:20:01',79.96,4,'Huge.Jazz87@gmail.com',0,'NA','placed','1612 east southmore Ave','Pasadena','Tx',77502),(2147483731,1000001,'2020-04-21 18:49:58',22.99,1,'stevesmith@gmail.com',0,'NA','placed','1111 Steve St','New York','NY',77392),(2147483732,1000000,'2020-04-22 18:33:56',59.97,3,'stevesmith@gmail.com',0,'NA','placed','1111 Steve St','New York','NY',77392),(2147483733,1000000,'2020-04-22 22:24:14',19.99,1,'jjwatt@texans.com',0,'NA','placed','1101 Texans ','Wichita Falls','TX',76306),(2147483734,37378708,'2020-04-22 22:25:38',99.99,1,'joh@gmail.com',0,'NA','placed','542 Wrejrh','New York','NY',100001),(2147483735,1000000,'2020-04-22 23:32:49',19.99,1,'john@gmail.com',0,'NA','placed','14914 Merritt Lane','Houston','Te',77060),(2147483736,37378708,'2020-04-23 19:11:48',99.99,1,'johndoe@gmail.com',0,'NA','placed','123 asdljk','Houston','tx',77777),(2147483737,37378708,'2020-04-24 02:15:51',99.99,1,'test@gmail.com',0,'NA','placed','123','ny','ny',12345),(2147483738,37378708,'2020-04-24 02:29:06',99.99,1,'new@gmail.com',0,'NA','placed','123','ny','ny',12311),(2147483739,37378708,'2020-04-24 02:29:36',99.99,1,'new@gmail.com',0,'NA','placed','123','ny','ny',12311),(2147483740,2057483647,'2020-04-24 02:51:37',168.42,7,'new@gmail.com',0,'S','placed','123','ny','ny',12311),(2147483741,99307447,'2020-04-24 03:49:24',34.48,1,NULL,1,'S','NA',NULL,NULL,NULL,NULL),(2147483742,99307447,'2020-04-24 04:21:18',68.96,2,'johndoe@gmail.com',0,'S','placed','123 asdljk','Houston','tx',77777),(2147483743,2057483648,'2020-04-24 16:45:10',20.00,2,'johndoe@gmail.com',0,'M','placed','123 asdljk','Houston','tx',77777),(2147483744,37378708,'2020-04-24 16:48:21',99.99,1,'johndoe@gmail.com',0,'NA','placed','123 asdljk','Houston','tx',77777),(2147483745,37378708,'2020-04-24 16:49:36',99.99,1,'johndoe@gmail.com',0,'NA','placed','123 asdljk','Houston','tx',77777),(2147483746,37378708,'2020-04-24 17:01:27',99.99,1,'johndoe@gmail.com',0,'NA','placed','123 asdljk','Houston','tx',77777),(2147483747,37378708,'2020-04-24 17:02:29',99.99,1,'new1@gmail.com',0,'NA','placed','123','ny','ny',12311),(2147483748,1000001,'2020-04-24 18:43:24',22.99,1,'johndoe@gmail.com',0,'NA','placed','123 asdljk','Houston','tx',77777),(2147483749,37378708,'2020-04-24 18:44:13',99.99,1,'johndoe@gmail.com',0,'NA','placed','123 asdljk','Houston','tx',77777),(2147483750,37378708,'2020-04-24 18:47:29',99.99,1,'testaccount@gmail.com',0,'NA','placed','123','ny','ny',77777),(2147483751,3296169,'2020-04-24 19:05:29',23.16,1,NULL,1,'L','NA',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER updateProductStock AFTER INSERT ON `order`
 FOR EACH ROW
	IF (SELECT product.gift_shop_id FROM product WHERE product.product_id=NEW.product_id AND product.product_size= NEW.product_size) != 11
    THEN
		UPDATE product SET product.stock = product.stock - NEW.quantity WHERE product.product_id = NEW.product_id AND product.product_size= NEW.product_size;
    END IF */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER becameMember AFTER INSERT ON `order` FOR EACH ROW 
BEGIN

  IF (NEW.product_id = 37378708
  AND (SELECT customer.isMember FROM customer WHERE customer.email = NEW.email) = 1)
  THEN UPDATE customer SET memberUntil = DATE_ADD(memberUntil, INTERVAL 1 YEAR) WHERE customer.email = NEW.email;

  ELSEIF (NEW.product_id = 37378708
  AND (SELECT customer.isMember FROM customer WHERE customer.email = NEW.email) = 0)
  THEN UPDATE customer SET isMember=1, memberUntil=DATE_ADD(DATE(now()), INTERVAL 1 YEAR) WHERE customer.email = NEW.email;
  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_size` enum('XS','S','M','L','XL','NA') NOT NULL DEFAULT 'NA',
  `product_name` varchar(50) NOT NULL,
  `gift_shop_id` int(11) DEFAULT NULL,
  `price` decimal(5,2) NOT NULL,
  `stock` int(11) DEFAULT NULL,
  `image_path` varchar(50) DEFAULT NULL,
  `target_stock` int(11) DEFAULT NULL,
  `shop_category` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`product_id`,`product_size`),
  KEY `gift_shop_id` (`gift_shop_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`gift_shop_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1000000,'NA','Dolphin Show Ticket',11,19.99,NULL,'ticket.png',NULL,'ticket'),(1000001,'NA','Giraffe Feeding Ticket',11,22.99,NULL,'ticket2.png',NULL,'ticket'),(1000002,'NA','Ferris Wheel Ticket',11,9.99,NULL,'ticket.png',NULL,'ticket'),(1000003,'NA','Carousel Ticket',11,9.99,NULL,'ticket2.png',NULL,'ticket'),(1000004,'NA','Petting Zoo Ticket',11,9.99,NULL,'ticket.png',NULL,'ticket'),(3296169,'L','Elephant T-shirt',5,23.16,84,'elephanttshirt.png',100,'clothing'),(37378708,'NA','1 Year Membership',11,99.99,NULL,'membership.png',NULL,'ticket'),(99307447,'S','Tiger Sweatshirt',5,34.48,81,'tigertshirt.png',100,'clothing'),(99307447,'M','Tiger Sweatshirt',5,25.00,20,'tigertshirt.png',23,NULL),(99307447,'L','Tiger Sweatshirt',5,30.00,30,'tigertshirt.png',30,NULL),(99307447,'XL','Tiger Sweatshirt',5,30.00,20,'tigertshirt.png',20,NULL),(103874962,'XL','Houston Zoo T-tshirt',5,28.59,80,'houstonzootshirt.png',100,'clothing'),(309067027,'NA','One-time entrance ticket',11,13.72,NULL,'ticket.png',NULL,'ticket'),(485198737,'XS','Hippo T-shirt',5,23.16,80,'hippotshirt.png',100,'clothing'),(691448905,'NA','Animal puzzle (300 pieces)',6,19.95,50,'puzzle.png',70,NULL),(1189877359,'NA','Elephant plush',6,14.49,50,'elephantplush.png',70,NULL),(1265934281,'NA','Tony the Hippo plush',6,14.49,50,'hippoplush.png',70,NULL),(1323181244,'NA','Leopard plush',6,23.48,50,'leopardplush.png',70,NULL),(1765395789,'NA','Artic fox ornament',7,13.12,50,'foxornament.png',50,NULL),(1862821703,'NA','Rex the lion ornament ',7,13.12,50,'lionornament.png',50,NULL),(1981207122,'NA','Butterfly chime',7,17.12,50,'butterflychime.png',50,NULL),(2022935798,'NA','Ruxa & Raina Ornament',7,48.21,50,'Ruxa&rainaornament.png',50,NULL),(2057483647,'XS','Koala T-shirt ',5,24.06,80,'koalatshirt.jpg',100,'clothing'),(2057483647,'S','Koala T-shirt ',5,24.06,73,'koalatshirt.jpg',100,'clothing'),(2057483647,'M','Koala T-shirt ',5,16.01,80,'koalatshirt.jpg',100,'clothing'),(2057483647,'L','Koala T-shirt ',5,16.01,80,'koalatshirt.jpg',100,'clothing'),(2057483648,'XS','Lion shirt',5,34.48,80,'lionshirt.jpg',100,'clothing'),(2057483648,'S','Lion shirt',5,34.48,80,'lionshirt.jpg',100,'clothing'),(2057483648,'M','Lion shirt',5,10.00,31,'lionshirt.jpg',30,'clothing'),(2057483652,'NA','Lion Petting Ticket',11,24.99,NULL,'ticket.png',NULL,'ticket'),(2057483653,'NA','Zoo Lights Ticket',11,10.00,1000,'ticket.png',1000,'ticket');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER assign_product_id BEFORE INSERT ON product FOR EACH ROW
BEGIN
	IF((SELECT COUNT(*) FROM product WHERE product_name=NEW.product_name)>0) THEN
		SET NEW.product_id=(SELECT product_id FROM product WHERE product_name=NEW.product_name LIMIT 1);
    ELSE
		SET NEW.product_id=(SELECT max(product_id) from product)+1;    
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`admin`@`%`*/ /*!50003 TRIGGER low_store_supplies 
AFTER UPDATE ON `product` FOR EACH ROW
BEGIN
	IF 
    NEW.stock < (0.2*NEW.target_stock) 
    AND
    (NEW.product_id, NEW.product_size, DATE(now())) NOT IN (SELECT store_supply_alerts.product_id, store_supply_alerts.product_size, store_supply_alerts.date_generated FROM store_supply_alerts)
    THEN
		INSERT INTO store_supply_alerts VALUES(NEW.product_id, NEW.product_size, (SELECT manager_id FROM department WHERE NEW.gift_shop_id = department.department_id) , (SELECT DATE(now())));
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `store_supply_alerts`
--

DROP TABLE IF EXISTS `store_supply_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `store_supply_alerts` (
  `product_id` int(11) NOT NULL,
  `product_size` enum('XS','S','M','L','XL','NA') NOT NULL,
  `manager_id` int(11) NOT NULL,
  `date_generated` date NOT NULL,
  PRIMARY KEY (`product_id`,`product_size`,`date_generated`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `store_supply_alerts_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `department` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `store_supply_alerts`
--

LOCK TABLES `store_supply_alerts` WRITE;
/*!40000 ALTER TABLE `store_supply_alerts` DISABLE KEYS */;
INSERT INTO `store_supply_alerts` VALUES (1765395789,'NA',10003,'2020-04-20'),(1862821703,'NA',10003,'2020-04-20'),(1981207122,'NA',10003,'2020-04-20'),(2022935798,'NA',10003,'2020-04-20'),(3296169,'L',10004,'2020-04-20'),(99307447,'S',10004,'2020-04-20'),(103874962,'XL',10004,'2020-04-20'),(329053980,'XL',10004,'2020-04-20'),(485198737,'XS',10004,'2020-04-20'),(612512796,'M',10004,'2020-04-20'),(2057483647,'XS',10004,'2020-04-20'),(2057483647,'S',10004,'2020-04-20'),(2057483647,'M',10004,'2020-04-20'),(2057483647,'L',10004,'2020-04-20'),(2057483648,'XS',10004,'2020-04-20'),(2057483648,'S',10004,'2020-04-20'),(691448905,'NA',10009,'2020-04-20'),(1189877359,'NA',10009,'2020-04-20'),(1265934281,'NA',10009,'2020-04-20'),(1323181244,'NA',10009,'2020-04-20');
/*!40000 ALTER TABLE `store_supply_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `takes_care_of`
--

DROP TABLE IF EXISTS `takes_care_of`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `takes_care_of` (
  `caretaker_id` int(11) NOT NULL,
  `animal_id` int(11) NOT NULL,
  PRIMARY KEY (`caretaker_id`,`animal_id`),
  KEY `animal_id` (`animal_id`),
  CONSTRAINT `takes_care_of_ibfk_1` FOREIGN KEY (`caretaker_id`) REFERENCES `employee` (`employee_id`),
  CONSTRAINT `takes_care_of_ibfk_2` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`animal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `takes_care_of`
--

LOCK TABLES `takes_care_of` WRITE;
/*!40000 ALTER TABLE `takes_care_of` DISABLE KEYS */;
INSERT INTO `takes_care_of` VALUES (10010,47234),(10014,47234),(10011,63067),(10012,63067),(10014,63067),(10014,341643),(10010,107777487),(10010,155344501),(10012,222252359),(10011,551854014),(10010,678157324),(10010,787385654),(10012,816182701),(10014,816182701),(10011,991225864),(10012,1198924616),(10011,1383883483),(10012,1462799396),(10014,1620537036),(10014,2039600117);
/*!40000 ALTER TABLE `takes_care_of` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zoo_supply_alerts`
--

DROP TABLE IF EXISTS `zoo_supply_alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zoo_supply_alerts` (
  `product_id` int(11) NOT NULL,
  `manager_id` int(11) NOT NULL,
  `date_generated` date NOT NULL,
  PRIMARY KEY (`product_id`,`manager_id`,`date_generated`),
  KEY `manager_id` (`manager_id`),
  CONSTRAINT `zoo_supply_alerts_ibfk_1` FOREIGN KEY (`manager_id`) REFERENCES `department` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zoo_supply_alerts`
--

LOCK TABLES `zoo_supply_alerts` WRITE;
/*!40000 ALTER TABLE `zoo_supply_alerts` DISABLE KEYS */;
INSERT INTO `zoo_supply_alerts` VALUES (1,10001,'2020-04-21'),(1,10001,'2020-04-24'),(322691273,10001,'2020-04-11'),(322691273,10001,'2020-04-16'),(794122027,10001,'2020-04-16'),(804823626,10001,'2020-04-20'),(839708572,10001,'2020-04-16'),(1298648319,10001,'2020-04-16'),(1868590879,10001,'2020-04-16'),(1868820041,10001,'2020-04-16'),(100001,10008,'2020-04-11'),(100001,10008,'2020-04-22'),(100002,10008,'2020-04-22'),(100005,10008,'2020-04-12'),(100006,10008,'2020-04-12'),(100012,10008,'2020-04-24');
/*!40000 ALTER TABLE `zoo_supply_alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'zoo_schema'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `validateMembership` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8mb4 */ ;;
/*!50003 SET character_set_results = utf8mb4 */ ;;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'UTC' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`admin`@`%`*/ /*!50106 EVENT `validateMembership` ON SCHEDULE EVERY 1 DAY STARTS '2020-04-24 02:47:39' ON COMPLETION PRESERVE ENABLE DO UPDATE customer SET isMember=0, memberUntil=null WHERE memberUntil<(SELECT DATE(NOW())) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-04-24 14:28:50
