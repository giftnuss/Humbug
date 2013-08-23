<?php

namespace Pea\Db\DataType;

use Zend\Db\Sql\Ddl\Column;

class Varchar extends Base
{
    protected $size = 64;

    public function getDdlColumn($name)
    {
        $column = new Column\Varchar( $name, $this->size() );
        $column->setNullable($this->nullable());
        $column->setDefault($this->default());
        return $column;
    }
}
