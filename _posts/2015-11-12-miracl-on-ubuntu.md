---
layout: post
title: "在Ubuntu上编译使用MIRACL"
author: 吴彦昌
date: 2015-11-14 00:25:00 +8:00
tags: ubuntu miracl compilare
thread_key: 2015-11-12-miracl-on-ubuntu
---

[*MIRACL*](https://www.certivox.com/miracl)是一个用C语言写的，主要用来操作大数的密码开发库。因为在应用一些密码协议时，大素数的获取以及大整数的处理尤为困难，所以这个开发库给这些密码协议的实现提供了便利。在这里，我放一些比较有用的经验，希望能给大家一些启发。

> 其中，我是在它的Github的项目[^github]上下到的[源码](https://github.com/CertiVox/MIRACL){:target="blank"}，可能不是最新的，因为这个是在课堂上用的，只是个人练习用，估计没什么区别吧。还有，以下的操作是我在**Ubuntu14.04**上实验过，如果其他系统有些许差异，还望见谅。

首先，下载Github上的项目源码，其中，我下到的是**.zip**压缩包，名字叫**MIRACL-mater.zip**，这个压缩包中包括源码，以及一个比较用的官方手册**manual.doc**。

之后就是让我头疼的编译了，当然，有关一些编译的问题，压缩包的手册也有讲，官网上自然也有[介绍](http://docs.certivox.com/docs/miracl/miracl-users-manual/installation){:target="blank"}[^installation]，但是我试了官网的方法，总是编译失败，通过上网查询，结果发现官网的那段代码有问题，因为它提供的代码是宽字符的横杠，结果复制的代码一直报错。但是，我按照那个方法编译，或多或少都有点问题，结果上网发现另一个[比较简便的方法](http://forum.ubuntu-it.org/viewtopic.php?p=4819326){:target="blank"}[^compilare-on-ubuntu]。

{% highlight bash %}
# 首先先建立一个目录用来放置源码
$ mkdir miracl
$ cd /path/to/miracl
# 然后将上面下载成功的MIRACL-mater.zip放到刚才创建的空目录下
$ cp /path/to/MIRACL-mater.zip ./
# 解压zip包，这步当时可是吓到我了，把所有文件都放在这个目录
$ unzip -j -aa -L MIRACL*.zip
# 上面这段命令是将所有非目录的文件解压在当前目录下（瞬间一堆文件吓到我了）
# 最后是编译，虽然源码中有提供make文件，但是不是很好用
# 所以用一个shell文件，其中64位系统用64的shell文件
$ bash linux64
# 如果是32位系统，用这个命令（我是64位系统，没试过这个行不行，只试了上面那个）
$ bash linux
# 最后测试一下是否编译成功，运行源码提供的示例代码 pk-demo
$ ./pk-demo
# 这个程序是个简单检验 迪菲－赫尔曼密钥交换（Diffie–Hellman key exchange）协议的正确性
# 如果输出是些正常的信息，那估计是成功了
...
{% endhighlight %}

下面，编译完了，自然是要用的，其中源码编译完后的必需的文件是两个头文件`miracl.h`和`mirdef.h`以及编译后的静态函数库`miracl.a`，需要在自己写的C程序中使用。

> 注意，这是C需要的，不是C++的，好像C++需要其他一些头文件，但是好像有提供c++库的编方式，如果没猜错应该是 linux_cpp 和 linux64_cpp，具体没试过，还请自行尝试一下，也可以在下方留言说一下自己的结果供他人参考

{% highlight bash %}
# 示例：自己写的源文件是 main.c （多文件的话，例如有main1.c）
# 先浏览一下当前项目目录下的文件
$ ls
main.c [main1.c] miracl.a miracl.h miradef.h
# 需要存在以上这类文件，然后用gcc编译，并输出 main 的二进制程序
$ gcc main.c [main1.c] miracl.a -o main
# 编译成功，并能成功运行就行了
{% endhighlight %}

关于**MIRACL**的API函数的使用，[官方文档](http://docs.certivox.com/docs/miracl/miracl-reference-manual){:target="blank"}[^docs]有些许介绍。

另：附上一些有关密码学的相关链接

1. [迪菲－赫尔曼密钥交换 - 维基百科，自由的百科全书](https://zh.wikipedia.org/wiki/%E8%BF%AA%E8%8F%B2%EF%BC%8D%E8%B5%AB%E5%B0%94%E6%9B%BC%E5%AF%86%E9%92%A5%E4%BA%A4%E6%8D%A2){:target="blank"}

2. [RSA算法原理（一） - 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2013/06/rsa_algorithm_part_one.html){:target="blank"}


------

[^github]: [MIRACL在Gihub上的项目链接](https://github.com/CertiVox/MIRACL){:target="blank"}
[^installation]: [miracl官方手册上的安装方法](http://docs.certivox.com/docs/miracl/miracl-users-manual/installation){:target="blank"}
[^compilare-on-ubuntu]: [Come compilare ed usare lib MIRACL in ubuntu? • Forum Ubuntu-it](http://forum.ubuntu-it.org/viewtopic.php?p=4819326){:target="blank"}
[^docs]: [MIRACL Reference Manual](http://docs.certivox.com/docs/miracl/miracl-reference-manual){:target="blank"}
