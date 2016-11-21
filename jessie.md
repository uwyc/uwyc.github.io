# Debian Jessie安装手记

> 系统信息： Debian GNU/Linux 8 (jessie) 64-bit    
> 电脑信息： HP(惠普) g4-2318tx    
> 参考网站： https://wiki.debian.org/InstallingDebianOn/HP/Envy%2015-j104sl

## 使用约定
* 但凡更改系统文件，都要备份系统预置文件，使用`_default`结尾命名    
* 备份一个文件使用`_backup`结尾命名    

## 安装配置

### 网络环境

* 国外的一些软件源有点慢，使用使用[163开源镜像](http://mirrors.163.com/.help/debian.html)的更新源，使用之前最后先备份    
* 安装Gnome网络设置上的VPN(pptp)插件    
```
 $ sudo apt-get install network-manager-pptp-gnome
```
* 解决无线驱动问题，添加好163的镜像就可以使用商业驱动或者一些非免费的驱动，电脑无线网卡型号和有线网卡    
```
 //Ralink corp. RT3290 Wireless 802.11n 1T/1R PCIe） https://wiki.debian.org/rt2800pci
 $ sudo apt-get install firmware-ralink
 //Realtek Semiconductor Co., Ltd. RTL8101E/RTL8102E PCI Express Fast Ethernet controller
 $ sudo apt-get install firmware-realtek
```
* Google等科学上网，更改hosts( http://laod.cn/hosts/2016-google-hosts.html )    
* 习惯使用[Google Chrome浏览器](https://wwww.google.com/chrome)，下载安装deb包，Google使用的是https协议，安装源`/etc/apt/source.list.d/google-chrome.list`建议更改成https    
* 支持`https`包安装 `$ sudo apt-get install apt-transport-https`    
* 连接打印机(HP-LaserJet-p2055d)，出现`There was an error during the CUPS operation: 'client-error-not-possible'.`错误，安装`$ sudo apt-get install smbclient`解决问题    
* 解决RT3290蓝牙问题（此方案无法解决）：http://wirama.web.id/rt3290-bluetooth-rtbth-driver-with-kernel-3-13/    

### 语言环境
* `$ sudo dpkg-reconfigure locales`选择`en_US.UTF-8`、`zh_CN.*`和`ja_JP.*`    
* 中文输入法：
  - [ ] 安装Rime中州韵输入法 `$ sudo apt-get install ibus-rime`    
  - [x] 因为Rime输入法一些偏门字体没有，选择ibus-libpinyin `$ sudo apt-get install ibus-libpinyin`    
* 日语输入法：选择安装Anthy输入法 `$ sudo apt-get install ibus-anthy`    
* 兼容当前中文文档，安装中文字体包支持：宋体(simsun.ttc、simsunb.ttf)、黑体(simhei.ttf)、楷体(simkai.ttf)、仿宋(simfang.ttf)、隶书(SIMLI.TTF)、微软雅黑(msyh.ttc、msyhbd.ttc、msyhl.ttc)    
* 或者安装Debian软件库中有的字体库[帮助](http://edyfox.codecarver.org/html/debian_testing_chinese.html)    
```
# 宋体、楷体替代
$ sudo apt-get install fonts-arphic-uming fonts-arphic-ukai
# 黑体替换
$ sudo apt-get install fonts-wqy-microhei
```

### 桌面美化
* Tweak Tool工具中Desktop(桌面)设置显示文件，Windows(窗口)设置TitleBar Buttons显示最小化按钮    
* 实用的Gnome Shell扩展插件：    
    - [x] Applications menu    
    - [x] Openweather    
    - [x] Places status indicator    
    - [x] User themes    
    - [x] [Media player indicator](https://extensions.gnome.org/extension/55/media-player-indicator/)    
    - [x] Dash to Dock(https://extensions.gnome.org/extension/307/dash-to-dock/)    
    - [ ] [Hide Top Bar](https://extensions.gnome.org/extension/545/hide-top-bar/)    
    - [x] [Dynamic Top Bar](https://extensions.gnome.org/extension/885/dynamic-top-bar/)    
    - [ ] [Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)    
    - [ ] [Drop Down Terminal](https://extensions.gnome.org/extension/442/drop-down-terminal/)    
    - [ ] [Lock Keys](https://extensions.gnome.org/extension/36/lock-keys/)    
    - [ ] [Netspeed](https://extensions.gnome.org/extension/104/netspeed/)    
    - [x] [EasyScreenCast](https://extensions.gnome.org/extension/690/easyscreencast/)
* 安装AMD显卡驱动( https://wiki.debian.org/ATIProprietary )    
```
# 自己机器的显卡信息
$ lspci -nn | grep VGA
Intel Corporation 3rd Gen Core processor Graphics Controller
Advanced Micro Devices, Inc. [AMD/ATI] Thames [Radeon HD 7500M/7600M Series]
# 安装驱动和图形控制面板
$ sudo apt-get install fglrx-driver fglrx-control
# 安装完后重启无法进入界面，点击Ctrl+Alt+F1配置再重启
$ sudo aticonfig --initial
```
* 设置30分钟黑屏，打开__dconf__，编辑`org.gnome.desktop.session idle-delay 1800`    

### 文件系统
* 解决移动硬盘读写权限失败的问题，参考网站( http://www.cnblogs.com/wangbo2008/p/3782730.html )    
```
// sdX1对应的是哪个存储设备和对应的分区号
$ sudo ntfsfix /dev/sdX1
```
* 解决`zip`压缩包文件乱码问题，安装`$ sudo apt-get install convmv`，然后使用命令`$ LANG=zh_CN.GBK(ja_JP.Shift_JIS) 7z x filename.zip`和`$ convmv -f [from-encode] -t UTF-8 file(invalid code) --notest`    

### 实用工具/软件

#### 网络工具
* aria2c下载工具(支持断点下载) `$ sudo apt-get install aria2`，再使用配置文件    
* FTP/FTPS/SFTP客户端：FileZilla `sudo apt-get install filezilla`    
* [XX-Net](https://github.com/XX-net/XX-Net)，科学上网

#### 文档查看和编辑
* 金山WPS(Office编辑)：https://www.wps.com/    
* Github Atom：https://atom.io/，使用插件包([sync-setting](https://github.com/atom-community/sync-settings))同步配置    
* RAR：因为Jessie上的软件源有点旧，直接去官网下载最新版本，然后将[已购买](http://rarlab.com/shop2rarlab-index.php?prod=winrar&x-source=winraronly)的key文件放入至`/usr/local/etc`目录下    
* FreeMind：http://freemind.sourceforge.net/wiki/index.php/Main_Page    
  - 直接下载官网的二进制版本，软件源的版本过旧    
  - 配置Desktop和MimeType
  ```
  1. Desktop file - ~/.local/share/applications/freemind.Desktop
  [Desktop Entry]
  Name=FreeMind
  Exec=sh "/opt/freemind-bin-max-1.0.1/freemind.sh"
  Icon=/opt/freemind-bin-max-1.0.1/FreeMindWindowIcon.png
  Terminal=false
  Type=Application
  Categories=Office;Graphics;
  MimeType=text/x-troff;
  2. mimeapps.list - ~/.local/share/applications/mimeapps.list
  ...
  text/x-troff-mm=freemind.desktop
  ```
#### 多媒体工具
- [x] 视频播放器：VedioLAN `$ sudo apt-get install vlc`    
- [x] 绘图工具（数位板绘画）：MyPaint `$ sudo apt-get install mypaint mypaint-data-extras`    
- [x] 录屏工具：[OBS](https://obsproject.com/)[安装方式](https://github.com/jp9000/obs-studio/wiki/Install-Instructions#manually-compiling-on-debian-based-distros)，安装完毕后，设置中的输出选择高级模式的录像下的FFmpeg类型来解决录屏文件的黑屏问题    

#### 娱乐游戏
* Steam游戏平台：http://store.steampowered.com/，安装时缺少32位环境( https://wiki.debian.org/Steam )    
```
# 首先要先开启32位软件支持
$ sudo dpkg --add-architecture i386
# 直接用软件源的安装文件，避免一些依赖项问题
$ sudo apt-get install steam
# 结果还有显卡依赖问题
$ sudo apt-get install libgl1-fglrx-glx:i386
```
  - 安装Dota2游戏(首先要先用完美世界登陆过Dota2)，设置启动参数`-perfectworld -language schinese -novid -high`    
* PlayOnLinux运行Windows小程序：https://www.playonlinux.com/en/    
```
# 首先要先开启32位软件支持
$ sudo dpkg --add-architecture i386
# 再安装jessie-backports的wine版本
$ sud apt-get -t jessie-backports install wine
# 然后安装从官网下载的PlayOnLinux的deb包
$ sudo dpkg -i PlayOnLinux_version.deb
```    
  - 安装osu!( http://osu.ppy.sh/ )，运行PlayOnLinux，使用系统自带的`wine`版本，安装运行库`dotnet4.5`,[下载osu!](http://m1.ppy.sh/release/osu!install.exe)运行    

### 开发环境

#### 程序员必备
* git版本控制工具：    
```
# 安装git
$ sudo apt-get install git
# 更改全局默认用户姓名和邮箱
$ git config --global user.name $USERNAME
$ git config --global user.email $USEREMAIL
# 将github的编辑器用vim代替nano
$ git config --global core.editor "vim"
```    
* vim编辑器：`$ sudo apt-get install vim`    
* build-essential：`$ sudo apt-get instal build-essential`    
* UML绘图工具：`$ sudo apt-get install dia-gnome`    
  - 简单更改`/usr/bin/dia`成`dia-gnome "$@"`解决中文输入问题    
* 打包安装工具[checkinstall](https://wiki.debian.org/CheckInstall)：`$ sudo apt-get install checkinstall`    

#### Java环境
* OpenJDK8：`$ sudo apt-get install openjdk-8-jdk`    
* NetBeans - Java IDE：https://netbeans.org/downloads/    

#### Ruby环境
* 安装Ruby    
  - [ ] 使用rbenv：https://github.com/rbenv    
  - [x] 或者直接`$ sudo apt-get install ruby ruby-dev bundler`    
* 配置淘宝镜像源 `$ gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/`    
* 配置`~/.gemrc`    
  - `$ echo "gem: --no-document --no-rdoc --no-ri --user-install" >> $HOME/.gemrc`    
  - `$ echo "export PATH=$HOME/.gem/ruby/2.1.0/bin:$PATH" >> $HOME/.bashrc`    
* 安装gem包    
  - bundler：`$ gem install bundler`
  - github-pages：    
  ```
  $ gem install activesupport
  $ sudo apt-get install zlib1g-dev
  $ gem install github-pages
  ```    

#### nodejs环境
* 安装    
  - [ ] 使用nvm：https://github.com/creationix/nvm    
  - [x] 或者官网：https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions     

#### Docker环境
* 安装    
```
$ curl -sSL https://get.daocloud.io/docker | sh
# 将当前管理员添加到docker用户组（需要重新登入系统）
$ sudo usermod -aG docker $USER
# 注册daocloud.io帐号，选择个人中心Docker加速
$ curl -sSL https://get.daocloud.io/daomonit/install.sh | sh -s ${HASHSUM}
```
* 使用    
```
# 安装需要的Docker容器(以mysql为例)
$ dao pull mysql
# 运行容器内的bash命令
$ docker exec -i -t container-name bash
```

#### VirtualBox虚拟机
* 安装方法
  - [ ] 官网安装包 https://www.virtualbox.org/wiki/Linux_Downloads    
  ```
  # 添加apt源公钥
  $ wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  # 添加virtualbox软件源
  $ echo "deb http://download.virtualbox.org/virtualbox/debian jessie contrib" | sudo tee -a /etc/apt/sources.list.d/virtualbox.list
  # 更新源，并安装virtualbox
  $ sudo apt-get update && sudo apt-get install -y virtualbox-5.0
  ```    
  - [x] Debian软件库安装 `$ sudo apt-get -t jessie-backports install virtualbox virtualbox-guest-additions-iso`    
* 后续基于虚拟机    
  - [x] Windows官方提供了90天的虚拟镜像供使用：https://developer.microsoft.com/zh-cn/microsoft-edge/tools/vms/linux/    
  - [x] Genymotion(安卓虚拟机)：https://www.genymotion.com/
