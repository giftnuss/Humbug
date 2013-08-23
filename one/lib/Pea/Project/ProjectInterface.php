<?php

namespace Pea\Project;

interface ProjectInterface
{
    public function getHome();
    
    public function getCwe();
    
    public function setCwe($cwe);
}
