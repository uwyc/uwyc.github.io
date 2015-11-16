---
layout: post
title: "开始使用Ubuntu作为桌面系统"
date: 2015-11-16 21:18:00 +8:00
tags: desktop ubuntu os
thread_key: start-using-ubuntu-desktop
---

出于某些原因，我选择了[Ubuntu Desktop](http://www.ubuntu.org.cn/download/desktop)作为我的桌面[操作系统](https://zh.wikipedia.org/wiki/%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F)。Ubuntu是[Linux发行版](https://zh.wikipedia.org/wiki/Linux%E5%8F%91%E8%A1%8C%E7%89%88)。

> 虽然Ubuntu也是Linux中的一种（准确点也不是这么解释），但是，因为各种Linux发行版的使用方式和操作习惯各不相同，所以下面也主要以我正在使用的*Ubuntu14.04*来做例子。

首先要介绍一下什么是操作系统，鉴于我操作系统学得不咋地，还是在这里提供一个链接来做参考吧[^OS_wiki]。当然，不得不说[**Windows**](https://www.microsoft.com/zh-cn/windows/)在可视化操作系统上面做得真的很好，特别是我刚开始使用Ubuntu的时候，各种不习惯，以及其他很多使用上的不便利，但也不得不说其中Ubuntu其实也在这方面不断努力。相信很多人都是一时图新鲜，特别是现在多系统，多设备的大环境下，大家对操作系统的认识，不再局限于Windows这一家了，还有**Mac OS**等。但是，有人安装后，只用一会儿就放弃，还有人干脆说用Linux都是装B或自虐之类的，虽然我当时也是图新鲜，装装删删，反复折腾，但也是稳定下来，选择Windows加Ubuntu的双系统，基本上也就一星期使用一天Windows了（其实也就是双休日玩玩游戏之类的）。

> 在这里，我也不评论Windows和Ubuntu的优劣，存在就是有意义，并没有好与坏，这也只是他人自己的看法，自己想怎么样就怎么样呗，操作系统最多是个工具，千万不要让工具支配了你（虽然有一段时间我就是这样...）

Ubuntu其实也有它独到的魅力，抛开使用上的不习惯以外（当然，这也是因为长期使用Windows，让大家已经习惯那种键鼠操作的简单便利，使用一段时间的Ubuntu也会习惯的，这也只是习惯问题），其实Ubuntu最吸引我的地方是内存占用小、做程序配置环境快速、游戏少（我在这强烈建议很想摆脱游戏的人可以试着使用Ubuntu）、以及装B（说实在的，哪个人多不想显摆几下呢）。自然，最重要的当然，配置环境快，因为很多开发语言或是一些技术，在Ubuntu下配置真心快，只需要几句命令就行了，而且Ubuntu的包管理机制挺完善的，用起来相当轻松。虽然Windows下都有相应的解决方案，但是，真心比较麻烦，我就被无限的坑过，就一气之下就换了双系统了，用习惯了也就那样。

在安装完Ubuntu双系统后，开始一些基础设置了。

鉴于对**GOOGLE**等网络的依赖性，所以要更改**host**。上网搜索后，发现一个博主的博客有对应的资源[^google-hosts]。下载完后，更改`/etc/hosts`文件，重启浏览器即可。

解压zip文件，需要安装**uzip**软件包。输入`sudo apt-get install uzip`，如果有提示更新软件源，可以使用命令`sudo apt-get update`完成。

完成语言更新，系统会自动提示，选择立即执行之类的按钮，输入权限密码，完成安装，重启一下比较好。出于在终端输入命令的便利性，把系统语言设置为英文，然后重启选择同意更改文件名，之后为了方便自己的使用，在系统设置中的语言支持一栏，重新将中文拖到顶端，设置中文为系统语言。重启后，选择不更改文件名，以及不再提示，即可。

AMD显卡，打开右上角的设置按钮中的系统设置，选择**软件和更新**的**附加驱动**中的**fglrx-updates**安装重启。因为独显开起来太耗电，切换至intel显卡，输入命令`sudo amdcccle`打开amd可视化界面，选择省电模式，重启即可。

下载[Chrome](https://www.google.com/chrome/browser/desktop/index.html)、[atom](https://atom.io/)(一款Github开发的文本编辑器)的**deb**安装包。使用命令`sudo dpkg -i name.deb`安装，其中缺少的依赖项，使用`sudo apt-get install -f`来自动安装。

安装完语言支持后，自带的**sun-pinyin**有ue/ve对应错误，某些字打不出来的问题，不过开发者知道这类问题，于是也提供了相应的补丁包，提供[解决链接](http://forum.ubuntu.org.cn/viewtopic.php?t=460618)[^sun-pinyin]。

为了更加便利的操作，可以在鼠标右键上设置*在文件夹中打开终端*，安装对应的插件（`sudo apt-get nautilus-open-terminal`），重启文件管理器。

------

[^OS_wiki]: [操作系统 - 维基百科，自由的百科全书](https://zh.wikipedia.org/wiki/%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F)
[^google-hosts]: [2015 Google hosts 持续更新 - 老D的博客](http://laod.cn/hosts/2015-google-hosts.html)
[^sun-pinyin]: [[已解决]（fcitx/ibus-）sunpinyin有关ue/ve对应错误，某些字打不出来的问题。 - 查看主题 • Ubuntu中文论坛](http://forum.ubuntu.org.cn/viewtopic.php?t=460618)
