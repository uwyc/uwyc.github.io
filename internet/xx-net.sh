#!/bin/sh

XXNET_TARBALL=https://api.github.com/repos/XX-net/XX-Net/tarball/master
XXNET_HOME=$HOME/.local/share/XX-Net

if [ ! -d $XXNET_HOME ]; then
    mkdir $XXNET_HOME
fi

echo "XX-Net Downloading..."
wget -O- $XXNET_TARBALL | tar xz -C $XXNET_HOME --strip-components=1

if [ -e $XXNET_HOME/start ]; then
    sed -i.bak "s#\$SCRIPTPATH/start > /dev/null#xterm -e '\$SCRIPTPATH/start'#g" $XXNET_HOME/start
    read -p "Is start XX-Net now(Y/n)?" yn
    yn=${yn:-y}
    case $yn in
        [Nn]* ) echo "Enter the following command to execute:\n \"$XXNET_HOME/start\"";;
        [Yy]* ) $XXNET_HOME/start;;
    esac
fi
