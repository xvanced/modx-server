<?php

require_once '/var/www/html/config.core.php';
require_once MODX_CORE_PATH . 'model/modx/modx.class.php';

$modx = new modX();
$modx->initialize('mgr');
$modx->getService('error', 'error.modError', '', '');

$modx->getCacheManager()->delete('clientconfig', array(xPDO::OPT_CACHE_KEY => 'system_settings'));
if ($modx->getOption('clientconfig.clear_cache', null, true)) {
    $modx->getCacheManager()->delete('', array(xPDO::OPT_CACHE_KEY => 'resource'));
    echo 'Deleted ClientConfig Cache' . PHP_EOL;
}

echo 'Refreshing MODX-Cache' . PHP_EOL;
$modx->cacheManager->refresh();

return true;