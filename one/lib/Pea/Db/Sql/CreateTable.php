<?php

namespace Pea\Db\Sql;

use Zend\Db\Metadata\Object\TableObject;
use Zend\Db\Sql\SqlInterface;
use Zend\Db\Adapter\Platform\PlatformInterface;

class CreateTable implements SqlInterface
{
	protected $_meta;

	public function __construct(TableObject $meta)
	{
		$this->_meta = $meta;
	}

    public function getSqlString(PlatformInterface $platform = null)
    {
		$meta = $this->_meta;
		$name = $meta->getName();
        $sql = 'CREATE TABLE ' . $platform->quoteIdentifier($name);
        $sql .= " (";
        
        foreach($meta->getColumns() as $column) {
		    $sql .= "\n  " . $platform->quoteIdentifier($column->getName());
		    $sql .= " " . $column->getDataType();
		    if($maxlength = $column->getCharacterMaximumLength()) {
				$sql .= "({$maxlength})";
			} 
		    $sql .= ",";	
		}
		$sql = rtrim($sql,",");
        $sql .= "\n)";
        return $sql;		
	}
}

