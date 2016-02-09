---
layout: post
title: "Installing LAMP with Docker"
date: 2016-02-28 20:52 +8:00
tags: debian docker apache php
---

之前，我介绍了[使用Vagrant安装开发环境]({% post_url 2015-11-22-installing-LAMP-with-vagrant %})，因为当时是因为刚从Windows转到Ubuntu（但是，现在已经在用Debian了，我是被Ubuntu的内部错误吓怕了...），于是显而易见地使用Vagrant来配置开发环境，而且当时还想介绍如何使用那套开发环境的说，结果就弃坑了，然后，在逐步了解Docker后，发现在Linux下使用Vagrant安装Linux开发环境有点鸡肋了，而且占用内存（无论是物理内存还是运行内存）也大。    

但是如果是Windows下尝试Linux的开发环境，还是可以使用Vagrant，使用都差不多，但是两者的虚拟技术是不一样的，Vagrant是中规中矩地建立一个虚拟机，而Docker是在Linux的内核上建立类似类似沙盒的与真实系统隔离的软件环境，具体两者的区别网上都有很多解释了，我就把我如今的使用流程简单地在这记录一下吧。    

前言
====
* 认真研读官方文档[^official-doc]：其实没有什么东西比官方文档更权威了，虽然有些开发技术或语言的官方文档写得太深奥或是太简单啥的，这些就另当别论了吧，但是安装方面，官方文档还是写得挺好的，言简意赅，当然，如果英文啥的是软肋，还是有中文方面的资料[^dockerpool]的，我就是结合着一起看的；    
* 确认自己的系统类型和版本，在这里我的系统是 Debian 8(Jessie 64位)，后续安装也是以这个为基准，自然官网上也有其他系统版本的安装；    
* 注意：我是安装官网的最新版本，不是系统软件库里的稳定版本，如果出现问题，那就只能给官方反馈Bug咯（当然，也可通过搜索引擎自己解决），我是安装成功的。    

安装
====
* 首先，向apt源中添加公钥，以确保安全性    

``` bash
$ sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
```

* 再在源列表中添加docker源    

``` bash
;; 编辑路径 '/etc/apt/sources.list.d/docker.list' 的文件
;; 如果该文件不存在，就创建一个，如下
$ sudo echo 'deb http://apt.dockerproject.org/repo debian-jessie main' > /etc/apt/sources.list.d/docker.list
$ sudo apt-get update
;; 确认 'apt' 包管理系统存在该软件包
$ sudo apt-cache policy docker-engine
;; 安装 Docker
$ sudo apt-get install -y docker-engine
```

基础配置
=======
* 因为Docker默认安装后，每次执行都要索取`root`权限，针对只有一个用户的个人系统来说，很不方便。下面使用来自官方的解决方法。  

``` bash
;; 如果不存在 'docker' 用户组，就创建一个
$ sudo groupadd docker
;; 向 'docker' 用户组中添加管理员的用户（如果是个人电脑，一般就是当前管理员'${USER}'）
$ sudo gpasswd -a ${USER} docker
;; 重启 'docker' 服务
$ sudo service docker restart
```

安装LAMP
========
* Docker的开发环境也跟Vagrant一样，也有一个仓库（英文名：Docker Hub）[^docker-hub]，只要在上面搜索关键词，基本都能搜到，仓库上的资源有官方认证的也有其他开发者自己的。    
* 在这里，我使用的是，一个是官方的[mysql](https://hub.docker.com/_/mysql/){:target="blank"}，另一个是改写自[wordpress](https://hub.docker.com/_/wordpress/){:target="blank"}官方 __Dockerfile__ 的[php](https://hub.docker.com/_/php/){:target="blank"}    
* 下载环境以及对应的版本（不填写版本tag的话，默认是latest），其中我的 __Dockerfile__ 如下：

```
FROM php:5.6-apache

# Base on wordpress:apache Dockfile
# 基于wordpress:apache的Dockfile
RUN a2enmod rewrite expires

# install the PHP extensions we need
# 安装必要的PHP插件
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mysqli opcache pdo_mysql

# Change uid 1000 to www-data avoid 403 forbidden
# 更改www-data用户的用户id至1000，避免出现403错误
RUN usermod -u 1000 www-data && groupmod -g 1000 www-data
```

```bash
;; 下载官方的mysql镜像
$ docker pull mysql
;; 由于官方的php镜像是纯净的，不含php插件（包括mysqli等）
;; 所以选择自己编写'Dockerfile'(如上)，或者选择'workpress'的官方镜像
;; 我是选择模仿'workpress'的'Dockerfile'改写了自己的'Dockerfile'
$ docker build -t php-with-mysqli:5.6-apache /path/to/Dockerfile
;; 等待一段时间建立自定义镜像，然后查看已安装的镜像，就可以看到自己的镜像
$ docker images
```
![Docker镜像列表](/img/2016-02-28-000.png)

* 因为要在之后的apache容器中使用mysql服务，先建立mysql容器，具体运行参数还是参考Docker Hub上的资料吧。    

```bash
;; 建立'mysql'后台服务，名称取为'db'，且分配映射3306端口
$ docker run -p 3306:3306 --name db -e MYSQL_ROOT_PASSWORD=root -d mysql
;; 建立'php-apache'后台服务，名称取为'php-apache-app'，链接到'db'，映射80端口且挂载网站目录
$ docker run -p 80:80 --name php-apache-app -v "/path/to/html":/var/www/html --link db:mysql -d php-with-mysqli:5.6-apache
```
![Docker正在运行的容器](/img/2016-02-28-001.png)

开始使用
=======
* 在 __/path/to/html/__ 下建立一个php文件，保存文件名为 __hello.php__ ，文件内容如下：    

```php
<?php
phpinfo();
 ?>
```

* 访问 __localhost/hello.php__ ，可以看到一些必须知道的参数，如下图：

![PHP全局变量](/img/2016-02-28-002.png)

* 之后，你就可以在 __/path/to/html/__ 目录下部署你的php项目。

```bash
;; 关闭容器
$ docker stop some-container
;; 打开容器
$ docker start some-container
;; 进入容器的终端（即Bash）
$ docker exec -i -t some-container bash
```


[^official-doc]: 官方安装最新版Docker教程：[https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/){:target="_blank"}    
[^dockerpool]: DockerPool的中文Doker教程：[http://dockerpool.com/static/books/docker_practice/](http://dockerpool.com/static/books/docker_practice/){:target="_blank"}    
[^docker-hub]: Docker官方仓库：[https://hub.docker.com/](https://hub.docker.com){:target="_blank"}
