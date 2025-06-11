CREATE DATABASE  IF NOT EXISTS `partsheirlooms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `partsheirlooms`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: partsheirlooms
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `categorys`
--

DROP TABLE IF EXISTS `categorys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorys` (
  `category_id` int NOT NULL,
  `category_name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `UKchwy6uyaq1ni10lcumtth0pj` (`category_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorys`
--

LOCK TABLES `categorys` WRITE;
/*!40000 ALTER TABLE `categorys` DISABLE KEYS */;
INSERT INTO `categorys` VALUES (2,'CPU'),(4,'主機板'),(9,'其他'),(7,'散熱器'),(8,'機殼'),(6,'硬碟'),(3,'記憶體'),(5,'電源'),(1,'顯示卡');
/*!40000 ALTER TABLE `categorys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite`
--

DROP TABLE IF EXISTS `favorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorite` (
  `favotite_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`favotite_id`),
  UNIQUE KEY `UK7mwcjtab8q4b44jw3bur1okk8` (`user_id`,`product_id`),
  KEY `FKrd09pqm0vasylahjcnagd0c7o` (`product_id`),
  CONSTRAINT `FKa2lwa7bjrnbti5v12mga2et1y` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKrd09pqm0vasylahjcnagd0c7o` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite`
--

LOCK TABLES `favorite` WRITE;
/*!40000 ALTER TABLE `favorite` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_reports`
--

DROP TABLE IF EXISTS `issue_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_reports` (
  `report_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `details` text,
  `reason_category` varchar(100) NOT NULL,
  `status` enum('Open','In Progress','Resolved','Closed','Invalid') NOT NULL DEFAULT 'Open',
  `targer_id` int DEFAULT NULL,
  `target_type` enum('PRODUCT','USER','GENERAL') NOT NULL,
  `reporter_user_id` int NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `FKs49tnrvy074agfinvr0a2vkru` (`reporter_user_id`),
  CONSTRAINT `FKs49tnrvy074agfinvr0a2vkru` FOREIGN KEY (`reporter_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_reports`
--

LOCK TABLES `issue_reports` WRITE;
/*!40000 ALTER TABLE `issue_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `mssage_id` int NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `receiver_user_id` int NOT NULL,
  `sender_user_id` int NOT NULL,
  `transaction_id` int DEFAULT NULL,
  PRIMARY KEY (`mssage_id`),
  KEY `FKrx9kj3k3dqvmcfk4my12a98c3` (`receiver_user_id`),
  KEY `FKk4mpqp6gfuaelpcamqv01brkr` (`sender_user_id`),
  KEY `FK59qh3mdk2nfskojf0t5nphe04` (`transaction_id`),
  CONSTRAINT `FK59qh3mdk2nfskojf0t5nphe04` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`),
  CONSTRAINT `FKk4mpqp6gfuaelpcamqv01brkr` FOREIGN KEY (`sender_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKrx9kj3k3dqvmcfk4my12a98c3` FOREIGN KEY (`receiver_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_content`
--

DROP TABLE IF EXISTS `product_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_content` (
  `content_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `full_description` text,
  `short_description` varchar(500) NOT NULL,
  `title` varchar(255) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`content_id`),
  UNIQUE KEY `UK8d43t7bfjejtvvbshjpv68hi6` (`product_id`),
  CONSTRAINT `FKeh88ivgn1tkvo5pwigm0bkys9` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_content`
--

LOCK TABLES `product_content` WRITE;
/*!40000 ALTER TABLE `product_content` DISABLE KEYS */;
INSERT INTO `product_content` VALUES (33,'2025-06-11 15:26:44.000000','這是一款功能強大的酷睿i7處理器，擁有8核心16線程，基礎頻率3.8GHz，睿頻可達5.1GHz。適合遊戲、內容創作和多任務處理。','高性能桌面處理器，手動添加用於API測試。','手動插入的酷睿i7處理器','2025-06-11 15:26:44.000000',33);
/*!40000 ALTER TABLE `product_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `product_id` int NOT NULL,
  `image_base64` tinytext NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `FKqnq71xsohugpqwf3c9gxmsuy` (`product_id`),
  CONSTRAINT `FKqnq71xsohugpqwf3c9gxmsuy` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
INSERT INTO `product_images` VALUES (27,'2025-06-11 15:26:44.000000',33,'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=');
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_transaction_details`
--

DROP TABLE IF EXISTS `product_transaction_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_transaction_details` (
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `general_notes` varchar(255) DEFAULT NULL,
  `meetup_latitude` decimal(10,8) DEFAULT NULL,
  `meetup_longitude` decimal(10,8) DEFAULT NULL,
  `meetup_time` datetime(6) DEFAULT NULL,
  `product_id` int NOT NULL,
  `method_id` int NOT NULL,
  PRIMARY KEY (`detail_id`),
  KEY `FKdtc9nqma7l9o1jw6n1gdj2xx6` (`method_id`),
  KEY `FKbca9n94o1yi0r9wrw3s80vnca` (`product_id`),
  CONSTRAINT `FKbca9n94o1yi0r9wrw3s80vnca` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `FKdtc9nqma7l9o1jw6n1gdj2xx6` FOREIGN KEY (`method_id`) REFERENCES `transaction_methods` (`method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_transaction_details`
--

LOCK TABLES `product_transaction_details` WRITE;
/*!40000 ALTER TABLE `product_transaction_details` DISABLE KEYS */;
INSERT INTO `product_transaction_details` VALUES (24,'超商付款',NULL,NULL,NULL,33,1);
/*!40000 ALTER TABLE `product_transaction_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int unsigned NOT NULL DEFAULT '1',
  `status` enum('For_Sale','Sold','Removed') NOT NULL DEFAULT 'For_Sale',
  `category_id` int NOT NULL,
  `seller_user_id` int NOT NULL,
  PRIMARY KEY (`product_id`),
  KEY `FKr638shrnkkh3wy5llr9cwyi4t` (`category_id`),
  KEY `FKk6lbwhosc0of49sw3j33nnwsp` (`seller_user_id`),
  CONSTRAINT `FKk6lbwhosc0of49sw3j33nnwsp` FOREIGN KEY (`seller_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKr638shrnkkh3wy5llr9cwyi4t` FOREIGN KEY (`category_id`) REFERENCES `categorys` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (33,'2025-06-11 15:26:44.000000',1299.99,10,'For_Sale',2,2);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `rating_id` int NOT NULL AUTO_INCREMENT,
  `comment` text,
  `created_at` datetime(6) NOT NULL,
  `score` smallint NOT NULL,
  `rated_user_id` int NOT NULL,
  `rater_user_id` int NOT NULL,
  `transaction_id` int DEFAULT NULL,
  PRIMARY KEY (`rating_id`),
  KEY `FKluqvvmyyo8xvjhwg50v1cwss2` (`rated_user_id`),
  KEY `FK9d5ei0g0ub5lsou2qm8tlq3e2` (`rater_user_id`),
  KEY `FK2rlcdm12rl9x25pguhq2pe5jo` (`transaction_id`),
  CONSTRAINT `FK2rlcdm12rl9x25pguhq2pe5jo` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`),
  CONSTRAINT `FK9d5ei0g0ub5lsou2qm8tlq3e2` FOREIGN KEY (`rater_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKluqvvmyyo8xvjhwg50v1cwss2` FOREIGN KEY (`rated_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller_verification`
--

DROP TABLE IF EXISTS `seller_verification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller_verification` (
  `verification_id` int NOT NULL AUTO_INCREMENT,
  `admin_remarks` text,
  `reviewed_at` datetime(6) DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected','Resubmit') NOT NULL DEFAULT 'Pending',
  `submitted_at` datetime(6) NOT NULL,
  `reviewed_by_admin_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`verification_id`),
  KEY `FKcid7xeu6096uchbfouvx7fkrg` (`reviewed_by_admin_id`),
  KEY `FKt4uqt0s2xdamfcbp6yqxdg610` (`user_id`),
  CONSTRAINT `FKcid7xeu6096uchbfouvx7fkrg` FOREIGN KEY (`reviewed_by_admin_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKt4uqt0s2xdamfcbp6yqxdg610` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller_verification`
--

LOCK TABLES `seller_verification` WRITE;
/*!40000 ALTER TABLE `seller_verification` DISABLE KEYS */;
INSERT INTO `seller_verification` VALUES (1,'用戶資料齊全，審核通過。','2025-06-11 16:28:39.657180','Approved','2025-06-11 16:12:24.000000',1,2);
/*!40000 ALTER TABLE `seller_verification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_methods`
--

DROP TABLE IF EXISTS `transaction_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_methods` (
  `method_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`method_id`),
  UNIQUE KEY `UKrilgp4gv868ipmnihq8bd0v9h` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_methods`
--

LOCK TABLES `transaction_methods` WRITE;
/*!40000 ALTER TABLE `transaction_methods` DISABLE KEYS */;
INSERT INTO `transaction_methods` VALUES (1,'2025-06-11 15:19:04.000000','透過超商寄送','超商'),(2,'2025-06-11 15:19:04.000000','買賣雙方約定地點當面交易','面交');
/*!40000 ALTER TABLE `transaction_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `final_price` decimal(10,2) NOT NULL,
  `shipped_at` datetime(6) DEFAULT NULL,
  `status` enum('Pending Payment','Paid','Processing','Shipped','Completed','Cancelled') NOT NULL DEFAULT 'Pending Payment',
  `updated_at` datetime(6) NOT NULL,
  `buyer_user_id` int NOT NULL,
  `chosen_transaction_detail_id` int NOT NULL,
  `product_id` int NOT NULL,
  `seller_user_id` int NOT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `FKpg6aigtpj7j81qomdym4cy42q` (`buyer_user_id`),
  KEY `FKb7c9mxb4x110beua7pomrxiv9` (`chosen_transaction_detail_id`),
  KEY `FKje45ey7lvk62tb8m0tb4lntfi` (`seller_user_id`),
  KEY `FKcdpkn7bkq15bjvlw9mo46l9ft` (`product_id`),
  CONSTRAINT `FKb7c9mxb4x110beua7pomrxiv9` FOREIGN KEY (`chosen_transaction_detail_id`) REFERENCES `product_transaction_details` (`detail_id`),
  CONSTRAINT `FKcdpkn7bkq15bjvlw9mo46l9ft` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `FKje45ey7lvk62tb8m0tb4lntfi` FOREIGN KEY (`seller_user_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `FKpg6aigtpj7j81qomdym4cy42q` FOREIGN KEY (`buyer_user_id`) REFERENCES `users` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `active` bit(1) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `hash_salt` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `primary_role` enum('BUYER','SELLER','ADMIN','BLACK') NOT NULL DEFAULT 'BUYER',
  `email_token` varchar(100) DEFAULT NULL,
  `last_email_sent_at` datetime(6) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UKr43af9ap4edm43mmtq01oddj6` (`username`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`),
  UNIQUE KEY `UKbu52pgeappkpf0hj2ao7kr66x` (`email_token`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,_binary '','john@gmail.com','zPn7lmXkDlbv53BH6GXGBg==','xhIHiEk5OHGNTzuEnV9CVR5m0FSW7UXN2WkaupVf1XU=','john','ADMIN',NULL,NULL,NULL),(2,_binary '','mary1234@gmail.com','Kr5p8aA8ywBO9TDgJA61VQ==','qIf0m6kj5d63qwXHCXUhkDibu2k4HXAUqibQEDp6QNw=','mary','SELLER',NULL,NULL,NULL),(3,_binary '','tommy@gmail.com','VfhLoEm7/v0zhdPnJp5pZA==','KUvTudAun4JY+MfsnX0dW3PkA+Vd74fn+NowVlvnsKU=','tommy','BUYER',NULL,NULL,NULL),(4,_binary '','andy@gmail.com','d1oektBVSqXTQNAnmWntwg==','d5AMfkzvti+Tgo0zyniOWA7vVODdCnWTQzUZOySt73s=','andy','BLACK',NULL,NULL,NULL),(6,_binary '','endless.puma.aphf@letterprotect.net','B/DqQVive0HpUTHL2P78DQ==','ZBMP5mocec0cEfEUm16EJgIiGi50x9Tho15fSEDZwu4=','endless','BUYER',NULL,'2025-06-05 15:58:35.120546',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification_images`
--

DROP TABLE IF EXISTS `verification_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification_images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `update_at` datetime(6) NOT NULL,
  `verification_id` int NOT NULL,
  `image_base64` tinytext NOT NULL,
  PRIMARY KEY (`image_id`),
  KEY `FKckr029o9c80xk83q9b8srj82e` (`verification_id`),
  CONSTRAINT `FKckr029o9c80xk83q9b8srj82e` FOREIGN KEY (`verification_id`) REFERENCES `seller_verification` (`verification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification_images`
--

LOCK TABLES `verification_images` WRITE;
/*!40000 ALTER TABLE `verification_images` DISABLE KEYS */;
INSERT INTO `verification_images` VALUES (1,'2025-06-11 16:12:24.000000',1,'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNkYAAAAAYAAjCB0C8AAAAASUVORK5CYII=');
/*!40000 ALTER TABLE `verification_images` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-11 16:34:33
