<?php

namespace Pea;

use Pea\Project\ProjectInterface;

class Project implements ProjectInterface
{
	private static $_instance;

	protected $_home;

	protected $_cwe = 'development';

	public static function instance( ProjectInterface $instance = null)
	{
        if($instance) {
            self::$_instance = $instance;
        }
		elseif(empty(self::$_instance)) {
			self::$_instance = new self();
		}
		return self::$_instance;
	}

    public static function home()
    {
        return self::instance()->getHome();
    }

    public static function cwe()
    {
		return self::instance()->getCwe();
	}

    public function getHome()
    {
		if(empty($this->_home)) {
			$this->_detectHome();
		}
		return $this->_home;
	}
    
    public function setHome($dir)
    {
        $this->_home = $dir;
        return $this;
    }

	public function getCwe()
	{
		return $this->_cwe;
	}

	public function setCwe($cwe)
	{
		$this->_cwe = $cwe;
		return $this;
	}

	protected function _detectHome()
	{
		$try = getcwd();
		if(file_exists("$try/init_autoloader.php")) {
			$this->_home = $try;
			return;
		}
		$try = dirname(__DIR__);
		foreach(range(1,3) as $idx) {
			$try = dirname($try);
			if(file_exists("$try/init_autoloader.php")) {
			    $this->_home = $try;
			    return;
		    }
		}
		$this->_home = getcwd();
	}
}
