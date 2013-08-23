<?php

namespace Zxd;

use ReflectionClass;

class Module
{
    protected function _moduleDir()
    {
        $class = get_class($this);
        $rc = new ReflectionClass($class);
        return dirname($rc->getFileName());
    }

    public function getConfig()
    {
        return include $this->_moduleDir() . '/config/module.config.php';
    }

    public function getAutoloaderConfig()
    {
        $path = explode('\\',get_class($this));
        $ns = $path[0];
        return array(
            'Zend\Loader\StandardAutoloader' => array(
                'namespaces' => array(
                     $ns => $this->_moduleDir() . '/src/' . $ns
                ),
            ),
        );
    }
}
