---
title: "利用Hugo+PaperMod+Github Pages搭建个人博客"
date: 2025-02-12T10:35:08+08:00
lastmod: 2025-04-18T10:35:08+08:00
author: "Zhu Dengda"
categories: []
tags: ['Blog']
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
ShowLastMod: true #显示文章更新时间
mermaid: true
cover:
    image: ""
    caption: ""
    alt: ""
    relative: false
---


[Github博客源码](https://github.com/Dengda98/dengda98.github.io)

经过多次尝试，终于搭建了个人博客。其中参考了多位大佬在网上分享的流程，并做了整合和适当修改。由于随时间推移，有的的博客域名可能过期，这里将整个流程都进行记录。

{{< alert type="note" title="注意事项" >}}
以下内容更多的是为了备份，建议新手查看其它博客学习入门。
{{< /alert >}}

{{< alert type="note" title="注意事项" >}}
Hugo等程序可能由于版本更新，可能存在变量名称和函数接口的更替，导致之前参考博客中的代码不可用，需要进行修改。
{{< /alert >}}

为保持一致性，这里声明该流程适用的版本：  
+ **Hugo v0.143.1**
+ **PaperMod v8.0**  

**操作系统：Ubuntu 22.04**


## Git安装和配置
``` bash
# 更新缓存
sudo apt update

# 安装git
sudo apt install git

# 配置git
git config --global user.name "your_user_name"
git config --global user.email "your_mail"

# 查看配置是否生效
git config --list

# 生成本地ssh key添加到github
ssh-keygen -t rsa -C "your_mail"

# 查看公钥
cat ~/.ssh/id_rsa.pub

# 进入github的settings设置，添加公钥即可
```

## Go编译器安装
``` bash
# 下载go
sudo apt install golang-go

# 验证安装
go version
# 我的输出: go version go1.18.1 linux/amd64

```

## 安装Hugo

[参考链接](https://www.shaohanyun.top/posts/env/blog_build1/)

[Hugo](https://gohugo.io/) 是一个开源的静态网站生成器，广泛用于构建个人博客、公司网站、文档网站等。它以 `Go` 语言编写，因此非常高效，生成网站速度快。Hugo 支持Markdown作为内容格式，并能将其转换为HTML。在初期我比较了Hexo和Hugo，最后Hugo高效性深得我心。

[Hugo官方安装说明](https://gohugo.io/installation/)

``` bash
# 由于apt提供的hugo版本更新不及时，这里使用snap安装
sudo snap install hugo

# 查看hugo版本
hugo version
# 我的输出：hugo v0.143.1-0270364a347b2ece97e0321782b21904db515ecc+extended linux/amd64 BuildDate=2025-02-04T08:57:38Z VendorInfo=snap:0.143.1
```

--------------------------
(2025.04.18更新)  
不建议使用snap安装hugo，snap会自动更新hugo版本，导致你本地编译调试出错。建议安装预编译好的[hugo](https://gohugo.io/installation/linux/#prebuilt-binaries)版本，能够固定版本。


## 新建站点
在本地合适目录下运行以下命令：
``` bash 
hugo new site myblog -f yml
```
可在当前目录下生成新文件夹`myblog/`，其中为hugo生成的博客框架：
``` bash 
$ ll
total 44
drwxr-xr-x 10 zhudengda zhudengda 4096 Feb 12 13:22 ./
drwxr-xr-x 14 zhudengda zhudengda 4096 Feb 12 13:22 ../
drwxr-xr-x  2 zhudengda zhudengda 4096 Feb 12 13:22 archetypes/
drwxr-xr-x  2 zhudengda zhudengda 4096 Feb 12 13:22 assets/
drwxr-xr-x  2 zhudengda zhudengda 4096 Feb 12 13:22 content/
drwxr-xr-x  2 zhudengda zhudengda 4096 Feb 12 13:22 data/
-rw-r--r--  1 zhudengda zhudengda   83 Feb 12 13:22 hugo.toml
drwxr-xr-x  2 zhudengda zhudengda 4096 Feb 12 13:22 i18n/
drwxr-xr-x  2 zhudengda zhudengda 4096 Feb 12 13:22 layouts/
drwxr-xr-x  2 zhudengda zhudengda 4096 Feb 12 13:22 static/
drwxr-xr-x  2 zhudengda zhudengda 4096 Feb 12 13:22 themes/
```
### 尝试创建一篇博客
在`myblog/`目录下运行以下命令：
``` bash 
hugo new content post1.md
```
生成`myblog/content/post1.md`，这是一篇空博客，文件头部有参数信息：
``` markdown
+++
date = '2025-02-12T13:32:33+08:00'
draft = true
title = 'Post1'
+++
```
其中`draft = true`表明这是一篇草稿，默认情况下不会被hugo编译。当运行
``` bash
hugo
```
`myblog/`路径下会生成`myblog/public`，其中是编译好的静态网页。当运行
``` bash
hugo server
```
hugo会编译博客并映射到本地端口，通常是`http://localhost:1313/`（依具体输出），这方便写博客时实时观察渲染效果。如果希望草稿也编译，运行
``` bash
hugo server -D
```
-------

{{< alert type="note" title="注意事项" >}}
到这一步完成了入门的第一步，其它基础知识详见hugo的官方入门，其中详细介绍了每个文件夹的用途，这也是以下配置主题以及其它自定义内容所必须的。
{{< /alert >}}

[Hugo官方入门](https://gohugo.io/getting-started/)

-------

## 安装PaperMod
Hugo也提供了[官方主题](https://themes.gohugo.io/)，这里以[PaperMod](https://github.com/adityatelange/hugo-PaperMod)为例，使用`git submodule`的方法进行安装。在`myblog/`目录下运行：

``` bash
# 初始化git库
git init 

# 添加子库，其中--depth=1表示只保留最新的commit记录
git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod

# needed when you reclone your repo (submodules may not get cloned automatically)
git submodule update --init --recursive 
```

下载的主题在`myblog/themes/PaperMod`。

## 设置hugo.yml
`hugo.yml`中保存了对hugo博客以及主题扩展的参数设置，我的设置参考了[链接1](https://cloud.tencent.com/developer/article/1944138)和[链接2](https://www.shaohanyun.top/posts/env/blog_build2/)，并做了适当更改。

``` yaml
baseURL: "https://dengda98.github.io/" # 绑定的域名
title: ZhuDengda's Blog
theme: PaperMod # 主题名称，和themes文件夹下的一致
languageCode: zh-cn # en-us

hasCJKLanguage: true # 自动检测是否包含中文日文韩文,如果文章中使用了很多中文引号的话可以开启
enableInlineShortcodes: true
enableEmoji: true # 允许使用 Emoji 表情，建议 true
enableRobotsTXT: true
buildDrafts: false
buildFuture: false
buildExpired: false
enableEmoji: true
pygmentsUseClasses: true
# googleAnalytics: UA-123-45


pagination:
  pagerSize: 10    # 首页每页显示的文章数


minify:
    disableXML: true
    # minifyOutput: true

permalinks:
  post: "/:title/"
  # post: "/:year/:month/:day/:title/"

defaultContentLanguage: zh # 最顶部首先展示的语言页面
defaultContentLanguageInSubdir: true

languages:
    zh:
      languageName: "Chinese"
      # contentDir: content/english
      weight: 1
      # custom params for each language should be under [langcode].parms - hugo v0.120.0
      # params:
      #   profileMode:
      #     enabled: true
          # title: ""
          # subtitle: ""
          # imageUrl: ""
          # imageTitle:
          # imageWidth: 150
          # imageHeight: 150
          # buttons:
          #   - name: 👨🏻‍💻技术
          #     url: posts/tech
          #   - name: 📕阅读
          #     url: posts/read
          #   - name: 🏖生活
          #     url: posts/life

      menu:
        main:
          - identifier: search
            name: 🔍搜索
            url: search
            weight: 1
          - identifier: home
            name: 🏠主页
            url: /
            weight: 2
          - identifier: posts
            name: 📚博客
            url: /posts
            weight: 3
          - identifier: archives
            name: ⏱时间轴
            url: /archives
            weight: 20
          # - identifier: categories
          #   name: 🧩分类
          #   url: categories
          #   weight: 30
          - identifier: tags
            name: 🔖标签
            url: /tags
            weight: 40
          - identifier: about
            name: 🙋🏻‍♂️关于
            url: /about
            weight: 50
          # - identifier: links
          #   name: 🤝友链
          #   url: links
          #   weight: 60

outputs:
    home:
        - HTML
        - RSS
        - JSON

params:
    env: production # to enable google analytics, opengraph, twitter-cards and schema.
    description: "这是一个纯粹的博客......"
    author: Zhu Dengda
    # author: ["Me", "You"] # multiple authors

    homeInfoParams:
      Title: Zhu Dengda
      Content: >
        👻 A PhD candidate in Seismology from Institute of Geology and Geophysics, 
        Chinese Academy of Sciences (**IGGCAS**), Beijing.   

        🕳️ Still struggling, trying to Escape the Absurdity.   

        💻 Love programming.

    enableSearch: true
    defaultTheme: light  # defaultTheme: light or  dark
    disableThemeToggle: false
    DateFormat: "2006-01-02"
    ShowShareButtons: true
    ShowReadingTime: true
    # disableSpecialistPost: true
    displayFullLangName: true
    ShowPostNavLinks: true
    ShowBreadCrumbs: true
    ShowCodeCopyButtons: true
    hideFooter: false # 隐藏页脚
    ShowWordCounts: true
    VisitCount: true

    ShowLastMod: true #显示文章更新时间

    ShowToc: true # 显示目录
    TocOpen: true # 自动展开目录

    comments: true

    socialIcons:
        - name: github
          url: "https://github.com/Dengda98"
        # - name: twitter
        #   url:  "img/twitter.png"
        # - name: bilibili
        #   url: ""
        # - name: QQ
        #   url: "img/qq.jpg"
        - name: email
          url: "mailto:zhudengda[At]mail.iggcas.ac.cn"
        # - name: RSS
        #   url: "index.xml"
        # - name: facebook
        #   url: ""
        # - name: instagram
        #   url: "img/instagram.png"
        # - name: QQ
        #   url: "img/qq.png"
        # - name: Phone
        #   url: "img/phone.png"


    # editPost:
    #     URL: "https://github.com/adityatelange/hugo-PaperMod/tree/exampleSite/content"
    #     Text: "Suggest Changes" # edit text
    #     appendFilePath: true # to append file path to Edit link

    # label:
    #     text: "Home"
    #     icon: icon.png
    #     iconHeight: 35

    # analytics:
    #     google:
    #         SiteVerificationTag: "XYZabc"

    assets:
        favicon: "img/logo.gif"
        favicon16x16: "img/logo.gif"
        favicon32x32: "img/logo.gif"
        apple_touch_icon: "logo.gif"
        safari_pinned_tab: "logo.gif"

    # cover:
    #     hidden: true # hide everywhere but not in structured data
    #     hiddenInList: true # hide on list pages and home
    #     hiddenInSingle: true # hide on single page

    fuseOpts:
        isCaseSensitive: false
        shouldSort: true
        location: 0
        distance: 1000
        threshold: 1
        minMatchCharLength: 0
        keys: ["title", "permalink", "summary"]

    twikoo:
      version: 1.4.11

taxonomies:
    category: categories
    tag: tags
    series: series

markup:
    goldmark:
        renderer:
            unsafe: true # HUGO 默认转义 Markdown 文件中的 HTML 代码，如需开启的话
    highlight:
        # anchorLineNos: true
        codeFences: true
        guessSyntax: true
        lineNos: true
        # noClasses: false
        # style: monokai
        style: darcula

        # codeFences：代码围栏功能，这个功能一般都要设为 true 的，不然很难看，就是干巴巴的-代码文字，没有颜色。
        # guessSyntax：猜测语法，这个功能建议设置为 true, 如果你没有设置要显示的语言则会自动匹配。
        # hl_Lines：高亮的行号，一般这个不设置，因为每个代码块我们可能希望让高亮的地方不一样。
        # lineNoStart：行号从编号几开始，一般从 1 开始。
        # lineNos：是否显示行号，我比较喜欢显示，所以我设置的为 true.
        # lineNumbersInTable：使用表来格式化行号和代码,而不是 标签。这个属性一般设置为 true.
        # noClasses：使用 class 标签，而不是内嵌的内联样式

privacy:
    vimeo:
        disabled: true
        simple: true

    twitter:
        disabled: true
        enableDNT: true
        simple: true

    instagram:
        disabled: false
        simple: true

    youtube:
        disabled: false
        privacyEnhanced: true

services:
    instagram:
        disableInlineCSS: true
    twitter:
        disableInlineCSS: true


```


## 设置layouts
以下是一些自定义的设置，包括

+ 修改目录至侧边
  - https://www.sulvblog.cn/posts/blog/hugo_toc_side/  
  - https://yfc01.github.io/move-the-sidebar-to-the-left/

+ 修改文章详情页元素+显示访问量+同理在页脚显示访问量
  - https://www.sulvblog.cn/posts/blog/hugo_postmeta/  
  - https://ibruce.info/2015/04/04/busuanzi/

+ 设置评论区 
  - https://www.shaohanyun.top/posts/env/hugo_comments/
  - https://utteranc.es/

+ 评论区颜色主题跟随papermod主题
  - https://ramsayleung.github.io/zh/post/2024/hugo%E8%AF%84%E8%AE%BA%E7%BB%84%E4%BB%B6%E8%87%AA%E9%80%82%E5%BA%94%E5%8D%9A%E5%AE%A2%E6%9A%97%E9%BB%91%E4%B8%BB%E9%A2%98/

+ 文章自动编号
  - https://www.shaohanyun.top/posts/env/hugo_autonumber/

## 部署Github Pages
Github Pages可以托管你的网站内容，并生成项目或个人主页。我使用的是Github Actions的方式自动编译博客。核心流程就是：   
1. 创建github库`<username>.github.io`
2. 将你的博客源码（例如上方的`myblog/`）作为git源码提交到`<username>.github.io`
3. 在库中添加`.github/workflows`。关于Hugo部署到Github Pages，官方提供了[示例](https://gohugo.io/hosting-and-deployment/hosting-on-github/)

这样每一次代码提交都会自动编译博客。