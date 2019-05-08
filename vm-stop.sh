#!/bin/bash

if [ -d ".vagrant" ]
then
    echo ".vagrant exists, stopping VM"
    vagrant halt
else
    echo "You first have to set up the VM"
    exit 1
fi
