---
title: "使用Shell脚本的一些小建议"
date: 2025-11-15T13:31:37+08:00
lastmod: 2025-11-15T13:31:37+08:00
author: "Zhu Dengda"
categories: []
tags: ["Shell"]
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

别把 Shell 当做"脚本语言"。

Shell 的首要身份是 **“交互式命令行解释器”** ，其次才是“脚本语言”。“灵活性”和“简洁性”的优先级通常高于“绝对的严谨性”。

如果真的要写，为了编写最健壮的 Bash 脚本，社区推荐在脚本开头使用以下组合：`set -euo pipefail`

+ set -e (errexit): 任何命令返回非零退出状态码（表示失败），脚本立即退出。
+ set -u (nounset): 使用未定义变量时，脚本立即退出。
+ set -o pipefail: 在管道（|）中，只要有任何一个命令失败，整个管道的退出状态码就是失败的（非零）。默认情况下，只有最后一个命令的退出码才算数。

当然，对复杂脚本，直接用 python 吧。