<?php

$canonical = <<<HEREDOC
http://blog.repl.net/index.php/gmail_and_encoding/2006/06/19/
HEREDOC;

$canonical = preg_replace('/https?:\/\/[^\/]+\//', '', $canonical);
$canonical = preg_replace('/\/$/', '', $canonical);
$canonical = preg_replace('/index\.php\//', '', $canonical);

if(preg_match('/([0-9]{2})\/([0-9]{2})\/([^\/]+)\//', $canonical)) {
    $cano = preg_replace('/([0-9]{2})\/([0-9]{2})\/([^\/]+)\//', "\\1-\\2-\\3-\\4", $canonical);

    if($canonical == $cano) {
        $cano = preg_replace('/.+?([^\/]+)\/([0-9]{4})\/([0-9]{2})\/([0-9]{2})\//', "\\2-\\3-\\4-\\1", $canonical);
        $filename = preg_replace('/_/', '-', $cano);
        $filename = preg_replace('/\.html$/', '', $filename);
        echo $filename.'.markdown'.PHP_EOL;
        echo '{% post_url '.$filename.' %}';
    } else {
        $filename = preg_replace('/_/', '-', $cano);
        $filename = preg_replace('/\.html$/', '', $filename);
        echo $filename.'.markdown'.PHP_EOL;
        echo '{% post_url '.$filename.' %}';
    }    
}

if(preg_match('/([0-9]{4})\/([0-9]{2})\/([0-9]{2})$/', $canonical)) {
    $cano = preg_replace('/([^\/]+)\/([0-9]{4})\/([0-9]{2})\/([0-9]{2})/', "\\2-\\3-\\4-\\1", $canonical);
    $filename = preg_replace('/_/', '-', $cano);
    echo $filename.'.markdown'.PHP_EOL;
    echo '{% post_url '.$filename.' %}';
}