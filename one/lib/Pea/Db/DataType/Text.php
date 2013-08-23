<?php

namespace Pea\Db\DataType;

use Zend\Db\Sql\Ddl\Column;

class Text extends Char
{
    protected $size = 65535;
}
