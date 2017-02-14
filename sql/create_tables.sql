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




# Dump of table efo
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo`;

CREATE TABLE `efo` (
  `id` varchar(500) NOT NULL DEFAULT '',
  `ont_id` varchar(500) DEFAULT NULL,
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
   `id` VARCHAR(500) NOT NULL DEFAULT '',
   `ont_id` VARCHAR(500) NULL DEFAULT NULL,
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
  `id` varchar(500) DEFAULT '',
  `def` varchar(500) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table efo_def_cleaned
# ------------------------------------------------------------

DROP VIEW IF EXISTS `efo_def_cleaned`;

CREATE TABLE `efo_def_cleaned` (
   `id` VARCHAR(500) NULL DEFAULT '',
   `def` VARCHAR(500) NULL DEFAULT ''
) ENGINE=MyISAM;



# Dump of table efo_is_a
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo_is_a`;

CREATE TABLE `efo_is_a` (
  `id` varchar(500) DEFAULT '',
  `is_a_value` varchar(500) DEFAULT NULL,
  `is_a_description` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table efo_is_a_cleaned
# ------------------------------------------------------------

DROP VIEW IF EXISTS `efo_is_a_cleaned`;

CREATE TABLE `efo_is_a_cleaned` (
   `id` VARCHAR(500) NULL DEFAULT '',
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

LOCK TABLES `efo_property` WRITE;
/*!40000 ALTER TABLE `efo_property` DISABLE KEYS */;

INSERT INTO `efo_property` (`id`, `name`, `example`)
VALUES
	(1,'EFO:URI','http://www.ebi.ac.uk/efo/EFO_0001433'),
	(2,'http://www.ebi.ac.uk/efo/NCI_Thesaurus_definition_citation NCIt:','C29862'),
	(3,'http://www.ebi.ac.uk/efo/SNOMEDCT_definition_citation SNOMEDCT:','4151780'),
	(4,'IAO:0000117','\"James Malone\" '),
	(5,'organizational:class','\"true\" '),
	(6,'source:definition','\"An occurrent [span:Occurrent] that exists in time by occurring or happening, has temporal parts and always involves and depends on some entity.\" '),
	(7,'ArrayExpress:label','\"disease property\"'),
	(8,'branch:class','\"true\" '),
	(9,'IAO:0000112','\"For example, the disposition of vegetables to decay when not refrigerated, the disposition of blood to coagulate, the disposition of a patient with a weakened immune system to contract disease.\" '),
	(10,'IAO:0000412','http://purl.obolibrary.org/obo/bto.owl'),
	(11,'http://www.ebi.ac.uk/efo/obsoleted_in_version','\"2.44\"'),
	(12,'http://www.ebi.ac.uk/efo/reason_for_obsolescence','\"Duplicate with class K562 http://www.ebi.ac.uk/efo/EFO_0002067\" '),
	(14,'http://www.ebi.ac.uk/efo/UBERON_definition_citation UBERON:','0004103'),
	(15,'http://www.ebi.ac.uk/efo/BFO_definition_citation BFO:','0000020'),
	(16,'http://www.ebi.ac.uk/efo/MSH_definition_citation MSH:','D012380'),
	(17,'definition:citation','http://purl.obolibrary.org/obo/OBI_0100060'),
	(18,'http://www.ebi.ac.uk/efo/Patent_definition_citation','\"Patent:BE863429 \"Patent\"\" '),
	(19,'http://www.ebi.ac.uk/efo/ATCC_definition_citation ATCC:','TIB-152'),
	(20,'bioportal:provenance','\"ABL1 Gene[accessedResource: C17H18FN3O3][accessDate: 05-04-2011]\"'),
	(21,'http://www.ebi.ac.uk/efo/Beilstein_definition_citation','\"Beilstein:567897 \"Beilstein Registry Number\"\" '),
	(22,'http://www.ebi.ac.uk/efo/ChEMBL_definition_citation','\"ChEMBL:100246 \"ChEMBL COMPOUND\"\" '),
	(23,'http://www.ebi.ac.uk/efo/ChemIDplus_definition_citation','\"ChemIDplus:70458-96-7 \"CAS Registry Number\"\" '),
	(24,'http://www.ebi.ac.uk/efo/CiteXplore_definition_citation','\"CiteXplore:3317294 \"PubMed citation\"\"'),
	(25,'http://www.ebi.ac.uk/efo/DrugBank_definition_citation','\"DrugBank:DB01059 \"DrugBank\"\"'),
	(26,'http://www.ebi.ac.uk/efo/Gmelin_definition_citation','\"Gmelin:1576626 \"Gmelin Registry Number\"\"'),
	(27,'http://www.ebi.ac.uk/efo/KEGG_COMPOUND_definition_citation','\"KEGG COMPOUND:70458-96-7 \"CAS Registry Number\"\" '),
	(28,'http://www.ebi.ac.uk/efo/KEGG_DRUG_definition_citation','\"KEGG DRUG:D00210 \"KEGG DRUG\"\" '),
	(30,'http://www.ebi.ac.uk/efo/Wikipedia_definition_citation','\"Wikipedia:Norfloxacin \"Wikipedia\"\"');

/*!40000 ALTER TABLE `efo_property` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table efo_property_value
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo_property_value`;

CREATE TABLE `efo_property_value` (
  `id` varchar(500) DEFAULT '',
  `property_value_cleaned` varchar(500) DEFAULT NULL,
  `property_id` int(11) DEFAULT NULL,
  `property_value` varchar(500) DEFAULT '',
  `mesh` varchar(500) DEFAULT '',
  `nci` varchar(500) DEFAULT '',
  `snomed` varchar(500) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table efo_property_value_cleaned
# ------------------------------------------------------------

DROP VIEW IF EXISTS `efo_property_value_cleaned`;

CREATE TABLE `efo_property_value_cleaned` (
   `id` VARCHAR(500) NULL DEFAULT '',
   `property_value_cleaned` VARCHAR(500) NULL DEFAULT NULL,
   `property_id` INT(11) NULL DEFAULT NULL,
   `property_value` VARCHAR(500) NULL DEFAULT '',
   `mesh` VARCHAR(500) NULL DEFAULT '',
   `nci` VARCHAR(500) NULL DEFAULT '',
   `snomed` VARCHAR(500) NULL DEFAULT ''
) ENGINE=MyISAM;



# Dump of table efo_relationship
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo_relationship`;

CREATE TABLE `efo_relationship` (
  `id` varchar(500) DEFAULT '',
  `rtype` varchar(500) DEFAULT NULL,
  `relationship_ont_name` varchar(500) DEFAULT NULL,
  `relationship_ont_value` varchar(500) DEFAULT NULL,
  `relationship_description` varchar(500) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table efo_relationship_cleaned
# ------------------------------------------------------------

DROP VIEW IF EXISTS `efo_relationship_cleaned`;

CREATE TABLE `efo_relationship_cleaned` (
   `id` VARCHAR(500) NULL DEFAULT '',
   `rtype` VARCHAR(500) NULL DEFAULT NULL,
   `relationship_ont_name` VARCHAR(500) NULL DEFAULT NULL,
   `relationship_ont_value` VARCHAR(500) NULL DEFAULT NULL,
   `relationship_description` VARCHAR(500) NULL DEFAULT ''
) ENGINE=MyISAM;



# Dump of table efo_synonym
# ------------------------------------------------------------

DROP TABLE IF EXISTS `efo_synonym`;

CREATE TABLE `efo_synonym` (
  `id` varchar(500) DEFAULT '',
  `synonym` varchar(500) DEFAULT '',
  `synonym_type` varchar(500) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table efo_synonym_cleaned
# ------------------------------------------------------------

DROP VIEW IF EXISTS `efo_synonym_cleaned`;

CREATE TABLE `efo_synonym_cleaned` (
   `id` VARCHAR(500) NULL DEFAULT '',
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
   `efo_property_value`.`property_value` AS `property_value`,
   `efo_property_value`.`mesh` AS `mesh`,
   `efo_property_value`.`nci` AS `nci`,
   `efo_property_value`.`snomed` AS `snomed`
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
