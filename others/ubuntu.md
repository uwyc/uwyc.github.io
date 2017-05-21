# Ubuntu 16.04 LTS

## bash

> 参考链接  
> [CustomizingBashPrompt](https://help.ubuntu.com/community/CustomizingBashPrompt)  
> [How to change Gnome-Terminal title?](https://askubuntu.com/a/22417)  

```bash
... file: ~/.bashrc
# 简化终端前缀
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)} \[\033[01;34m\]\w \[\033[01;33m\]\$ \[\033[00m\]'
else

...

# 删除终端窗口用户名
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

...
```

## system

### 双系统时间问题

> 参考 http://www.cnblogs.com/qf19910623/p/5559514.html

```bash
$ sudo hwclock --localtime --systohc
```

## desktop

> 参考 http://askubuntu.com/a/660859

```bash
# Gtk主题修改
gsettings set org.gnome.desktop.interface gtk-theme 'YourGTKTheme'
# Icon图标修改
gsettings set org.gnome.desktop.interface icon-theme 'YourIconTheme'
# 窗口主题修改
gsettings set org.gnome.desktop.wm.preferences theme 'YourWindowTheme'
```

## ruby(2.3)

> 参考 https://ruby.taobao.org/

```bash
# 安装ruby
$ sudo apt install ruby-dev
$ ruby --version

# 替换gem源
$ sudo gem sources --add https://gems.ruby-china.org/ --remove https://rubygems.org/
$ gem sources -l
```

## node & npm

> 参考 http://stackoverflow.com/a/20845072

```bash
# 安装node和npm
$ sudo apt install nodejs-dev npm

# ubuntu的包管理机制没有node命令（有两种方法解决）
## 建立备选命令node指向nodejs
$ sudo update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10
## 直接按装nodejs-legacy解决
$ sudo apt install nodejs-legacy
$ node -v
```

## NetBeans

> 参考  
> https://netbeans.org/bugzilla/show_bug.cgi?id=256166#c4  

解决字体锯齿问题和界面中文问题，打开NetBeans的配置文件。
配置文件：包管理的在`/etc/netbeans.conf`；手动安装的在`/path/to/netbeans/etc/netbeans.conf`
找到`netbeans_default_options`后添加`-J-Dawt.useSystemAAFontSettings=on -J-Duser.country=US -J-Duser.language=en`

Ubuntu包管理版本出现yaml文件解析错误，需要在`netbeans_default_options`后添加`--cp:p /usr/share/java/jcodings.jar`
