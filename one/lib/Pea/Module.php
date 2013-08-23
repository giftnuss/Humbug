<?php

namespace Pea;

use Pea\Module\Base;

Base::register(__NAMESPACE__,__DIR__,2);

class Module
{
    public function getServiceConfig()
    {
        return array(
            'factories' => array(
                'pea.config' => ''
            )
        );
    }

}
