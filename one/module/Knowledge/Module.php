<?php

namespace Knowledge;

use Zend\Mvc\ModuleRouteListener;
use Zend\Mvc\MvcEvent;

use Pea\Module\Base;

Base::register(__NAMESPACE__,__DIR__);

class Module extends \Pea\Module
{
    public function onBootstrap(MvcEvent $e)
    {
        $e->getApplication()->getServiceManager()->get('translator');
        $eventManager        = $e->getApplication()->getEventManager();
        $moduleRouteListener = new ModuleRouteListener();
        $moduleRouteListener->attach($eventManager);
    }
}
