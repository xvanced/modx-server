#!/bin/bash

if [ -d ".vagrant" ]
then
    echo ".vagrant exists, pausing VM"
    vagrant suspend
else
    echo "You first have to set up the VM"
    exit 1
fi
