# ************************************************************
# Sequel Ace SQL dump
# Version 20046
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 5.7.29)
# Database: symfony
# Generation Time: 2023-04-29 07:00:02 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table players
# ------------------------------------------------------------

DROP TABLE IF EXISTS `players`;

CREATE TABLE `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) DEFAULT NULL,
  `is_available` int(11) DEFAULT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_264E43A6296CD8AE` (`team_id`),
  CONSTRAINT `FK_264E43A6296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `players` WRITE;
/*!40000 ALTER TABLE `players` DISABLE KEYS */;

INSERT INTO `players` (`id`, `first_name`, `last_name`, `price`, `is_available`, `team_id`)
VALUES
	(1,'MS','Dhoni',1000,0,2),
	(2,'Virat','Kohli',1000,0,3),
	(3,'Rohit','Sharma',1000,0,1),
	(4,'Hardik','Pandya',900,0,1),
	(5,'Jasprit','Bumrah',900,0,1),
	(6,'Mohmmad','Shami',900,0,2),
	(7,'Ravindra','Jadeja',900,0,2),
	(8,'Risabh','Pant',900,1,NULL),
	(9,'Lokesh','Rahul',800,0,3),
	(10,'Yuzvenndra','Chahal',800,0,3),
	(11,'Bhuvaneshvar','Kumar',800,0,2),
	(12,'Suryakumar','Yadav',700,0,1),
	(13,'Krunal','Pandya',700,0,1),
	(14,'Subhman','Gill',700,0,3),
	(15,'Ishan','Kishan',700,1,NULL),
	(16,'Kuldeep','Yadav',700,1,NULL),
	(17,'Ravi','Ashvin',700,1,NULL),
	(18,'Deepak','Chahar',600,0,2),
	(19,'Dinesh','Kartik',600,1,NULL),
	(20,'Mohmaad','Siraj',600,0,3),
	(21,'Axar','Patel',600,0,2),
	(22,'Shikhar','Dhawan',600,1,NULL),
	(23,'Tilak','Varma',500,0,2),
	(24,'Deepak','Hooda',500,1,NULL),
	(25,'Shreyas','Iyer',500,1,NULL),
	(26,'Nitish','Rana',500,1,NULL),
	(27,'Abdul','Samad',500,1,NULL),
	(28,'Umran','Malik',500,1,NULL),
	(29,'Harshal','Patel',400,0,3),
	(30,'Ambati','Raydu',400,0,2),
	(31,'Ruturaj','Gaikwad',400,1,NULL),
	(32,'Jayant','Yadav',400,1,NULL),
	(33,'Mohit','Sharma',300,1,NULL),
	(34,'Shardul','Thakur',300,1,NULL),
	(35,'Rahul','Chahar',300,1,NULL),
	(36,'Ayush','Badoni',300,1,NULL),
	(37,'Abhinav','Manohar',300,1,NULL),
	(38,'Rinku','Singh',300,1,NULL),
	(39,'Rajat','Patidar',200,1,NULL),
	(40,'Sandeep','Sharma',200,1,NULL),
	(41,'Venkatesh','Iyer',200,1,NULL),
	(42,'Rahul','Tewatia',100,1,NULL),
	(43,'Abhishek','Sharma',100,1,NULL),
	(44,'Manish','Pandey',100,1,NULL),
	(45,'Ravi','Bishnoi',100,1,NULL);

/*!40000 ALTER TABLE `players` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;

INSERT INTO `role` (`id`, `name`, `role_name`, `status`)
VALUES
	(1,'Role Admin','ROLE_ADMIN',1),
	(2,'Role Owner','ROLE_OWNER',1),
	(3,'Role User','ROLE_USER',1);

/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table teams
# ------------------------------------------------------------

DROP TABLE IF EXISTS `teams`;

CREATE TABLE `teams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purse` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `teams` WRITE;
/*!40000 ALTER TABLE `teams` DISABLE KEYS */;

INSERT INTO `teams` (`id`, `name`, `country`, `purse`)
VALUES
	(1,'Mumbai Indians','India',5800),
	(2,'Chennai Supar','Austrelia',500),
	(3,'Royal Challengers','England',5700);

/*!40000 ALTER TABLE `teams` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table transfer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `transfer`;

CREATE TABLE `transfer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `old_team_id` int(11) DEFAULT NULL,
  `new_team_id` int(11) DEFAULT NULL,
  `player_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `transfer` WRITE;
/*!40000 ALTER TABLE `transfer` DISABLE KEYS */;

INSERT INTO `transfer` (`id`, `old_team_id`, `new_team_id`, `player_id`, `created`)
VALUES
	(1,NULL,1,3,'2023-04-28 15:10:34'),
	(2,NULL,1,5,'2023-04-28 15:14:47'),
	(3,NULL,1,4,'2023-04-28 15:14:49'),
	(4,NULL,1,13,'2023-04-28 15:14:52'),
	(5,NULL,1,23,'2023-04-28 15:14:57'),
	(6,NULL,1,12,'2023-04-28 15:15:01'),
	(7,NULL,2,1,'2023-04-28 15:18:21'),
	(8,NULL,2,7,'2023-04-28 15:18:24'),
	(9,NULL,2,11,'2023-04-28 15:18:27'),
	(10,NULL,2,21,'2023-04-28 15:18:30'),
	(11,NULL,2,18,'2023-04-28 15:18:33'),
	(12,NULL,2,30,'2023-04-28 15:18:38'),
	(13,NULL,3,2,'2023-04-28 15:18:59'),
	(14,NULL,3,14,'2023-04-28 15:19:01'),
	(15,NULL,3,10,'2023-04-28 15:19:04'),
	(16,NULL,3,9,'2023-04-28 15:19:07'),
	(17,NULL,3,20,'2023-04-28 15:19:11'),
	(18,NULL,3,29,'2023-04-28 15:19:14'),
	(20,1,NULL,23,'2023-04-29 05:12:36'),
	(21,NULL,2,23,'2023-04-29 06:01:34'),
	(22,NULL,2,6,'2023-04-29 06:48:33');

/*!40000 ALTER TABLE `transfer` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `team_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649F85E0677` (`username`),
  UNIQUE KEY `UNIQ_8D93D649296CD8AE` (`team_id`),
  CONSTRAINT `FK_8D93D649296CD8AE` FOREIGN KEY (`team_id`) REFERENCES `teams` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `username`, `roles`, `password`, `team_id`)
VALUES
	(1,'admin','[]','$2y$13$cANT3C3Q78iW8tTsMexlWOLE9dSmzL5cTPD67wVuqDTUUSxtAeNjG',NULL),
	(2,'mumbai','[]','$2y$13$wn79skP8skanD41UwzUr9eWfxBeDoAzS0aznAM0xYPB9CyKkYlq0.',1),
	(3,'chennai','[]','$2y$13$.ZAoe8/BBx5ddYiYc.K9ZORu9/yxVe5BFEzGe5dhvZ/D7hfT4jVau',2),
	(4,'banglore','[]','$2y$13$uUvR./jrvlCumBvk6SAIfuGt61V/X8x4epWFW5nLKa1I4DzHwdIha',3);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_role`;

CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `IDX_2DE8C6A3A76ED395` (`user_id`),
  KEY `IDX_2DE8C6A3D60322AC` (`role_id`),
  CONSTRAINT `FK_2DE8C6A3A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2DE8C6A3D60322AC` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;

INSERT INTO `user_role` (`user_id`, `role_id`)
VALUES
	(1,1),
	(1,3),
	(2,2),
	(2,3),
	(3,2),
	(3,3),
	(4,2),
	(4,3);

/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
