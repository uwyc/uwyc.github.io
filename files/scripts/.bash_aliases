# npm path start
export PATH='./node_modules/.bin:$PATH'
# npm path end

# cnpm start
alias cnpm='npm --registry=https://registry.npm.taobao.org'
# cnpm end

# avoid rm start
alias remove='/bin/rm'
alias rm='trash-put'
# avoid rm end

## XX-Net: PATH=$HOME/Software/XX-Net/
alias XX-Net='cd $HOME/Software/XX-Net/ && ./start'

## playonlinux with zh_CN.UTF-8
alias playonlinux_cn='LANG=zh_CN.UTF-8 playonlinux'
alias playonlinux_jp='LANG=ja_JP.UTF-8 playonlinux'
