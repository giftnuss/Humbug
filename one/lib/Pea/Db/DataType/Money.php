<?php

namespace Pea\Db\DataType;

use Zend\Db\Sql\Ddl\Column;

class Money extends Decimal
{
    protected $size = 18;

}
