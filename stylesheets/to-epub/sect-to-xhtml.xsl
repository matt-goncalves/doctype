<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">

  <xsl:output method="xml" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.1//EN"
              doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>

  <!-- ========== Root Template: SECTION ========= -->
  <xsl:template match="/section">
    <html>
      <head>
        <title><xsl:value-of select="title"/></title>
        <meta charset="UTF-8"/>
        <link rel="stylesheet" type="text/css" href="styles.css"/>
      </head>
      <body>
        <xsl:apply-templates select="title"/>
        <xsl:apply-templates select="*[not(self::title)]"/>
      </body>
    </html>
  </xsl:template>

  <!-- ========== Title ========== -->
  <xsl:template match="title">
    <h1><xsl:apply-templates/></h1>
  </xsl:template>

  <!-- ========== Paragraphs ========== -->
  <xsl:template match="par">
    <p>
      <xsl:if test="@type">
        <xsl:attribute name="class">
          <xsl:value-of select="@type"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!-- ========== Emphasis ========== -->
  <xsl:template match="emph">
    <xsl:choose>
      <xsl:when test="@style='b'">
        <strong><xsl:apply-templates/></strong>
      </xsl:when>
      <xsl:when test="@style='i'">
        <em><xsl:apply-templates/></em>
      </xsl:when>
      <xsl:when test="@style='u'">
        <u><xsl:apply-templates/></u>
      </xsl:when>
      <xsl:otherwise>
        <span><xsl:apply-templates/></span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ========== Inline Elements ========== -->
  <xsl:template match="code">
    <code><xsl:apply-templates/></code>
  </xsl:template>

  <xsl:template match="foreign">
    <span xml:lang="{@lang}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="inline">
    <span class="{@type}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="date">
    <time><xsl:apply-templates/></time>
  </xsl:template>

  <xsl:template match="link">
    <a href="{@to}"><xsl:apply-templates/></a>
  </xsl:template>

  <!-- ========== Code Block ========== -->
  <xsl:template match="code-block">
    <pre><code><xsl:apply-templates/></code></pre>
  </xsl:template>

  <!-- ========== Image ========== -->
  <xsl:template match="image">
    <img src="{@src}" alt="{@alt}"/>
  </xsl:template>

  <!-- ========== Lists ========== -->
  <xsl:template match="list">
    <xsl:choose>
      <xsl:when test="@type='enum'">
        <ol><xsl:apply-templates/></ol>
      </xsl:when>
      <xsl:otherwise>
        <ul><xsl:apply-templates/></ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="item">
    <li><xsl:apply-templates/></li>
  </xsl:template>

  <!-- ========== Generic Block ========= -->
  <xsl:template match="block">
    <div class="{@type}"><xsl:apply-templates/></div>
  </xsl:template>

  <!-- ========== Table Support ========= -->
  <xsl:template match="table">
    <table>
      <xsl:if test="@title">
        <caption><xsl:value-of select="@title"/></caption>
      </xsl:if>
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="row">
    <tr><xsl:apply-templates/></tr>
  </xsl:template>

  <xsl:template match="cell">
    <td><xsl:apply-templates/></td>
  </xsl:template>

  <!-- ========== Fallback ========== -->
  <xsl:template match="*">
    <div class="unhandled-element">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

</xsl:stylesheet>
