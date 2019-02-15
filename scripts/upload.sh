#!/bin/bash 

set -ex

TEMP_RASP_SER=pharo7-iot-rasp-ser
TEMP_RASP_SERCLI=pharo7-iot-rasp-ser-cli
TEMP_MULTI_SERCLI=pharo7-iot-multi-ser-cli
# FILE_DATE=$(date +%Y%m%d%H%M)
FILE_DATE=last

mkdir download

zip -qr download/$TEMP_RASP_SER-$FILE_DATE.zip $TEMP_RASP_SER
zip -qr download/$TEMP_RASP_SERCLI-$FILE_DATE.zip $TEMP_RASP_SERCLI
zip -qr download/$TEMP_MULTI_SERCLI-$FILE_DATE.zip $TEMP_MULTI_SERCLI