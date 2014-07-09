<?xml version="1.0" encoding="UTF-8"?>
   <!--====================================================​========================
   语法高亮样式表
   modify by gogo1217
    ====================================================​=========================-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:fo="http://www.w3.org/1999/XSL/Format"
				xmlns:xslthl="http://xslthl.sf.net"
				exclude-result-prefixes="xslthl"
				version='1.0'>
	
	<!-- 引入默认样式 -->
	<xsl:import href="../docbook/highlighting/common.xsl"/>
    <!-- 启用语法高亮 -->
	<xsl:param name="highlight.source" select="1"/>
    <!-- 默认语言为XML -->
	<xsl:param name="highlight.default.language" select="xml" />
	<!-- 高亮语法支持类型 -->
	<xsl:param name="highlight.xslthl.config" select="highlighting/xslthl-config.xml" />

    <xsl:attribute-set name="monospace.verbatim.properties">
      <xsl:attribute name="font-family">Lucida Sans Typewriter</xsl:attribute>
      <xsl:attribute name="font-size">9pt</xsl:attribute>
      <xsl:attribute name="keep-together.within-column">always</xsl:attribute>
    </xsl:attribute-set>
    
    <xsl:param name="shade.verbatim" select="1"/>
    <xsl:attribute-set name="shade.verbatim.style">
      <xsl:attribute name="background-color">#fefefe</xsl:attribute>
      <xsl:attribute name="border-width">1pt</xsl:attribute>
      <xsl:attribute name="border-style">solid</xsl:attribute>
      <xsl:attribute name="border-color">#888888</xsl:attribute>
      <xsl:attribute name="padding">3pt</xsl:attribute>
    </xsl:attribute-set>

    <!-- 高亮配色设置-->
	<xsl:template match='xslthl:keyword'  mode="xslthl">
        <fo:inline font-weight="bold" color="#7F0055"><xsl:apply-templates/></fo:inline>
    </xsl:template>
   
    <xsl:template match='xslthl:comment'  mode="xslthl">
        <fo:inline color="#3F5FBF" font-style="italic"><xsl:apply-templates/></fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:oneline-comment'  mode="xslthl">
        <fo:inline color="#3F5FBF"><xsl:apply-templates/></fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:multiline-comment'  mode="xslthl">
        <fo:inline color="#3F5FBF"><xsl:apply-templates/></fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:tag'  mode="xslthl">
        <fo:inline  color="#2DC530" font-weight="bold"><xsl:apply-templates/></fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:attribute'  mode="xslthl">
        <fo:inline color="#7F0055" font-weight="bold"><xsl:apply-templates/></fo:inline>
    </xsl:template>
   
    <xsl:template match='xslthl:value'  mode="xslthl">
        <fo:inline color="#2A00FF" font-weight="bold"><xsl:apply-templates/></fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:string'  mode="xslthl">
        <fo:inline color="#2A00FF" font-style="italic" font-weight="bold"><xsl:apply-templates/></fo:inline>
    </xsl:template>
   
    <xsl:template match='xslthl:number' mode="xslthl">
        <xsl:apply-templates mode="xslthl"/>
    </xsl:template>

    <xsl:template match='xslthl:annotation' mode="xslthl">
        <fo:inline color="gray"><xsl:apply-templates mode="xslthl"/></fo:inline>
    </xsl:template>

    <xsl:template match='xslthl:directive' mode="xslthl">
        <fo:inline color="#7F0055"><xsl:apply-templates mode="xslthl"/></fo:inline>
    </xsl:template>

    <!-- Not sure which element will be in final XSLTHL 2.0 -->
    <xsl:template match='xslthl:doccomment|xslthl:doctype' mode="xslthl">
        <fo:inline font-weight="bold" color="#3F5F5F"><xsl:apply-templates mode="xslthl"/></fo:inline>
    </xsl:template>


</xsl:stylesheet>