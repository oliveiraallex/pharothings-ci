#!/bin/bash 

set -ex

FILE_DATE=$(date +%Y%m%d%H%M)
FILE_PHARO=Pharo7.0-32bit-iot
FILE_NAME=$FILE_PHARO-$FILE_DATE.zip

zip -qr download/$FILE_NAME  $FILE_PHARO
cp download/$FILE_NAME download/$FILE_PHARO-latest.zip
rm -rf $FILE_PHARO

git checkout master
git add download
git add -u
git commit -m "Travis upload $FILE_DATE"
git push http://oliveiraallex:${GH}@github.com/oliveiraallex/pharothings-ci.git > /dev/null 2>&1