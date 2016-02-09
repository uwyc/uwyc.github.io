---
layout: post
title: "开始使用Ubuntu作为桌面系统"
date: 2015-11-18 16:00:00 +8:00
tags: desktop ubuntu os
thread_key: 2015-11-18-start-using-ubuntu-desktop
---

出于某些原因，我选择了[Ubuntu Desktop](http://www.ubuntu.org.cn/download/desktop){:target="blank"}作为我的桌面[操作系统（ 来自百度百科的解释）](http://baike.baidu.com/link?url=d8g_hrzY2cYAaG9OMCb975CGJEMZrDvwhMgzNI3MtdVIYYOjgSbgsirL2qgJNNCOEgqEzI2AjsPy1NSz1I5A4-cdAfWF7BCu3wDQOpFYdhq){:target="blank"}。Ubuntu是[Linux发行版](https://zh.wikipedia.org/wiki/Linux%E5%8F%91%E8%A1%8C%E7%89%88){:target="blank"}中的一个，相对其他Linux发行版在桌面系统中普及比较高的一个，也是入门比较低的Linux发行版。

> 虽然Ubuntu也是Linux中的一种（准确点也不是这么解释），但是，因为各种Linux发行版的使用方式和操作习惯各不相同，所以下面也主要以我正在使用的*Ubuntu14.04*来做例子。

首先要介绍一下什么是操作系统，鉴于我操作系统学得不咋地，还是在这里提供一个链接来做参考吧[^OS_wiki]。当然，不得不说[**Windows**](https://www.microsoft.com/zh-cn/windows/){:target="blank"}在可视化操作系统上面做得真的很好，特别是我刚开始使用Ubuntu的时候，各种不习惯，以及其他很多使用上的不便利，但也不得不说其中Ubuntu其实也在这方面不断努力。相信很多人都是一时图新鲜，特别是现在多系统，多设备的大环境下，大家对操作系统的认识，不再局限于Windows这一家了，还有**Mac OS**等。但是，有人安装后，只用一会儿就放弃，还有人干脆说用Linux都是装B或自虐之类的，虽然我当时也是图新鲜，装装删删，反复折腾，但也是稳定下来，选择Windows加Ubuntu的双系统，基本上也就一星期使用一天Windows了（其实也就是双休日玩玩游戏之类的）。

> 在这里，我也不评论Windows和Ubuntu的优劣，存在就是有意义，并没有好与坏，这也只是他人自己的看法，自己想怎么样就怎么样呗，操作系统最多是个工具，千万不要让工具支配了你（虽然有一段时间我就是这样...）

Ubuntu其实也有它独到的魅力，抛开使用上的不习惯以外（当然，这也是因为长期使用Windows，让大家已经习惯那种键鼠操作的简单便利，使用一段时间的Ubuntu也会习惯的，这也只是习惯问题），其实Ubuntu最吸引我的地方是内存占用小、做程序配置环境快速、游戏少（我在这强烈建议很想摆脱游戏的人可以试着使用Ubuntu）、以及装B（说实在的，哪个人多不想显摆几下呢）。自然，最重要的当然，配置环境快，因为很多开发语言或是一些技术，在Ubuntu下配置真心快，只需要几句命令就行了，而且Ubuntu的包管理机制挺完善的，用起来相当轻松。虽然Windows下都有相应的解决方案，但是，真心比较麻烦，我就被无限的坑过，就一气之下就换了双系统了，用习惯了也就那样。

在安装完Ubuntu双系统后，开始一些基础设置了。

刚装完Ubuntu，系统会提示完成语言支持的更新（假如你选择的是简体中文环境），系统会自动提示，选择立即执行之类的按钮，输入权限密码，完成安装，重启一下就可以了。出于在终端输入命令的便利性，把系统语言设置为英文，然后重启选择同意更改文件名，之后为了方便自己的使用，在系统设置中的语言支持一栏，重新将中文拖到顶端，设置中文为系统语言。重启后，选择不更改文件名，以及不再提示，即可。

鉴于对**GOOGLE**等网络的依赖性，所以要更改**host**。上网搜索后，发现一个博主的博客有对应的资源[^google-hosts]。下载完后，更改`/etc/hosts`文件，重启浏览器即可。

解压zip文件，需要安装**uzip**软件包。打开终端（Terminal，快捷键是`ctrl+shift+T`），输入`sudo apt-get install uzip`，如果有提示更新软件源，可以使用命令`sudo apt-get update`完成。在这里，初次使用Ubuntu会觉得终端安装软件特别不习惯，但是这是踏入Linux世界的第一步，如果想要用好Ubuntu，就必须硬性要求熟悉Linux下的各种常用命令操作，在这里，我提供一个网址供参考[^linux_command]。

由于我的笔记本是AMD显卡加Intel双显卡，所以想要装独立显卡驱动。打开右上角的设置按钮中的系统设置，选择**软件和更新**的**附加驱动**中的**fglrx-updates**安装重启。由于Ubuntu不支持双显卡自动切换，而且独显开起来太耗电（除非运行游戏，当然，Ubuntu下还是有游戏，但是体验感嘛...），要切换至intel显卡，输入命令`sudo amdcccle`打开amd可视化操作界面，选择省电模式，重启即可。

出于一些日常需要，我就下载了[Chrome](https://www.google.com/chrome/browser/desktop/index.html){:target="blank"}（一款比较流行的浏览器，而且我的书签和扩展插件都是在Chrome上同步的）、[atom](https://atom.io/){:target="blank"}（一款Github开发的文本编辑器）的**deb**安装包。使用命令`sudo dpkg -i /path/to/installer-name.deb`安装，其中缺少的依赖项，可以使用`sudo apt-get install -f`来自动安装。

安装完语言支持后，自带的**sun-pinyin**有ue/ve对应错误，某些字打不出来的问题，不过开发者知道这类问题，于是也提供了相应的补丁包，提供[解决链接](http://forum.ubuntu.org.cn/viewtopic.php?t=460618){:target="blank"}[^sun-pinyin]。

为了更加便利的操作，可以在鼠标右键上设置*在文件夹中打开终端*，安装对应的插件（`sudo apt-get nautilus-open-terminal`），重启文件管理器。


[^OS_wiki]: [操作系统 - 维基百科，自由的百科全书](https://zh.wikipedia.org/wiki/%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F){:target="blank"}
[^google-hosts]: [2015 Google hosts 持续更新 - 老D的博客](http://laod.cn/hosts/2015-google-hosts.html){:target="blank"}
[^linux_command]: [Linux命令大全(手册)_Linux常用命令行实例详解_Linux命令学习手册](http://man.linuxde.net/){:target="blank"}
[^sun-pinyin]: [[已解决]（fcitx/ibus-）sunpinyin有关ue/ve对应错误，某些字打不出来的问题。 - 查看主题 • Ubuntu中文论坛](http://forum.ubuntu.org.cn/viewtopic.php?t=460618){:target="blank"}
