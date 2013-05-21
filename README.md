An iOS Remote app for Yahoo! Web player.
===========
by __fuzzy-ninja__

这是为Yahoo!的Web Player开发的手机远程控制软件，可以通过手机对网页上使用Yahoo! Web Player正在播放的媒体进行播放、暂停、下一首、上一首、全屏、静音等操作。

#使用方式
###安装chrome插件:

在chrome选择设置－工具－扩展程序

开发模式－载入正在开发的插件

选择chrome-addin文件夹

后续可能进行打包

###安装ios插件:

开发者打开xcode工程，使用iphone进行调试

非开发者可以使用模拟器，后续可能提供ipa

###运行服务器

参见node.js以及faye的相关文档

#设计思路：

##网页端：

chrome插件，自动在当前网页中嵌入与sever通讯的相关基于jquery的js代码，打开时生成二维码，供连接用。

##通讯服务器：

基于node.js和faye的sever，在手机和网页端之间接收并转发指令。

##手机端：

iOS应用，设计参考了ipod的转轮设计，使用时先扫瞄chrome插件中的二维码并进行连接。连接之后可以对网页中的播放器进行操作。

##运行截图
![screenshot](https://raw.github.com/stranbird/fuzzy-ninja/master/report/IMG_7300.PNG "screenshot") 

![screenshot](https://raw.github.com/stranbird/fuzzy-ninja/master/report/IMG_7304.PNG "screenshot")

![screenshot](https://raw.github.com/stranbird/fuzzy-ninja/master/report/IMG_7305.PNG "screenshot")

![screenshot](https://raw.github.com/stranbird/fuzzy-ninja/master/report/IMG_7306.PNG "screenshot")

![screenshot](https://raw.github.com/stranbird/fuzzy-ninja/master/report/IMG_7307.PNG "screenshot")

![screenshot](https://raw.github.com/stranbird/fuzzy-ninja/master/report/IMG_7308.PNG "screenshot")

![screenshot](https://raw.github.com/stranbird/fuzzy-ninja/master/report/IMG_7309.PNG "screenshot")

![screenshot](https://raw.github.com/stranbird/fuzzy-ninja/master/report/IMG_7310.PNG "screenshot")
##关于

2013雅虎北研黑客日 第13组fuzzy-ninja

获得本次最佳人气奖

![award](https://raw.github.com/stranbird/fuzzy-ninja/master/report/IMG_7289.JPG "award")

![award](https://raw.github.com/stranbird/fuzzy-ninja/master/report/IMG_0002.JPG "award")

开源并免费使用，欢迎二次开发，但希望引用时予以说明

##开发团队:

朱元飞 上海交通大学 大三

甄晓磊 上海交通大学 大三

刘凡平 中国科学与技术大学 研二

刘飞 中国科学与技术大学 研二
