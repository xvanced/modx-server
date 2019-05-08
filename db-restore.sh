#!/bin/bash

if [ -d ".vagrant" ]
then
    echo ".vagrant exists, logging into vm and RESTORING data"
    vagrant ssh -c 'cd /var/www/html; Gitify restore'
else
    echo "Changing into www directory and RESTORING data"
    cd ../www
    Gitify restore
fi
