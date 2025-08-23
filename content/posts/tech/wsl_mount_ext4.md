---
title: "在Windows系统中使用WSL2挂载ext4文件系统(Linux)的外接硬盘"
date: 2025-04-02T14:58:20+08:00
lastmod: 2025-08-23T14:58:20+08:00
author: "Zhu Dengda"
categories: []
tags: ["WSL2"]
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



+ 非外接硬盘，WSL2可直接支持，详见[链接](https://learn.microsoft.com/en-us/windows/wsl/wsl2-mount-disk)  
+ 若是使用usb的外接硬盘，WSL2官方提供的[方法](https://learn.microsoft.com/en-us/windows/wsl/connect-usb)————使用usbipd工具还不够，需要重新编译构建一个WSL2版本，其中参数选择支持USB大容量硬盘，详见[视频](https://www.youtube.com/watch?v=iyBfQXmyH4o)

挂载时给予用户权限：

``` bash
sudo mount -o uid=1000,gid=1000,fmask=113,dmask=002 /dev/sdd1 mount_dir
```

如果硬盘是NTFS文件系统，则WSL2可直接mount，不需要usbipd工具。例如以下挂载 E 盘（在windows文件管理器中显示），并分配用户权限

``` bash
sudo mount -o uid=1000,gid=1000,fmask=113,dmask=002 -t drvfs E: mount_dir
```