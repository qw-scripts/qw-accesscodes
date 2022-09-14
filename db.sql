CREATE TABLE IF NOT EXISTS `accesscodes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` text DEFAULT NULL,
  `bank` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb3;