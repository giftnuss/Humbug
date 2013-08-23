<?php

namespace Pea\Db;

use Pea\Db\Schema\ColumnFactory;
use Pea\Db\Schema\Table;
use Pea\Db\Schema\TypeFactory;
use Pea\Db\Schema\TypeContainer;
//use Pea\Db\Schema\Raise\UnknownTypeClass;

class Schema
{
    protected $name;
    protected $typeFactory;
    
    protected $namedTypes = array();
    protected $tables = array();

    public function __construct($name = '')
    {
        $this->name = $name;
        $this->type = new TypeContainer($this,'');
        $this->typeFactory = new TypeFactory();
    }
    
    public $type;

    public function type($name = '')
    {
        $name = strtolower($name);
        if(isset($this->namedTypes[$name])) {
            return $this->namedTypes[$name];
        }
        $type = new TypeContainer($this,$name);
        $this->namedTypes[$name] = $type;
        return $type;
    }

    public function getTypeClass($name)
    {
        return $this->typeFactory->getClass($name);
    }
    
    public function getType($name)
    {
        if(isset($this->namedTypes[$name])) {
            return $this->namedTypes[$name]->getType();
        }
        return $this->type->$name;
    }
    
    /**
     * This method is for constructing a table, thatswhy it
     * @returns ColumnFactory
     */ 
    public function table($name)
    {
        if(isset($this->tables[$name])) {
            $table = $this->tables[$name];
        }
        else {
            $table = $this->tables[$name] = new Table($this,$name);
        }
        return new ColumnFactory($table);
    }
    
    public function getTables()
    {
        return $this->tables;
    }
    
    public function getTable($name)
    {
        return $this->tables[$name];
    }
}
