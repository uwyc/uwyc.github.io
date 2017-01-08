#!/bin/sh
echo "Uninstall Gnome Desktop Environment"
sudo aptitude purge `dpkg --get-selections | grep gnome | cut -f 1`
sudo aptitude -f install
sudo aptitude purge `dpkg --get-selections | grep deinstall | cut -f 1`
sudo aptitude -f install
