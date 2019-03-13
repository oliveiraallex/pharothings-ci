<?php
# Dynamic update on .htaccess file
# Get the tag of the last release on Github and create the .htaccess file to redirect the zip files

function getPage ($url) {
$curl_handle=curl_init();
curl_setopt($curl_handle, CURLOPT_URL,$url);
curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, 2);
curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($curl_handle, CURLOPT_USERAGENT, 'Mozilla');
$query = curl_exec($curl_handle);
curl_close($curl_handle);
return $query;
}

function getTag ($json,$key) {
$jsonObj = json_decode($json);
$tag = $jsonObj->$key;
return $tag;
}

function checkHtaccess (){
$file = fopen(".htaccess", "r") or die("Unable to open file!");
$tagFile = fgets($file);
fclose($file);
$tag=substr($tagFile, 1);
return $tag;
}

function createHtaccess ($tag){
$file = fopen(".htaccess", "w") or die("Unable to open file!");
$txt = "#".$tag."\n";
$txt .= "# BEGIN Redirect zip files\n";
$txt .= "<IfModule mod_rewrite.c>\n";
$txt .= "   RewriteRule ^server\.zip$ https://github.com/oliveiraallex/pharothings-ci/releases/download/".$tag."/pharothings-server.zip [R=302]\n";
$txt .= "   RewriteRule ^server\.zip$ https://github.com/oliveiraallex/pharothings-ci/releases/download/".$tag."/pharothings-client.zip [R=302]\n";
$txt .= "   RewriteRule ^server\.zip$ https://github.com/oliveiraallex/pharothings-ci/releases/download/".$tag."/pharothings-multi.zip [R=302]\n";
$txt .= "</IfModule>\n";
$txt .= "# END Redirect zip files\n";
fwrite($file, $txt);
fclose($file);    
}

function updateHtaccess ($tagR,$tagL){
    if ($tagR == $tagL) {
        $log = 'tagRemote: '.$tagR.' tagLocal: '.$tagL.'<br>';
        $log .= 'nothing to do, .htaccess updated...';
        } else {
        createHtaccess ($tagR);
        $log = 'tagRemote: '.$tagR.' tagLocal: '.$tagL.'<br>';
        $log .= '.htaccess updated <br>';
        $log .= 'tagRemote: '.$tagR.' tagLocal: '.trim(checkHtaccess ()).'<br>';
    }
    return $log;
}

$page=getPage ('https://api.github.com/repos/oliveiraallex/pharothings-ci/releases/latest');
$tagRemote=trim(getTag ($page,'tag_name'));
$tagLocal=trim(checkHtaccess ());
echo updateHtaccess($tagRemote,$tagLocal);

?>