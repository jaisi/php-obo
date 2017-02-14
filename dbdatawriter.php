<?php

namespace datawriter;


class DBDataWriter implements DataWriter
{
      public function writeData($allTerms)
      {
          //create connection
          $config = parse_ini_file('./config.ini');
          $db = new \mysqli('127.0.0.1', $config['username'],$config['password'],$config['dbname']);
	  echo(print_r($config,1));

          // Check connection
          if ($db->connect_error) {
              die("Connection failed: " . $db->connect_error);
          }

$i = 0;

          foreach ($allTerms as $term)
          {
              //echo "i am now here";
              //echo $ont_id[1];
          //  echo $term['id'] . ' ' . $term['name'] . ' ' . $term['def'][0]. ' ' . $term['property_value'][0]. PHP_EOL;

              $id = $term['id'];
              $name = $term['name'];
              $namespace = $term['namespace'];
              $equivalent_to = $term['equivalent_to'];
              $is_obsolete = $term['is_obsolete'];
              $created_by = $term['created_by'];
              $creation_date = $term['creation_date'];
              $i++;
              if ($i <= 1000 ) {
                //var_dump($term);

                $props = $term['property_value'];

                foreach ($props as $p) {
                  $matches = [];
                  $pname = [];
                  $prop_name = '';
                  $prop_val = '';

                  //echo "<h1> Property  $p </h1>";
                  // This is an http string property
                  if (preg_match('/^(.*?)\s(.*?)\s?/', $p, $matches)) {
                    $prop_name = $matches[1];
                    $prop_value = $matches[2];
                     echo "<h3> $p </h3> <h3> General Rule caught it Derived Name: $prop_name Value: $prop_value  </h3>";

                  }

                  if (preg_match('/^(http:.*?)\s(.*?)(xsd:string)?/', $p, $matches)) {
                    //echo "<h3> Http Property Property Name Matches </h3>";
                    $prop_name = $matches[1];
                    $prop_value = $matches[2];
                  //  echo "<h3> Derived Name: $prop_name Value: $prop_value  </h3>";

                  }
                  // Quoted Property Value format of property string ,  Property name is beginning of string to first ". Value is in ""
                  else if (preg_match('/^(.*?)\s?"(.*?)" xsd:string/', $p, $matches)) {
                   echo "<h3> Quoted Property Value Matches </h3>";
                    $prop_name = $matches[1];
                    $prop_value = $matches[2];

                  /*  if (preg_match('/(".*?")/', $p, $matches)) {
                      echo "<h3> Value Matches  </h3>";
                      var_dump($matches);
                    }
                    */
                  }
                  else {
                    echo "<h3 style='color:red;'> Property Not derived . Handle this property type </h3>";
                    echo("<h3> Property Value $p </h3>");
                  }

                  //echo "<h3> Derived Name: $prop_name Value: $prop_value  </h3>";

                  // Insert prop name and get id in database if it doesn't exist.
                  //$prop_id = $this->findInsertProperty($prop_name);

                }





              }

              else {
                // Insert prop name and get id in database if it doesn't exist.
                $prop_id = $this->findInsertProperty($prop_name);


              }

              continue;

              /* End debugging */
              //prop_value
              if (is_array($term['property_value']))
              {


                foreach ($term['property_value'] as $v)
                {

                  $property_value = $v;

                  if (!empty($v))
                  {
                    $v = preg_replace('/\[]|"|xsd:string|\\\n/', '', $v);
                    $v_cleaned = $v;
                    $v_cleaned = preg_replace('*ArrayExpress:label|EFO:URI|IAO:0000117|source:definition|organizational:class|definition:citation|bioportal:provenance|branch:class|IAO:0000412|http://www.ebi.ac.uk/efo/MSH_definition_citation MSH:|http://www.ebi.ac.uk/efo/NCI_Thesaurus_definition_citation NCIt:|http://www.ebi.ac.uk/efo/Patent_definition_citation|http://www.ebi.ac.uk/efo/SNOMEDCT_definition_citation SNOMEDCT:|http://www.ebi.ac.uk/efo/BFO_definition_citation BFO:|http://www.ebi.ac.uk/efo/obsoleted_in_version|http://www.ebi.ac.uk/efo/UBERON_definition_citation UBERON:|http://www.ebi.ac.uk/efo/reason_for_obsolescence|IAO:0000112*','', $v_cleaned);
                    $sql = $db->prepare("INSERT INTO efo_property_value(id, property_value, property_value_cleaned)
                                        VALUES(?,?,?)");
                    $sql->bind_param("sss", $id, $v, $v_cleaned);
                    $sql->execute();
                    $sql->close();
                  }
                }

              }
              else
              {
                $property_value = $term['property_value'];

                if (!empty($property_value))
                {
                  // Check for property in property taable and insert if we don't have it.
                  $sql = "select property_id from efo_property where" ;
                  $property_value = preg_replace('/\[]|"|xsd:string|\\\n/', '', $property_value);

                  $property_value_cleaned = $property_value;
                  $property_value_cleaned = preg_replace('*ArrayExpress:label|EFO:URI|IAO:0000117|source:definition|organizational:class|definition:citation|bioportal:provenance|branch:class|IAO:0000412|http://www.ebi.ac.uk/efo/MSH_definition_citation MSH:|http://www.ebi.ac.uk/efo/NCI_Thesaurus_definition_citation NCIt:|http://www.ebi.ac.uk/efo/Patent_definition_citation|http://www.ebi.ac.uk/efo/SNOMEDCT_definition_citation SNOMEDCT:|http://www.ebi.ac.uk/efo/BFO_definition_citation BFO:|http://www.ebi.ac.uk/efo/obsoleted_in_version|http://www.ebi.ac.uk/efo/UBERON_definition_citation UBERON:|http://www.ebi.ac.uk/efo/reason_for_obsolescence|IAO:0000112*','', $property_value_cleaned);

                  $sql = $db->prepare("INSERT INTO efo_property_value(id, property_value, property_value_cleaned)
                                      VALUES(?,?,?)");
                  $sql->bind_param("sss", $id, $property_value, $property_value_cleaned);
                  $sql->execute();
                  $sql->close();
                }
              }

              //def
              if (is_array($term['def']))
              {


                foreach ($term['def'] as $v)
                {

                  $def = $v;
                  if (!empty($v))
                 {
                    $v = preg_replace('/\[]|"|\\\n/', '', $v);
                    $sql = $db->prepare("INSERT INTO efo_def(id, def)
                                        VALUES(?,?)");
                    $sql->bind_param("ss", $id, $v);
                    $sql->execute();
                    $sql->close();
                  }
                 }

              }
              else
              {
                $def = $term['def'];
                if (!empty($def))
                {
                  $def = preg_replace('/\[]|"|\\\n/', '', $def);
                  $sql = $db->prepare("INSERT INTO efo_def(id, def)
                                      VALUES(?,?)");
                  $sql->bind_param("ss", $id, $def);
                  $sql->execute();
                  $sql->close();
                }
              }

              //synonym
              if (is_array($term['synonym']))
              {


                foreach ($term['synonym'] as $v)
                {

                  $synonym = $v;
                  if (!empty($v))
                 {
                   $synonym_type = strstr($v, 'EXACT')?'EXACT':(strstr($v,'RELATED')?'RELATED':'');
                    $v = preg_replace('/\[]|"|\\\n|EXACT|RELATED/', '', $v);
                    $sql = $db->prepare("INSERT INTO efo_synonym(id, synonym, synonym_type)
                                        VALUES(?,?,?)");
                    $sql->bind_param("sss", $id, $v, $synonym_type);
                    $sql->execute();
                    $sql->close();
                  }
                }

              }
              else
              {
                $synonym = $term['synonym'];
                if (!empty($synonym))
                {
                  $synonym_type = strstr($synonym, 'EXACT')?'EXACT':(strstr($synonym,'RELATED')?'RELATED':'');
                  $synonym = preg_replace('/\[]|"|\\\n|EXACT|RELATED/', '', $synonym);

                  $sql = $db->prepare("INSERT INTO efo_synonym(id, synonym, synonym_type)
                                      VALUES(?,?,?)");
                  $sql->bind_param("sss", $id, $synonym, $synonym_type);
                  $sql->execute();
                  $sql->close();
                }
              }

              //is_a
              if (is_array($term['is_a']))
              {
                foreach ($term['is_a'] as $v)
                {

                  $is_a = $v;
                  list($is_a_value, $is_a_desc) = explode("!", $is_a);
                   if(!empty($v))
                  {

                      $sql = $db->prepare("INSERT INTO efo_is_a(id, is_a_value, is_a_description)
                                          VALUES(?,?,?)");
                      $sql->bind_param("sss", $id, $is_a_value, $is_a_desc);
                      $sql->execute();
                      $sql->close();
                   }
                  }

              }
              else
              {
                $is_a = $term['is_a'];
                $is_a = explode("!", $is_a);

                if (!empty($is_a[0]))
                {
                  if (!empty($is_a[1])) { $is_a_desc = $is_a[1];} else {$is_a_desc = '';}

                  $sql = $db->prepare("INSERT INTO efo_is_a(id, is_a_value, is_a_description)
                                      VALUES(?,?,?)");
                  $sql->bind_param("sss", $id, $is_a[0], $is_a_desc);
                  $sql->execute();
                  $sql->close();
                }
              }

              //relationship
              if (is_array($term['relationship']))
              {


                foreach ($term['relationship'] as $v)
                {

                  $relationship = $v;

                  if (strstr($relationship, '!'))
                  {
                    list($relationship,$relationship_description) = explode("!", $relationship);
                  }
                  $relationship = preg_split( '/(\s|:)/', $relationship);
                  if (!empty($v))
                  {
                    $sql = $db->prepare("INSERT INTO efo_relationship(id, rtype, relationship_ont_name, relationship_ont_value, relationship_description)
                                          VALUES(?,?,?,?,?)");
                    $sql->bind_param("sssss", $id, $relationship[0], $relationship[1], $relationship[2], $relationship_description);
                    $sql->execute();
                    $sql->close();
                  }
                }

              }
              else
              {
                $relationship = $term['relationship'];

                if (strstr($relationship, '!'))
                {
                  list($relationship,$relationship_description) = explode("!", $relationship);
                }

                $relationship = preg_split('/(\s|:)/', $relationship);
                if (!empty($relationship[0]))
                {
                  $sql = $db->prepare("INSERT INTO efo_relationship(id, rtype, relationship_ont_name, relationship_ont_value, relationship_description)
                                        VALUES(?,?,?,?,?)");
                  $sql->bind_param("sssss", $id, $relationship[0], $relationship[1], $relationship[2], $relationship_description);
                  $sql->execute();
                  $sql->close();

                }
              }


            //efo
            // prepare and bind
             $ont_id = preg_split('/:/', $id);
             $ont_id = $ont_id[1];
              $sql = $db->prepare("INSERT INTO efo (id, ont_id, name, namespace, equivalent_to, is_obsolete, created_by, creation_date)
                            VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
              $sql->bind_param("ssssssss", $id, $ont_id, $name, $namespace, $equivalent_to, $is_obsolete, $created_by, $creation_date);
              $sql->execute();
              $sql->close();

              // If the query executed properly proceed

            //  if($result)
              //{
                //echo "parsing and dump to database successful";
              //}
            //  else
            //  {
                  //echo $db -> error();

            //  }


            }
            echo "Writing to db successful!<br>";


            //update efo_property_value table
            $sql11 = "UPDATE efo_property_value e
                      JOIN efo_property ep ON e.property_value LIKE CONCAT(ep.name,'%')
                      SET e.property_id=ep.id";
           $result11 = $db -> query($sql11);


           echo "Updating db successful!";

}



}
?>
