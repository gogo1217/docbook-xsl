docbook-xsl
===========

docbook自定义xsl，适用于中国文档

## 主要内容

* 参考jboss-docbook-xsl中的章节标题的设置，去掉了jboss语法高亮、页眉页脚等设置，需要使用fop1.0及以上
* 默认使用[文泉驿正黑]
(http://wenq.org/wqy2/index.cgi?%E9%A6%96%E9%A1%B5)开源中文字体（含英文字体）作为PDF的内嵌字体


## XXE使用
本文中的相对目录是指相对于docbook-xsl解压目录。
	
### 设置内嵌字体使得PDF支持中文
选择options/Preferences…，在弹出的窗口中选择Add-on/FOP下添加字体(./fonts目录下)。

	sans-serif（非衬线字体-标题）title.font.family      'WenQuanYi Zen Hei Sharp'  WenQuanYiZenHei.ttf
	serif（衬线字体-正文）       body.font.family       'WenQuanYi Zen Hei'        WenQuanYiZenHeiSharp.ttf
	monospace（等宽字体-代码）   monospace.font.family  'WenQuanYi Zen Hei Mono'   WenQuanYiZenHeiMono.ttf


### 添加PDF转换XSL
选择options/Customize Configuration…/Customize Document Conversion Stylesheets，切换至PDF转换，然后点击add按钮，添加我们的自定义样式文件（./xslt/pdf.xsl）。


### 添加PDF转换XSL参数
设置pdf转化需要的参数，用于PDF内嵌提示用的图片。
选择options/Customize Configuration…/Change Document Conversion Parameters，切换至PDF转换，然后添加所需变量inlay.src.path，变量值指向./目录。

	+docbook-xsl[inlay.src.path指向的目录]
	+-images
	+–docbook
	+—admon图片文件
	+—callouts
	+—-callouts图片文件
	
### 语法高亮支持
在xxe中，需要支持更多的语法，需要制添加自定义属性 highlight.xslthl.config 指向 ./xslt/highlighting/xslthl-config.xml
