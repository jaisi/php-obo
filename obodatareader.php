<?php

use PhpObo\LineReader,
    PhpObo\Parser;
    
class OboDataReader implements DataReader
{
  public function readData()
  {
      $start = microtime(true);

      //read in obo file
      $handle = fopen('efo.obo','r');
      $lineReader = new LineReader($handle);

      //parse file
      $parser = new Parser($lineReader);
      $parser->retainTrailingComments(true);
      $parser->getDocument()->mergeStanzas(false); //speed tip
      $parser->parse();

      //loop through Term stanzas to find all terms
      $allTerms = array_filter($parser->getDocument()->getStanzas('Term'), function($stanza) {
          return (isset($stanza['id']));
      });


      echo (microtime(true) - $start), ' seconds and ', memory_get_peak_usage(true),
           ' bytes memory taken to complete.', PHP_EOL, PHP_EOL;
      return $allTerms;
  }
}

?>
