---
title: "解决sphinx_rtd_theme主题数学公式编号偏移"
date: 2025-05-08T16:55:44+08:00
lastmod: 2025-05-08T16:55:44+08:00
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

这个问题从2016年就在Github上讨论，至今官方没有提供合适的解决方案，算是这个主题的痛点。但Github issue中有用户给出了一些work around，我尝试了一下觉得还行，我这里记录一下。

链接：  
+ https://github.com/readthedocs/sphinx_rtd_theme/issues/301
+ https://github.com/readthedocs/sphinx_rtd_theme/pull/383


``` css
div.math {
    position: relative;
    padding-right: 2.5em;
}
.eqno {
    height: 100%;
    position: absolute;
    right: 0;
    padding-left: 5px;
    padding-bottom: 5px;
    /* Fix for mouse over in Firefox */
    padding-right: 1px;
}
.eqno:before {
    /* Force vertical alignment of number */
    display: inline-block;
    height: 100%;
    vertical-align: middle;
    content: "";
}
.eqno .headerlink {
    display: none;
    visibility: hidden;
    font-size: 14px;
    padding-left: .3em;
}
.eqno:hover .headerlink {
    display: inline-block;
    visibility: hidden;
    /* margin-right: -1.05em; */  /* 鼠标悬停时会偏移 */
}
.eqno .headerlink:after {
    visibility: visible;
    content: "\f0c1";
    font-family: FontAwesome;
    display: inline-block;
    margin-left: -.9em;
}
/* Make responsive */
.MathJax_Display {
    max-width: 100%;
    overflow-x: auto;
    overflow-y: hidden;
}

```