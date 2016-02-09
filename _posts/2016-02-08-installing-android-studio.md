---
layout: post
title:  "Installing Android Studio"
date:   2016-02-08 +0800
tags: android install development
---

Today, I using my computer (System is Debian8(64 bit) and  Desktop environment is Gnome 3.14.1) to install Android Studio for android development.    

Preface
=======
Comparing two tools, Android Studio and Eclipse, I think Android Studio is future. So, I installed Android Studio for developing Andriod applications, and use Eclipse for Java.

First, Open Android Studio official site.
=========================================
According to official site[^official-site], step by step to install Android Studio.    
1. You will download Android Studio binary zip pack, unzip into your path for Android Studio.    
2. Start Android Studio with `studio.sh` under `/your/pathto/android-studio/bin`.    
3. Initial Android Studio configure, and download Andriod SDK Tools from Android Studio.    
4. To support 32-bit apps on a 64-bit machine, you will need to install the ia32-libs, lib32ncurses5-dev, and lib32stdc++6 packages.(Notice, the **ia32-libs** package is not supported, use **lib32z1** instead.)    
5. For quickly opening Android Studio, create a desktop file in your system, for example, in my computer, the desktop folder is under the `~/.local/share/applications/`.    

```bash
# list my terminal history
$ unzip /your/pathto/android-studio.zip /your/pathto/android-studio
$ sudo apt-get install lib32z1 lib32ncurses5-dev lib32stdc++6
$ touch ~/.local/share/applications/android-studio.desktop
$ vim ~/.local/share/applications/android-studio.desktop

# next is my desktop file content
[Desktop Entry]
Name=Android Studio
Exec=/your/pathto/android-studio/bin/studio.sh
Icon=/your/pathto/android-studio/bin/studio.png
Type=Application
Terminal=false
Categories=Development;Java;Android;
```

Second, Setting Android Virtual Device.
=======================================
1. Install openGL support for system.    

```bash
$ sudo apt-get install libgl1-mesa-dev
```
2. You can choose Genymotion[^genymotion] instead of default AVD, but I choose default AVD for calling between two devices.    
3. Sometime else about AVD in Linux[^kvm], however, I cannot use [KVM](https://wiki.debian.org/KVM){:target="blank"}.   

Last, Using Android Studio.
===========================
1. I turn to Android Studio from Eclipse, so I set the **keymaps** to eclipse.    
2. Happy use!    

> Now, I introduce my friend installing tutorial on Mac OS.[^mac]    
> Wooo.... First English post, please check out.    


[^official-site]: [Android Studio Download Page - http://developer.android.com/sdk/installing/index.html?pkg=studio](http://developer.android.com/sdk/installing/index.html?pkg=studio){:target="blank"}    
[^genymotion]: [Genymotion – Fast And Easy Android Emulation](https://www.genymotion.com/){:target="blank"}    
[^kvm]: [Using the Emulator - Android Developers](http://developer.android.com/tools/devices/emulator.html#vm-linux){:target="blank"}    
[^mac]: [安卓开发工具与Genymotion模拟器安装配置详解 - 代码咖啡](http://wjnovember.lofter.com/post/1d65f281_812a20c){:target="blank"}
