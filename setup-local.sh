#!/bin/bash

clear

echo
echo "          #     #                                         ";
echo "  #    #  #     #    ##    #    #   ####   ######  #####  ";
echo "   #  #   #     #   #  #   ##   #  #    #  #       #    # ";
echo "    ##    #     #  #    #  # #  #  #       #####   #    # ";
echo "    ##     #   #   ######  #  # #  #       #       #    # ";
echo "   #  #     # #    #    #  #   ##  #    #  #       #    # ";
echo "  #    #     #     #    #  #    #   ####   ######  #####  ";
echo
echo "  __  __  ___  ______  __  ____                           ";
echo " |  \/  |/ _ \|  _ \ \/ / / ___|  ___ _ ____   _____ _ __ ";
echo " | |\/| | | | | | | \  /  \___ \ / _ \ '__\ \ / / _ \ '__|";
echo " | |  | | |_| | |_| /  \   ___) |  __/ |   \ V /  __/ |   ";
echo " |_|  |_|\___/|____/_/\_\ |____/ \___|_|    \_/ \___|_|   ";
echo "                                                          ";

echo
echo "Checking dependencies"
echo "_____________________________________________________"
echo

command -v vagrant >/dev/null 2>&1 || { echo >&2 "Vagrant is required but not installed. Aborting."; exit 1; }
echo "Vagrant is installed, continuing..."

command -v ansible >/dev/null 2>&1 || { echo >&2 "Ansible is required but not installed. Aborting."; exit 1; }
echo "Ansible is installed, continuing..."

echo
echo "Installing Ansible Roles"
echo "_____________________________________________________"
echo

ansible-galaxy install -r ansible/requirements.yml

echo
echo "Starting and provisioning the virtual machine"
echo "_____________________________________________________"
echo

vagrant up --provision