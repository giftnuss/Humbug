<?php

namespace Pea;

use Pea\Seed;
use Pea\Db\Environment;
use Pea\Db\Define\Table as TableDefinition;

use Pea\Raise\Mistake;

class Db
{
    private static $_environments;

    private static $_defaultEnvironment;

    public static function start
        (
            Seed $start = null,
            Environment $env = null
        )
    {
		if(null === $env) {
		    if(isset(self::$_defaultEnvironment)) {
			    $env = self::_defaultEnvironment();
			}
			else {
				$env = new \Pea\Db\Environment\Common();
			}
		}
	    $env->initialize($start);
		self::$_environments[ $env->getName() ] = $env;
		if(empty(self::$_defaultEnvironment)) {
			self::setDefaultEnvironment($env->getName());
		}
	}

	public static function setDefaultEnvironment($name)
	{
		if(empty(self::$_environments[$name])) {
			throw new Mistake("Db environment '$name' is undefined.");
		}
		self::$_defaultEnvironment = $name;
	}

	public static function isEnvironment($name)
	{
		return isset(self::$_environments[$name]);
	}

    public static function adapter($name = null, $envname = null)
    {
        if($envname === null) {
            $env = self::_defaultEnvironment();
            if(empty($env)) {
                throw new Mistake("No default db environment. " .
                     "Maybe you have not perfom \Pea\Db::start().");
            }
        }
        else {
            $env = self::$_environments[$envname];
            if(empty($env)) {
                throw new Mistake("No DB environment with name '$envname'.");
            }
        }
        return $env->getDb($name);
    }

	protected static function _defaultEnvironment()
	{
		return self::$_environments[self::$_defaultEnvironment];
	}

    public static function define($table)
    {
        return new TableDefinition($table);
    }
}
