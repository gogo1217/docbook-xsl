<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY lowercase "'abcdefghijklmnopqrstuvwxyz'">
<!ENTITY uppercase "'ABCDEFGHIJKLMNOPQRSTUVWXYZ'">
 ]>
   <!--====================================================​========================
   自定义pdf转换样式表
   modify by liushimin
    ====================================================​=========================-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
            version="1.0"
            xmlns="http://www.w3.org/TR/xhtml1/transitional"
            xmlns:db="http://docbook.org/ns/docbook"
            xmlns:fo="http://www.w3.org/1999/XSL/Format"
            xmlns:ng="http://docbook.org/docbook-ng"
            xmlns:exsl="http://exslt.org/common"
            xmlns:xslthl="http://xslthl.sf.net"
            exclude-result-prefixes="xslthl db ng exsl">

  <!--引入默认的样式表-->
  <xsl:import href="../docbook/fo/docbook.xsl"/>
  <!--引入基本样式表-->
  <xsl:import href="common.xsl" />
  <!--引入自定义修订历史记录模板-->
  <xsl:import href="revhistory.xsl" />
  <!--启用高亮并设置颜色-->
  <xsl:import href="highlight.xsl" />
  <!--设置自定义的页眉和页脚-->
  <xsl:import href="header_footer.xsl" />
  
  <xsl:param name="draft.mode" select="'no'"/>
  
  <!--====================================================​========================
    font setting
    ====================================================​=========================-->
  <!--设置标题字体-->
  <!--<xsl:param name="title.font.family">sans-serif</xsl:param>-->
  <!--设置内容字体-->
  <!--<xsl:param name="body.font.family">serif</xsl:param>-->
  <!--设置代码字体-->
  <!--<xsl:param name="monospace.font.family">monospace</xsl:param>-->

  <!--================================​============================================
    图，表格，资料，代码列表标题 setting
    ================================​=============================================-->
  <xsl:attribute-set name="formal.title.properties">
    <xsl:attribute name="font-size">
      <xsl:choose>
        <!--图片和表格的标题字体为默认的0.7倍-->
        <xsl:when test="self::figure"><xsl:value-of select="concat($body.font.master*0.7, 'pt')"/></xsl:when>
        <xsl:when test="self::table"><xsl:value-of select="concat($body.font.master*0.7, 'pt')"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="concat($body.font.master, 'pt')"/></xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:choose>
        <!--图片和表格的标题居中-->
        <xsl:when test="self::figure">center</xsl:when>
        <xsl:when test="self::table">center</xsl:when>
        <xsl:otherwise>left</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:attribute-set>

  <!--用于文章中的图、表等等元素的标题，设置图片和表格在后面-->
  <xsl:param name="formal.title.placement">
    figure after
    example before
    equation before
    table after
    procedure before
    task before
  </xsl:param>

  <xsl:param name="alignment">justify</xsl:param>
  <!--添加bookmark书签,使用fop1.1版本，关闭fop1.0以下版本-->
  <xsl:param name="fop.extensions" select="0"/>
  <xsl:param name="fop1.extensions" select="1"/>

  <xsl:param name="qandadiv.autolabel" select="0"/>
  <!--去掉默认图形、表格生成目录-->
  <xsl:param name="generate.toc">
    /appendix toc,title
    article/appendix  nop
    /article  toc,title
    book      toc,title
    /chapter  toc,title
    part      toc,title
    reference toc,title
    /sect1    toc
    /sect2    toc
    /sect3    toc
    /sect4    toc
    /sect5    toc
    /section  toc
    set       toc,title
  </xsl:param>
  <!--将qanda的标题加入TOC目录-->
  <xsl:param name="qanda.in.toc">1</xsl:param>

  <!--取消hyphenation特殊字符功能，否则会提示：[ERROR] Couldn't find hyphenation pattern zh_cn-->
  <xsl:param name="hyphenate">true</xsl:param>
  <!--设置行间距为1.5倍-->
  <xsl:param name="line-height" select="1.5"/>

   <!-- Callouts -->
  <xsl:param name="callout.defaultcolumn">80</xsl:param>
  <xsl:param name="callout.icon.size">10pt</xsl:param>

  <!-- Admonitions -->
  <xsl:param name="admon.graphics.extension" select="'.svg'"/>

  <xsl:attribute-set name="admonition.title.properties">
    <xsl:attribute name="font-size">13pt</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:choose>
        <xsl:when test="self::note">#4C5253</xsl:when>
        <xsl:when test="self::caution">#533500</xsl:when>
        <xsl:when test="self::important">white</xsl:when>
        <xsl:when test="self::warning">white</xsl:when>
        <xsl:when test="self::tip">white</xsl:when>
        <xsl:otherwise>white</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>

  </xsl:attribute-set>

  <xsl:attribute-set name="graphical.admonition.properties">
    <xsl:attribute name="color">
      <xsl:choose>
        <xsl:when test="self::note">#4C5253</xsl:when>
        <xsl:when test="self::caution">#533500</xsl:when>
        <xsl:when test="self::important">white</xsl:when>
        <xsl:when test="self::warning">white</xsl:when>
        <xsl:when test="self::tip">white</xsl:when>
        <xsl:otherwise>white</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="background-color">
      <xsl:choose>
        <xsl:when test="self::note">#B5BCBD</xsl:when>
        <xsl:when test="self::caution">#E3A835</xsl:when>
        <xsl:when test="self::important">#4A5D75</xsl:when>
        <xsl:when test="self::warning">#7B1E1E</xsl:when>
        <xsl:when test="self::tip">#7E917F</xsl:when>
        <xsl:otherwise>#404040</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>

    <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
    <xsl:attribute name="padding-bottom">12pt</xsl:attribute>
    <xsl:attribute name="padding-top">12pt</xsl:attribute>
    <xsl:attribute name="padding-right">12pt</xsl:attribute>
    <xsl:attribute name="padding-left">12pt</xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$title.margin.left"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <!-- Make the section depth in the TOC 2, same as html -->
  <xsl:param name="toc.section.depth">2</xsl:param>
  <!--设置目录中的字体大小9pt-->
  <xsl:attribute-set name="toc.line.properties">
    <xsl:attribute name="font-size">9pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- Now, set enable scalefit for large images -->
  <xsl:param name="graphicsize.extension" select="'1'" />
  
  <!--外部链接时隐藏URL地址-->
  <xsl:param name="ulink.show" select="0"/>
  <xsl:attribute-set name="xref.properties">
    <xsl:attribute name="font-style">italic</xsl:attribute>
    <xsl:attribute name="color">
    <xsl:choose>
      <xsl:when test="ancestor::note or ancestor::caution or ancestor::important or ancestor::warning or ancestor::tip">
        <xsl:text>#aee6ff</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>#0066cc</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="text-decoration">underline</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="monospace.properties">
    <xsl:attribute name="font-size">9pt</xsl:attribute>
    <xsl:attribute name="font-family">
      <xsl:value-of select="$monospace.font.family"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="monospace.verbatim.properties" use-attribute-sets="verbatim.properties monospace.properties">
    <xsl:attribute name="text-align">start</xsl:attribute>
    <xsl:attribute name="wrap-option">wrap</xsl:attribute>
    <xsl:attribute name="hyphenation-character">&#x25BA;</xsl:attribute>
  </xsl:attribute-set>

  <xsl:param name="shade.verbatim" select="1"/>
  <xsl:attribute-set name="shade.verbatim.style">
    <xsl:attribute name="wrap-option">wrap</xsl:attribute>
    <xsl:attribute name="background-color">
    <xsl:choose>
      <xsl:when test="ancestor::note"> <xsl:text>#B5BCBD</xsl:text> </xsl:when>
      <xsl:when test="ancestor::caution"> <xsl:text>#E3A835</xsl:text> </xsl:when>
      <xsl:when test="ancestor::important"> <xsl:text>#4A5D75</xsl:text> </xsl:when>
      <xsl:when test="ancestor::warning"> <xsl:text>#7B1E1E</xsl:text> </xsl:when>
      <xsl:when test="ancestor::tip"> <xsl:text>#7E917F</xsl:text> </xsl:when>
      <xsl:otherwise>
        <xsl:text>#f5f5f5</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="color">
    <xsl:choose>
      <xsl:when test="ancestor::note"> <xsl:text>#4C5253</xsl:text> </xsl:when>
      <xsl:when test="ancestor::caution"> <xsl:text>#533500</xsl:text> </xsl:when>
      <xsl:when test="ancestor::important"> <xsl:text>white</xsl:text> </xsl:when>
      <xsl:when test="ancestor::warning"> <xsl:text>white</xsl:text> </xsl:when>
      <xsl:when test="ancestor::tip"> <xsl:text>white</xsl:text> </xsl:when>
      <xsl:otherwise>
        <xsl:text>#000</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="padding-left">12pt</xsl:attribute>
    <xsl:attribute name="padding-right">12pt</xsl:attribute>
    <xsl:attribute name="padding-top">6pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">6pt</xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$title.margin.left"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="verbatim.properties">
    <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
    <xsl:attribute name="wrap-option">wrap</xsl:attribute>
    <xsl:attribute name="white-space-collapse">false</xsl:attribute>
    <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
    <xsl:attribute name="text-align">start</xsl:attribute>
  </xsl:attribute-set>

  <!--================================​============================================
    emphasis setting 强调设置
    ================================​=============================================-->
  <xsl:template name="inline.italicseq">
      <xsl:param name="content">
          <xsl:call-template name="simple.xlink">
              <xsl:with-param name="content">
                  <xsl:apply-templates/>
              </xsl:with-param>
          </xsl:call-template>
      </xsl:param>
      <!--输出颜色为红色-->
      <fo:inline color="red">
          <xsl:call-template name="anchor"/>
          <xsl:if test="@dir">
              <xsl:attribute name="direction">
                  <xsl:choose>
                      <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
                      <xsl:otherwise>rtl</xsl:otherwise>
                  </xsl:choose>
              </xsl:attribute>
          </xsl:if>
          <xsl:copy-of select="$content"/>
      </fo:inline>
  </xsl:template>
  <xsl:template name="inline.boldseq">
      <xsl:param name="content">
          <xsl:call-template name="simple.xlink">
              <xsl:with-param name="content">
                  <xsl:apply-templates/>
              </xsl:with-param>
          </xsl:call-template>
      </xsl:param>
      <!--输出颜色为红色-->
      <fo:inline color="red">
          <xsl:if test="@dir">
              <xsl:attribute name="direction">
                  <xsl:choose>
                      <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
                      <xsl:otherwise>rtl</xsl:otherwise>
                  </xsl:choose>
              </xsl:attribute>
          </xsl:if>
          <xsl:copy-of select="$content"/>
      </fo:inline>
  </xsl:template>


  <!--目录后强制分页-->
  <xsl:template name="component.toc.separator">
      <fo:block break-after="page"/>
  </xsl:template>

  <!-- Format Variable Lists as Blocks (prevents horizontal overflow). -->
  <xsl:param name="variablelist.as.blocks">1</xsl:param>

  <!--段首缩进-->
  <xsl:attribute-set name="standard.para.spacing" use-attribute-sets="normal.para.spacing">
    <xsl:attribute name="text-indent">2em</xsl:attribute>
  </xsl:attribute-set>
  <xsl:template match="abstract/para|appendix/para|chapter/para|colophon/para|legalnotice/para|preface/para|section/para|sect1/para|sect2/para">
    <fo:block xsl:use-attribute-sets="standard.para.spacing">
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="section/para/*">
    <fo:wrapper text-indent="0pt">
      <xsl:apply-imports/>
    </fo:wrapper>
  </xsl:template>

  <!-- The horrible list spacing problems, this is much better. -->
  <xsl:attribute-set name="list.block.spacing">
    <xsl:attribute name="space-before.optimum">2em</xsl:attribute>
    <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">3em</xsl:attribute>
    <xsl:attribute name="space-after.optimum">0.1em</xsl:attribute>
    <xsl:attribute name="space-after.minimum">0.1em</xsl:attribute>
    <xsl:attribute name="space-after.maximum">0.1em</xsl:attribute>
  </xsl:attribute-set>

  <!-- Some padding inside tables -->
  <xsl:attribute-set name="table.cell.padding">
  <xsl:attribute name="padding-left">4pt</xsl:attribute>
  <xsl:attribute name="padding-right">4pt</xsl:attribute>
  <xsl:attribute name="padding-top">2pt</xsl:attribute>
  <xsl:attribute name="padding-bottom">2pt</xsl:attribute>
  </xsl:attribute-set>

  <!-- Only hairlines as frame and cell borders in tables -->
  <xsl:param name="table.frame.border.thickness">0.3pt</xsl:param>
  <xsl:param name="table.cell.border.thickness">0.15pt</xsl:param>
  <xsl:param name="table.cell.border.color">#5c5c4f</xsl:param>
  <xsl:param name="table.frame.border.color">#5c5c4f</xsl:param>
  <xsl:param name="table.cell.border.right.color">white</xsl:param>
  <xsl:param name="table.cell.border.left.color">white</xsl:param>
  <xsl:param name="table.frame.border.right.color">white</xsl:param>
  <xsl:param name="table.frame.border.left.color">white</xsl:param>
  <!-- Paper type, no headers on blank pages, no double sided printing -->
  <xsl:param name="paper.type" select="'A4'"/>
  <xsl:param name="double.sided">0</xsl:param>

  <!-- Space between paper border and content (chaotic stuff, don't touch) -->
  <xsl:param name="page.margin.top">15mm</xsl:param>
  <xsl:param name="region.before.extent">10mm</xsl:param>
  <xsl:param name="body.margin.top">15mm</xsl:param>

  <xsl:param name="body.margin.bottom">15mm</xsl:param>
  <xsl:param name="region.after.extent">10mm</xsl:param>
  <xsl:param name="page.margin.bottom">15mm</xsl:param>

  <xsl:param name="page.margin.outer">30mm</xsl:param>
  <xsl:param name="page.margin.inner">30mm</xsl:param>

  <!--设置内容字体大小12-->
  <xsl:param name="body.font.master">12</xsl:param>
  <!-- No intendation of Titles -->
  <xsl:param name="body.start.indent">0pt</xsl:param>

  <!--章节标题颜色-->
  <xsl:param name="title.color">#4a5d75</xsl:param>
  <xsl:param name="chapter.title.color" select="$title.color" />
  <xsl:param name="section.title.color" select="$title.color" />

  <!--节标题设置-->
  <xsl:attribute-set name="section.title.level1.properties">
    <xsl:attribute name="color"><xsl:value-of select="$section.title.color"/></xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.6"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level2.properties">
    <xsl:attribute name="color"><xsl:value-of select="$section.title.color"/></xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.4"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level3.properties">
    <xsl:attribute name="color"><xsl:value-of select="$section.title.color"/></xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.3"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level4.properties">
    <xsl:attribute name="color"><xsl:value-of select="$section.title.color"/></xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.2"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level5.properties">
    <xsl:attribute name="color"><xsl:value-of select="$section.title.color"/></xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 1.1"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>
  <xsl:attribute-set name="section.title.level6.properties">
    <xsl:attribute name="color"><xsl:value-of select="$section.title.color"/></xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="section.title.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$title.font.family"/>
    </xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1.0em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <xsl:attribute name="start-indent"><xsl:value-of select="$title.margin.left"/></xsl:attribute>
  </xsl:attribute-set>

  <!--封面颜色设置-->
  <xsl:param name="titlepage.color" select="$title.color"/>
  <xsl:attribute-set name="book.titlepage.recto.style">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$title.fontset"/>
    </xsl:attribute>
    <xsl:attribute name="color"><xsl:value-of select="$titlepage.color"/></xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="component.title.properties">
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="space-before.optimum"><xsl:value-of select="concat($body.font.master, 'pt')"/></xsl:attribute>
    <xsl:attribute name="space-before.minimum"><xsl:value-of select="concat($body.font.master, 'pt')"/></xsl:attribute>
    <xsl:attribute name="space-before.maximum"><xsl:value-of select="concat($body.font.master, 'pt')"/></xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
    <xsl:attribute name="color">
      <xsl:choose>
        <xsl:when test="not(parent::chapter | parent::article | parent::appendix)"><xsl:value-of select="$title.color"/></xsl:when>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="text-align">
      <xsl:choose>
        <xsl:when test="((parent::article | parent::articleinfo) and not(ancestor::book) and not(self::bibliography))        or (parent::slides | parent::slidesinfo)">center</xsl:when>
        <xsl:otherwise>left</xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="start-indent"><xsl:value-of select="$title.margin.left"/></xsl:attribute>
  </xsl:attribute-set>

  <!--章标题设置-->
  <xsl:attribute-set name="chapter.titlepage.recto.style">
    <xsl:attribute name="color"><xsl:value-of select="$chapter.title.color"/></xsl:attribute>
    <xsl:attribute name="background-color">white</xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:choose>
        <xsl:when test="$l10n.gentext.language = 'ja-JP'">
          <xsl:value-of select="$body.font.master * 1.7"/>
          <xsl:text>pt</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>24pt</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="text-align">left</xsl:attribute>
    <!--xsl:attribute name="wrap-option">no-wrap</xsl:attribute-->
    <xsl:attribute name="padding-left">1em</xsl:attribute>
    <xsl:attribute name="padding-right">1em</xsl:attribute>
  </xsl:attribute-set>

  <!--前言标题设置-->
  <xsl:attribute-set name="preface.titlepage.recto.style">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$title.fontset"/>
    </xsl:attribute>
    <xsl:attribute name="color">#4a5d75</xsl:attribute>
    <xsl:attribute name="font-size">12pt</xsl:attribute>
    <xsl:attribute name="font-weight">bold</xsl:attribute>
  </xsl:attribute-set>

  <!--部分标题设置-->
  <xsl:attribute-set name="part.titlepage.recto.style">
    <xsl:attribute name="color"><xsl:value-of select="$title.color"/></xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
  </xsl:attribute-set>

  <!--表格单元格设置-->
  <xsl:template name="table.cell.block.properties">
    <!-- 单元格背景颜色 -->
    <xsl:if test="ancestor::thead or ancestor::tfoot">
      <xsl:attribute name="font-weight">bold</xsl:attribute>
    <xsl:attribute name="background-color">#4a5d75</xsl:attribute>
    <xsl:attribute name="color">white</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <!--表格行设置-->
  <xsl:template name="table.row.properties">
    <xsl:variable name="bgcolor">
      <xsl:call-template name="dbfo-attribute">
        <xsl:with-param name="pis" select="processing-instruction('dbfo')"/>
        <xsl:with-param name="attribute" select="'bgcolor'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="$bgcolor != ''">
      <xsl:attribute name="background-color">
        <xsl:value-of select="$bgcolor"/>
      </xsl:attribute>
    </xsl:if>
    <xsl:if test="ancestor::thead or ancestor::tfoot">
    <xsl:attribute name="background-color">#4a5d75</xsl:attribute>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
