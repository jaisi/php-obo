CREATE TABLE if not exists `efo` (
  `id` varchar(500) DEFAULT '',
  `ont_id` varchar(500) DEFAULT NULL,
  `name` varchar(500) DEFAULT '',
  `namespace` varchar(500) DEFAULT NULL,
  `equivalent_to` varchar(500) DEFAULT NULL,
  `is_obsolete` varchar(500) DEFAULT NULL,
  `created_by` varchar(500) DEFAULT NULL,
  `creation_date` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE if not exists `efo_def` (
  `id` varchar(500) DEFAULT '',
  `def` varchar(500) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE if not exists `efo_is_a` (
  `id` varchar(500) DEFAULT '',
  `is_a_value` varchar(500) DEFAULT NULL,
  `is_a_description` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE if not exists `efo_property_value` (
  `id` varchar(500) DEFAULT '',
  `property_value_cleaned` varchar(500) DEFAULT NULL,
  `property_id` int(11) DEFAULT NULL,
  `property_value` varchar(500) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE if not exists `efo_relationship` (
  `id` varchar(500) DEFAULT '',
  `relationship_part_of_ont` varchar(500) DEFAULT NULL,
  `relationship_ont_name` varchar(500) DEFAULT NULL,
  `relationship_ont_value` varchar(500) DEFAULT NULL,
  `relationship_description` varchar(500) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE if not exists `efo_synonym` (
  `id` varchar(500) DEFAULT '',
  `synonym` varchar(500) DEFAULT '',
  `synonym_type` varchar(500) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
