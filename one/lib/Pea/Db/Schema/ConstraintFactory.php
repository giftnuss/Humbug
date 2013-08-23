<?php

namespace Pea\Db\Schema;

use Zend\Db\Sql\Ddl\Constraint\PrimaryKey;

use Pea\Db\Sql\Ddl\Constraint\UniqueKey;

class ConstraintFactory extends AbstractTableFactory
{    
    public function __get($attr)
    {
        if($attr == 'column') {
            return new ColumnFactory($this->table);
        }
        elseif($attr == 'constraint') {
            return new self($this->table);   
        }
        return null;
    }
    
    public function pk()
    {
        $columns = func_get_args();
        $pk = new PrimaryKey($columns);
        $this->table->addConstraint($pk);
        return $this;
    }

    public function unique()
    {print_r($this->getPlatform());die();
        $columns = func_get_args();
        $upper = array_map('strtoupper',$columns);
        $name = join('_', $upper) . '_UNIQ';
        $unique = new UniqueKey($columns,$name);
        $this->table->addConstraint($unique);
        return $this;
    }
    
    public function __call($type,$args)
    {
        return $this;
    }
}
