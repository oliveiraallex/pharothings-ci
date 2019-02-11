#!/bin/bash 

set -ex

TEMP_RASP_SER=pharo7-iot-rasp-ser
TEMP_RASP_SERCLI=pharo7-iot-rasp-ser-cli
TEMP_MULTI_SERCLI=pharo7-iot-multi-ser-cli
FILE_DATE=$(date +%Y%m%d%H%M)

zip -qr $TEMP_RASP_SER download/$TEMP_RASP_SER-$FILE_DATE.zip
zip -qr $TEMP_RASP_SERCLI download/$TEMP_RASP_SERCLI-$FILE_DATE.zip
zip -qr $TEMP_MULTI_SERCLI download/$TEMP_MULTI_SERCLI-$FILE_DATE.zip

rm -rf $TEMP_RASP_SER TEMP_RASP_SERCLI TEMP_MULTI_SERCLI

git checkout master
git add download
git add -u
git commit -m "Travis upload $FILE_DATE"
git push http://oliveiraallex:${GH}@github.com/oliveiraallex/pharothings-ci.git > /dev/null 2>&1