<?php

namespace datawriter;

interface DataWriter
{
    function connectDb();
    function createDb($db);
    function writeData($a);
    function findInsertProperty($db,$a,$b,$c,$d);


}



?>
