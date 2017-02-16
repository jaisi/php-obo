<?php

namespace datawriter;

class CSVDataWriter implements DataWriter
{
  //to do
          public function findInsertProperty($db,$a,$b,$c,$d)
          {}

          public function connectDb()
          {}

          public function writeData($allTerms)
          {
            $fp = fopen("test.csv","w") or die('Unable to open file!'); // file pointer
            foreach($allTerms as $tkey => $tvalue)
            {
                if (is_array($tvalue))
                {
                  echo "i am here";
                  fputcsv($fp, $tvalue, ',', '"');
                }

                foreach($tvalue as $key => $value)
                {
                    if(is_array($value))
                    {
                      //echo "i am here";

                      fputcsv($fp, $value, ',', '"');



                    }
                    else
                    {
                    //  echo "hey this is not an array??";
                    }
                 }

                //  echo "i am here";

              }
              fclose($fp);
              echo "finished writing to csv file";
            }
}


?>
