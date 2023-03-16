#!/bin/bash

if [ -z "$CRON_SCHEDULE" ]; then
    CRON_SCHEDULE="1 1 * * *"
fi

if (( 5 != $(echo "$CRON_SCHEDULE" | awk '{print NF}' ) )); then
    echo "Invalid cron schedule.  Should look something like: 1 1 * * *"
    exit
fi

env | grep "^PFSENSE_" > /tmp/.pfsense_backup.env

echo "$CRON_SCHEDULE set -a ; . /tmp/.pfsense_backup.env; set +a;  /backup.sh >> /data/crontab.log 2>&1" | crontab

cron -f
