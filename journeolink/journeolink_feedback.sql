CREATE DATABASE  IF NOT EXISTS `journeolink` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `journeolink`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: journeolink
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `driver_id` int NOT NULL,
  `passenger_id` int DEFAULT NULL,
  `passenger_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `feedback_type` enum('positive','negative','complaint') COLLATE utf8mb4_general_ci DEFAULT 'positive',
  `rating` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `complaint_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('open','resolved','closed') COLLATE utf8mb4_general_ci DEFAULT 'open',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  KEY `idx_driver_id` (`driver_id`),
  KEY `idx_status` (`status`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `bookings` (`id`),
  CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`),
  CONSTRAINT `feedback_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (31,86,9,NULL,'Juan Dela Cruz','positive',5,'Excellent Service','Very friendly driver, arrived on time, clean vehicle',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(32,87,9,NULL,'Maria Santos','positive',5,'Great Experience','Professional and courteous. Will ride again!',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(33,88,9,NULL,'Carlos Reyes','positive',4,'Good Ride','Pleasant journey, minor delay but communicated well',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(34,89,9,NULL,'Anna Wong','positive',5,'Outstanding Driver','Exceptional service, helped with luggage',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(35,90,9,NULL,'Miguel Lopez','positive',4,'Comfortable Trip','Clean vehicle, smooth driving',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(36,91,9,NULL,'Sofia Reyes','positive',5,'Perfect Service','Punctual and friendly',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(37,92,9,NULL,'Robert Garcia','positive',5,'Professional','Best driver I have worked with',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(38,93,9,NULL,'Lisa Chen','positive',4,'Nice Trip','Good experience overall',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(39,94,9,NULL,'Patricia Fernandez','complaint',2,'Service Delay','Driver arrived 20 minutes late without notification','Service Delay','resolved','2025-11-24 10:07:42','2025-11-24 10:07:42'),(40,95,9,NULL,'Daniel Kim','negative',3,'Poor Communication','Driver did not greet passengers or provide updates','Poor Communication','open','2025-11-24 10:07:42','2025-11-24 10:07:42'),(41,96,9,NULL,'Jennifer Cruz','complaint',2,'Vehicle Condition','Vehicle was not clean, seats were torn','Vehicle Condition','open','2025-11-24 10:07:42','2025-11-24 10:07:42'),(42,97,9,NULL,'Michael Santos','complaint',1,'Rude Behavior','Driver was rude and dismissive to passengers','Rude Behavior','open','2025-11-24 10:07:42','2025-11-24 10:07:42'),(43,98,9,NULL,'Angela Reyes','negative',3,'Route Deviation','Driver took longer route without asking','Route Deviation','resolved','2025-11-24 10:07:42','2025-11-24 10:07:42'),(44,99,9,NULL,'David Wong','positive',5,'Excellent Journey','Safe driving, early arrival',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(45,100,9,NULL,'Rachel Thompson','complaint',2,'Temperature Control','AC was not working properly','Vehicle Condition','resolved','2025-11-24 10:07:42','2025-11-24 10:07:42'),(46,101,9,NULL,'Vincent Lopez','positive',5,'Great Service','Punctual and professional',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(47,102,9,NULL,'Catherine Park','positive',4,'Nice Ride','Comfortable journey',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(48,103,9,NULL,'Mark Johnson','positive',5,'Excellent','Top notch service',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(49,104,9,NULL,'Sarah Lee','positive',4,'Good Trip','Pleasant experience',NULL,'closed','2025-11-24 10:07:42','2025-11-24 10:07:42'),(50,105,9,NULL,'Lisa Zhang','negative',3,'Average Service','Could have been better','Service Quality','resolved','2025-11-24 10:07:42','2025-11-24 10:07:42');
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-24 18:44:05
