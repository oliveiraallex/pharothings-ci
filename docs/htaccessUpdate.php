<?php
# Dynamic update on .htaccess file
# Get the tag of the last release on Github and create the .htaccess file to redirect the zip files

function getPage ($url) {
$curl_handle=curl_init();
curl_setopt($curl_handle, CURLOPT_URL,$url);
curl_setopt($curl_handle, CURLOPT_CONNECTTIMEOUT, 2);
curl_setopt($curl_handle, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($curl_handle, CURLOPT_USERAGENT, 'Mozilla');
$page = curl_exec($curl_handle);
curl_close($curl_handle);
return $page;
}

function getRemoteTag ($json,$key) {
$jsonObj = json_decode($json);
$remoteTag = $jsonObj->$key;
return trim($remoteTag);
}

function getLocalTag (){
$file = fopen(".htaccess", "r") or die("Unable to open file!");
$tagFile = fgets($file);
fclose($file);
$localTag=substr($tagFile, 1);
return trim($localTag);
}

function createHtaccess ($tag){
$file = fopen(".htaccess", "w") or die("Unable to open file!");
$txt = "#".$tag."\n";
$txt .= "# BEGIN Redirect zip files\n";
$txt .= "<IfModule mod_rewrite.c>\n";
$txt .= "   RewriteRule ^server\.zip$ https://github.com/oliveiraallex/pharothings-ci/releases/download/".$tag."/server.zip [R=302]\n";
$txt .= "   RewriteRule ^server\.zip$ https://github.com/oliveiraallex/pharothings-ci/releases/download/".$tag."/client.zip [R=302]\n";
$txt .= "   RewriteRule ^server\.zip$ https://github.com/oliveiraallex/pharothings-ci/releases/download/".$tag."/multi.zip [R=302]\n";
$txt .= "</IfModule>\n";
$txt .= "# END Redirect zip files\n";
fwrite($file, $txt);
fclose($file);    
}

function updateHtaccess ($tagR,$tagL){
    if ($tagR == $tagL) {
        $log = 'tagRemote: '.$tagR.' tagLocal: '.$tagL."<br>\n";
        $log .= 'nothing to do, htaccess updated...';
        } else {
        createHtaccess ($tagR);
        $log = 'tagRemote: '.$tagR.' tagLocal: '.$tagL."<br>\n";
        $log .= "htaccess updating... <br>\n";
        $log .= 'tagRemote: '.$tagR.' tagLocal: '.getLocalTag ().'<br>';
    }
    return $log;
}

$jsonResult=getPage ('https://api.github.com/repos/oliveiraallex/pharothings-ci/releases/latest');
$tagRemote=getRemoteTag ($jsonResult,'tag_name');
$tagLocal=getLocalTag ();
echo updateHtaccess($tagRemote,$tagLocal);

?>