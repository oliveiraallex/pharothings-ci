#!/bin/bash 

set -ex

TEMP_RASP_SER=pharothings-server
TEMP_RASP_SERCLI=pharothings-client
TEMP_MULTI_SERCLI=pharothings-multi
# FILE_DATE=$(date +%Y%m%d%H%M)
FILE_DATE=last

mkdir download

zip -qr9 download/$TEMP_RASP_SER.zip $TEMP_RASP_SER
zip -qr9 download/$TEMP_RASP_SERCLI.zip $TEMP_RASP_SERCLI
zip -qry9 download/$TEMP_MULTI_SERCLI.zip $TEMP_MULTI_SERCLI