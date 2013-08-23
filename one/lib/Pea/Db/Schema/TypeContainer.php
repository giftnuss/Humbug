<?php

namespace Pea\Db\Schema;

class TypeContainer
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
            return $this->ddl;
        }
        throw new \Exception("Unknown Typeclass $attr");
    }
    
    public function getType()
    {
        return $this->ddl;
    }
}
