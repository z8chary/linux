#!/bin/bash

# repos to backup
BK_TYPE='jira-pg_ jira_attach_ *.zi'
BACKUPLOCATION='/data/backup'
DATESTAMP=$(date '+%h-%d-%y-%s')
USER='svc-backup'

# for all repos do the following
for TYPES in $BK_TYPE; do
	SUBJECT="$BACKUPLOCATION/$TYPES"
	echo "$SUBJECT is backup type and path"
	echo "----- starting $TYPES -----"
	CURRENTFILE=$(ls -t $BACKUPLOCATION/$TYPES* | head -1)
	scp -p $CURRENTFILE $USER@backupserver.fqdn.com:/opt/data/backups/jira/
	COUNT=$(ls $SUBJECT* -t -al | wc -l)
	echo $COUNT $TYPES backups exist
	COUNT=`expr $COUNT - 3`
	echo $COUNT $TYPES backups to be deleted
		if [ $COUNT -eq 0 ]
			then
				echo "no files to be deleted"
			else
				echo "Preparing to delete $COUNT files
				\rm $(ls $SUBJECT* -t | tail -$COUNT)
		fi
done
