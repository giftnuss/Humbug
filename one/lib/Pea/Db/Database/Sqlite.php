<?php

namespace Pea\Db\Database;

use Pea\Db\Database\ZendDatabase;

class Sqlite extends ZendDatabase
{
    public function getName()
	{
        $config = $this->getConfig();
        return $config['database'];        
    }
    
    protected function _getDbName()
    {
	    return Project::home() . "/" . $this->getName();	
	}

    public function create()
    {
		return $this;
	}
	
    public function drop()
    {
		if(file_exists($this->_getDbName())) {
			unlink($this->_getDbName());
		}
		return $this;
	}
}
