<?php

namespace datawriter;


class DBDataWriter implements DataWriter
{
      public function connectDb()
      {
        $config = parse_ini_file('./config.ini');
        $db = new \mysqli($config['server'], $config['username'],$config['password'],$config['dbname']);
        echo(print_r($config,1));

        // Check connection
        if ($db->connect_error) {
            die("Connection failed: " . $db->connect_error);
        }
        return $db;
      }

      public function createDb($db)
      {
        //echo "i am here";
        $query = file_get_contents("create_db.sql");

          if ($db->multi_query($query)) {
              do {
                  /* store first result set */
                  if ($result = $db->store_result()) {
                      while ($row = $result->fetch_row()) {
                          printf("%s\n", $row[0]);
                      }
                      $result->close();
                  }
                  /* print divider */
                  if ($db->more_results()) {
                      printf("-----------------\n");
                  }
              } while ($db->next_result());
          }

          /* close connection */
          $db->close();



      }

      public function findInsertProperty($db, $id, $p, $prop_name, $prop_value)
      {
                $sql = $db->prepare("select name from efo_property where name = ?");

                 $sql->bind_param("s", $prop_name);
                 $sql->execute();
                 $sql->store_result();
                 $numrows = $sql->num_rows;

                 $sql->close();

                 if ($numrows == 0 && $prop_name != '' && $prop_value != '')
                 {
                   $sql = $db->prepare("INSERT INTO efo_property (name,example)
                                       VALUES(?,?)");
                   $sql->bind_param("ss", $prop_name, $prop_value);
                   $sql->execute();
                   $sql->close();
                 }
                 $sql = $db->prepare("INSERT INTO efo_property_value(id, property_value, property_value_cleaned)
                                     VALUES(?,?,?)");
                 $sql->bind_param("sss", $id, $p, $prop_value);
                 $sql->execute();
                 $sql->close();
      }

      public function findInsertDef($db,$id,$def)
      {
        $sql = $db->prepare("INSERT INTO efo_def(id, def)
                            VALUES(?,?)");
        $sql->bind_param("ss", $id, $def);
        $sql->execute();
        $sql->close();
      }

      public function findInsertSynonym($db,$id,$synonym,$synonym_type)
      {
        $sql = $db->prepare("INSERT INTO efo_synonym(id, synonym, synonym_type)
                            VALUES(?,?,?)");
        $sql->bind_param("sss", $id, $synonym, $synonym_type);
        $sql->execute();
        $sql->close();
      }

      public function writeData($allTerms)
      {
          //create connection
          $db = $this->connectDb();


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

                //var_dump($term);
                //insert values into the efo_property and efo_property_value table
                if (is_array($term['property_value']))
                {

                foreach ($term['property_value'] as $p)
                {
                  $property_value = $p;

                  if (!empty($p))
                  {
                  $matches = [];
                  $pname = [];
                  $prop_name = '';
                  $prop_value = '';


                  if (preg_match('/^(http:.*?)\s(.*?) xsd:string/', $p, $matches)) {
                  //  echo "<h3> Http Property Property Name Matches </h3>";
                    $prop_name = $matches[1];
                    $prop_value = $matches[2];
                  // echo "<h3> Derived Name: $prop_name Value: $prop_value  </h3>";

                  }
                  // Quoted Property Value format of property string ,  Property name is beginning of string to first ". Value is in ""
                  else if (preg_match('/^(.*?)\s?"(.*?)" xsd:string/', $p, $matches)) {

                    $prop_name = $matches[1];
                    $prop_value = $matches[2];
                //  echo "<h3> Quoted Property matches $p Name: $prop_name Value: $prop_value  </h3>";

                  /*  if (preg_match('/(".*?")/', $p, $matches)) {
                      echo "<h3> Value Matches  </h3>";
                      var_dump($matches);
                    }
                    */
                  }
                  //echo "<h1> Property  $p </h1>";
                  // This is an http string property
                  else if (preg_match('/(EFO:URI http:.*?)EFO_(.*?) xsd:string/', $p, $matches)) {
                   $prop_name = $matches[1];
                    $prop_value = 'EFO:'.$matches[2];
                  //EFO
                }

                  else if (preg_match('/^(.*?)\s(.*?)\s(.*?)/', $p, $matches)) {
                   $prop_name = $matches[1];
                    $prop_value = $matches[2];
                  //   echo "<h3> $p </h3> <h3> General Rule caught it Derived Name: $prop_name Value: $prop_value  </h3>";

                  }

                  else {
                    echo "<h3 style='color:red;'> Property Not derived . Handle this property type $p</h3>";
                  //  echo("<h3> Property Value $p </h3>");
                  }

                  // Insert prop name and get id in database if it doesn't exist.
                 $this->findInsertProperty($db, $id, $p, $prop_name, $prop_value);

                }
              }
              //continue;
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
                    $this->findInsertDef($db,$id,$v);

                  }
                 }

              }
              else
              {
                $def = $term['def'];
                if (!empty($def))
                {
                  $def = preg_replace('/\[]|"|\\\n/', '', $def);
                  $this->findInsertDef($db,$id,$def);
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
                    $this->findInsertSynonym($db,$id,$v,$synonym_type);
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
                  $this->findInsertSynonym($db,$id,$synonym,$synonym_type);

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
