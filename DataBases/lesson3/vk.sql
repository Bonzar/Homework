-- MySQL dump 10.13  Distrib 5.7.30, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: vk
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Р�РґРµРЅС‚РёС„РёРєР°С‚РѕСЂ СЃСЂРѕРєРё',
  `name` varchar(150) NOT NULL COMMENT 'РќР°Р·РІР°РЅРёРµ РіСЂСѓРїРїС‹',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ СЃРѕР·РґР°РЅРёСЏ СЃС‚СЂРѕРєРё',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ РѕР±РЅРѕРІР»РµРЅРёСЏ СЃС‚СЂРѕРєРё',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Р“СЂСѓРїРїС‹';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities`
--

LOCK TABLES `communities` WRITE;
/*!40000 ALTER TABLE `communities` DISABLE KEYS */;
/*!40000 ALTER TABLE `communities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `communities_users`
--

DROP TABLE IF EXISTS `communities_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `communities_users` (
  `community_id` int unsigned NOT NULL COMMENT 'РЎСЃС‹Р»РєР° РЅР° РіСЂСѓРїРїСѓ',
  `user_id` int unsigned NOT NULL COMMENT 'РЎСЃС‹Р»РєР° РЅР° РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ СЃРѕР·РґР°РЅРёСЏ СЃС‚СЂРѕРєРё',
  PRIMARY KEY (`community_id`,`user_id`) COMMENT 'РЎРѕСЃС‚Р°РІРЅРѕР№ РїРµСЂРІРёС‡РЅС‹Р№ РєР»СЋС‡'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='РЈС‡Р°СЃС‚РЅРёРєРё РіСЂСѓРїРї, СЃРІСЏР·СЊ РјРµР¶РґСѓ РїРѕР»СЊР·РѕРІР°С‚РµР»СЏРјРё Рё РіСЂСѓРїРїР°РјРё';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communities_users`
--

LOCK TABLES `communities_users` WRITE;
/*!40000 ALTER TABLE `communities_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `communities_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendship`
--

DROP TABLE IF EXISTS `friendship`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friendship` (
  `user_id` int unsigned NOT NULL COMMENT 'РЎСЃС‹Р»РєР° РЅР° РёРЅРёС†РёР°С‚РѕСЂР° РґСЂСѓР¶РµСЃРєРёС… РѕС‚РЅРѕС€РµРЅРёР№',
  `friend_id` int unsigned NOT NULL COMMENT 'РЎСЃС‹Р»РєР° РЅР° РїРѕР»СѓС‡Р°С‚РµР»СЏ РїСЂРёРіР»Р°С€РµРЅРёСЏ РґСЂСѓР¶РёС‚СЊ',
  `status_id` int unsigned NOT NULL COMMENT 'РЎСЃС‹Р»РєР° РЅР° СЃС‚Р°С‚СѓСЃ (С‚РµРєСѓС‰РµРµ СЃРѕСЃС‚РѕСЏРЅРёРµ) РѕС‚РЅРѕС€РµРЅРёР№',
  `requested_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ РѕС‚РїСЂР°РІР»РµРЅРёСЏ РїСЂРёРіР»Р°С€РµРЅРёСЏ РґСЂСѓР¶РёС‚СЊ',
  `confirmed_at` datetime DEFAULT NULL COMMENT 'Р’СЂРµРјСЏ РїРѕРґС‚РІРµСЂР¶РґРµРЅРёСЏ РїСЂРёРіР»Р°С€РµРЅРёСЏ',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ СЃРѕР·РґР°РЅРёСЏ СЃС‚СЂРѕРєРё',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ РѕР±РЅРѕРІР»РµРЅРёСЏ СЃС‚СЂРѕРєРё',
  PRIMARY KEY (`user_id`,`friend_id`) COMMENT 'РЎРѕСЃС‚Р°РІРЅРѕР№ РїРµСЂРІРёС‡РЅС‹Р№ РєР»СЋС‡'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='РўР°Р±Р»РёС†Р° РґСЂСѓР¶Р±С‹';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendship`
--

LOCK TABLES `friendship` WRITE;
/*!40000 ALTER TABLE `friendship` DISABLE KEYS */;
/*!40000 ALTER TABLE `friendship` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendship_statuses`
--

DROP TABLE IF EXISTS `friendship_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friendship_statuses` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Р�РґРµРЅС‚РёС„РёРєР°С‚РѕСЂ СЃС‚СЂРѕРєРё',
  `name` varchar(150) NOT NULL COMMENT 'РќР°Р·РІР°РЅРёРµ СЃС‚Р°С‚СѓСЃР°',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ СЃРѕР·РґР°РЅРёСЏ СЃС‚СЂРѕРєРё',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ РѕР±РЅРѕРІР»РµРЅРёСЏ СЃС‚СЂРѕРєРё',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='РЎС‚Р°С‚СѓСЃС‹ РґСЂСѓР¶Р±С‹';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendship_statuses`
--

LOCK TABLES `friendship_statuses` WRITE;
/*!40000 ALTER TABLE `friendship_statuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `friendship_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Р�РґРµРЅС‚РёС„РёРєР°С‚РѕСЂ СЃС‚СЂРѕРєРё',
  `user_id` int unsigned NOT NULL COMMENT 'РЎСЃС‹Р»РєР° РЅР° РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ, РєРѕС‚РѕСЂС‹Р№ Р·Р°РіСЂСѓР·РёР» С„Р°Р№Р»',
  `filename` varchar(255) NOT NULL COMMENT 'РџСѓС‚СЊ Рє С„Р°Р№Р»Сѓ',
  `size` int NOT NULL COMMENT 'Р Р°Р·РјРµСЂ С„Р°Р№Р»Р°',
  `metadata` json DEFAULT NULL COMMENT 'РњРµС‚Р°РґР°РЅРЅС‹Рµ С„Р°Р№Р»Р°',
  `media_type_id` int unsigned NOT NULL COMMENT 'РЎСЃС‹Р»РєР° РЅР° С‚РёРї РєРѕРЅС‚РµРЅС‚Р°',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ СЃРѕР·РґР°РЅРёСЏ СЃС‚СЂРѕРєРё',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ РѕР±РЅРѕРІР»РµРЅРёСЏ СЃС‚СЂРѕРєРё',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='РњРµРґРёР°С„Р°Р№Р»С‹';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_types` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Р�РґРµРЅС‚РёС„РёРєР°С‚РѕСЂ СЃС‚СЂРѕРєРё',
  `name` varchar(255) NOT NULL COMMENT 'РќР°Р·РІР°РЅРёРµ С‚РёРїР°',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ СЃРѕР·РґР°РЅРёСЏ СЃС‚СЂРѕРєРё',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ РѕР±РЅРѕРІР»РµРЅРёСЏ СЃС‚СЂРѕРєРё',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='РўРёРїС‹ РјРµРґРёР°С„Р°Р№Р»РѕРІ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Р�РґРµРЅС‚РёС„РёРєР°С‚РѕСЂ СЃС‚СЂРѕРєРё',
  `from_user_id` int unsigned NOT NULL COMMENT 'РЎСЃС‹Р»РєР° РЅР° РѕС‚РїСЂР°РІРёС‚РµР»СЏ СЃРѕРѕР±С‰РµРЅРёСЏ',
  `to_user_id` int unsigned NOT NULL COMMENT 'РЎСЃС‹Р»РєР° РЅР° РїРѕР»СѓС‡Р°С‚РµР»СЏ СЃРѕРѕР±С‰РµРЅРёСЏ',
  `body` text NOT NULL COMMENT 'РўРµРєСЃС‚ СЃРѕРѕР±С‰РµРЅРёСЏ',
  `is_important` tinyint(1) DEFAULT NULL COMMENT 'РџСЂРёР·РЅР°Рє РІР°Р¶РЅРѕСЃС‚Рё',
  `is_delivered` tinyint(1) DEFAULT NULL COMMENT 'РџСЂРёР·РЅР°Рє РґРѕСЃС‚Р°РІРєРё',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ СЃРѕР·РґР°РЅРёСЏ СЃС‚СЂРѕРєРё',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='РЎРѕРѕР±С‰РµРЅРёСЏ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `user_id` int unsigned NOT NULL COMMENT 'РЎСЃС‹Р»РєР° РЅР° РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ',
  `gender` char(1) NOT NULL COMMENT 'РџРѕР»',
  `birthday` date DEFAULT NULL COMMENT 'Р”Р°С‚Р° СЂРѕР¶РґРµРЅРёСЏ',
  `city` varchar(130) DEFAULT NULL COMMENT 'Р“РѕСЂРѕРґ РїСЂРѕР¶РёРІР°РЅРёСЏ',
  `country` varchar(130) DEFAULT NULL COMMENT 'РЎС‚СЂР°РЅР° РїСЂРѕР¶РёРІР°РЅРёСЏ',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ СЃРѕР·РґР°РЅРёСЏ СЃС‚СЂРѕРєРё',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ РѕР±РЅРѕРІР»РµРЅРёСЏ СЃС‚СЂРѕРєРё',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='РџСЂРѕС„РёР»Рё';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'Р�РґРµРЅС‚РёС„РёРєР°С‚РѕСЂ СЃС‚СЂРѕРєРё',
  `first_name` varchar(100) NOT NULL COMMENT 'Р�РјСЏ РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ',
  `last_name` varchar(100) NOT NULL COMMENT 'Р¤Р°РјРёР»РёСЏ РїРѕР»СЊР·РѕРІР°С‚РµР»СЏ',
  `email` varchar(100) NOT NULL COMMENT 'РџРѕС‡С‚Р°',
  `phone` varchar(100) NOT NULL COMMENT 'РўРµР»РµС„РѕРЅ',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ СЃРѕР·РґР°РЅРёСЏ СЃС‚СЂРѕРєРё',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Р’СЂРµРјСЏ РѕР±РЅРѕРІР»РµРЅРёСЏ СЃС‚СЂРѕРєРё',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='РџРѕР»СЊР·РѕРІР°С‚РµР»Рё';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2020-06-08  0:41:50
