<?php

namespace Pea\Db\Schema;

use Pea\Factory\ClassMapFactory;

class TypeFactory extends ClassMapFactory
{
    protected function _initClassMap()
    {
        $this->classMap =
            array('blob' => 'Pea\Db\DataType\Blob',
                  'boolean' => 'Pea\Db\DataType\Boolean',
                  'char' => 'Pea\Db\DataType\Char',
                  'date' => 'Zend\Db\Sql\Ddl\Column\Date',
                  'decimal' => 'Zend\Db\Sql\Ddl\Column\Decimal',
                  'float' => 'Pea\Db\DataType\Float',
                  'integer' => 'Pea\Db\DataType\Integer',
                  'text' => 'Pea\Db\DataType\Text',
                  'time' => 'Zend\Db\Sql\Ddl\Column\Time',
                  'varchar' => 'Pea\Db\DataType\Varchar',
                  );
    }

    protected function _initAliasMap()
    {
        $this->aliasMap =
            array('int' => 'integer',
                  'double' => 'float'
                  );
    }
}
