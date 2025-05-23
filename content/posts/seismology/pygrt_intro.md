---
title: "PyGRT: 高效、便捷计算半无限分层介质中理论地震图的C/Python程序包"
date: 2025-05-17T10:50:28+08:00
lastmod: 2025-05-17T10:50:28+08:00
author: "Zhu Dengda"
categories: []
tags: ["Python", "C", "PyGRT"]
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

**Github 链接：** https://github.com/Dengda98/PyGRT  
**中文文档介绍：** https://pygrt.readthedocs.io/zh-cn/latest/ 


## 写在最后

我是在2022年春季在雁栖湖校区选修的由中国科学院大学地球与行星科学学院开设的《理论地震学》课程，该课程由中国科学院地质与地球物理研究所的[李娟](https://igg.cas.cn/sourcedb_igg_cas/cn/zjrck/200907/t20090713_2065459.html)老师和[郝金来](https://igg.cas.cn/sourcedb_igg_cas/cn/zjrck/201502/t20150210_4311909.html)老师讲授。感谢两位老师的精彩讲授！

课程难度很大，对数学物理的要求很高。由于课程时间有限，加之我所掌握的数理基础偏薄弱，扪心自问，有太多内容我并没有完全理解。尤其是介质模型从 *无限均匀模型* 变为 *半无限均匀模型* ，再到 *半无限水平分层均匀模型* 时，我不禁感叹先哲们的精妙解法，但又遗憾自己能力有限只能理解到表层。  

课程使用的参考教材为Aki和Richards合著的《Quantitative Seismology》（定量地震学）以及姚振兴老师和谢小碧老师合著的《理论地震学（初稿）》（等待出版）。其中这门课前半段中主要是基于《Quantitative Seismology》对部分内容进行了入门，包括 *无限和半无限均匀模型* 中理论地震图解法的初步了解，以及面波理论的简介，其中浩瀚的公式在有限的课时里也不可能讲授完（我斗胆曾试图硬啃，但到了Chapter 5-6往后就太吃力了）； 后半段基于《理论地震学（初稿）》对 *半无限水平分层均匀模型* 中理论地震图的解法做了比较详细的介绍，包括不同震源的震源系数，及其在水平层中不断的反射透射而形成广义反射透射系数矩阵，然后再使用离散波数积分得到格林函数频谱。

再回看时，发现《理论地震学（初稿）》中对公式的介绍很详细，尽管过程繁琐，但内容逻辑很清楚，将震源系数、矩阵系数等结果都给了出来（除少量笔误）。或者说，该书几乎已经把所有的计算思路写好了。不过还是由于课时限制，当时这些公式并没有自己推导过，也没有公式和计算结果直接对比可视化。尽管在地震学领域早已有解类似问题的开源代码，课程也开展了相关的小组研讨活动，但都和教材的公式推导方法不一致，对于程序输入参数没有直观的概念，且随着计算机的高速发展，部分代码已经出现兼容性问题，在代码阅读和程序运行上就形成了阻碍，我只能是囫囵吞枣地先接受，而又理解得太慢。  

回所开展科研工作后，干的活被迫很少涉及这一块儿了，但偶尔一间接涉及，也不愿只是跑跑程序，还是会时不时拿起教材再看看，再在草稿纸上划划。不久后购买了张海明老师的著作 [《地震学中的Lamb问题（上）》](https://www.ecsponline.com/goods.php?id=210382)，论述非常详细，解答了我不少的疑惑，前言的阅读建议也让我更想动手实现。

2024年2月，做了各种思想准备，反复翻阅《理论地震学（初稿）》，参考相关文献，利用[sympy](https://www.sympy.org/en/index.html>)工具辅助做了不少公式推导，了解类似程序的一些痛点，决定以**Python+C**混合编写 **PyGRT** 程序，**且最终可保留C程序和Python程序两种运行方式，底层调用相同库文件**。程序主体写得很快，不过初试果然有bug，加上各种琐事到来，又搁置了。  

2024年7月，再回想起这个程序，不甘心，再找bug，终于改好。之后制作了程序文档以及一些示例。

**PyGRT** 的计算逻辑基本都来自《理论地震学（初稿）》，包括内部代码注释的公式索引也都来自于此。有一些核心公式做了计算优化，防止浮点数精度吞太多。

到目前为止，**PyGRT已增加了应力、应变、旋转张量的计算，且可求解动态解和静态解**，同时在数值上增加了自适应Filon积分(SAFIM)。基于Github Action在线编译了多个操作系统的**PyGRT** 版本，无需再编译，下载即用。

课程难度大，老师们能做的很有限，更多的需要自己摸索。程序本身也只是工具，编写了程序也不代表能理解透彻，知识有待更多的测试和挖掘。如果之后有同学学习《理论地震学》时，能因为 **PyGRT** 程序而少走一些弯路，减少一些困惑，理解得更深刻，那我最初的想法就达到了。如果 **PyGRT** 能用于你的科研工作，Let Me Know！我不胜荣幸，欢迎讨论指导！






