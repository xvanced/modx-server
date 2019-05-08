#!/bin/bash

if [ -d ".vagrant" ]
then
    echo ".vagrant exists, logging into vm and BUILDING data"
    vagrant ssh -c 'cd /var/www/html; Gitify build --force'
else
    echo "Changing into www directory and BUILDING data"
    cd ../www
    Gitify build --force
fi
