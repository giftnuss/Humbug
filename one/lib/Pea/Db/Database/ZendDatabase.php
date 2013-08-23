<?php

namespace Pea\Db\Database;

use Zend\Db\Adapter\Adapter;
use Zend\Db\Metadata\Metadata;

use Pea\Db\Database;
use Pea\Db\Sql\CreateTable;

abstract class ZendDatabase implements Database
{
    protected $_adapter;
    protected $_metadata;

    public function __construct(Adapter $adapter)
    {
        $this->_adapter = $adapter;
    }

    public function getAdapter()
    {
	    return $this->_adapter;
	}

	public function getPlatform()
	{
		return $this->getAdapter()->getPlatform();
	}

    public function getConfig()
    {
        $conn = $this->getAdapter()->getDriver()->getConnection();
        return $conn->getConnectionParameters();
    }

    public function getMetadata()
    {
        if(empty($this->_metadata)) {
            $this->_metadata = new Metadata($this->getAdapter());
        }
        return $this->_metadata;
    }

	public function createTable($meta)
	{
		$create = new CreateTable($meta);
		$sql = $create->getSqlString($this->getPlatform());
		echo $sql,"\n";
		$this->getAdapter()->query($sql)->execute();
	    return $this;
	}
}
