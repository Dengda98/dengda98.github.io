---
title: "AutoCAD2020激活时序列号无效的解决方案"
date: 2025-04-11T16:33:46+08:00
lastmod: 2025-04-11T16:33:46+08:00
author: "Zhu Dengda"
categories: []
tags: ["CAD"]
keywords: []

description: " " # 文章描述，与搜索优化相关
summary: " " # 文章简单描述，会展示在主页
weight: # 输入1可以顶置文章，用来给文章展示排序，不填就默认按时间排序
slug: ""
draft: false # 是否为草稿
comments: true
showToc: true # 显示目录
TocOpen: true # 自动展开目录
autonumbering: true # 目录自动编号
hidemeta: false # 是否隐藏文章的元信息，如发布日期、作者等
disableShare: true # 底部不显示分享栏
searchHidden: false # 该页面可以被搜索到
showbreadcrumbs: true # 顶部显示当前路径
mermaid: true
cover:
    image: ""
    caption: ""
    alt: ""
    relative: false
---

[链接](https://www.bilibili.com/opus/982466424572215298)

## 原因

出现如图问题是因为在此电脑中已经安装了高了好几个版本的AutoDesk软件，其中携带的许可证验证程序与低版本不相合。

## 解决方法

将现存高版本许可证验证程序卸载，并安装低版本许可证验证程序。

### 找到现存高版本许可证验证程序并将其卸载  
 一般路径是在`C:\Program Files (x86)\Common Files\Autodesk Shared\AdskLicensing`，然后以管理员身份运行路径下的`uninstall.exe`程序，等待自行卸载，直至该文件夹自行清空为止  (该过程没有进度条没有提示框，请勿担心)  

### 找到刚刚安装旧版本的许可证验证程序，再次运行
一般安装时安装包会先解压在`C:\Autodesk`路径下，然后在`C:\Autodesk\AutoCAD_2020_Simplified_Chinese_Win_64bit_dlm\x86\AdskLicensing\AdskLicensing-installer.exe`会有许可证验证程序，以管理员身份再次运行。

### 重新进行激活
激活可顺利进行。