#!/bin/bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi

. "$DIR/common.sh"

## Script

echo -e "${NC}Changing into ${DIR}"
cd ${DIR}

echo
echo -e "${ORANGE}=== Checking Dependencies ==="
echo

echo -e "${NC}Checking for vagrant"
if exists vagrant; then
	echo -e "${GREEN}vagrant found."
else
	missing vagrant
fi

echo -e "${NC}Checking for ansible"
if exists ansible; then
	echo -e "${GREEN}ansible found."
else
	missing ansible
fi

echo
echo -e "${GREEN}All dependencies installed"

echo
echo -e "${ORANGE}=== Checking .env ==="
echo

if [ -f "../.env" ]
then
	echo -e "${GREEN}'../.env' found"
else
    echo -e "${ORANGE}'../.env' not found"
    echo -e "${ORANGE}Copying the sample-file to '../.env'"

    cp .env.example ../.env
fi

echo
echo -e "${GREEN}All checks passed"

echo
read -p "Do you want to set up your local server now? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo -e "${NC}Starting 'setup-local.sh' installation script"
    ./setup-local.sh
else
    echo -e "${ORANGE}User aborted"
    echo -e "${NC}Please manually run 'setup-local.sh' to set up your local server."
fi

echo
echo -e "${GREEN}=== Done ==="
echo

echo -e "${NC}You finished the initialization."
echo
echo -e "${NC}Use 'vagrant ssh' inside '${DIR}' or one of the following scripts to operate on the machine: "

echo "$(ls ./*.sh | egrep -v '(common|init).sh')"

exit 0
