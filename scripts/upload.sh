#!/bin/bash 

set -ex

rm -r docs/*.zip
cp download/server.zip docs/
cp download/client.zip docs/
cp download/multi.zip docs/

git config --global user.email "allex.oliveira@yahoo.com.br"
git config --global user.name "Allex Oliveira"
git add docs/*.zip
git commit -m "Travis upload"
git push http://oliveiraallex:${GH}@github.com/oliveiraallex/pharothings-ci.git 
