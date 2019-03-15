#!/bin/bash 

set -ex

cp download/server.zip docs/
cp download/client.zip docs/
cp download/multi.zip docs/

git fetch --unshallow
git checkout master
git add docs/*.zip
git add -u
git commit -m "Travis upload"
git push http://oliveiraallex:${GH}@github.com/oliveiraallex/pharothings-ci.git > /dev/null 2>&1