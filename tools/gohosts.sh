#!/bin/sh

GOHOSTS_URL="https://raw.githubusercontent.com/racaljk/hosts/master/hosts"

# Backup hosts
cp /etc/hosts $HOME/GoHosts/hosts-$(date '+%Y-%m-%d').back

# Delete outdated google hosts
sudo sed -i "/^# Modified hosts start/,/^# Modified hosts end/d" /etc/hosts
sudo sh -c "curl -s $GOHOSTS_URL | sed -n '/^# Modified hosts start/,/^# Modified hosts end/p' >> /etc/hosts"
