#!/bin/bash 

set -ex

TEMP_RASP_SER=pharo7-iot-rasp-ser
TEMP_RASP_SERCLI=pharo7-iot-rasp-ser-cli
TEMP_MULTI_SERCLI=pharo7-iot-multi-ser-cli
# FILE_DATE=$(date +%Y%m%d%H%M)
FILE_DATE=last

mkdir download
rm -rf download/*.*

zip -qr download/$TEMP_RASP_SER-$FILE_DATE.zip $TEMP_RASP_SER
zip -qr download/$TEMP_RASP_SERCLI-$FILE_DATE.zip $TEMP_RASP_SERCLI
zip -qr download/$TEMP_MULTI_SERCLI-$FILE_DATE.zip $TEMP_MULTI_SERCLI

sudo rm -rf $TEMP_RASP_SER $TEMP_RASP_SERCLI $TEMP_MULTI_SERCLI

sudo git lfs track "*.zip"
sudo git add .gitattributes

sudo git config --global user.email "allex.oliveira@yahoo.com.br"
sudo git config --global user.name "Allex Oliveira"

sudo git checkout master
sudo git add download
sudo git add -u
sudo git commit -m "Travis upload $FILE_DATE"
sudo git push http://oliveiraallex:${GH}@github.com/oliveiraallex/pharothings-ci.git
