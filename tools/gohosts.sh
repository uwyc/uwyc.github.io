#!/bin/sh

GOHOSTS_URL="https://raw.githubusercontent.com/racaljk/hosts/master/hosts"

# Backup hosts
BACKUP_HOME=$HOME/GoHosts
BACKUP_NAME=hosts-$(date '+%Y-%m-%d')
if [ ! -e $BACKUP_HOME ]; then
    mkdir $BACKUP_HOME
fi
if [ -e $BACKUP_HOME/$BACKUP_NAME ]; then
    i=0
    while [ -e $BACKUP_HOME/$BACKUP_NAME.$i ]; do
        i=`expr $i + 1`
    done
    BACKUP_NAME=$BACKUP_NAME.$i
fi
cp /etc/hosts $BACKUP_HOME/$BACKUP_NAME
echo "Backup in $BACKUP_HOME/$BACKUP_NAME"

# Delete outdated google hosts
sudo sed -i "/^# Modified hosts start/,/^# Modified hosts end/d" /etc/hosts
sudo sh -c "curl -s $GOHOSTS_URL | sed -n '/^# Modified hosts start/,/^# Modified hosts end/p' >> /etc/hosts"
