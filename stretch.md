# Debian Testing 更新手记

> 系统信息： Debian GNU/Linux stretch/sid 64-bit    
> 电脑信息： HP(惠普) g4-2318tx    
> 参考网站： https://www.debian.org/releases/testing/amd64/release-notes/ch-upgrading

## 安装原则
* Debian软件库优先原则

## 安装配置

### 系统相关

#### 源设置
* 添加 unstable/sid 源，详见官方wiki：https://wiki.debian.org/AptPreferences
```bash
#向 /etc/apt/source.list 添加
deb http://ftp.cn.debian.org/debian unstable main contrib non-free
#这是我的 /etc/apt/preferences 文件
Package: *
Pin: release o=Debian,a=testing
Pin-Priority: 900
Package: *
Pin: release o=Debian,a=unstable
Pin-Priority: 300
Package: *
Pin: release o=Debian
Pin-Priority: -1
```
* 安转软件，但不安装推荐的附加软件包: `$ sudo apt-get install --no-install-recommends foo`

#### 桌面系统

##### xfce4
因为`gnome-shell`现在是各种崩，暂时使用`xfce4`替代使用，记得配置lightdm
```bash
# 方法1：
## 安装xfce4核心
$ sudo apt-get install xfce4
## 安装xfce4基本的工具
$ sudo apt-get install xfce4-goodies
# 方法2：
## 使用 tasksel，选择xfce桌面环境
$ sudo tasksel
# 配置使用lightdm
$ sudo sudo dpkg-reconfigure lightdm
```
而且，因为这两个桌面系统有很好的兼容性，所以，软件基本都是能通用的，不用再额外安装了。

* 去除恶心的系统蜂鸣 http://ubuntuforums.org/showthread.php?t=859176  
```bash
$ sudo modprobe -r pcspkr
$ sudo vim /etc/modprobe.d/blacklist.conf

# 在最下面添加下面这几句

# this is how you mute annoying beeps in console and shutdown
blacklist pcspkr
```

* 解决安卓手机mtp文件传输的问题`$ sudo apt-get install gvfs-backends`    
* 因为一些不知名的Bug，所以在锁屏重新唤醒xfce4的时候，会出现鼠标不显示的情况，目前已知的[方法]()是`Ctrl+Alt+F1`和`Ctrl+Alt+F7`切换    
* quod libet缺少plusesink，安装gstreamer1.0-pulseaudio    
* ibus输入法位置问题，需要安装ibus-clutter ibus-gtk ibus-gtk3 ibus-qt4，然后重新启动电脑    

##### Gnome Shell
* 解决触摸板的驱动问题，因为gnome开始使用驱动__xserver-xorg-input-libinput__来代替__xserver-xorg-input-synaptics__，所以，要想成功地像之前一样愉快地使用触摸板了
```bash
# 移除xserver-xorg-input-synaptics驱动
$ sudo apt-get purge xserver-xorg-input-synaptics
# 重新启动机器
$ sudo reboot
```

#### 桌面美化
##### xfce4桌面系统
- [x] 安装breeze的主题图标和鼠标 `$ sudo apt-get install breeze-icon-theme breeze-cursor-theme`    
- [x] 为Libreoffice添加breeze主题 `$ sudo apt-get install libreoffice-style-breeze`，然后在`Tools->Options->View->Icon size and style`选择__Breeze__    
- [x] 配置系统的breeze主题，在`Appearance->Icons`中选择__Breeze__，在`Mouse and Touchpad->Theme`中选择__Breeze__
- [ ] 下载xfwm-theme-breeze主题（我重新替换成系统的__Kokodi__窗口主题）   
```bash
$ git clone https://github.com/psy-q/xfwm-theme-breeze.git ~/.local/share/themes/Breeze-xfwm
# 然后在Window Manager选择Breeze-xfwm
```
- [x] 使用Clearlooks做主要主题，在`Appearance=>Style`中选择第一个__Clearlooks__    

