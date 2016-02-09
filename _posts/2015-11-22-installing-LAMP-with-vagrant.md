---
layout: post
title: "使用Vagrant安装LAMP开发环境"
date: 2015-11-22 12:45 +8:00
tags: vagrant php apache
thread_key: 2015-11-12-installing-LAMP-with-vagrant
---

上次有一篇[博客]({% post_url 2015-09-12-ubuntu-in-virtualbox %}){:target="blank"}讲到出于对原有系统不造成太大的破坏，想利用虚拟机服务器来做开发环境，并且，一些开发环境需要用到Linux的环境（虽然我用的也是Linux的桌面系统）。但是，现在我不想弄这么麻烦的配置方式，有没有跟快捷的开发方法，显然是有的，上次在一次学习Rails的视频中接触到了[Vagrant](https://www.vagrantup.com/){:target="blank"}，这次通过安装LAMP环境，记录一下自己的使用情况。

> 注：我的主机是Ubuntu14.04，如果是Windows用户的话，也是可以使用Vagrant的，但是因为Windows没有自带**SSH**的命令，所以要另外下载**SSH**管理工具，例如[XShell](https://www.netsarang.com/products/xsh_overview.html){:target="blank"}，或者下载[Git](https://git-scm.com/){:target="blank"}来给系统装上**SSH**命令，反正无论什么方法，只要能使用**SSH客户端**即可。    
> 在此，也感谢[happypeter](http://happypeter.github.io/rails10/01_vagrant.html){:target="blank"}[^happypeter]的工具介绍。

那么，下面我们开始安装Vagrant的开发环境，首先，什么是Vagrant，Vagrant就是基于开源的VirtualBox虚拟机的建立虚拟机的工具（算了，具体概念还是看官网[^vagrant]好了）。下面就是介绍安装Vagrant的具体方法了。

首先，在安装Vagrant前，要先安装好[VirtualBox](https://www.virtualbox.org/){:target="blank"}，其中如果有人想用VMWare Workstation，在这里，我先声明一句，VMWare虚拟机是个收费的商业软件，虽然其中[VMWare Player](https://my.vmware.com/cn/web/vmware/free#desktop_end_user_computing/vmware_workstation_player/12_0){:target="blank"}是个免费的个人软件，但是因为一些不开放的api，所以Vagrant对应的VMWare版是收费的。

> 在此，特别说一下，为什么我会使用之前那个虚拟机配置方法，因为我在使用Windows操作系统中，发生了一些不知原因的网络问题，导致VirtualBox创建的虚拟机无法连接网络，所以，就用VMWare Player来配置建立开发环境了

下载安装VirtualBox好，并在Vagrant官网[下载](https://www.vagrantup.com/downloads.html){:target="blank"}自己系统对应的版本，安装完后，打开终端，输入`vagrant -v`来查看是否安装完毕，Windows用户可能还要配置系统的环境变量。

接下来，在自己喜欢的文件夹下新建一个文件夹，在这提醒一下，这个文件夹是用来存放Vagrant的配置启动信息，以及作为与虚拟机共享的文件夹使用，而虚拟机主体是存放在VirtualBox的虚拟机创建目录下。还有，在`/home/User/.vagrant.d`中存放的是之后要用的虚拟机镜像文件（**boxes**）和一些其他配置信息。然后在当前文件夹打开终端。

```bash
$ mkdir vagrant
$ cd vagrant
# 初始化获取Vagrantfile的配置文件，且指定虚拟机系统类型为Ubuntu14.04（64位)
$ vagrant init ubuntu/trusty64
```

然后编辑**Vagrantfile**配置文件，其中，先要更改分配给虚拟机的内存，知道这么几段注释并修改为，分配给虚拟机*1024MB*内存：

```bash
config.vm.provider "virtualbox" do |vb|
#   # Display the VirtualBox GUI when booting the machine
#   vb.gui = true
#
#   # Customize the amount of memory on the VM:
  vb.memory = "1024"
end
```

然后，就是修改**Vagrantfile**的网络配置，让其使用有别于宿主机的个人ip（**host-only**），找到这几段，并取消注释：

```bash
# Create a private network, which allows host-only access to the machine
# using a specific IP.
config.vm.network "private_network", ip: "192.168.33.10"
```

这样你就能通过访问IP，访问到虚拟机了，如果为了方便可以修改自己系统的*host*，`my.dev 192.168.33.10`来通过自定义域名访问该虚拟机，还有可以有时需要端口转发，找到这几段，请取消注释，在后面添加配置，使虚拟机的端口转发到主机的指定ip的端口上。

```bash
# Create a forwarded port mapping which allows access to a specific port
# within the machine from a port on the host machine. In the example below,
# accessing "localhost:8080" will access port 80 on the guest machine.
# 其中我设置host_ip是指定主机IP为0.0.0.0，默认是localhost
config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "0.0.0.0"
```

更多其他详情配置，可以参考[官方文档](https://docs.vagrantup.com/v2/){:target="blank"}。

配置完一些基础配置后，然后就可以安装虚拟机了，这时候，只需在当前文件夹下输入命令`vagrant up`，即可自动安装虚拟机。注意，如果是第一次使用该虚拟机系统，会先行下载虚拟机镜像存到之前提到的那个文件夹中，而且会因为不同地区时间网速等综合原因，导致下载速度不尽相同，所以，需要耐心等候，有可能速度慢的话，要1、2个小时。当然，网上还有一些关于下载的其他解决方案，因为我没查仔细，就不介绍了。

漫长地等待后，就可以启动期待已久的虚拟机了。当前目录下输入命令`vagrant ssh`即可连接到虚拟机服务器，上面提到了如果Windows没有ssh命令怎么办，使用ssh的管理软件连接`localhost:2222`，其中用户名和密码都是`vagrant`，或者打开之前下载的**Git Bash**，使用命令`vagrant ssh`。

连接完成后，就开始安装LAMP了，而**Ubuntu Server**提供了一个十分好用的安装工具包，输入命令`sudo tasksel`，空格选择**LAMP Server**，然后`tab`跳转到**OK**，回车，按照可视化界面安装LAMP即可。这时，在自己的系统上访问虚拟机的IP时，看到Ubuntu的Apache欢迎界面就是成功了。

对了，如果主机是zh_CN.UTF-8的本地语言，会在ssh连接之后，报本地化啥啥的警告，只要做好配置即可，另外，还有时区的设置。

```bash
# 设置语言环境
$ sudo locale-gen zh_CN.UTF-8 en_US.UTF-8
# 设置时区
$ sudo tzselect
# 按照要求选择时区，Asia->China->Beijing，然后设置时区
$ sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
```

另外，附上一些Vagrant的常用命令：

```bash
# 初始化虚拟机 box.name为.vagrant.d下boxes中的虚拟机镜像
$ vagrant init box.name
# 开启虚拟机，前提当前文件夹下有Vagrantfile
$ vagrant up
# 关闭虚拟机
$ vagrant halt
# 修改完配置信息后，重启虚拟机
$ vagrant reload
# 连接虚拟机
$ vagrant ssh
# 保存（休眠）虚拟机
$ vagrant suspend
# 恢复（唤醒）虚拟机
$ vagrant resume
```

当然，这一切只是开端，之后还有Apache服务器配置，以及PHP各种蛋疼的编码适配等等。

> 相关参考链接：    
> 1. [图灵社区 - 合集 - Vagrant学习手册](http://www.ituring.com.cn/minibook/10949){:target="blank"}    
> 2. [happypeter的Rails十日谈](http://happypeter.github.io/rails10/){:target="blank"}    
> 3. [Apache的安装配置 - Ubuntu中文论坛](http://wiki.ubuntu.org.cn/LAMP_%E6%9C%8D%E5%8A%A1%E5%99%A8%E5%AE%89%E8%A3%85%E9%85%8D%E7%BD%AE){:target="blank"}    
> 4. [ubuntu server设置时区和更新时间_汉斯的遗忘_新浪博客](http://blog.sina.com.cn/s/blog_6c9d65a1010145st.html){:target="blank"}    


[^happypeter]: [使用 vagrant 安装 ubuntu 系统 - happypeter](http://happypeter.github.io/rails10/01_vagrant.html){:target="blank"}

[^vagrant]: [Vagrant的官网网址：https://www.vagrantup.com/](https://www.vagrantup.com/){:target="blank"}
