<?xml version="1.0" encoding="UTF-8"?>
   <!--====================================================​========================
   自定义页眉和页脚
   modify by gogo1217
    ====================================================​=========================-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:fo="http://www.w3.org/1999/XSL/Format"
				xmlns:xslthl="http://xslthl.sf.net"
				exclude-result-prefixes="xslthl"
				version='1.0'>

	<xsl:param name="headers.on.blank.pages">1</xsl:param>
	<xsl:param name="footers.on.blank.pages">1</xsl:param>
	<!--xsl:param name="header.column.widths" select="'1 4 1'"/-->
	<xsl:param name="header.column.widths" select="'0 0 1'"/>
	<xsl:param name="footer.column.widths" select="'1 0 1'"/>
	<xsl:param name="header.rule" select="1"/>

	<!--###################################################
		Custom Header
	################################################### -->
	<xsl:attribute-set name="header.content.properties">
		<!--定义字体大小-->
	  	<xsl:attribute name="font-size">
			<xsl:value-of select="concat($body.font.master*0.7, 'pt')"/>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:template name="header.content">
		<xsl:param name="pageclass" select="''"/>
		<xsl:param name="sequence" select="''"/>
		<xsl:param name="position" select="''"/>
		<xsl:param name="gentext-key" select="''"/>
		<xsl:param name="font-size">
			<xsl:value-of select="concat($body.font.master*0.7, 'pt')"/>
		</xsl:param>
		<xsl:variable name="copyright">
			<xsl:choose>
				<xsl:when test="//copyright//holder">
					<xsl:value-of select="//copyright//holder"/>
				</xsl:when>
				<xsl:otherwise>
					请注明版权信息
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<!--右侧显示版本信息-->
			<xsl:when test="$position='right'">
				<xsl:value-of select="$copyright"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- nop -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--###################################################
		Custom Footer
	################################################### -->
	<xsl:attribute-set name="footer.content.properties">
		<!--定义字体大小-->
	  	<xsl:attribute name="font-size">
			<xsl:value-of select="concat($body.font.master*0.7, 'pt')"/>
		</xsl:attribute>
	</xsl:attribute-set>
	<xsl:template name="footer.content">
		<xsl:param name="pageclass" select="''"/>
		<xsl:param name="sequence" select="''"/>
		<xsl:param name="position" select="''"/>
		<xsl:param name="gentext-key" select="''"/>

		<xsl:variable name="title">
			<xsl:value-of select="//title"/>
		</xsl:variable>
		<xsl:variable name="version">
			<xsl:choose>
				<xsl:when test="//releaseinfo">
					<xsl:value-of select="//releaseinfo"/>
				</xsl:when>
				<xsl:otherwise>
					<!-- nop -->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:choose>
			<!--左侧显示文档的标题和版本信息-->
			<xsl:when test="$position='left'">
				<xsl:value-of select="$title"/> <xsl:value-of select="$version"/>
			</xsl:when>
			<!--右侧显示页号-->
			<xsl:when test="$position='right'">
				<fo:page-number/>
			</xsl:when>
			<xsl:otherwise>
				<!-- nop -->
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
 
</xsl:stylesheet>