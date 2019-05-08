#!/bin/bash

echo "Going up one directory"
cd ..

echo "Making sure Gitify-Folders and Configuration exist"

if [ -d "_backup" ]
then
    echo "_backup exists"
else
    echo "_backup directory is missing"
    exit 1
fi

if [ -d "_data" ]
then
    echo "_data exists"
else
    echo "_data directory is missing"
    exit 1
fi

if [ -d "_keys" ]
then
    echo "_keys exists"
else
    echo "_keys directory is missing"
    exit 1
fi

if [ -d "www" ]
then
    echo "www exists"
else
    echo "www directory is missing"
    exit 1
fi

if [ -e "www/.gitify" ]
then
    echo "www/.gitify exists"
else
    echo ".gitify file is missing"
    exit 1
fi

echo "Changing into ./www and beginning MODX Installation (core/packages):"
cd www
sleep 2

Gitify modx:install && Gitify package:install --all

echo "Delete default ht.access from MODX directory"
rm ht.access

echo "Secure MODX core directory"
mv ./core/ht.access ./core/.htaccess

echo "MODX and its packages are installed."
echo "Now building the site content:"
sleep 2

Gitify build --force --no-backup

exit
