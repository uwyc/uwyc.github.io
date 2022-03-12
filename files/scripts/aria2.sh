#!/bin/sh
if ! type aria2c > /dev/null; then
    sudo apt update && sudo apt install -y aria2
    echo "Installing aria2c command...."
fi
ARIA2_CONFIG_URL=https://raw.githubusercontent.com/acgotaku/BaiduExporter/master/aria2c/aria2.conf

if [ ! -f $HOME/.aria2 ]; then
    mkdir $HOME/.aria2
fi

echo "Downloading aria2 conf...."
if [ ! -f $HOME/.aria2/aria2.conf ]; then
    # curl -s $ARIA2_CONFIG_URL -o $HOME/.aria2/aria2.conf
    wget $ARIA2_CONFIG_URL -qO /tmp/aria2.conf
    sed -i 's/^enable-rpc=/#&/; s/^dir=/#&/' /tmp/aria2.conf
    mv /tmp/aria2.conf $HOME/.aria2/aria2.conf
fi

echo "Create bash alias command \"aria2c-rpc\" for aria2 RPC mode...."
if [ ! -f $HOME/.aria2/aria2.session ]; then
    touch $HOME/.aria2/aria2.session
fi
if [ -f $HOME/.bash_aliases ]; then
    sed -i '/^alias aria2c-rpc=/d' $HOME/.bash_aliases
fi
cat << EOT >> $HOME/.bash_aliases
alias aria2c-rpc="aria2c --enable-rpc --dir=$HOME/Downloads \
--input-file=$HOME/.aria2/aria2.session --save-session=$HOME/.aria2/aria2.session "
EOT
