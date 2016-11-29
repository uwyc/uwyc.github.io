#!/usr/bin/env bash

sudo apt update && sudo apt install aria2

mkdir $HOME/.aria2
touch $HOME/.aria2/aria2.session

cp aria2.conf $HOME/.aria2
cat << EOT >> $HOME/.bash_aliases
# aria2c RPC
alias aria2c-rpc="aria2c --enable-rpc --dir=$HOME/Downloads \
--input-file=$HOME/.aria2/aria2.session --save-session=$HOME/.aria2/aria2.session "
EOT
