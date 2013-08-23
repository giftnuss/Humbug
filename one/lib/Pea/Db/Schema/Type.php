<?php

namespace Pea\Db\Schema;

class Type
{
    protected $schema;
    protected $name;
    protected $ddl;

    public function __construct($schema, $name)
    {
        $this->schema = $schema;
        $this->name = $name;
    }

    public function __get($attr)
    {
        if($class = $this->schema->getTypeClass($attr)) {
            $this->ddl = new $class();
            return $this;
        }
        throw new \Exception("Unknown Typeclass $attr");
    }
}
