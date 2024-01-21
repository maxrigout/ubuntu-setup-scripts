#!/bin/bash

echo "installing steam cmd"
# https://developer.valvesoftware.com/wiki/SteamCMD
# sudo useradd -m steam
# sudo -u steam -s
# cd /home/steam
sudo add-apt-repository multiverse
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install steamcmd