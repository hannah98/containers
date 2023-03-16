# Summary
This container runs a cronjob that will attempt to pull a backup of your pfsense configuration.

# Running

```
docker run -v $PWD/data:/data -d -e PFSENSE_IP=192.168.0.1 -e PFSENSE_USER=YOURUSER -e PFSENSE_PASS=YOURPASS furiousgeorge/pfsensebackup
```

# Details

The backup files will be dropped into the /data volume, so you can mount that volume on your host to have access to the backups.

# Schedule

If you want to adjust the crontab schedule, set the "CRON_SCHEDULE" variable at run time.

For example, if you want to run the backup once a week instead of once a day:

```
docker run -v $PWD/data:/data -d -e CRON_SCHEDULE="1 1 * * 1" -e PFSENSE_IP=192.168.0.1 -e PFSENSE_USER=YOURUSER -e PFSENSE_PASS=YOURPASS furiousgeorge/pfsensebackup
```
