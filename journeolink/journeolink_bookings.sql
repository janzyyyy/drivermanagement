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
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `driver_id` int DEFAULT NULL,
  `passenger_id` int DEFAULT NULL,
  `passenger_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `passenger_email` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `passenger_phone` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `route` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pickup_location` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `dropoff_location` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `booking_date` date NOT NULL,
  `scheduled_date` date NOT NULL,
  `scheduled_time` time NOT NULL,
  `distance` decimal(8,2) DEFAULT NULL,
  `fare` decimal(10,2) NOT NULL,
  `status` enum('pending','accepted','ongoing','completed','cancelled') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `payment_method` enum('Cash','Card','Online') COLLATE utf8mb4_general_ci DEFAULT 'Cash',
  `payment_status` enum('pending','paid','refunded') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `rating` int DEFAULT NULL,
  `notes` text COLLATE utf8mb4_general_ci,
  `review` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `passenger_id` (`passenger_id`),
  KEY `idx_driver_id` (`driver_id`),
  KEY `idx_status` (`status`),
  KEY `idx_scheduled_date` (`scheduled_date`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`passenger_id`) REFERENCES `passengers` (`id`) ON DELETE SET NULL,
  CONSTRAINT `bookings_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (2,9,1,'Alice Johnson','alice.j@example.com','555-0101','A102-B405','45 Kalayaan Ave, Diliman, QC','120 Visayas Ave, QC','2025-11-24','2025-11-24','18:30:00',8.50,22.50,'ongoing','Card','paid',NULL,NULL,NULL,'2025-11-24 10:32:32','2025-11-24 10:32:32'),(3,9,2,'Bob Smith','bob.s@example.com','555-0102','R301-R302','101 East Ave, Diliman, QC','202 West Ave, QC','2025-11-23','2025-11-23','08:00:00',15.20,45.00,'completed','Online','paid',5,NULL,'Fast and friendly service. Highly recommend!','2025-11-22 23:45:00','2025-11-23 00:30:00'),(4,9,3,'Charlie Brown','charlie.b@example.com','555-0103','D505-S101','55 Industrial St, Bagumbayan, QC','99 Katipunan Ave, Loyola Heights, QC','2025-11-22','2025-11-22','14:20:00',5.80,18.75,'completed','Cash','paid',4,NULL,'The driver was professional, a bit of a detour though.','2025-11-22 06:00:00','2025-11-22 06:40:00'),(5,9,4,'Diana Prince','diana.p@example.com','555-0104','G200-L100','700 Commonwealth Ave, QC','450 Tandang Sora Ave, QC','2025-11-21','2025-11-21','20:45:00',25.00,65.20,'completed','Card','paid',5,NULL,'Excellent long-distance ride. Very smooth.','2025-11-21 12:30:00','2025-11-21 13:40:00'),(6,9,5,'Ethan Hunt','ethan.h@example.com','555-0105','Q111-Q222','UP Town Center, Katipunan, QC','Trinoma Mall, EDSA, QC','2025-11-20','2025-11-20','05:30:00',30.10,88.00,'completed','Online','paid',5,NULL,'Punctual for an early morning airport run. Great job!','2025-11-19 21:00:00','2025-11-19 22:10:00'),(7,9,1,'Alice Johnson','alice.j@example.com','555-0101','A300-Z001','10 Parklane St, Cubao, QC','90 City Hall Drive, QC Circle','2025-11-19','2025-11-19','11:15:00',6.30,20.00,'completed','Cash','paid',4,NULL,'A pleasant trip, though the car smelled slightly of coffee.','2025-11-19 03:00:00','2025-11-19 03:30:00'),(8,9,2,'Bob Smith','bob.s@example.com','555-0102','T100-M100','33 Technohub, Commonwealth Ave, QC','11 UP AyalaLand Technohub, QC','2025-11-18','2025-11-18','16:00:00',10.50,32.50,'completed','Card','paid',5,NULL,'Very quick and efficient route.','2025-11-18 07:45:00','2025-11-18 08:25:00'),(9,9,3,'Charlie Brown','charlie.b@example.com','555-0103','L555-J444','5 Farmer\'s Plaza, Cubao, QC','7 Maginhawa St, Diliman, QC','2025-11-17','2025-11-17','19:30:00',4.10,14.50,'completed','Online','paid',5,NULL,'Perfect for a short evening ride. Driver was courteous.','2025-11-17 11:15:00','2025-11-17 11:45:00'),(10,9,4,'Diana Prince','diana.p@example.com','555-0104','H777-K888','Diliman Doctors Hospital, QC','St. Luke\'s Medical Center QC','2025-11-16','2025-11-16','09:10:00',7.90,24.00,'completed','Cash','paid',4,NULL,'A solid ride, nothing bad to say.','2025-11-16 01:00:00','2025-11-16 01:35:00'),(11,9,5,'Ethan Hunt','ethan.h@example.com','555-0105','P001-P002','44 Vinzons Hall, UP Diliman','66 Palma Hall, UP Diliman','2025-11-15','2025-11-15','13:40:00',2.50,10.00,'completed','Card','paid',5,NULL,'The best short ride! Got me to class quickly.','2025-11-15 05:30:00','2025-11-15 05:50:00'),(12,9,1,'Alice Johnson','alice.j@example.com','555-0101','X000-Y000','1 Eastwood City, Libis, QC','2 Libis Ave, QC','2025-11-14','2025-11-14','17:00:00',18.00,50.00,'completed','Online','paid',5,NULL,'Fantastic sunset view during the drive. Driver was very nice.','2025-11-14 08:45:00','2025-11-14 09:50:00'),(13,9,2,'Bob Smith','bob.s@example.com','555-0102','R301-R302','101 East Ave, Diliman, QC','202 West Ave, QC','2025-11-23','2025-11-23','08:00:00',15.20,45.00,'completed','Online','paid',5,NULL,'Fast and friendly service. Highly recommend!','2025-11-22 23:45:00','2025-11-23 00:30:00'),(14,9,3,'Charlie Brown','charlie.b@example.com','555-0103','D505-S101','55 Industrial St, Bagumbayan, QC','99 Katipunan Ave, Loyola Heights, QC','2025-11-22','2025-11-22','14:20:00',5.80,18.75,'completed','Cash','paid',4,NULL,'The driver was professional, a bit of a detour though.','2025-11-22 06:00:00','2025-11-22 06:40:00'),(15,9,4,'Diana Prince','diana.p@example.com','555-0104','G200-L100','700 Commonwealth Ave, QC','450 Tandang Sora Ave, QC','2025-11-21','2025-11-21','20:45:00',25.00,65.20,'completed','Card','paid',5,NULL,'Excellent long-distance ride. Very smooth.','2025-11-21 12:30:00','2025-11-21 13:40:00'),(16,9,5,'Ethan Hunt','ethan.h@example.com','555-0105','Q111-Q222','UP Town Center, Katipunan, QC','Trinoma Mall, EDSA, QC','2025-11-20','2025-11-20','05:30:00',30.10,88.00,'completed','Online','paid',5,NULL,'Punctual for an early morning airport run. Great job!','2025-11-19 21:00:00','2025-11-19 22:10:00'),(17,9,1,'Alice Johnson','alice.j@example.com','555-0101','A300-Z001','10 Parklane St, Cubao, QC','90 City Hall Drive, QC Circle','2025-11-19','2025-11-19','11:15:00',6.30,20.00,'completed','Cash','paid',4,NULL,'A pleasant trip, though the car smelled slightly of coffee.','2025-11-19 03:00:00','2025-11-19 03:30:00'),(18,9,2,'Bob Smith','bob.s@example.com','555-0102','T100-M100','33 Technohub, Commonwealth Ave, QC','11 UP AyalaLand Technohub, QC','2025-11-18','2025-11-18','16:00:00',10.50,32.50,'completed','Card','paid',5,NULL,'Very quick and efficient route.','2025-11-18 07:45:00','2025-11-18 08:25:00'),(19,9,3,'Charlie Brown','charlie.b@example.com','555-0103','L555-J444','5 Farmer\'s Plaza, Cubao, QC','7 Maginhawa St, Diliman, QC','2025-11-17','2025-11-17','19:30:00',4.10,14.50,'completed','Online','paid',5,NULL,'Perfect for a short evening ride. Driver was courteous.','2025-11-17 11:15:00','2025-11-17 11:45:00'),(20,9,4,'Diana Prince','diana.p@example.com','555-0104','H777-K888','Diliman Doctors Hospital, QC','St. Luke\'s Medical Center QC','2025-11-16','2025-11-16','09:10:00',7.90,24.00,'completed','Cash','paid',4,NULL,'A solid ride, nothing bad to say.','2025-11-16 01:00:00','2025-11-16 01:35:00'),(21,9,5,'Ethan Hunt','ethan.h@example.com','555-0105','P001-P002','44 Vinzons Hall, UP Diliman','66 Palma Hall, UP Diliman','2025-11-15','2025-11-15','13:40:00',2.50,10.00,'completed','Card','paid',5,NULL,'The best short ride! Got me to class quickly.','2025-11-15 05:30:00','2025-11-15 05:50:00'),(22,9,1,'Alice Johnson','alice.j@example.com','555-0101','X000-Y000','1 Eastwood City, Libis, QC','2 Libis Ave, QC','2025-11-14','2025-11-14','17:00:00',18.00,50.00,'completed','Online','paid',5,NULL,'Fantastic sunset view during the drive. Driver was very nice.','2025-11-14 08:45:00','2025-11-14 09:50:00'),(23,9,2,'Bob Smith','bob.s@example.com','555-0102','C100-D200','15 West Ave, West Triangle, QC','30 Tomas Morato Ave, QC','2025-11-13','2025-11-13','07:15:00',11.20,30.00,'cancelled','Card','refunded',NULL,NULL,NULL,'2025-11-12 23:00:00','2025-11-12 23:05:00'),(24,9,3,'Charlie Brown','charlie.b@example.com','555-0103','F300-G400','40 Gateway Mall, Cubao, QC','50 SM City North EDSA, QC','2025-11-12','2025-11-12','12:45:00',3.50,12.00,'cancelled','Cash','pending',NULL,NULL,NULL,'2025-11-12 04:30:00','2025-11-12 04:35:00'),(25,9,4,'Diana Prince','diana.p@example.com','555-0104','K500-M600','60 Kamuning Rd, QC','70 New Manila Ave, QC','2025-11-11','2025-11-11','15:20:00',9.00,25.50,'cancelled','Online','refunded',NULL,NULL,NULL,'2025-11-11 07:00:00','2025-11-11 07:02:00'),(26,9,5,'Ethan Hunt','ethan.h@example.com','555-0105','N700-O800','80 Araneta Coliseum, Cubao','90 Capitol Hills Golf, QC','2025-11-10','2025-11-10','18:50:00',6.70,21.00,'cancelled','Card','refunded',NULL,NULL,NULL,'2025-11-10 10:30:00','2025-11-10 10:40:00'),(27,9,1,'Alice Johnson','alice.j@example.com','555-0101','P900-Q000','10 Bago Bantay, QC','20 Balintawak Market, QC','2025-11-09','2025-11-09','06:00:00',22.00,55.00,'cancelled','Cash','pending',NULL,NULL,NULL,'2025-11-08 21:45:00','2025-11-08 21:50:00'),(28,9,2,'Bob Smith','bob.s@example.com','555-0102','S123-T456','30 LRT Roosevelt Station, QC','40 QC Bus Port, Araneta Center','2025-11-08','2025-11-08','10:30:00',14.50,38.00,'cancelled','Online','refunded',NULL,NULL,NULL,'2025-11-08 02:15:00','2025-11-08 02:20:00'),(29,9,3,'Charlie Brown','charlie.b@example.com','555-0103','U789-V012','50 QC Memorial Circle','60 La Mesa Eco Park, Fairview','2025-11-07','2025-11-07','13:10:00',5.10,16.00,'cancelled','Card','refunded',NULL,NULL,NULL,'2025-11-07 05:00:00','2025-11-07 05:02:00'),(30,9,4,'Diana Prince','diana.p@example.com','555-0104','W345-X678','70 Centris Walk, EDSA, QC','80 Project 6, Diliman, QC','2025-11-06','2025-11-06','17:40:00',10.90,31.50,'cancelled','Cash','pending',NULL,NULL,NULL,'2025-11-06 09:25:00','2025-11-06 09:35:00'),(31,9,5,'Ethan Hunt','ethan.h@example.com','555-0105','Y901-Z234','90 Seda Vertis North, QC','100 Maginhawa Food Park, QC','2025-11-05','2025-11-05','21:00:00',4.00,13.00,'cancelled','Online','refunded',NULL,NULL,NULL,'2025-11-05 12:45:00','2025-11-05 12:50:00'),(32,9,1,'Alice Johnson','alice.j@example.com','555-0101','A1A1-B2B2','11 Fairview Terraces, QC','22 Novaliches Town Proper, QC','2025-11-04','2025-11-04','14:10:00',1.50,8.50,'cancelled','Card','refunded',NULL,NULL,NULL,'2025-11-04 06:00:00','2025-11-04 06:05:00'),(33,9,1,'Alice Johnson','alice.j@example.com','555-0101','PQC-AUM','Philcoa, QC','Ateneo de Manila University, QC','2025-11-25','2025-11-25','07:00:00',7.00,20.00,'pending','Card','pending',NULL,NULL,NULL,'2025-11-24 10:34:49','2025-11-24 10:34:49'),(34,9,2,'Bob Smith','bob.s@example.com','555-0102','SMF-NOV','SM Fairview, QC','Novaliches Bayan, QC','2025-11-25','2025-11-25','09:45:00',4.50,15.00,'pending','Cash','pending',NULL,NULL,NULL,'2025-11-24 10:34:49','2025-11-24 10:34:49'),(35,9,3,'Charlie Brown','charlie.b@example.com','555-0103','UPV-MAT','UP Village, QC','Matalino St, QC','2025-11-25','2025-11-25','13:30:00',3.20,11.00,'pending','Online','pending',NULL,NULL,NULL,'2025-11-24 10:34:49','2025-11-24 10:34:49'),(36,9,4,'Diana Prince','diana.p@example.com','555-0104','VMM-MUN','Veterans Memorial Medical Center, QC','Muñoz Market, QC','2025-11-25','2025-11-25','16:15:00',9.80,28.00,'pending','Card','pending',NULL,NULL,NULL,'2025-11-24 10:34:49','2025-11-24 10:34:49'),(37,9,5,'Ethan Hunt','ethan.h@example.com','555-0105','SIV-GMA','St. Ignatius Village, QC','Green Meadows Ave, QC','2025-11-25','2025-11-25','22:00:00',6.10,19.50,'pending','Cash','pending',NULL,NULL,NULL,'2025-11-24 10:34:49','2025-11-24 10:34:49');
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
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
