#!/bin/bash

# Basic variables
MAILTO='support@smeeptech.in'

# Set the datestamp, login credentials and backup directory
export date=$(date +\%Y\%m\%d)
export creds="-uadmin -p`cat /etc/psa/.psa.shadow`"
export backupdir="/mysqlbackup/$(date '+%d-%b-%Y')"

# delete week old files
find ${backupdir}/ -regex '.*.dump.gz' -mtime +4 -exec rm {} \;

#dump databases to the backupdir
cd /mysqlbackup/
mkdir $(date '+%d-%b-%Y')
echo "show databases;" | mysql ${creds} | egrep -v ^Database$ | \
awk '{print "mysqldump --single-transaction ${creds} "$1" | \
gzip > ${backupdir}/db-"$1"-${date}.sql.gz"}' | \
sh

# Jobs a goodun
echo "Hi SysAdmin!!! Live DB Backups completed for testdriveguru.in. Backups are stored at path "/mysqlbackup" directory." | mail -s "DB Backup Notification from testdriveguru.in Server" $MAILTO

##Notification email address

_EMAIL=support@smeeptech.in

ERRORLOG=/var/log/backuplogs/backup.err`date +%F`

ACTIVITYLOG=/var/log/backuplogs/activity.log`date +%F`

##Directory which needs to be backed up

SOURCE=/mysqlbackup/*

#Clear the logs if the script is executed second time

:> ${ERRORLOG}

:> ${ACTIVITYLOG}

##Uploading the Daily DB Backup to Amazon S3

s3cmd sync --no-progress --recursive --skip-existing --no-check-md5 ${SOURCE} s3://investmentguru-mysql-bkp/ 1>>${ACTIVITYLOG} 2>>${ERRORLOG}

ret2=$?

##Sent email alert

msg="DB BACKUP NOTIFICATION ALERT FROM `hostname`"

if [ $ret2 -eq 0 ];then

msg1="Amazon S3 Backup Uploaded Successfully"

else

msg1="Amazon S3 Backup Failed!!\n Check ${ERRORLOG} for more details"

fi

echo -e "$msg1"|mail -s "$msg" ${_EMAIL}
