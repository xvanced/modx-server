#!/bin/bash

if [ -d ".vagrant" ]
then
    echo ".vagrant exists, starting VM"
    vagrant up
else
    echo "You first have to set up the VM"
    exit 1
fi
