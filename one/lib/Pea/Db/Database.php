<?php

namespace Pea\Db;

/**
 * A database is usualy a concrete data store.
 */
interface Database
{
    public function getAdapter();

    public function create();
    
    public function drop();
}
