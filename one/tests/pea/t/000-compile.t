<?php

require __DIR__ . '/test-setup.php';

foreach(array(
    'Pea\Factory\ClassMapFactory',
    'Pea\Db',
    'Pea\Db\Schema',
    'Pea\Project',
    'Pea\Service',
) as $class) { use_class($class); }

foreach(array(
    'Pea\Factory',
    'Pea\Seed'
) as $interface) { use_interface($interface); }
