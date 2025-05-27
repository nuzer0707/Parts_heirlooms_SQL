CREATE DATABASE  IF NOT EXISTS `parts_heirlooms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `parts_heirlooms`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: parts_heirlooms
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
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '分類 ID (PK)',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分類名稱 (例如: 顯示卡, CPU)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_categories_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品分類表 (極簡版)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_reports`
--

DROP TABLE IF EXISTS `issue_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_reports` (
  `report_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '回報 ID (PK)',
  `reporter_user_id` int unsigned NOT NULL COMMENT '回報者使用者 ID (FK)',
  `target_type` enum('PRODUCT','USER','GENERAL') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '回報目標類型',
  `target_id` int unsigned DEFAULT NULL COMMENT '回報目標的 ID (若適用，例如 product_id 或 user_id)',
  `reason_category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '回報原因分類 (更通用的分類)',
  `details` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '詳細說明',
  `status` enum('Open','In Progress','Resolved','Closed','Invalid') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Open' COMMENT '處理狀態',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提交時間',
  PRIMARY KEY (`report_id`),
  KEY `idx_ir_reporter` (`reporter_user_id`),
  KEY `idx_ir_target` (`target_type`,`target_id`),
  KEY `idx_ir_status_reason` (`status`,`reason_category`),
  CONSTRAINT `fk_ir_reporter` FOREIGN KEY (`reporter_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='通用問題回報表';
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
  `message_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '訊息 ID (PK)',
  `sender_user_id` int unsigned NOT NULL COMMENT '發送者 ID (FK)',
  `receiver_user_id` int unsigned NOT NULL COMMENT '接收者 ID (FK)',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '訊息內容',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '發送時間',
  PRIMARY KEY (`message_id`),
  KEY `idx_messages_sender_final` (`sender_user_id`),
  KEY `idx_messages_receiver_final` (`receiver_user_id`),
  CONSTRAINT `fk_messages_receiver_final` FOREIGN KEY (`receiver_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_messages_sender_final` FOREIGN KEY (`sender_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者訊息表';
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
  `content_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '內容 ID (PK)',
  `product_id` int unsigned NOT NULL COMMENT '關聯的商品 ID (FK & UNIQUE for 1-to-1)',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商品標題',
  `short_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '商品簡短描述/摘要 (用於列表預覽)',
  `full_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '商品詳細描述 (用於詳情頁)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '內容建立時間',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '內容最後更新時間',
  PRIMARY KEY (`content_id`),
  UNIQUE KEY `uq_pc_product_id` (`product_id`),
  CONSTRAINT `fk_pc_product_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品標題與描述內容表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_content`
--

LOCK TABLES `product_content` WRITE;
/*!40000 ALTER TABLE `product_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_images`
--

DROP TABLE IF EXISTS `product_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_images` (
  `image_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '圖片 ID (PK)',
  `product_id` int unsigned NOT NULL COMMENT '商品 ID (FK)',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '圖片路徑/URL',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '上傳時間',
  PRIMARY KEY (`image_id`),
  KEY `idx_productimages_product_final` (`product_id`),
  CONSTRAINT `fk_productimages_product_final` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品圖片表 (精簡)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_images`
--

LOCK TABLES `product_images` WRITE;
/*!40000 ALTER TABLE `product_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_transaction_details`
--

DROP TABLE IF EXISTS `product_transaction_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_transaction_details` (
  `detail_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '詳情記錄 ID (PK)',
  `product_id` int unsigned NOT NULL COMMENT '相關商品 ID (FK)',
  `method_id` int unsigned NOT NULL COMMENT '採用的交易方式 ID (FK)',
  `meetup_time` time DEFAULT NULL COMMENT '建議面交時間 (例如 19:00:00, 僅 method_id 為面交時填寫)',
  `general_notes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '通用說明 (面交地點/日期補充, 郵寄N天內出貨承諾, 運費等)',
  `meetup_latitude` decimal(10,8) DEFAULT NULL COMMENT '面交緯度 (僅當 method_id 為面交時有效)',
  `meetup_longitude` decimal(11,8) DEFAULT NULL COMMENT '面交經度 (僅當 method_id 為面交時有效)',
  PRIMARY KEY (`detail_id`),
  KEY `idx_ptd_product_l_final` (`product_id`),
  KEY `idx_ptd_method_l_final` (`method_id`),
  CONSTRAINT `fk_ptd_method_l_final` FOREIGN KEY (`method_id`) REFERENCES `transaction_methods` (`method_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ptd_product_l_final` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品交易方式詳情表 (面交TIME, 通用notes, 7欄)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_transaction_details`
--

LOCK TABLES `product_transaction_details` WRITE;
/*!40000 ALTER TABLE `product_transaction_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_transaction_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '商品 ID (PK)',
  `seller_user_id` int unsigned NOT NULL COMMENT '賣家 ID (FK)',
  `category_id` int unsigned NOT NULL COMMENT '分類 ID (FK)',
  `price` decimal(10,2) NOT NULL COMMENT '價格',
  `quantity` int unsigned NOT NULL DEFAULT '1' COMMENT '商品數量 (預設為1)',
  `status` enum('For Sale','Sold','Removed') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'For Sale' COMMENT '狀態',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '商品核心記錄建立時間',
  PRIMARY KEY (`product_id`),
  KEY `idx_products_seller_v_cs` (`seller_user_id`),
  KEY `idx_products_category_v_cs` (`category_id`),
  CONSTRAINT `fk_products_category_v_cs` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_products_seller_v_cs` FOREIGN KEY (`seller_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='商品核心屬性表 (內容已分離)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ratings` (
  `rating_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '評價 ID (PK)',
  `rater_user_id` int unsigned NOT NULL COMMENT '評價者 ID (FK)',
  `rated_user_id` int unsigned NOT NULL COMMENT '被評價者 ID (FK)',
  `transaction_id` int unsigned DEFAULT NULL COMMENT '關聯的交易 ID (FK, 可選)',
  `score` tinyint unsigned NOT NULL COMMENT '評分 (1-5)',
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '評論內容 (可選)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '評價時間',
  PRIMARY KEY (`rating_id`),
  KEY `idx_ratings_rater_final` (`rater_user_id`),
  KEY `idx_ratings_rated_final` (`rated_user_id`),
  KEY `idx_ratings_transaction_final` (`transaction_id`),
  CONSTRAINT `fk_ratings_rated_final` FOREIGN KEY (`rated_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ratings_rater_final` FOREIGN KEY (`rater_user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ratings_transaction_final` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`transaction_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者評價表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seller_verifications`
--

DROP TABLE IF EXISTS `seller_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seller_verifications` (
  `verification_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '認證申請 ID (PK)',
  `user_id` int unsigned NOT NULL COMMENT '申請認證的使用者 ID (FK)',
  `status` enum('Pending','Approved','Rejected','Resubmit') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending' COMMENT '認證狀態',
  `admin_remarks` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '管理員審核備註 (例如: 拒絕原因)',
  `submitted_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申請提交時間',
  `reviewed_at` timestamp NULL DEFAULT NULL COMMENT '審核完成時間',
  `reviewed_by_admin_id` int unsigned DEFAULT NULL COMMENT '審核管理員 ID (FK to users, 可選)',
  PRIMARY KEY (`verification_id`),
  KEY `idx_sv_user` (`user_id`),
  KEY `idx_sv_status` (`status`),
  KEY `idx_sv_reviewed_by` (`reviewed_by_admin_id`),
  CONSTRAINT `fk_sv_reviewed_by_admin` FOREIGN KEY (`reviewed_by_admin_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_sv_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='賣家資格認證申請表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seller_verifications`
--

LOCK TABLES `seller_verifications` WRITE;
/*!40000 ALTER TABLE `seller_verifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `seller_verifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_methods`
--

DROP TABLE IF EXISTS `transaction_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_methods` (
  `method_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '交易方式 ID (PK)',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '方式名稱 (例如: 郵寄, 面交)',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '方式簡短描述',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  PRIMARY KEY (`method_id`),
  UNIQUE KEY `name_UNIQUE_tm` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='交易方式定義表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_methods`
--

LOCK TABLES `transaction_methods` WRITE;
/*!40000 ALTER TABLE `transaction_methods` DISABLE KEYS */;
INSERT INTO `transaction_methods` VALUES (1,'郵寄','透過郵局或快遞寄送','2025-05-13 07:29:45'),(2,'面交','買賣雙方面對面交易','2025-05-13 07:29:45');
/*!40000 ALTER TABLE `transaction_methods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transactions` (
  `transaction_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '交易紀錄 ID (PK)',
  `product_id` int unsigned NOT NULL COMMENT '相關商品 ID (FK)',
  `seller_user_id` int unsigned NOT NULL COMMENT '賣家 ID (FK)',
  `buyer_user_id` int unsigned NOT NULL COMMENT '買家 ID (FK)',
  `chosen_transaction_detail_id` int unsigned NOT NULL COMMENT '選擇的商品交易方式詳情 ID (FK)',
  `final_price` decimal(10,2) NOT NULL COMMENT '最終成交價格',
  `status` enum('Pending Payment','Paid','Processing','Shipped','Completed','Cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Pending Payment' COMMENT '交易狀態',
  `shipped_at` timestamp NULL DEFAULT NULL COMMENT '實際出貨時間 (賣家確認出貨時記錄)',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '交易建立時間 (訂單成立時間)',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '交易狀態最後更新時間',
  PRIMARY KEY (`transaction_id`),
  KEY `idx_transactions_product_k_final` (`product_id`),
  KEY `idx_transactions_seller_k_final` (`seller_user_id`),
  KEY `idx_transactions_buyer_k_final` (`buyer_user_id`),
  KEY `idx_transactions_chosen_detail_k_final` (`chosen_transaction_detail_id`),
  CONSTRAINT `fk_transactions_buyer_k_final` FOREIGN KEY (`buyer_user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_transactions_chosen_detail_k_final` FOREIGN KEY (`chosen_transaction_detail_id`) REFERENCES `product_transaction_details` (`detail_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_transactions_product_k_final` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_transactions_seller_k_final` FOREIGN KEY (`seller_user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='核心交易紀錄 (含實際出貨時間)';
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
  `user_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '使用者 ID (PK)',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '使用者名稱 (登入用)',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '電子郵件 (登入/通知用)',
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '雜湊後的密碼',
  `hash_salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密碼鹽值 (若雜湊庫需要單獨儲存)',
  `primary_role` enum('BUYER','SELLER','ADMIN') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BUYER' COMMENT '使用者主要角色',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '註冊時間',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='使用者核心資料表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `verification_images`
--

DROP TABLE IF EXISTS `verification_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `verification_images` (
  `image_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '圖片 ID (PK)',
  `verification_id` int unsigned NOT NULL COMMENT '關聯的認證申請 ID (FK)',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '圖片的路徑或 URL',
  `uploaded_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '圖片上傳時間',
  PRIMARY KEY (`image_id`),
  KEY `idx_vi_verification` (`verification_id`),
  CONSTRAINT `fk_vi_verification` FOREIGN KEY (`verification_id`) REFERENCES `seller_verifications` (`verification_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='賣家認證申請的圖片表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `verification_images`
--

LOCK TABLES `verification_images` WRITE;
/*!40000 ALTER TABLE `verification_images` DISABLE KEYS */;
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

-- Dump completed on 2025-05-27 15:30:32
