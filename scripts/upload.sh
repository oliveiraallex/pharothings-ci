#!/bin/bash 

set -ex

TEMP_RASP_SER=pharothings-server
TEMP_RASP_SERCLI=pharothings-client
TEMP_MULTI_SERCLI=pharothings-multi

mkdir download

zip -qr9 download/server.zip $TEMP_RASP_SER
zip -qr9 download/client.zip $TEMP_RASP_SERCLI
zip -qry9 download/multi.zip $TEMP_MULTI_SERCLI