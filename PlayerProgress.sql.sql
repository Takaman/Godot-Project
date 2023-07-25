| PlayerProgress | CREATE TABLE `PlayerProgress` (
  `username` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `date_joined` varchar(255) DEFAULT NULL,
  `points` decimal(9,6) DEFAULT NULL,
  `comp_rate` decimal(10,6) DEFAULT NULL,
  `comp_date` varchar(255) DEFAULT NULL,
  `last_played` varchar(255) DEFAULT NULL,
  `se_correct` int DEFAULT NULL,
  `se_completed` int DEFAULT NULL,
  `policy_correct` int DEFAULT NULL,
  `policy_completed` int DEFAULT NULL,
  `malware_correct` int DEFAULT NULL,
  `malware_completed` int DEFAULT NULL,
  `breakdown` text,
  `accountStatus` varchar(255) DEFAULT NULL,
  `has_interacted` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_c