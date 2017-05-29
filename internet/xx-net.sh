#!/bin/sh

XXNET_TARBALL=https://api.github.com/repos/XX-net/XX-Net/tarball/master
XXNET_STABLE_VERSION=3.3.1
XXNET_DOWNLOAD_URL=https://codeload.github.com/XX-net/XX-Net/zip/$XXNET_STABLE_VERSION
XXNET_DIR=XX-Net-$XXNET_STABLE_VERSION
XXNET_HOME=$HOME/.local/share/XX-Net

# if [ ! -d $XXNET_HOME ]; then
#     mkdir -p $XXNET_HOME
# fi

echo "XX-Net Downloading..."
# wget -O- $XXNET_TARBALL | tar xz -C $XXNET_HOME --strip-components=1
wget $XXNET_DOWNLOAD_URL -qO /tmp/$XXNET_DIR.zip

echo "Extracting $XXNET_DIR.zip...."
unzip -q /tmp/$XXNET_DIR.zip -d /tmp
mv /tmp/$XXNET_DIR $XXNET_HOME

if [ -e $XXNET_HOME/start ]; then
    sed -i.bak "s#\$SCRIPTPATH/start > /dev/null#x-terminal-emulator -e '\$SCRIPTPATH/start'#g;s#DESKDIR=~/Desktop/#DESKDIR=~/.local/share/applications/#g" $XXNET_HOME/start
    mkdir -p $HOME/.local/share/applications
    $XXNET_HOME/start;
fi
