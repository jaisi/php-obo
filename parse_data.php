<?php

require_once 'vendor/autoload.php';

use PhpObo\LineReader,
    PhpObo\Parser;
include 'dataprocessor.php';
include 'datareader.php';
include 'obodatareader.php';
include 'datawriter.php';
include 'dbdatawriter.php';
include 'csvdatawriter.php';

$w = isset($_GET['write_mode']) ? ($_GET['write_mode']) : 'db';
$r = isset($_GET['read_mode']) ? ($_GET['read_mode']) : 'obo';

$dataprocessor = new Processor($w, $r);
$dataprocessor->process();


?>
