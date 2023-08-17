#!/bin/bash

BACKUPLOCATION='/data/backup/backups/'
CURRENTFILE=$(ls -t $BACKUPLOCATION | head -1)

sudo chown svc-backup $BACKUPLOCATION*
sudo chmod 744 $BACKUPLOCATION*
echo "copying $CURRENTFILE to backup server"
echo "{$BACKUPLOCATION}${CURRENTFILE}

scp -p ${BACKUPLOCATION}${CURRENTFILE} svc-backup@backupserver.fqdn.com:/opt/data/backups/confluence

# how many backup files exist in the backup dir
COUNT=$(ls $BACKUPLOCATION* -t -al | wc -l)
echo "$COUNT files exist in $BACKUPLOCATION"

# find the difference of total files from 3
COUNT=`expr $COUNT -3`
echo "$COUNT files will be moved"

if [ $COUNT -le 0 ]
	then
		echo "no files to be moved"
	else
		echo "preparing to move $COUNT files"
		\rm $(ls $BACKUPLOCATION* -t | tail -$COUNT)
fi
