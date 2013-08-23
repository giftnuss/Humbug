<?php

namespace Pea\Db\Starter;

use Pea\Project;
use Pea\Seed;
use Zend\Config\Reader\Ini;

class IniStart implements Seed
{
    public function getConfig()
    {
		$file = Project::home() . "/config/" . Project::cwe() . "-db.ini";
		$reader = new Ini();
		return $reader->fromFile($file);
	}
}
