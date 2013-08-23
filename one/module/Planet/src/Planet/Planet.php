<?php

namespace Planet;

use Pea\Project;
use Pea\Service;

class Planet extends Service
{
    protected $_feeds;

    protected function _getDefaultSeed()
    {
        return new Seed\Simple();
    }
    
    public function getConfig()
    {
        return $this->getSeed()->getConfig();
    }
}
