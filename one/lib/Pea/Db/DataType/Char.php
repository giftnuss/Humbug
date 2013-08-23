<?php

namespace Pea\Db\DataType;

use Zend\Db\Sql\Ddl\Column;

class Char extends Base
{
    protected $size;

    public function getDdlColumn($name)
    {
        $column = new Column\Char( $name, $this->size() );
        $column->setNullable($this->nullable());
        $column->setDefault($this->default());
        return $column;
    }
}
