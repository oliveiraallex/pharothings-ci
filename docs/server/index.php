<?php 
$remoteRepoFile='https://github.com/oliveiraallex/pharothings-ci/blob/master/docs/server/index.html';
$remotePage='https://oliveiraallex.github.io/pharothings-ci/server/index.html';
$localPage="http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
echo file_get_contents($remotePage); 
echo "\n#<i>This page was generated dynamically with content from <a href=\"".$remotePage."\">".$remotePage."</a> by page <a href=\"".$localPage."\">".$localPage."</a>
<br>If you want to improve the content of this page, change it and make a Pull Request in the file <a href=\"".$remoteRepoFile."\">".$remoteRepoFile."</a></i>";
?>