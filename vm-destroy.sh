#!/bin/bash

if [ -d ".vagrant" ]
then
    echo
    echo ".vagrant directory exists"

    echo "Backing up DB, just in case..."
    ./db-backup.sh

    echo "Executing destroy command on vagrant VM (user-input required)"
    vagrant destroy
    echo

    read -p "Do you want to delete .vagrant? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        rm -rf .vagrant
    fi
fi

if [ -f "../www/.modx_version" ]
then
    echo
    echo "../www/.modx_version file exists"

    read -p "Do you want to delete ../www/.modx_version? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        rm ../www/.modx_version
    fi
fi

if [ -f "../www/config.core.php" ]
then
    echo
    echo "../www/config.core.php file exists"

    read -p "Do you want to delete MODX relevant files? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        cd ..
        rm www/config.core.php
        rm www/index.php
        rm -rf www/assets/components
        rm -rf www/assets/image-cache
        rm -rf www/connectors
        rm -rf www/core
        rm -rf www/manager
        rm -rf www/setup
        git checkout www/core
    fi
fi
