<?php

namespace Pea\Module;

use Zend\ModuleManager\Feature;

class Base implements 
    Feature\AutoloaderProviderInterface
{
    private static $_ns;

    protected $_configPath = '/config/';

    /**
     * This base class needs to know something about the module.
     */
    public static function register($namespace,$dir,$level = 0)
    {
		while($level > 0) {
		    $dir = dirname($dir);
            $level--;	
		}
        self::$_ns["$namespace\\Module"] = $dir;
    }

    protected function _moduleDir()
    {
        return self::$_ns[get_class($this)];
    }

    protected function _moduleConfig($file)
    {
        return $this->_configPath . $file;
    }

    protected function _getConfig($file)
    {
        return $this->_moduleDir() . $this->_moduleConfig($file);
    }
    
    public function getConfig()
    {
		return include $this->_getConfig('module.config.php');
	}

    public function getAutoloaderConfig()
    {
        $path = explode('\\',get_class($this));
        $ns = $path[0];
        
        $config = array();
        $classmap = $this->_getConfig('autoload_classmap.php');
        if(file_exists($classmap)) {
			$config['Zend\Loader\ClassMapAutoloader'] = array($classmap);
        }
        $config['Zend\Loader\StandardAutoloader'] = array(
            'namespaces' => array(
                 $ns => $this->_moduleDir() . '/src/' . $ns
            )
        );
        return $config;
    }
}
