#!/bin/bash

rsync -av --stats /opt/data/backup/ svc-backup@hostname.com:/opt/backups/
