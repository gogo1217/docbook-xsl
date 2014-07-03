<?xml version='1.0' encoding="UTF-8" ?>
   <!--====================================================​========================
   修订历史记录样式表
   modify by liushimin
    ====================================================​=========================-->
<xsl:stylesheet exclude-result-prefixes="db"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version='1.0'>
  <!--修定历史表格样式-->
  <xsl:attribute-set name="revhistory.table.properties"> 
    <xsl:attribute name="border">0.5pt solid black</xsl:attribute>
  </xsl:attribute-set>

  <!--修定历史表格单元格样式-->
  <xsl:attribute-set name="revhistory.table.cell.properties">
    <xsl:attribute name="border">0.5pt solid black</xsl:attribute>
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="padding">4pt</xsl:attribute>
  </xsl:attribute-set>

  <!--修定历史表格表头样式-->
  <xsl:attribute-set name="revhistory.table.head.properties">
    <xsl:attribute name="border">0.5pt solid black</xsl:attribute>
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="padding">4pt</xsl:attribute>
    <xsl:attribute name="background-color">antiquewhite</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="revhistory" mode="titlepage.mode">
    <xsl:variable name="explicit.table.width">
      <xsl:call-template name="pi.dbfo_table-width"/>
    </xsl:variable>

    <xsl:variable name="table.width">
      <xsl:choose>
        <xsl:when test="$explicit.table.width != ''">
          <xsl:value-of select="$explicit.table.width"/>
        </xsl:when>
        <xsl:when test="$default.table.width = ''">
          <xsl:text>100%</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$default.table.width"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <fo:table table-layout="fixed" width="{$table.width}" xsl:use-attribute-sets="revhistory.table.properties">
      <fo:table-column column-number="1" column-width="proportional-column-width(1)"/>
      <fo:table-column column-number="2" column-width="proportional-column-width(1)"/>
      <fo:table-column column-number="3" column-width="proportional-column-width(1)"/>
      <fo:table-column column-number="4" column-width="proportional-column-width(3)"/>
      <fo:table-body start-indent="0pt" end-indent="0pt">
        <!--自定义表头-->
        <fo:table-row>
          <fo:table-cell xsl:use-attribute-sets="revhistory.table.head.properties"><fo:block>修订号</fo:block></fo:table-cell>
          <fo:table-cell xsl:use-attribute-sets="revhistory.table.head.properties"><fo:block>修订时间</fo:block></fo:table-cell>
          <fo:table-cell xsl:use-attribute-sets="revhistory.table.head.properties"><fo:block>修订人</fo:block></fo:table-cell>
          <fo:table-cell xsl:use-attribute-sets="revhistory.table.head.properties"><fo:block>修订描述</fo:block></fo:table-cell>
        </fo:table-row>
        <xsl:apply-templates select="*[not(self::title)]" mode="titlepage.mode"/>
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template match="revhistory/revision" mode="titlepage.mode">
    <xsl:variable name="revnumber" select="revnumber"/>
    <xsl:variable name="revdate"   select="date"/>
    <xsl:variable name="revauthor" select="authorinitials|author"/>
    <xsl:variable name="revremark" select="revremark|revdescription"/>
    <fo:table-row>
      <fo:table-cell xsl:use-attribute-sets="revhistory.table.cell.properties">
        <fo:block>
          <xsl:if test="$revnumber">
            <xsl:call-template name="gentext">
              <xsl:with-param name="key" select="'Revision'"/>
            </xsl:call-template>
            <xsl:call-template name="gentext.space"/>
            <xsl:apply-templates select="$revnumber[1]" mode="titlepage.mode"/>
          </xsl:if>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell xsl:use-attribute-sets="revhistory.table.cell.properties">
        <fo:block>
          <xsl:apply-templates select="$revdate[1]" mode="titlepage.mode"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell xsl:use-attribute-sets="revhistory.table.cell.properties">
        <fo:block>
          <xsl:for-each select="$revauthor">
            <xsl:apply-templates select="." mode="titlepage.mode"/>
            <xsl:if test="position() != last()">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </fo:block>
      </fo:table-cell>
      <!--将remark合并在一行显示，默认是另起一行-->
      <fo:table-cell xsl:use-attribute-sets="revhistory.table.cell.properties">
        <fo:block>
          <xsl:if test="$revremark">
            <xsl:apply-templates select="$revremark[1]" mode="titlepage.mode"/>
          </xsl:if>
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

</xsl:stylesheet>