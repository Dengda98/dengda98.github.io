---
title: "Windows系统使用robocopy命令多线程复制文件"
date: 2025-07-26T12:52:32+08:00
lastmod: 2025-07-26T12:52:32+08:00
author: "Zhu Dengda"
categories: []
tags: [Windows]
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


在 Windows 上复制大量小文件时，如果直接使用文件资源管理器界面的复制/粘贴，其需要复制前计算文件所有文件数量和大小，对于大量小文件很耗时。
建议使用 `robocopy` 命令（鲁棒文件复制工具），它比普通的 `xcopy` 或 `copy` 更高效且支持断点续传：

``` bash
robocopy "源文件夹路径" "目标文件夹路径" /E /ZB /COPYALL /R:3 /W:5 /TEE /V /MT:16 /LOG:复制日志.txt
```

参数说明：

+ /E - 复制所有子目录（包括空目录）

+ /ZB - 使用重启模式（如果拒绝访问则使用备份模式）

+ /COPYALL - 复制所有文件信息（数据、属性、时间戳、权限等）

+ /R:3 - 失败时重试3次（默认是100万次，这里减少等待）

+ /W:5 - 重试间隔5秒（默认30秒）

+ /TEE - 输出显示到控制台同时写入日志

+ /V - 生成详细输出

+ /MT:16 - 使用16线程复制（根据CPU核心数调整，范围1-128）

+ /LOG: - 生成日志文件（便于排查问题）