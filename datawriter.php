<?php

namespace datawriter;

interface DataWriter
{
    function connectDb();
    function writeData($a);
    function findInsertProperty($db,$a,$b,$c,$d);


}



?>
