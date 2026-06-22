---
title: "设置任意暂停Windows更新时长"
date: 2026-03-06T22:04:23+08:00
lastmod: 2026-03-06T22:04:23+08:00
author: "Zhu Dengda"
categories: []
tags: ["Windows"]
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


1. win+r，输入regedit打开注册表
2. 打开注册表的这个路径  `计算机\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings`,
右键空白的地方新建DWORD值命名为：`FlightSettingsMaxPauseDays`

3. 双击 `FlightSettingsMaxPauseDays` ,修改里面的值为 10000，右边基数设置为十进制。
设置为 10000 就是最多暂停 10000 天，这个值可以自己定义。
然后在Windows设置的“Windows更新”，点击“暂停更新”的下拉列表，就会发现超长的可供选择时长列表。

{{< alert type="warning" title="注意事项" >}}
`FlightSettingsMaxPauseDays` 这个值别设置太大，否则下拉列表打开很卡。
{{< /alert >}}