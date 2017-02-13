CREATE VIEW `efo_cleaned`
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

CREATE VIEW `efo_def_cleaned`
AS SELECT
   `efo_def`.`id` AS `id`,
   `efo_def`.`def` AS `def`
FROM `efo_def` where (`efo_def`.`id` like 'EFO%');

CREATE VIEW `efo_is_a_cleaned`
AS SELECT
   `efo_is_a`.`id` AS `id`,
   `efo_is_a`.`is_a_value` AS `is_a_value`,
   `efo_is_a`.`is_a_description` AS `is_a_description`
FROM `efo_is_a` where (`efo_is_a`.`id` like 'EFO%');

CREATE VIEW `efo_property_value_cleaned`
AS SELECT
   `efo_property_value`.`id` AS `id`,
   `efo_property_value`.`property_value_cleaned` AS `property_value_cleaned`,
   `efo_property_value`.`property_id` AS `property_id`,
   `efo_property_value`.`property_value` AS `property_value`,
   `efo_property_value`.`mesh` AS `mesh`,
   `efo_property_value`.`nci` AS `nci`,
   `efo_property_value`.`snomed` AS `snomed`
FROM `efo_property_value` where (`efo_property_value`.`id` like 'EFO%');

CREATE VIEW `efo_relationship_cleaned`
AS SELECT
   `efo_relationship`.`id` AS `id`,
   `efo_relationship`.`rtype` AS `rtype`,
   `efo_relationship`.`relationship_ont_name` AS `relationship_ont_name`,
   `efo_relationship`.`relationship_ont_value` AS `relationship_ont_value`,
   `efo_relationship`.`relationship_description` AS `relationship_description`
FROM `efo_relationship` where (`efo_relationship`.`id` like 'EFO%');

CREATE VIEW `efo_synonym_cleaned`
AS SELECT
   `efo_synonym`.`id` AS `id`,
   `efo_synonym`.`synonym` AS `synonym`,
   `efo_synonym`.`synonym_type` AS `synonym_type`
FROM `efo_synonym` where (`efo_synonym`.`id` like 'EFO%');

CREATE VIEW `phecode_efo`
AS
SELECT
   `j`.`jd_code` AS `jd_code`,
   `j`.`jd_string` AS `jd_string`,
   `j`.`jd_string_short` AS `jd_string_short`,
   `e`.`id` AS `id`,
   `e`.`name` AS `name`
FROM (`phewas_translate`.`jd_code_info` `j` join `cpmv_phewas`.`efo_cleaned` `e`
on ((( j.jd_string_short=e.name or j.jd_string=e.name or j.`jd_string_short` like concat('%',`e`.`name`,' '))
or (`j`.`jd_string_short` like concat(' ',`e`.`name`,'%')) or (`j`.`jd_string` like concat('%',`e`.`name`,' '))
or (`j`.`jd_string` like concat(' ', `e`.`name`,'%')))))
