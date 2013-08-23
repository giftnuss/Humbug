<?php

require __DIR__ . '/test-setup.php';

$schema = new Pea\Db\Schema;

// build anonymous types over the type property
isa_ok($schema->type->blob,'Pea\Db\DataType\Blob');
isa_ok($schema->type->boolean,'Pea\Db\DataType\Boolean');
isa_ok($schema->type->float,'Pea\Db\DataType\Float');
isa_ok($schema->type->integer,'Pea\Db\DataType\Integer');
isa_ok($schema->type->varchar,'Pea\Db\DataType\Varchar');
