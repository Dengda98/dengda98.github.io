---
title: "关于GMT中grdcontour -N的用法"
date: 2025-09-24T17:23:50+08:00
lastmod: 2025-09-24T17:23:50+08:00
author: "Zhu Dengda"
categories: []
tags: ["GMT"]
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

grdcontour -N要求使用离散型cpt，在当前GMT版本(6.6)下，如果设置输出为矢量图（例如pdf），
grdcontour -N在等值线之间填充的色块会有细小的白色网格分界线，且输入的grd网格越密，网格分界线越密，pdf文件体积越大。

推测与解决方法大概是这样：

1、grdcontour -N填充的色块和grdimage的效果在矢量图上的机制应该不一样。你可以在你的脚本上对比这两个命令分别生成的pdf大小有很大差别，使用grdimage生成的pdf体积会要小很多。使用其它工具打开grdcontour -N的结果也会很卡，而且从这个网格线来看，推测它是把每个色块当作一个四边形去渲染，导致网格变密pdf体积就增大，而grdimage应该是把网格光栅化(raster)成图片，其pdf体积就小很多。
2、grdcontour -N本来就需要传入离散型cpt，而既然有了离散cpt，就可直接使用grdimage绘制了。初看会很糊，可使用grdimage -E1000改变重采样精度，效果就会好很多。

所以如果是需要使用矢量图+等值线填充，就使用离散型cpt+grdimage吧，当然如果生成png位图就无所谓了。

