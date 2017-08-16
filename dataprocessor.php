<?php

class Processor
{

      function __construct($w,$r)
      {
          //echo "i am here";
          $this->write_mode = $w;
          $this->read_mode = $r;

          echo "write mode is ".$this->write_mode."<br>";
          echo "read mode is ".$this->read_mode."<br>";
      }

      public function process()
      {

          if ($this->read_mode == 'obo')
          {
            $datareader = new OboDataReader();
            $allTerms = $datareader->readData();
          }

          if ($this->write_mode == 'db')
          {
            //  echo "i am here";
             $datawriter = new datawriter\DBDataWriter($allTerms);
             $conn = $datawriter -> connectDb();
             $datawriter -> createDb($conn);
             $datawriter -> writeData($allTerms);


          }
          else
          {
            //echo "i am here now";
            $datawriter = new datawriter\CSVDataWriter($allTerms);
            $datawriter -> writeData($allTerms);
          }
        }

    }
    ?>
