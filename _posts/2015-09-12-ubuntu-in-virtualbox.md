---
layout: post
title: "Ubuntu in Virtualbox"
date: 2015-09-12 16:18:10 +8:00
written:
tags: virtualbox ubuntu config
thread_key: 2015-09-12-ubuntu-in-virtualbox
---

利用虚拟机构建开发环境，虽然[vagrant](https://www.vagrantup.com/)提供了很好的解决方案，但是我还是想用[virtualbox](https://www.virtualbox.org)自己建一个（有点折腾），特记下这篇博客，主要还是一些安装后的配置简述。

首先，我选择的系统是[Ubuntu Server](http://www.ubuntu.org.cn/download/server) ，因为只是利用**Linux**的开发环境，还用不上它的图形化的软件。

接着，就是在虚拟机上安装**Ubuntu Server**，至于安装步骤，相信只要上[百度](https://www.baidu.com/)或是[Google](https://www.google.com/)就能找到很多相关教程，我在这提供一个网站[^UbuntuServer]。

安装完后**Ubuntu Server**，安装增强功能：
{% highlight bash %}
# 将增强功能的光盘插入，挂载增强工具
$ sudo mount /dev/cdrom /media/cdrom
# 安装对应的依赖项
$ sudo apt-get update
$ sudo apt-get install make gcc
# 这个好像已经预先装了
$ sudo apt-get install linux-headers-$(uname -r)
# 之后切换到/media/cdrom运行增强功能程序
$ cd /media/cdrom
$ sudo ./VBoxLinuxAdditions.run
# 安装完成后，关闭虚拟机，并重新启动
{% endhighlight %}

如果想用**SSH**功能，还要设置网络配置，配置**host-only**网卡2[^host-only]:
{% highlight bash %}
# 首先在虚拟机设置上，挂上网卡2
# 假如设置host-only网卡的IP为192.168.56.1 ，子网掩码为255.255.255.0
$ sudo vim /etc/network/interface
# 在下面加上这几行
  # The host-only network interface
  auto eth1
  iface eth1 inet static
  address 192.168.56.101
  netmask 255.255.255.0
  network 192.168.56.0
  broadcast 192.168.56.255
# 然后重新启动网络服务
$ sudo service networking restart
# 查看ifconfig，就会看到已被配置的网卡2
$ ifconfig
# 安装 OpenSSH 服务，在这里我选择了偷懒
# 不是专门搞服务器，直接用Ubuntu的安装工具包
$ sudo tasksel
# 看到开始安装的紫色安装框
# 按空格选择 OpenSSH server，按ENTER开始安装
{% endhighlight %}
安装完**OpenSSH**后就可以用[Xshell](http://www.netsarang.com/products/xsh_overview.html)连接虚拟机了。 这里的**tasksel**是一个简便的网络服务安装工具（我是这么理解的），对于我这种不是很需要了解太细节的懒人，用这个就好了。其中**tasksel**中有许多其他的服务器安装，比如LAMP(Linux,Apache,MySQL,PHP/python)、Tomcat服务等等。

最后，就是挂载共享文件夹，关闭正在启动的虚拟机，然后设置共享文件夹的选项，假设设置共享文件夹路径**X:/vmshare**，共享文件夹名称**vmshare**，如果要手动挂载，不能点击自动挂载。
1.手动挂载法[^sharefolder]
{% highlight bash %}
# 编辑配置文件，让系统加载virtualbox模块
$ sudo vim /etc/modules
# 在文件后添加两行，必须要添加这两行，否则开机挂载会失败
  vboxsf
  vboxguest
# 编辑虚拟系统的启动挂载配置
$ sudo vim /etc/fstab
# 在文件后添加一行
# 共享文件夹名称 挂载点 挂载类型
  vmshare /home/user/shares vboxsf defaults 0 0
# 重启即可
{% endhighlight %}
2.自动挂载法
{% highlight bash %}
# 首先将用户(示例为user)添加到 vboxsf 用户组中
# 使用户user能够操作自动挂载点内容
$ sudo usermod -a -G vboxsf user
# 然后将自动挂载勾上
# 就会在 /media/ 下挂载 sf_vmshare (即sf_[共享文件夹名称])
# 如果想要方便访问对应的挂载点，可以建立软链接
$ ln -s /media/sf_vmshare /home/user/shares
{% endhighlight %}

如果对单调的**Bash**配色不满意，可以去**Ubuntu**官网社区的配色教程配色[^CustomizingBashPrompt]

***

[^UbuntuServer]: [Ubuntu 12.04 LTS服务器版安装过程及使用图解(来源：Linux公社)](http://www.linuxidc.com/Linux/2012-05/60147.htm)

[^host-only]: [Ubuntu Server VirtualBox host-only adapter confusion (windows 7 host) - Ask Ubuntu](http://askubuntu.com/questions/164635/ubuntu-server-virtualbox-host-only-adapter-confusion-windows-7-host)

[^sharefolder]: [和VBOX虚拟机上的UBUNTU Server共享目录 - 懒猫 - 新浪博客](http://blog.sina.com.cn/s/blog_591ecf860100ipwx.html)

[^CustomizingBashPrompt]: [CustomizingBashPrompt - Community Help Wiki](https://help.ubuntu.com/community/CustomizingBashPrompt)
