#!/bin/bash

# this script cleans up gitlab backups older than 7 days

#backup location on backup server
BACKUPLOCATION='/opt/data/backups/gitlab'
SERVICE='/*gitlab*'

#how many backup files exist in the backup dir
COUNT=$(ls $BACKUPLOCATION$SERVICE -t -al | wc -l)
echo "$COUNT files exist"

#find the difference of total files from 3
COUNT=`expr $COUNT - 7`
echo $COUNT files will be moved

if [ $COUNT -eq 0 ]; then
	echo "no files to delete"
else
	echo "preparing to delete $COUNT files
	\rm $(ls $BACKUPLOCATION$SERVICE -t | tail -$COUNT)
fi
