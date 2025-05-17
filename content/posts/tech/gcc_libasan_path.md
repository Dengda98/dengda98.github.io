---
title: "GCC查看libasan.so库路径"
date: 2025-05-17T10:42:52+08:00
lastmod: 2025-05-17T10:42:52+08:00
author: "Zhu Dengda"
categories: []
tags: ["GCC"]
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

为了使用libasan.so库帮我调查segmentation fault，需查看进行一些设置，其中使用了libasan.so库的路径，

1. gcc编译程序时加上 -g，这样后面报告问题时可以显示行号。
2. 使用gccc查看libasan.so库的位置，
``` bash
$ gcc -print-file-name=libasan.so
/usr/lib/gcc/x86_64-linux-gnu/11/libasan.so
```
3. 设置环境变量`LD_PRELOAD`，
``` bash
export LD_PRELOAD=/usr/lib/gcc/x86_64-linux-gnu/11/libasan.so
```
4. 这样每次运行程序时，就会有内存报告，提示内存问题出处。
5. 如果不想使用了，可使用`unset`撤销，
``` bash
unset LD_PRELOAD
```