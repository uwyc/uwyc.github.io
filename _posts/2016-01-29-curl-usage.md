---
layout: post
title:  "CURL Usage"
date:   2016-01-29 +0800
tags: debian development web
---

CURL —— 一款用来检测HTTP路由的工具

安装步骤
=======
```bash
$ sudo apt-get install curl
```

使用方法
==========================================================
```bash
;; GET Method(Default)
$ curl localhost:8080/predictions
$ curl --request GET localhost:8080/predictions/
$ curl localhost:8080/predictions?id=31
;; GET Method with Header (ex.Use GET request for JSON data)
$ curl --header "Accept: application/json" localhost:8080/predictions/
$ curl --header "Accept: application/json" localhost:8080/predictions?id=31
;; POST Method with Data
$ curl --request POST --data "who=Mike&what=Hello world" localhost:8080/predictions/
;; PUT Method with new Data
$ curl --request PUT --data "id=33#what=This is an update" localhost:8080/predictions/
;; DELETE Method
$ curl --request DELETE localhost:8080/predictions?id=33
```
