<?php

namespace Pea\Db\DataType;

class Base
{
    protected $nullable = false;
    protected $default = null;
    
    public function __call($name, $args)
    {
        if(property_exists($this,$name)) {
            if($args) {
                $this->$name = $args[0];
                return $this;
            }
            else {
                return $this->$name;
            }
        }
        throw new \Exception("Unknown property $name!");
    }

}
