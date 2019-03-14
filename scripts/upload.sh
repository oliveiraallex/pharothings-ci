#!/bin/bash 

set -ex

cp download/server.zip docs/
cp download/client.zip docs/
cp download/multi.zip docs/

git config --global user.email "allex.oliveira@yahoo.com.br"
git config --global user.name "Allex Oliveira"
git checkout master
git add docs/*.zip
git commit -m "Travis upload"
git push http://oliveiraallex:${GH}@github.com/oliveiraallex/pharothings-ci.git