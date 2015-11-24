---
layout: post
title: "在Vagrant上使用和配置Apache服务器"
author: "吴彦昌"
data: 2015-11-24 17:35 +8:00
tags: ["apache", "vagrant", "config"]
thread_key: 2015-11-24-using-apache-with-vagrant
---

上篇博客，我讲到了如何安装Vagrant来建立一个开发环境，让自己的电脑与开发环境隔离，在文章中，我也讲到了如何在Vagrant中简单安装LAMP的web服务器，这次，我在这篇文章中，简单的讲解我在使用Vagrant做我的Apache服务器时，遇见的一些问题以及相关的解决方案。

### Apache服务器在Vagrant上的一些权限问题

在Apache服务器上部署一个网站的时候，这时，有个十分偷懒的方法，就是将自己的网站项目放进Vagrant的共享目录下，然后，登陆Vagrant建立的虚拟机中，在`/var/www/`目录下建立软链接（`ln -s /vagrant/yourweb /var/www/path/to/yourweb`）即可。但是，在本地连接上次配好的ip的地址，访问刚才部署好的网站目录时，显示**403**的错误信息，这是我就郁闷了，4开头的错误一般是客户端的错误，难道我访问的地址错误了？然后，我又试一下，先把软链接删除，再将整个网站项目复制到`/var/www/`下时，访问对应网址，结果还是错误了，后来，渐渐发现了，这是个权限错误，客户端以及当前我这个用户及用户组无权访问网站部署目录下的目录，所以只要更改一下Apache的配置就行了。

{% highlight Bash %}
# 打开 /etc/apache2/
# 编辑目录下的 apache2.conf 文件
$ sudo vim apache2.conf
# 找到以下两行，并修改用户和用户组
...
User  www-data => User  vagrant
Group www-data => Group vagrant
...
{% endhighlight %}

这时，重启Apache服务器，无论是建立软链接还是使用配置更改网站根目录都可以正常访问了。

{% highlight Bash %} $ sudo service apache2 restart {% endhighlight %}

### Apache服务器不同站点及端口的设置

在新的Apache2的配置信息中，将站点信息配置和功能模块配置等等配置信息个分成了两类目录，它们分别是对应的可用配置目录（\*-available/）和已被使用的配置目录（\*-enabled/），而每个被使用的配置目录下的文件其实就是可用配置目录下文件的软链接，而开启关闭这些配置，可以用下面的命令实现。

{% highlight Bash %}
/etc/apache2
     |__ apache2.conf
     |__ conf-availiable/
     |    |__ ...可用的配置文件
     |__ conf-enabled/
     |    |__ ...被使用的配置文件，实际上就是软链接
     |        $ sudo a2enconf filename  使用配置
     |        $ sudo a2disconf filename 取消使用
     |__ envvars
     |__ magic
     |__ mods-available/
     |    |__ ...可用的模块配置
     |__ mods-enabled/
     |    |__ ...被用的模块配置
     |        $ sudo a2enmod  filename
     |        $ sudo a2dismod filename
     |__ ports.conf  监听端口号配置
     |__ sites-available/
     |    |__ ...可用的站点配置，之后的站点配置都可以写在这
     |__ sites-enabled/
          |__ ...正在使用的站点
              $ sudo a2ensite  filename
              $ sudo a2dissite filename
{% endhighlight %}

比如，我要建立一个在**8080**上的，对应站点根目录在`/var/path/to/mysite/`的站点，首先，在`/etc/apache2/sites-available/`目录下，复制**000-default.conf**（`sudo cp 000-default.conf 001-mysite.conf`），并编辑。

{% highlight XML %}
# 1. 修改 001-mysite.conf 文件
<VirtualHost *:8080>
  ....
	DocumentRoot /var/path/to/mysite
  ....
	ErrorLog ${APACHE_LOG_DIR}/mysite.error.log
	CustomLog ${APACHE_LOG_DIR}/mysite.access.log combined
  ....
</VirtualHost>

# 2. 修改监听端口配置 ports.conf
Listen 80
Listen 8080
....
{% endhighlight %}

修改完后，使用命令`sudo a2ensite 001-mysite.conf`，然后重启Apache服务器（`sudo service apache2 restart`），访问 host-only-ip:8080就可以看到自己部署的网站了。
