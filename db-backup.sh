#!/bin/bash

if [ -d ".vagrant" ]
then
    echo ".vagrant exists, logging into vm and BACKUPING data"
    vagrant ssh -c 'cd /var/www/html; Gitify backup'
else
    echo "Changing into www directory and BACKUPING data"
    cd ../www
    Gitify backup
fi
