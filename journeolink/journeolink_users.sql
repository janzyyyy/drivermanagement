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
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `middle_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ext` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `alternative_email` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `role` enum('driver','admin','traveler') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('pending','active','suspended','rejected') COLLATE utf8mb4_general_ci DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `phone` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('male','female','other') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `license_number` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `years_experience` int DEFAULT '0',
  `previous_jobs` text COLLATE utf8mb4_general_ci,
  `license_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nbi_clearance` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `proof_of_address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rating` decimal(3,2) DEFAULT '0.00',
  `total_trips` int DEFAULT '0',
  `member_since` date DEFAULT (curdate()),
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `vehicle_categories` json DEFAULT NULL,
  `license_issue_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'Marvin Navarette',NULL,NULL,NULL,NULL,'mnavarette00@gmail.com',NULL,'../assets/user-avatar.png',NULL,'pending','2025-11-18 05:08:48','+63 912 345 6789','Quezon City, Metro Manila','1995-03-15',NULL,'N01-12-345678','2020-11-01','2025-11-01',8,'Delivery driver for 3 years, Taxi driver for 5 years','../assets/licence-sample.jpg',NULL,NULL,4.80,142,'2024-01-15','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',NULL,NULL),(6,'Test User',NULL,NULL,NULL,NULL,'test@example.com',NULL,NULL,NULL,'pending','2025-11-21 10:59:08',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,0.00,0,'2025-11-21','$2y$10$f8s4e74VdGYzwztM5DURKOkMmhE7UQuBERsomuzrUIFkgqyhemvAK',NULL,NULL),(7,'Marvin N. Navarette','Marvin','Navarette','N.','','mnavarette45@gmail.com','mnavarette00@gmail.com','../uploads/avatars/avatar_7_1763737500.jpg','driver','pending','2025-11-21 11:59:11','09509344458','409 east berkely st. california village','2004-01-23','male','23A1','2025-11-22','2025-12-11',5,'ASD',NULL,NULL,NULL,0.00,0,'2025-11-21','$2y$10$Dkcjc4r3mW2iUg7XWJFXHeAxUGouizVLwPg2BbY0LW08NTYbfc4sG','[\"sedan\", \"suv\", \"minibus\"]',NULL),(8,'Marron N. Navarette','Marron','Navarette','N.','','marron@gmail.com','mnavarette00@gmail.com','../uploads/avatars/avatar_8_1763829595.jpg','driver','pending','2025-11-22 16:18:53','09509344458','409 east berkely st. california village','1998-03-18','male','4235A','2025-11-23','2025-12-03',0,'asd','../uploads/licenses/license_8_1763829918.jpg',NULL,NULL,0.00,0,'2025-11-23','$2y$10$PC.y8Qh.tc.R1rR6dlemfO0KNL8oIA/QPymOGoUGi5mxGr39XeFqW','[\"suv\"]',NULL),(9,'Marvin N. Navarette','Marvin','Navarette','N.','','marvin@gmail.com','mnavarette00@gmail.com','../uploads/registration/idPicture_1763905761_692310e1e755d.jpg','driver','pending','2025-11-23 13:49:22','09509344458','409 east berkely st. california village','2004-01-23','male','523GD','2025-11-28','2029-11-22',10,'asdfasdfasdfasdfasdf','../uploads/registration/licensePhoto_1763905761_692310e1e6812.jpg','../uploads/registration/nbiClearance_1763905761_692310e1e6dda.jpg','../uploads/registration/proofOfAddress_1763905761_692310e1e72db.jpg',0.00,0,'2025-11-23','$2y$10$lSx72H6nlewGEr9k4R1i7uFkHQd3fUQVRNrcOhvtof.hcvUkrXw6C','[\"sedan\", \"suv\", \"minibus\"]',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
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
