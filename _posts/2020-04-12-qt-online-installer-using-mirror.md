---
layout: post
title: Qt在线安装包设置镜像
---

**Qt Online Installer** 在线安装过慢，使用镜像加速。

> 目前使用 **Qt** 安装程序，会强制登录验证，为了避免后续安装，建议 [注册](https://login.qt.io/register) 一个 **Qt** 账号

## 镜像准备

访问 **Qt** 官网选择镜像[^qt-mirrors]，这里我选择 **清华镜像源**[^tsinghua]。

[^qt-mirrors]: http://download.qt.io/static/mirrorlist/
[^tsinghua]: https://mirrors.tuna.tsinghua.edu.cn/qt/

确认镜像源各目录的用处，一般关注这两个打 **星号（*）**目录下内容：

```tree
  File Name  ↓          File Size  ↓    Date  ↓
  Parent directory/     -               -
  archive/              -               2019-12-18 13:30
  community_releases/   -               2017-02-23 13:29
  development_releases/ -               2019-05-17 22:44
  learning/             -               2013-05-22 21:20
  linguist_releases/    -               2019-03-26 13:49
  ministro/             -               2017-02-20 16:32
* official_releases/    -               2019-06-03 16:59
* online/               -               2014-03-13 14:45
  snapshots/            -               2019-05-16 19:07
  timestamp.txt         11 B            2020-03-24 22:00
```

## 下载在线安装包

在 `official_releases/official_releases/online_installers/` 目录下，可以找到各系统的 **Qt** 在线安装包。
由于我是 **Windows 10** 平台下，我选择下载 [qt-unified-windows-x86-online.exe](https://mirrors.tuna.tsinghua.edu.cn/qt/official_releases/online_installers/qt-unified-windows-x86-online.exe)。

## 选择在线库

浏览 [`online/qtsdkrepository/windows_x86/`](https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/windows_x86/) 目录下，选择 `desktop` 可以找到在线软件源，类似 **Debian** 下的 **APT** 源吧。

```tree
  File Name  ↓         File Size  ↓     Date  ↓
  Parent directory/    -                -
  android/             -                2020-03-17 16:19
* desktop/             -                2020-03-17 16:19
  root/                -                2013-12-12 01:35
  winrt/               -                2020-03-17 16:19
```

> 不同开发平台选择不同目录，例如 `MAC OS` 选择 [`../mac_x64/`](https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/mac_x64/)，`Linux 64位` 选择 [`../linux_x64/`](https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/linux_x64/) 等

## 添加在线库

打开 Qt 在线安装软件，点击左下角的 **设置**，选择 **资料档案库**，添加以下在线库

> 官网还有许多可以选择的环境，因为我只用到 MSVC 环境，所以没有选择其它环境，具体可以浏览 [在线库](https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/windows_x86/desktop/) 选择要装的环境和工具

```url
// 必选
https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/windows_x86/desktop/licenses
https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/windows_x86/desktop/tools_generic
https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/windows_x86/desktop/tools_ifw
https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/windows_x86/desktop/tools_vcredist
https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/windows_x86/desktop/tools_telemetry
https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/windows_x86/desktop/tools_maintenance

// Qt Creator 工具
https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/windows_x86/desktop/tools_qtcreator

// Qt 版本和源码，我这里选择 Qt 5.9.9 版本，如果需要其它版本，可以从 online 源里选择
https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/windows_x86/desktop/qt5_599
https://mirrors.tuna.tsinghua.edu.cn/qt/online/qtsdkrepository/windows_x86/desktop/qt5_599_src_doc_examples
```

## 设置 Hosts

因为 Qt 安装程序无论是否设置 **用户定义的资料档案库**，都会引用 `http://download.qt.io` 的官方源，所以我采用更改 **Hosts** 文件屏蔽官方源域名。

``` hosts
# C:\Windows\System32\drivers\etc\hosts
127.0.0.1 download.qt.io
```

## 安装 Qt Creator 和 Qt 依赖库

按照上述配置完成后，登录 **Qt** 账户，同意许可，选择 **Qt** 的安装路径和指定版本库即可。
