<?php

namespace Pea\Db;

use Exception;
use Zend\Db\TableGateway\TableGateway;
use Pea\Raise\Db\UnknownTable;

class Adapter extends \Zend\Db\Adapter\Adapter
{
	protected $_database;
	
	public function table($name)
	{
		try {
		    $table = new TableGateway($name,$this);
            $table->delete('1 = 0');
		}
		catch(Exception $exp) {
	        throw new UnknownTable("Table '$name' is unknown.");
	    }	
        return $table;
	}
	
	public function getDatabase()
	{
		if(empty($this->_database)) {
		    $conn = $this->getDriver()->getConnection();
		    $drivername = $conn->getDriverName();
		
		    $class = "\\Pea\\Db\\Database\\" . ucfirst($drivername);
		    $this->_database = new $class($this);
		}
		return $this->_database;
	}

}
