<?php

namespace Planet;

use Zend\ModuleManager\Feature;
use Pea\Module\Base;

Base::register(__NAMESPACE__,__DIR__,2);

class Module extends Base
implements
    Feature\ServiceProviderInterface
{
    public function getServiceConfig()
    {
        return array(
            'factories' => array(
                'Planet' => Builder::build()
            )
        );
    }
}
