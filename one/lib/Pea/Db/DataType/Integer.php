<?php

namespace Pea\Db\DataType;

use Zend\Db\Sql\Ddl\Column;

class Integer extends Base
{
    protected $size = 11;

    public function getDdlColumn($name)
    {
        return new Column\Integer(
            $name,
            $this->nullable(),
            $this->default(),
            array(
                'size' => $this->size()
            )
        );
    }
}
