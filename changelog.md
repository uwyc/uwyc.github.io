## Jessie to Testing(Stretch)
### 2016-06-22
1. 将系统升级为testing
2. 升级完testing后，因为之前的独立显卡驱动有问题，所以需要更改xorg的配置（因为之前ati显卡初始化，保留了初始配置）
   $ sudo mv  /etc/X11/xorg.conf.original-0 /etc/X11/xorg.conf
3. 部分软件我采用软件库优先的原则，重新安装了一遍，详情见stretch.md

### 2016-06-25
1. Ruby环境从2.1.0升级至2.3.0，gem的bin路径更改，根据[官网](http://guides.rubygems.org/faqs/#user-install)更改配置方式
2. 配置文件从直接修改`.bashrc`，更改为添加自己私有配置(`.bash_own`)，保证可配置性
3. 使用Ubuntu的字体配置文件，主要是这个[软件包](http://packages.ubuntu.com/xenial-updates/language-selector-common)里的文件，部分问题还是用fonts.conf解决

### 2016-07-02
1. 使用xfce4桌面代替gnome-shell
2. 配置`lightdm`，使用默认的panel设置
3. 使用__freeplane__代替__freemind__
4. 设置底端panel为自动隐藏，而且在顶部添加音量插件__PulseAudio Plugin__，设置一下时间显示，打开clipman粘帖板工具
5. 放弃fonts.conf的配置信息，完全使用ubuntu的修改后的软件包，并且手动设置chrome和atom的字体显示顺序

### 2016-07-04
1. 桌面美化，从现在开始正式使用xfce4桌面
2. Ruby相关工具的下载和使用
3. 实用工具的补充
4. Xfce4: Quod Libet没有声音

### 2016-07-15
1. 添加两个bash配置文件
2. 因为`ibus-libpinyin`的回退机制有点坑爹，所以选择原来的`ibus-pinyin`，不再出现以前的拼音错误

### 2016-07-16
> 由于手贱，使用`rm -rf *`直接删除掉了`~/`下的全部可见文件，后悔的要死

1. 所以采用`trash-put`代替`rm`命令的方法，避免误删的惨剧出现
2. 下载安装轻量级C/C++的文本编辑器，可支持编译运行的简单操作 —— Geany
3. 下载轻量级的C/C++的IDE，CodeLite
4. 添加[vim配置文件](https://github.com/RunnerWoo/OSConfig/blob/master/.vimrc)
5. 输入法的问题，因为会在terminal出现光标消失的现象，所以重新使用`ibus-libpinyin`

### 2016-07-28
1. 之前因为触摸板的原因而放弃gnome-shell，现在重新使用gnome-shell，找到了触摸板点击失效的原因了
2. 升级了docker，发现原有配置已经废弃

### 2016-08-02
1. Node.js一些前端管理需要的[包下载](https://github.com/RunnerWoo/OSConfig/blob/master/stretch.md#软件包管理)
