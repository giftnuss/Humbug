<?php

namespace Pea\Factory;

use Pea\Factory;

class ClassMapFactory implements Factory
{    
    protected $classMap = array();
    protected $aliasMap = array();

    public function __construct()
    {
        $this->_initClassMap();
        $this->_initAliasMap();
    }
    
    public function registerClass($code,$class)
    {
        $this->classMap[$code] = $class;
        return $this;
    }
    
    public function registerAlias($alias,$code)
    {
        $this->aliasMap[$alias] = $code;
        return $this;
    }
    
    public function getClass($name)
    {
        if(isset($this->aliasMap[$name])) {
            $name = $this->aliasMap[$name];
        }
        return $this->classMap[$name];
    }

    protected function _initClassMap()
    {
        
    }
    
    protected function _initAliasMap()
    {
    
    }
 
}