###### Gnome Shell桌面系统
####### 桌面美化
* 使用(__Numix__ 主题)[https://numixproject.org/]美化    
  - gtk的主题`$ sudo apt-get install numix-gtk-theme`    
  - 图标主题`$ sudo apt-get install numix-icon-theme`    
 然后使用`Gnome Tweak Tools`修改
####### 插件更新
> 这些插件接着[上一次](https://github.com/RunnerWoo/OSConfig/blob/master/jessie.md#桌面美化)的更新

- [x] [Status Title Bar](https://extensions.gnome.org/extension/59/status-title-bar/)    
- [x] [Maximus NG](https://extensions.gnome.org/extension/1026/maximus-ng/)    
- [x] [Window Buttons](https://extensions.gnome.org/extension/426/window-buttons/)    


#### 系统驱动
* 独立显卡，无解    
* 重新安装固件驱动`$ sudo apt-get install firmware-linux-nonfree`    
* 触摸板设置，无解（[可解](#Gnome Shell)）    

#### 系统工具
* 安装系统硬件查看工具`$ sudo apt-get install hardinfo`    
* xfce4下没有对应的文字管理工具，安装fontmanager`$ sudo apt-get install font-manager`    
* 将`rm`命令替换成`mv`([参考网站](http://www.webupd8.org/2010/02/make-rm-move-files-to-trash-instead-of.html))
```bash
# 安装 trash-cli
$ sudo apt-get install trash-cli
# 设置rm的别名为trash-put
alias rm='trash-put'
```

#### 语言环境
* 使用Ubuntu的[语言包](http://packages.ubuntu.com/xenial-updates/language-selector-common)的配置文件，并且简单修改Noto字体的显示顺序。（还是有很多奇怪的问题，因为Noto字体预先使用的日文字体，导致很多应用显示的是日文优先）
```
# 文件位置 /etc/fonts/conf.d/64-language-selector-prefer.conf
...
<family>Noto Sans CJK SC</family>
<family>Noto Sans CJK TC</family>
<family>Noto Sans CJK JP</family>
...
<family>Noto Sans Mono CJK SC</family>
<family>Noto Sans Mono CJK TC</family>
<family>Noto Sans Mono CJK JP</family>
...
```
> Google Chrome浏览器，系统配置信息对其不起作用，只能在设置里更改，使用`Noto Sans CJK SC`为默认字体    
> 同理，使用Chrome的一些应用，比如Atom，也有这样的问题，一样在设置中选择`Noto Sans CJK SC`为默认字体    

### 实用工具

#### 文档办公
* freeplane: 一款新的思维导图工具，因为最新的软件库中没有__freemind__了，`$ sudo apt-get install freeplane`    
* 查询一个文件的md5值`$ md5sum CheckedFile`    
* xarchiver: 一款xfce4桌面端的压缩工具`$ sudo apt-get install xarchiver`    

#### 多媒体
* 音频文件的简单切割(使用ffmpeg)
```bash
# 安装ffmpeg
$ sudo apt-get install ffmpeg
# 运行 将InputFile的00:00:00到00:01:32截出来到OutputFile
$ ffmpeg -i InputFile -vn -acodec copy -ss 00:00:00 -t 00:01:32 OutputFile
```    
* obs-studio：一款直播和录屏软件，现在已经加入unstable软件库，所以添加完unstable软件源后，执行`$ sudo apt-get install obs-studio`即可    
* Xfce4桌面下，Quod Libet没有声音，安装`gstreamer1.0-alsa`即可，`$ sudo apt-get install gstreamer1.0-alsa`    

##### 其它小工具
* [figlet](http://www.figlet.org/): 一款能够生成banner（类似于Spring Boot启动画面中的Spring提示符）的小工具，不过暂且是英文，中文不知道怎么弄    
* 简单的使用[openssl](https://linuxconfig.org/using-openssl-to-encrypt-messages-and-files-on-linux)加解密文件
```bash
# 加密passwd.txt，并输出passwd.dat，之后再输入密码并确认密码
$ openssl enc -aes-256-cbc -in passwd.txt -out passwd.dat
# 解密passwd.dat，并输出passwd文件，输入密码即可
$ openssl enc -aes-256-cbc -d -in passwd.dat -out passwd
```

### 开发环境

#### Node.js
* 删除官方的软件库，因为Debian Testing上的软件库版本还可以
```bash
$ sudo rm /etc/apt/sources.list.d/nodesource.list
$ sudo apt-get autoremove --purge nodejs
$ sudo apt-get update
$ sudo apt-get install -y npm nodejs
# 因为默认没有node这个命令，需要自己添加软链接
$ sudo ln -s $(which nodejs) /usr/bin/node
```
##### 前端开发
###### 软件包管理
* [bower](https://bower.io/): 用于管理前端样式和JS脚本依赖的工具(主要是可以[设置安装路径](http://get.ftqq.com/733.get)，比npm方便目录分配)
```bash
$ sudo npm install bower -g
```
* [gulp](http://gulpjs.com/): 用于构建项目的js工具([教程入门](https://segmentfault.com/a/1190000000372547))
```bash
$ sudo npm install gulp -g
```

#### Docker
* 卸载官方的版本，安装Debian软件库版本
```bash
$ sudo rm /etc/apt/sources.list.d/docker.list
$ sudo apt-get autoremove --purge docker-engine
$ sudo apt-get update
$ sudo apt-get install -y docker.io
```
* 根据这个[Bug反馈](https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=799386)，修改配置文件   
* (最新的[更新显示](https://docs.docker.com/v1.11/engine/reference/commandline/daemon/#daemon-configuration-file)，原有配置方法已经废弃)~~因为校园网跟172.17.0.0的网络冲突，根据[官网文档](https://docs.docker.com/engine/userguide/networking/default_network/custom-docker0/)修改`/etc/default/docker`~~    
  选择新的方法，修改`/etc/docker/daemon.json`
```bash
# 添加这样的配置信息(老的方法，不建议)
DOCKER_OPTS="-bip=172.167.1.1/28 --storage-opt overlay --registry-mirror=这里填写加速镜像网站"
$ sudo service docker restart

# 新的方法，新建并修改daemon.json
{
  "bip": "172.167.1.1/28",
  "storage-driver": "overlay",
  "registry-mirror": []
}
```
#### MySQL
* MySQL Workbench：一款MySQL数据库管理的前端程序，支持到处数据库ER图等功能`$ sudo apt-get install mysql-workbench`    

#### Ruby
* [gimli](https://github.com/walle/gimli)：一款可以将markdown格式转换成pdf的工具
```bash
# 安装下载
$ gem install gimli
# 使用方法，将test.md文件输出成pdf格式，且输出目录(content)和页脚的右侧页码(格式是当前页/总页数)
$ gimli -f test.md -w '--toc --footer-right "[page]/[toPage]"'
```

#### Java
* IDE: 重新安装，选择软件源的NetBeans`$ sudo apt-get install netbeans`    
  - 出现了个` ClassNotFoundException: org.jcodings.Encoding`错误，[参考网站](https://netbeans.org/bugzilla/show_bug.cgi?id=256166)    
    方法是：向`/etc/netbeans.conf`的`netbeans_default_options`后面添加参数`netbeans --cp:p /usr/share/java/jcodings.jar`    

#### C/C++
* [Geany](http://geany.org/)：一款轻量级的文本编辑器，用来写点单文件的C/C++程序还是不错的
```bash
$ sudo apt-get install geany
```
* [CodeLite](http://www.codelite.org/)：一款轻量级的多功能C/C++的IDE，可以与[Code::Blocks](http://codeblocks.org/)媲美的IDE
```bash
$ sudo apt-get install codelite
# 如果要装plugin的话
$ sudo apt-get install codelite-plugins
```

### 游戏
* [ppsspp](http://build.ppsspp.org/?page/downloads#linux)：一款PSP模拟器，Debian软件源没有该软件，建议下载官网的二进制可执行文件，解压即可用    
* RetroArch: 一款GBA等多功能模拟器`$ sudo apt-get install retroarch`    
  这款模拟器还要自行安装其他的运行环境库，建议`$ apt-cache search libretro`看一下支持哪些运行库    
