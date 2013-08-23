<?php

namespace Planet;

class Builder
{
    public static function build()
    {
        return function ($sm) {
            $planet = new Planet();
            $config = $sm->get('configuration');
            if(isset($config['planet']['seed'])) {
                $class = $config['planet']['seed'];
                if(is_callable($class)) {
                    $seed = $class($sm);
                }
                else {
                    $seed = $sm->get($class);
                }
                $planet->setSeed($seed);
            }
            return $planet;
        };
    }
}
