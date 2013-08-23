<?php

namespace Pea\Db\Schema;

class AbstractTableFactory
{
    protected $schema;
    protected $table;
    
    public function __construct($table)
    {
        $this->table = $table;
        $this->schema = $table->getSchema();
    }
    
    public function getPlatform()
    {
        return $this->table->getAdapter()->getPlatform();
    }
}
