---
layout: post
title: '在Ubuntu上使用MySQL服务'
author: 吴彦昌
date: 2017-04-17 19:30 +8:00
tags: virtualbox ubuntu mysql config
thread_key: 2015-10-20-mysql-in-virtualbox
update: true
---

在Ubuntu上使用MySQL服务，主要是利用Deb包管理器管理，使用的软件包版本是Ubuntu自带的。

> 原标题 **在Ubuntu上的MySQL上增加远程访问用户**

~~前面讲到用*Vitrualbox*安装自己的本地服务器（云服务器也同理），现在我想用*MySQL*数据库服务，并且可以利用主机上的可视化工具连接客户机上的数据库。~~

首先，先安装*MySQL*服务器，这里有两种方法：一是去[MySQL官网](http://dev.mysql.com/downloads/mysql/){:target="blank"}下载对应的二进制包或者源码安装，二是通过*Ubuntu*的*apt*包管理机制安装。那么我这里就用包管理的方式安装*MySQL*。

```bash
# 安装 MySQL
$ sudo apt-get install mysql-server
# 在安装 MySQL 的过程中，可能会被要求输入 root 密码，按照要求输入即可
```

如果要在自己的主机访问客户机上的*MySQL*的服务的话，在配置好对应的*host-only*的网络配置后，还要在*MySQL*数据库中添加远程访问用户，具体步骤如下（[相关参考网站](http://blog.csdn.net/preterhuman_peak/article/details/40396873){:target="blank"}[^mysql]）

```bash
# 首先用 root 用户登陆 mysql
$ mysql -u root -p
# 之后会要求输入密码
# 输入完密码后，进入 mysql
```

添加*MySQL*的远程用户有两种方法：
> 当然对于云服务器也适用

1.使用**grant**方法授权远程用户

```bash
mysql > grant all privileges on *.* to admin@'%' identified by 'password' with grant option;
# 命令的解释是： grant [权限内容](上面的内容代表全部操作权限) on [数据库](上面的代表所有数据库)
# to [用户名](上面的用户名为admin)@[登陆主机](%代表任何其它主机) identified by [密码] with grant option
```

2.使用**INSERT**语句插入至**user**表

```bash
# 选择 mysql 数据库
mysql > use mysql;
# 查看 user 的表头信息
mysql > desc user;
# 在 user 表中插入对应数据
mysql > insert into user values('%', 'admin', password('password'), 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y', 'y');
# 其中注意有 14 个 'y'
```

接着，还要配置*MySQL*的配置信息，特别是服务端口**(port)**和绑定地址**(bind-address)**，不同的*MySQL*安装方式，可能对应的配置文件目录地址（而我的目录地址是`/etc/mysql/my.cnf`）不同，但是基本的配置信息修改都是一样的。打开对应的配置文件，修改**bind-address**为**0.0.0.0**，至于端口就默认好了。之后，解决MySQL插入中文数据失败问题，需要将数据库的编码类型改成UTF-8模式，参考链接[^utf8]。  
> 提示：在最新的Ubuntu16.04LTS版本中，配置文件在`/etc/mysql/mysql.conf.d/mysqld.conf`  

简单的配置如下（仅为本人自己的配置）：

```bash
# 修改配置文件
[mysqld]
...
bind-address=0.0.0.0
character-set-server=utf8
collation-server=utf8_unicode_ci

# 重启mysql服务
$ sudo service mysql restart
```

最后，可能会需要防火墙配置，为什么有防火墙呢，因为有些需要安全性高的系统，可能会只对外开放几个端口，这就需要修改防火墙来开放*MySQL*的服务端口，不过，我安装完*Ubuntu*后，好像默认不开启防火墙的，如果有需要的可以参考以下网址[CentOS Linux防火墙配置](CentOS Linux防火墙配置及关闭 - 像块石头 - 博客园){:target="blank"}[^iptables]和[Ubuntu UFW防火墙配置](http://wiki.ubuntu.org.cn/UFW%E9%98%B2%E7%81%AB%E5%A2%99%E7%AE%80%E5%8D%95%E8%AE%BE%E7%BD%AE){:target="blank"}[^UFW]


[^mysql]:[MYSQL添加远程用户或允许远程访问三种方法 - 上帝之手 - 博客频道 - CSDN.NET](http://blog.csdn.net/preterhuman_peak/article/details/40396873){:target="blank"}
[^iptables]:[CentOS Linux防火墙配置及关闭 - 像块石头 - 博客园](http://www.cnblogs.com/rockee/archive/2012/05/17/2506671.html){:target="blank"}
[^UFW]:[UFW防火墙简单设置 - Ubuntu中文](http://wiki.ubuntu.org.cn/UFW%E9%98%B2%E7%81%AB%E5%A2%99%E7%AE%80%E5%8D%95%E8%AE%BE%E7%BD%AE){:target="blank"}
[^utf8]:[Change MySQL default character set to UTF-8 in my.cnf? - Stack Overflow](http://stackoverflow.com/a/10866836)
