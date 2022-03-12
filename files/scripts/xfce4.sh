#!/bin/sh

# 安装桌面环境
sudo apt update & sudo apt upgrade
sudo apt install -y xfce4 xfce4-goodies

# 安装gtk主题
sudo apt install -y greybird-gtk-theme
xfconf-query -c xsettings -p /Net/ThemeName -s Greybird

# 图标设置
sudo apt install -y moka-icon-theme
xfconf-query -c xsettings -p /Net/IconThemeName -s Moka

# 窗口主题设置
xfconf-query -c xfwm4 -p /general/theme -s Greybird
