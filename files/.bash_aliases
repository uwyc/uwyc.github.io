## npm bin
alias npm-exec='PATH=$(npm bin):$PATH'
## cnpm config
alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"

## avoid rm
alias remove='/bin/rm'
alias rm='trash-put'

## XX-Net: PATH=$HOME/Software/XX-Net/
alias XX-Net='cd $HOME/Software/XX-Net/ && ./start'

## playonlinux with zh_CN.UTF-8
alias playonlinux_cn='LANG=zh_CN.UTF-8 playonlinux'
alias playonlinux_jp='LANG=ja_JP.UTF-8 playonlinux'
