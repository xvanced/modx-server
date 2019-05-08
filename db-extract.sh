#!/bin/bash

if [ -d ".vagrant" ]
then
    echo ".vagrant exists, logging into vm and EXTRACTING data"
    vagrant ssh -c 'cd /var/www/html; Gitify extract'
else
    echo "Changing into www directory and EXTRACTING data"
    cd ../www
    Gitify extract
fi

