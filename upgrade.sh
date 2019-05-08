#!/bin/bash

if [ -d ".vagrant" ]
then
    echo ".vagrant exists, logging into vm and UPGRADING MODX"
    vagrant ssh -c 'cd /var/www/html; Gitify modx:upgrade'
    echo "UPGRADING all Extras"
    vagrant ssh -c 'cd /var/www/html; Gitify package:install --all'
else
    echo "Changing into www directory and UPGRADING MODX"
    cd ../www
    Gitify modx:upgrade
    echo "UPGRADING all Extras"
    Gitify package:install --all
fi
