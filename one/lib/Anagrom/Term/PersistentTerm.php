<?php

namespace Anagrom\Term;

use Anagrom\Term;

class PersistentTerm extends BaseTerm implements Term
{
    protected $storage;

    public function setStorage($storage)
    {
        $this->storage = $storage;
        return $this;
    }
    
}
