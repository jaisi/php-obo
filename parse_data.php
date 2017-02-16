<?php

require_once 'vendor/autoload.php';

use PhpObo\LineReader,
    PhpObo\Parser;

include 'datareader.php';
include 'obodatareader.php';
include 'datawriter.php';
include 'dbdatawriter.php';
include 'csvdatawriter.php';

$w = isset($_GET['write_mode']) ? ($_GET['write_mode']) : 'db';
$r = isset($_GET['read_mode']) ? ($_GET['read_mode']) : 'obo';

$dataprocessor = new Processor($w, $r);

class Processor
{

  function __construct($w,$r)
  {
      //echo "i am here";
      $this->write_mode = $w;
      $this->read_mode = $r;

      echo "write mode is ".$this->write_mode."<br>";
      echo "read mode is ".$this->read_mode."<br>";

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
