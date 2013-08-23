<?php

namespace Pea;

use Pea\Seed;

abstract class Service
{
    protected $_seed;
    
    protected abstract function _getDefaultSeed();
    
    public function getSeed()
    {
        if(empty($this->_seed)) {
            $this->_seed = $this->_getDefaultSeed();
        }
        return $this->_seed;
    }
    
    public function setSeed( Seed $seed )
    {
        $this->_seed = $seed;
        return $this;
    }
}
