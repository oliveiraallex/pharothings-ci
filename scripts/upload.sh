#!/bin/bash 

set -ex

cd ..
mkdir download
zip -r download/Pharo7.0-32bit-iot-$(date +%Y%m%d%H%M).zip  Pharo7.0-32bit-iot/
rm -rf Pharo7.0-32bit-iot

git checkout master
git add download
git add -u
git commit
git push git@github.com:oliveiraallex/pharothings-ci.git