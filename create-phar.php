<?php

try
{
    $pharPath = "PocketMine-MP.phar";
    if(file_exists($pharPath)){
        @unlink($pharPath);
    }
    $phar = new \Phar($pharPath);
    $phar->setMetadata([
        "name" => "Festival",
        "version" => "1.5dev",
        "creationDate" => time()
    ]);

    $phar->setSignatureAlgorithm(\Phar::SHA1);
    $phar->startBuffering();

    $phar->buildFromDirectory(__DIR__ . '/server');

    $phar->setStub('<?php require("phar://". __FILE__ ."/src/pocketmine/PocketMine.php"); __HALT_COMPILER(); ?>');

    $phar->stopBuffering();

    $phar->compressFiles(Phar::GZ);

    chmod(__DIR__ . "/{$pharPath}", 0770);

    echo "$pharPath successfully created" . PHP_EOL;

    return true;
}
catch (Exception $e)
{
    echo $e->getMessage();
}
