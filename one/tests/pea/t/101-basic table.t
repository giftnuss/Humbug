<?php

require __DIR__ . '/test-setup.php';

$schema = new Pea\Db\Schema;

$idtype = $schema->type('id')->int->size(14);

$schema->table('id')
    ->column->id('id')
    ->constraint->pk('id');
 
$idtable = $schema->getTable('id');

is($idtable->getName(),'id','getName method');

