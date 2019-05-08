#!/bin/bash

echo "Setting up tools"
cd ..

echo "Set up .profile file and add Gitify to path"
PROFILE=.profile

if [ ! -e "$PROFILE" ]; then
    touch "$PROFILE"
fi

if [ ! -w "$PROFILE" ]; then
    echo "Cannot write to $PROFILE"
else
    echo PATH=$PATH:"${PWD}/tools/gitify" > "$PROFILE"
    echo "alias g='git'" >> "$PROFILE"
    echo "alias gs='git status '" >> "$PROFILE"
    echo "alias ga='git add '" >> "$PROFILE"
    echo "alias gb='git branch '" >> "$PROFILE"
    echo "alias gc='git commit -m'" >> "$PROFILE"
    echo "alias gd='git diff'" >> "$PROFILE"
    echo "alias gl='git pull'" >> "$PROFILE"
    echo "alias gp='git push'" >> "$PROFILE"
fi
echo "Added to $PROFILE"

echo "Set up .user_bashrc file and add aliases and settings"
BASHRC=.user_bashrc

if [ ! -e "$BASHRC" ]; then
    touch "$BASHRC"
fi

if [ ! -w "$BASHRC" ]; then
    echo "Cannot write to $BASHRC"
else
    echo "export PATH=/www/htdocs/${USER##*\-}/tools/gitify/:$PATH" > "$BASHRC"
    echo "alias g='git'" >> "$BASHRC"
    echo "alias gs='git status '" >> "$BASHRC"
    echo "alias ga='git add '" >> "$BASHRC"
    echo "alias gb='git branch '" >> "$BASHRC"
    echo "alias gc='git commit -m'" >> "$BASHRC"
    echo "alias gd='git diff'" >> "$BASHRC"
    echo "alias gl='git pull'" >> "$BASHRC"
    echo "alias gp='git push'" >> "$BASHRC"
    echo "alias php='/usr/bin/php72'" >> "$BASHRC"
fi
source "./$BASHRC"
echo "Added to $BASHRC"

mkdir -p tools
cd tools

mkdir composer
cd composer
curl -sS https://getcomposer.org/installer | php
cd ..

git clone https://github.com/modmore/Gitify.git gitify
cd gitify
php ../composer/composer.phar install
chmod +x Gitify
cd ..

echo "Deployment-Tools composer and Gitify installed. Gitify added through $PROFILE to PATH"
