#!/bin/bash 

set -ex

mkdir download
zip -qr download/Pharo7.0-32bit-iot-$(date +%Y%m%d%H%M).zip  Pharo7.0-32bit-iot/
rm -rf Pharo7.0-32bit-iot

git checkout master
git add download
git add -u
git commit -m "Travis upload $(date +%Y%m%d%H%M)"
git push http://oliveiraallex:${GH}@github.com/oliveiraallex/pharothings-ci.git > /dev/null 2>&1
