#!/bin/bash
#
# find the latest backup file

BACKUPLOCATION='/mnt/gitlab_local_backups/'
USER='svc-backup'
ADMINS="john.smith@email.com,jane.doe@email.com"

sudo chown -R $USER: $BACKUPLOCATION
sudo chmod -R 700 $BACKUPLOCATION

#echo out the file that will be copied
echo "mirroring backups from gitlabserver01 to backupserver01"

#copy latest file to backup server maintaining original file create time stamp
rsync -avh $BACKUPLOCATION $USER@backupserver01.fqdn.com:/opt/data/backups/gitlab/ --delete
if [ $# -ne 0]; then
	echo "" | mailx -v -s "Gitlab backup transfer issue!" \
		-S smtp=smtp://mail.fqdn.com:25 \
		-S ssl-verify=ignore \
		-S from="devops-gitlab@gitlab.fqdn.com" \
		$ADMINS
fi
