<?xml version='1.0'?>
<!--====================================================​========================
modify by gogo1217
====================================================​=========================-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!--  Enable extensions (needed for callouts) -->
    <xsl:param name="use.extensions">1</xsl:param>

    <!-- For backwards compatibility we want to use callouts specified using programlistingco elements -->
    <xsl:param name="callouts.extension">1</xsl:param>

    <!-- Use graphical callouts as they look nicer with highlighed code. -->
    <xsl:param name="callout.graphics">1</xsl:param>
    <xsl:param name="callout.graphics.number.limit">15</xsl:param>
    <xsl:param name="callout.graphics.extension">.png</xsl:param>
    <!--自定义内嵌图片的顶级目录-->
    <xsl:param name="inlay.src.path" />
    <xsl:param name="callout.graphics.path">
        <!--如果用户指定了该目录，则使用该目录，否则使用img.src.path。-->
        <!--在xxe中，直接使用img.src.path会有问题，将导致文档本身的内嵌图片地址丢失，因此需要指定inlay.src.path。-->
        <!--在jdocbook插件中，如果指定inlay.src.path，则需要是一个绝对目录，不能使用maven变量，但是它会自动创建img.src.path，指向staging/images，而我们可以通过插件将内嵌图片拷贝到该目录下，因此这种情况下不需要指定inlay.src.path。-->
        <xsl:choose>
            <xsl:when test="$inlay.src.path != ''">
                <xsl:value-of select="$inlay.src.path"/>
            </xsl:when>
            <xsl:when test="$img.src.path != ''">
                <xsl:value-of select="$img.src.path"/>
            </xsl:when>
        </xsl:choose>
        <xsl:text>images/docbook/callouts/</xsl:text>
    </xsl:param>

    <!-- Admonitions -->
    <xsl:param name="admon.graphics" select="1"/>
    <xsl:param name="admon.graphics.path">
        <xsl:choose>
            <xsl:when test="$inlay.src.path != ''">
                <xsl:value-of select="$inlay.src.path"/>
            </xsl:when>
            <xsl:when test="$img.src.path != ''">
                <xsl:value-of select="$img.src.path"/>
            </xsl:when>
        </xsl:choose>
        <xsl:text>images/docbook/</xsl:text>
    </xsl:param>

    <!-- TOC -->
    <xsl:param name="section.autolabel" select="1"/>
    <!-- Include the chapter no -->
    <xsl:param name="section.label.includes.component.label" select="1" />

    <!-- 修正默认中文语言中的 #和多余的.  -->
    <xsl:param name="local.l10n.xml" select="document('')"/>
    <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
        <l:l10n language="zh_cn">
            <l:context name="title-numbered">
                <l:template name="chapter" text="第 %n 章 %t"/>
                <l:template name="section" text="%n %t"/>
                <l:template name="sect1" text="%n %t"/>
                <l:template name="sect2" text="%n %t"/>
                <l:template name="sect3" text="%n %t"/>
                <l:template name="sect4" text="%n %t"/>
                <l:template name="sect5" text="%n %t"/>
                <l:template name="appendix" text="附录 %n %t"/>
                <l:template name="article/appendix" text="%n %t"/>
                <l:template name="bridgehead" text="%n %t"/>
                <l:template name="part" text="部分 %n %t"/>
            </l:context>
            <l:context name="title">
                <l:template name="equation" text="公式 %n %t"/>
                <l:template name="example" text="例 %n %t"/>
                <l:template name="figure" text="图 %n %t"/>
                <l:template name="procedure.formal" text="过程 %n %t"/>
                <l:template name="productionset.formal" text="产品 %n"/>
                <l:template name="table" text="表 %n %t"/>
            </l:context>
        </l:l10n>
    </l:i18n>
    <!-- 启用中文本地化-->
    <xsl:param name="l10n.gentext.default.language" select="'zh_cn'"/>

</xsl:stylesheet>
