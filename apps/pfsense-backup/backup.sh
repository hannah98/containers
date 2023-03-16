#!/bin/sh

error=0
if [ -z "$PFSENSE_IP" ]; then
        echo Must supply PFSENSE_IP
        error=1
fi

if [ -z "$PFSENSE_USER" ]; then
        echo Must supply PFSENSE_USER
        error=1
fi

if [ -z "$PFSENSE_PASS" ]; then
        echo Must supply PFSENSE_PASS
        error=1
fi

if [ "$PFSENSE_USER" = "none" ]; then
        echo Must supply PFSENSE_USER
        error=1
fi

if [ "$PFSENSE_PASS" = "none" ]; then
        echo Must supply PFSENSE_PASS
        error=1
fi

if [ $error -ne 0 ]; then
        exit
fi

filedate=$(date +"%Y%m%d%H%M%S")
filetoday="/data/config-router-$filedate.xml"
filelatest="/data/latest/config-router-latest.xml"
# These commands taken from:
# https://doc.pfsense.org/index.php/Remote_Config_Backup

url="https://$PFSENSE_IP/diag_backup.php"
wget -qO- --keep-session-cookies --save-cookies cookies.txt  --no-check-certificate "$url" | grep "name='__csrf_magic'" | sed 's/.*value="\(.*\)".*/\1/' > csrf.txt

wget -qO- --keep-session-cookies --load-cookies cookies.txt --save-cookies cookies.txt --no-check-certificate  --post-data "login=Login&usernamefld=$PFSENSE_USER&passwordfld=$PFSENSE_PASS&__csrf_magic=$(cat csrf.txt)" "$url"  | grep "name='__csrf_magic'" \
  | sed 's/.*value="\(.*\)".*/\1/' > csrf2.txt

wget -q --keep-session-cookies --load-cookies cookies.txt --no-check-certificate  --post-data "download=download&donotbackuprrd=yes&__csrf_magic=$(head -n 1 csrf2.txt)" "$url" -O "$filetoday"

mkdir -p /data/latest
cp "$filetoday" "$filelatest"
