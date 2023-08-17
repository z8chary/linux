#!/bin/bash

# This script rotates gitlab backups either daily or weekly
# daily keep limit is 14 days
# weekly keep limit is 12
# Examples of running this script:
# ./rotate_gitlab_backups.sh weekly
# ./rotate_gitlab_backups.sh daily

BACKUPLOCATION='/opt/backups/gitlab/'
BACKUPLOCATION_WEEKLY='/opt/backups/gitlab/.weekly/'
file_start='*gitlab_backup'
daily_keep=14
weekly_keep=12

if [[ "$1" == "daily" ]]; then
	# how many backup files exist in the backup dir
	COUNT=$(ls ${BACKUPLOCATION}${file_start}* -t -al | wc -l)
	echo "$COUNT files exist"

	# find the difference of total files from 14
	COUNT=$(( $COUNT - $daily_keep ))
	echo $COUNT files will be removed

	if [ $COUNT -le 0 ]; then
		echo "No files to delete"
	else
		echo "Preparing to delete $COUNT files"
		rm $(ls ${BACKUPLOCATION}${file_start}* -t | tail -$COUNT)
	fi
fi

if [[ "$1" == "weekly" ]]; then

	CURRENTFILE=$(ls -t ${BACKUPLOCATION}${file_start}* | tail -1)
	[[ -d ${BACKUPLOCATION_WEEKLY} || mkdir ${BACKUPLOCATION_WEEKLY}

	echo "Copy $CURRENTFILE to Weekly directory"
	cp -p $CURRENTFILE ${BACKUPLOCATION_WEEKLY}

	# how many backup files exist in the backup weekly directory
	COUNT=$(ls ${BACKUPLOCATION_WEEKLY}* -t -al | wc -l)
	echo $COUNT files exist in $BACKUPLOCATION

	# find the difference of total files from 12
	COUNT=$(($COUNT - $weekly_keep ))
	echo $COUNT files will be removed

	if [ $COUNT -le 0 ]; then
		echo "no files to remove"
	else
		echo "preparing to remove $COUNT files"
		rm $(ls ${BACKUPLOCATION_WEEKLY}* -t | tail -$COUNT
	fi
fi
