<?php

namespace Pea\Db\Schema;

class Column
{
    protected $schema;
    protected $table;
    
    protected $name;
    protected $type;
    
    public function __construct($table)
    {
        $this->table = $table;
        $this->schema = $table->getSchema();
    }
    
    public function getName()
    {
        return $this->name;
    }

    public function setName($name)
    {
        $this->name = $name;
        return $this;
    }
    
    public function getType()
    {
        return $this->type;
    }
    
    public function setType($type)
    {
        $this->type = $type;
        return $this;
    }
    
        
    public function getDdlColumn()
    {
        return $this->getType()->getDdlColumn($this->getName());
    }

}
