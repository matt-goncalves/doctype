<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="xsl">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"
    doctype-public="-//W3C//DTD XHTML 1.1//EN"
    doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>

  <xsl:strip-space elements="*"/>

  <!-- Root template -->
  <xsl:template match="/document">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
      <head>
        <title><xsl:value-of select="head/title"/></title>
        <xsl:for-each select="head/meta">
          <meta name="{@name}" content="{@content}" />
        </xsl:for-each>
        <link rel="stylesheet" type="text/css" href="styles.css" />
      </head>
      <body>
        <xsl:apply-templates select="body/*"/>
      </body>
    </html>
  </xsl:template>

  <!-- Recursive section with level control -->
  <xsl:template match="section">
    <xsl:param name="level" select="1"/>
    <div class="section">
      <xsl:call-template name="heading">
        <xsl:with-param name="level" select="$level"/>
        <xsl:with-param name="content" select="title"/>
      </xsl:call-template>
      <xsl:apply-templates select="*[not(self::title)]">
        <xsl:with-param name="level" select="$level + 1"/>
      </xsl:apply-templates>
    </div>
  </xsl:template>

  <!-- Heading selector up to <h6> -->
  <xsl:template name="heading">
    <xsl:param name="level"/>
    <xsl:param name="content"/>

    <!-- Clamp level to max 6 -->
    <xsl:variable name="actualLevel">
      <xsl:choose>
        <xsl:when test="$level &gt; 6">6</xsl:when>
        <xsl:otherwise><xsl:value-of select="$level"/></xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <!-- Dynamically create heading element -->
    <xsl:element name="h{$actualLevel}">
      <xsl:value-of select="$content"/>
    </xsl:element>
  </xsl:template>

  <!-- Paragraph -->
  <xsl:template match="par">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <!-- Block -->
  <xsl:template match="block">
    <div class="block" data-type="{@type}">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- Code block -->
  <xsl:template match="code-block">
    <pre><code><xsl:value-of select="."/></code></pre>
  </xsl:template>

  <!-- List -->
  <xsl:template match="list">
    <xsl:choose>
      <xsl:when test="@type='bullet'"><ul><xsl:apply-templates/></ul></xsl:when>
      <xsl:otherwise><ol><xsl:apply-templates/></ol></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="item">
    <li><xsl:apply-templates/></li>
  </xsl:template>

  <!-- Inline elements -->
  <xsl:template match="code">
    <code><xsl:apply-templates/></code>
  </xsl:template>

  <xsl:template match="emphasis">
    <xsl:choose>
      <xsl:when test="@style='b'"><strong><xsl:apply-templates/></strong></xsl:when>
      <xsl:when test="@style='i'"><em><xsl:apply-templates/></em></xsl:when>
      <xsl:otherwise><span><xsl:apply-templates/></span></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="link">
    <a href="{@to}"><xsl:apply-templates/></a>
  </xsl:template>

  <xsl:template match="foreign">
    <span xml:lang="{@lang}"><xsl:apply-templates/></span>
  </xsl:template>

  <xsl:template match="date">
    <time><xsl:apply-templates/></time>
  </xsl:template>

  <xsl:template match="inline">
    <span class="inline" data-type="{@type}"><xsl:apply-templates/></span>
  </xsl:template>

  <!-- Image -->
  <xsl:template match="image">
    <img src="{@src}">
      <xsl:if test="@alt">
        <xsl:attribute name="alt">
          <xsl:value-of select="@alt"/>
        </xsl:attribute>
      </xsl:if>
    </img>
  </xsl:template>

  <!-- Table -->
  <xsl:template match="table">
    <table>
      <xsl:if test="@title">
        <caption><xsl:value-of select="@title"/></caption>
      </xsl:if>
      <tbody>
        <xsl:apply-templates/>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="row">
    <tr><xsl:apply-templates/></tr>
  </xsl:template>

  <xsl:template match="cell">
    <td><xsl:apply-templates/></td>
  </xsl:template>

</xsl:stylesheet>
