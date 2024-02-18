<?php

$canonical = <<<HEREDOC
http://www.palgle.com/2006/12/07/adsense-vs-adclix/
HEREDOC;

$canonical = preg_replace('/https?:\/\/[^\/]+\//', '', $canonical);
$canonical = preg_replace('/\/$/', '', $canonical);

$cano = preg_replace('/([0-9]{2})\/([0-9]{2})\/([^\/]+)\//', "\\1-\\2-\\3-\\4", $canonical);

if($canonical == $cano) {
    $cano = preg_replace('/.+?([^\/]+)\/([0-9]{4})\/([0-9]{2})\/([0-9]{2})\//', "\\2-\\3-\\4-\\1", $canonical);
    $filename = preg_replace('/_/', '-', $cano);
    echo $filename.'.markdown'.PHP_EOL;
    echo '{% post_url '.$filename.' %}';
} else {
    $filename = preg_replace('/_/', '-', $cano);
    echo $filename.'.markdown'.PHP_EOL;
    echo '{% post_url '.$filename.' %}';
}

