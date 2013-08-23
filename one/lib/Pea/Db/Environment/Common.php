<?php

namespace Pea\Db\Environment;

use Pea\Project;
use Pea\Seed;
use Pea\Db;
use Pea\Db\Adapter;
use Pea\Db\Environment;

class Common implements Environment
{
	protected $_name;

	protected $_adapters;

	protected $_defaultAdapter;

    public function __construct($name = '')
    {
		if(Db::isEnvironment($name)) {
			throw new \Pea\Raise\Mistake(
			    "There is already a db environment with name '$name'."
			);
		}
		$this->_name = $name;
	}

	public function initialize( Seed $start = null )
	{
	    if($start === null) {
			$start = $this->_getDefaultStarter();
		}
		foreach($start->getConfig() as $name => $config) {
		    $this->addDb($name,$config);
		}
	}

	public function getName()
	{
		return $this->_name;
	}

	public function addDb($name,$config)
	{
		if(isset($this->_adapters[$name])) {
			throw \Pea\Raise\Mistake(
			    "Adapter '$name' already exists in the environment."
			);
		}
		if(isset($config['default'])) {
			if($config['default']) {
				if(isset($this->_defaultAdapter)) {
					throw new \Pea\Raise\Mistake(
					    "Only one default adapter allowed.");
				}
				$this->_defaultAdapter = $name;
			}
			unset($config['default']);
		}
		$this->_adapters[$name] = $this->loadDb($config);
	}

    public function getDb($name = null)
    {
        if($name === null) {
            $name = $this->_defaultAdapter;
        }
        if(empty($this->_adapters[$name])) {
            throw \Pea\Raise\Mistake("Adapter '$name' not found.");
        }
        return $this->_adapters[$name];
    }

	public function loadDb($config)
	{
		$drivername = $config['driver'];
		switch(strtolower($drivername)) {
			case 'pdo_sqlite':
			    $config['database'] = Project::home() . "/" .
			        $config['database'];
			    break;
	    } 
		return new Adapter($config);
	}

    protected function _getDefaultStarter()
    {
	    return new \Pea\Db\Starter\IniStart();
	}
}
