<?php

namespace Pea\Db\Schema;

class ColumnFactory extends AbstractTableFactory
{
    public function __get($attr)
    {
        if($attr == 'column') {
            return new self($this->table);
        }
        elseif($attr == 'constraint') {
            return new ConstraintFactory($this->table);
        }
        return null;
    }
    
    public function __call($type,$args)
    {
        if($typeObj = $this->schema->getType($type)) {
            $column = new Column($this->table);
            $column->setName($args[0]);
            $column->setType($typeObj);
            $this->table->addColumn($column);
        }
        return $this;
    }
}
