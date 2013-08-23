<?php

namespace Pea\Db\Define;

use Zend\Db\Metadata\Object\TableObject;
use Zend\Db\Metadata\Object\ColumnObject;

class Table
{
    protected $_tableObject;

    protected $_currentColumn;

    public function __construct($name)
    {
        $this->_tableObject = new TableObject($name);
    }
    
    public function getTableObject()
    {
		return $this->_tableObject;
	}

    public function column($name,$type,$size,$options = array())
    {
        $column = new ColumnObject($name,$this->_tableObject->getName());
        $column->setDataType(strtoupper($type));
        $this->_currentColumn = $column;
        $this->_addColumn();
        $this->_specifyColumn($size,$options);
        return $this;
    }

    public function seq()
    {
        return $this;
    }

    public function pk()
    {
        return $this;
    }

    protected function _addColumn()
    {
        $columns = $this->_tableObject->getColumns();
        $position = count($columns);
        $columns[] = $this->_currentColumn;
        $this->_tableObject->setColumns($columns);
        $this->_currentColumn->setOrdinalPosition($position);
    }

    protected function _specifyColumn($size,$options)
    {
        $datatype = $this->_currentColumn->getDataType();
        switch($datatype) {
            case 'INT':
                break;
            case 'VARCHAR':
                $this->_currentColumn->setCharacterMaximumLength($size);
                break;
            case 'ENUM':
                break;
            default:
                throw \Pea\Raise\NotImplemented(
                    "Datatype $datatype is not supported yet.");
        }
    }
}
