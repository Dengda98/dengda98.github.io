---
title: "Zotero使用“author (date)”引用"
date: 2025-02-12T16:49:52+08:00
lastmod: 2025-02-12T16:49:52+08:00
author: "Zhu Dengda"
categories: []
tags: ["文献引用", "Zetero"]
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


**Zotero版本：v7.0.11**

--------
我在Word中使用Zotero插件进行文献引用，其中文内引用(in-text citation)常用"(author, date)"的形式，例如`(Dziewonski and Anderson, 1981)`。但通常CSL样式中没有"author (date)"的形式，而引用作为句子一部分时需要使用这种形式，例如`"Dziewonski and Anderson (1981) proposed ..."`。


## Zotero添加引用——现代界面
在默认情况下，在Word中使用Zotero添加引用时，弹出的界面如下
![alt text](image.png)
点击对应文献后，
![alt text](image-1.png)
点击备选的引用框，弹出弹窗
![alt text](image-2.png)
勾选`省略作者`，按回车，即可得到`(1981)`的域代码，然后再在前面手动补充作者信息。

## Zotero添加引用——经典界面
在Zotero设置中，勾选`使用经典版“添加引注”对话框`
![alt text](image-3.png)
此时在Word中添加引用时，弹出的界面如下
![alt text](<image-4.png>)
同样勾选“省略作者”即可。

## 存在的问题
作者名修改无法同步。