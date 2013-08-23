<?php

// Composer autoloading
if (file_exists('vendor/autoload.php')) {
    $loader = include 'vendor/autoload.php';
}

$zf2Path = false;

if (is_dir('vendor/ZF2/library')) {
    $zf2Path = 'vendor/ZF2/library';
}
elseif (getenv('ZF2_PATH')) {
    $zf2Path = getenv('ZF2_PATH');
}
elseif (get_cfg_var('zf2_path')) {
    $zf2Path = get_cfg_var('zf2_path');
}

if ($zf2Path) {
    if (isset($loader)) {
        $loader->add('Zend', $zf2Path);
    }
    else {
        include $zf2Path . '/Zend/Loader/AutoloaderFactory.php';
        Zend\Loader\AutoloaderFactory::factory(array(
            'Zend\Loader\StandardAutoloader' => array(
                'autoregister_zf' => true
            )
        ));
        $loader = Zend\Loader\AutoloaderFactory::getRegisteredAutoloader(
           'Zend\Loader\StandardAutoloader'
        );
    }
}

if (!class_exists('Zend\Loader\AutoloaderFactory')) {
    throw new RuntimeException('Unable to load ZF2. Run `php composer.phar install` or define a ZF2_PATH environment variable.');
}

$libPath = __DIR__ . '/lib';
$method = method_exists($loader,'registerNamespace') ?
    'registerNamespace' : 'add';

$loader->$method('Kimbo',"$libPath/Kimbo");
$loader->$method('Zxd',"$libPath/Zxd");
$loader->$method('Pea',"$libPath/Pea");
$loader->$method('Sknpp', __DIR__ . '/vendor/Sknpp/src/Sknpp');
$loader->$method('Anagrom', "$libPath/Anagrom");
