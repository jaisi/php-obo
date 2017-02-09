<?php

namespace datawriter;

class CSVDataWriter implements DataWriter
{
  //to do
          public function writeData($allTerms)
          {
            $fp = fopen("test.csv","w") or die('Unable to open file!'); // file pointer
            foreach($allTerms as $term)
            {
                foreach($term as $key => $value)
                {
                    if(is_array($value))
                    {
                      //echo "i am here";

                      fputcsv($fp, $value, ',', '"');



                    }
                    else
                    {
                      echo "hey this is not an array??";
                    }
                 }

                //  echo "i am here";

              }
              fclose($fp);
            }
}

?>
