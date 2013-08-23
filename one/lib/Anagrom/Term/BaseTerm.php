<?php

namespace Anagrom\Term;

abstract class BaseTerm
{
    protected $word;
    protected $identifier;
    protected $description;
    
    public function getWord()
    {
        return $this->word;
    }
    
    public function getIdentifier()
    {
        return $this->identifier;
    }

    public function getDescription()
    {
        return $this->description;
    }
    
    
}
