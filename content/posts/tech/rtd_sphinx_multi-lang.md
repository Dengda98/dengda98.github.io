---
title: "ReadTheDocs+Sphinx多语言文档构建"
date: 2025-04-22T21:55:44+08:00
lastmod: 2025-04-27T21:55:44+08:00
author: "Zhu Dengda"
categories: []
tags: ["RTD"]
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
https://docs.readthedocs.com/platform/stable/guides/manage-translations-sphinx.html

https://zhuanlan.zhihu.com/p/427843476

https://www.cnblogs.com/oaks/p/12693166.html

sphinx官方文档：
https://www.sphinx-doc.org/en/master/usage/advanced/intl.html

(如果按RTD的叙述，加上`gettext_uuid=True`，生成的`.pot`文件中会有数字代码以跟踪版本，但这样会额外增加git提交信息)