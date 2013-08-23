<?php

require __DIR__ . '/test-setup.php';

foreach(array(

) as $class) { use_class($class); }

foreach(array(
    'Anagrom\Term'
) as $interface) { use_interface($interface); }
