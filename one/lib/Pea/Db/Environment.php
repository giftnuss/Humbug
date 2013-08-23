<?php

namespace Pea\Db;

use Pea\Seed;

interface Environment
{
    public function getName();

    public function initialize( Seed $start = null );

    public function addDb( $name, $config );

    public function getDb( $name = null );
}
