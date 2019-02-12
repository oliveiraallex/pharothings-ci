#!/bin/bash 

set -ex

TEMP_RASP_SER=pharo7-iot-rasp-ser
TEMP_RASP_SERCLI=pharo7-iot-rasp-ser-cli
TEMP_MULTI_SERCLI=pharo7-iot-multi-ser-cli
FILE_DATE=$(date +%Y%m%d%H%M)

zip -qr download/$TEMP_RASP_SER-$FILE_DATE.zip $TEMP_RASP_SER
zip -qr download/$TEMP_RASP_SERCLI-$FILE_DATE.zip $TEMP_RASP_SERCLI
zip -qr download/$TEMP_MULTI_SERCLI-$FILE_DATE.zip $TEMP_MULTI_SERCLI

rm -rf $TEMP_RASP_SER TEMP_RASP_SERCLI TEMP_MULTI_SERCLI

sudo add-apt-repository ppa:git-core/ppa
apt-get update
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
sudo apt-get install git-lfs
git lfs install

git lfs track "*.zip"
git add .gitattributes

git checkout master
git add download
git add -u
git commit -m "Travis upload $FILE_DATE"
git push http://oliveiraallex:${GH}@github.com/oliveiraallex/pharothings-ci.git
