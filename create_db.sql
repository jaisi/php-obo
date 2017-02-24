# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.7.17-log)
# Database: efo
# Generation Time: 2017-02-14 14:53:35 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table efo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo`;

CREATE TABLE `efo` (
  `id` varchar(50) NOT NULL DEFAULT '',
  `ont_id` varchar(50) DEFAULT NULL,
  `name` varchar(500) DEFAULT '',
  `namespace` varchar(500) DEFAULT NULL,
  `equivalent_to` varchar(500) DEFAULT NULL,
  `is_obsolete` varchar(500) DEFAULT NULL,
  `created_by` varchar(500) DEFAULT NULL,
  `creation_date` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table efo_cleaned
# ------------------------------------------------------------

DROP VIEW IF EXISTS `efo_cleaned`;

CREATE TABLE `efo_cleaned` (
   `id` VARCHAR(50) NOT NULL DEFAULT '',
   `ont_id` VARCHAR(50) NULL DEFAULT NULL,
   `name` VARCHAR(500) NULL DEFAULT '',
   `namespace` VARCHAR(500) NULL DEFAULT NULL,
   `equivalent_to` VARCHAR(500) NULL DEFAULT NULL,
   `is_obsolete` VARCHAR(500) NULL DEFAULT NULL,
   `created_by` VARCHAR(500) NULL DEFAULT NULL,
   `creation_date` VARCHAR(500) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Dump of table efo_def
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo_def`;

CREATE TABLE `efo_def` (
  `id` varchar(50) DEFAULT '',
  `def` varchar(500) DEFAULT '',
  KEY `id` (`id`,`def`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table efo_def_cleaned
# ------------------------------------------------------------

DROP VIEW IF EXISTS `efo_def_cleaned`;

CREATE TABLE `efo_def_cleaned` (
   `id` VARCHAR(50) NULL DEFAULT '',
   `def` VARCHAR(500) NULL DEFAULT ''
) ENGINE=MyISAM;



# Dump of table efo_is_a
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo_is_a`;

CREATE TABLE `efo_is_a` (
  `id` varchar(50) DEFAULT '',
  `is_a_value` varchar(500) DEFAULT NULL,
  `is_a_description` varchar(500) DEFAULT NULL,
  KEY `id` (`id`,`is_a_value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table efo_is_a_cleaned
# ------------------------------------------------------------

DROP VIEW IF EXISTS `efo_is_a_cleaned`;

CREATE TABLE `efo_is_a_cleaned` (
   `id` VARCHAR(50) NULL DEFAULT '',
   `is_a_value` VARCHAR(500) NULL DEFAULT NULL,
   `is_a_description` VARCHAR(500) NULL DEFAULT NULL
) ENGINE=MyISAM;



# Dump of table efo_property
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo_property`;

CREATE TABLE `efo_property` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(500) DEFAULT NULL,
  `example` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



# Dump of table efo_property_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo_property_value`;

CREATE TABLE `efo_property_value` (
  `id` varchar(50) DEFAULT '',
  `property_value_cleaned` varchar(500) DEFAULT NULL,
  `property_id` int(11) DEFAULT NULL,
  `property_value` varchar(500) DEFAULT '',
  KEY `id` (`id`,`property_value_cleaned`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table efo_property_value_cleaned
# ------------------------------------------------------------

DROP VIEW IF EXISTS `efo_property_value_cleaned`;

CREATE TABLE `efo_property_value_cleaned` (
   `id` VARCHAR(50) NULL DEFAULT '',
   `property_value_cleaned` VARCHAR(500) NULL DEFAULT NULL,
   `property_id` INT(11) NULL DEFAULT NULL,
   `property_value` VARCHAR(500) NULL DEFAULT ''

) ENGINE=MyISAM;



# Dump of table efo_relationship
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo_relationship`;

CREATE TABLE `efo_relationship` (
  `id` varchar(50) DEFAULT '',
  `rtype` varchar(500) DEFAULT NULL,
  `relationship_ont_name` varchar(500) DEFAULT NULL,
  `relationship_ont_value` varchar(500) DEFAULT NULL,
  `relationship_description` varchar(500) DEFAULT '',
  KEY `id` (`id`,`rtype`,`relationship_ont_name`,`relationship_ont_value`)

) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table efo_relationship_cleaned
# ------------------------------------------------------------

DROP VIEW IF EXISTS `efo_relationship_cleaned`;

CREATE TABLE `efo_relationship_cleaned` (
   `id` VARCHAR(50) NULL DEFAULT '',
   `rtype` VARCHAR(500) NULL DEFAULT NULL,
   `relationship_ont_name` VARCHAR(500) NULL DEFAULT NULL,
   `relationship_ont_value` VARCHAR(500) NULL DEFAULT NULL,
   `relationship_description` VARCHAR(500) NULL DEFAULT ''
) ENGINE=MyISAM;



# Dump of table efo_synonym
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo_synonym`;

CREATE TABLE `efo_synonym` (
  `id` varchar(50) DEFAULT '',
  `synonym` varchar(500) DEFAULT '',
  `synonym_type` varchar(500) DEFAULT '',
  KEY `id` (`id`,`synonym`,`synonym_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table efo_synonym_cleaned
# ------------------------------------------------------------

DROP VIEW IF EXISTS `efo_synonym_cleaned`;

CREATE TABLE `efo_synonym_cleaned` (
   `id` VARCHAR(50) NULL DEFAULT '',
   `synonym` VARCHAR(500) NULL DEFAULT '',
   `synonym_type` VARCHAR(500) NULL DEFAULT ''
) ENGINE=MyISAM;





# Replace placeholder table for efo_def_cleaned with correct view syntax
# ------------------------------------------------------------

DROP TABLE `efo_def_cleaned`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `efo_def_cleaned`
AS SELECT
   `efo_def`.`id` AS `id`,
   `efo_def`.`def` AS `def`
FROM `efo_def` where (`efo_def`.`id` like 'EFO%');


# Replace placeholder table for efo_is_a_cleaned with correct view syntax
# ------------------------------------------------------------

DROP TABLE `efo_is_a_cleaned`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `efo_is_a_cleaned`
AS SELECT
   `efo_is_a`.`id` AS `id`,
   `efo_is_a`.`is_a_value` AS `is_a_value`,
   `efo_is_a`.`is_a_description` AS `is_a_description`
FROM `efo_is_a` where (`efo_is_a`.`id` like 'EFO%');


# Replace placeholder table for efo_cleaned with correct view syntax
# ------------------------------------------------------------

DROP TABLE `efo_cleaned`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `efo_cleaned`
AS SELECT
   `efo`.`id` AS `id`,
   `efo`.`ont_id` AS `ont_id`,
   `efo`.`name` AS `name`,
   `efo`.`namespace` AS `namespace`,
   `efo`.`equivalent_to` AS `equivalent_to`,
   `efo`.`is_obsolete` AS `is_obsolete`,
   `efo`.`created_by` AS `created_by`,
   `efo`.`creation_date` AS `creation_date`
FROM `efo` where (`efo`.`id` like 'EFO%');


# Replace placeholder table for efo_relationship_cleaned with correct view syntax
# ------------------------------------------------------------

DROP TABLE `efo_relationship_cleaned`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `efo_relationship_cleaned`
AS SELECT
   `efo_relationship`.`id` AS `id`,
   `efo_relationship`.`rtype` AS `rtype`,
   `efo_relationship`.`relationship_ont_name` AS `relationship_ont_name`,
   `efo_relationship`.`relationship_ont_value` AS `relationship_ont_value`,
   `efo_relationship`.`relationship_description` AS `relationship_description`
FROM `efo_relationship` where (`efo_relationship`.`id` like 'EFO%');


# Replace placeholder table for efo_property_value_cleaned with correct view syntax
# ------------------------------------------------------------

DROP TABLE `efo_property_value_cleaned`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `efo_property_value_cleaned`
AS SELECT
   `efo_property_value`.`id` AS `id`,
   `efo_property_value`.`property_value_cleaned` AS `property_value_cleaned`,
   `efo_property_value`.`property_id` AS `property_id`,
   `efo_property_value`.`property_value` AS `property_value`

FROM `efo_property_value` where (`efo_property_value`.`id` like 'EFO%');


# Replace placeholder table for efo_synonym_cleaned with correct view syntax
# ------------------------------------------------------------

DROP TABLE `efo_synonym_cleaned`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `efo_synonym_cleaned`
AS SELECT
   `efo_synonym`.`id` AS `id`,
   `efo_synonym`.`synonym` AS `synonym`,
   `efo_synonym`.`synonym_type` AS `synonym_type`
FROM `efo_synonym` where (`efo_synonym`.`id` like 'EFO%');

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
