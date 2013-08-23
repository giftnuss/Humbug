<?php

namespace Planet\Seed;

use Pea\Project;
use Pea\Seed as SeedInterface;

class Simple implements SeedInterface
{
   public function getConfig()
   {
		$file = Project::home() . "/config/" . 
            Project::cwe() . "-planet.php";
		return include($file);
   }
}
