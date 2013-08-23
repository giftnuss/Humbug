<?php

namespace Pea\Db\Schema;

use Zend\Db\Sql\Ddl\CreateTable;

class Table
{
    protected $schema;
    protected $name;
    protected $columns = array();
    protected $constraints = array();

    public function __construct($schema, $name)
    {
        $this->schema = $schema;
        $this->name = $name;
    }
    
    public function getSchema()
    {
        return $this->schema;
    }
    
    public function getName()
    {
        return $this->name;
    }
    
    public function addColumn($column)
    {
        $name = $column->getName();
        if(isset($this->columns[$name])) {
            throw new \Exception("Column $name is already defined");
        }
        $this->columns[$name] = $column;
        return $this;
    }
    
    public function addConstraint($constraint)
    {
        $this->constraints[] = $constraint;
        return $this;
    }
    
    public function getCreateTable($create = null)
    {
        if($create === null) {
            $create = new CreateTable();
        }
        $create->setTable($this->getName());
        foreach($this->columns as $name => $col) {
            $create->addColumn($col->getDdlColumn());    
        }
        foreach($this->constraints as $constraint) {
            $create->addConstraint($constraint);
        }
        
        return $create;
    }
}
