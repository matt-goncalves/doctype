<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#default">

  <xsl:output method="xml" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
              indent="yes"/>

  <!-- Root -->
  <xsl:template match="/document">
    <html>
      <head>
        <xsl:apply-templates select="head"/>
        <link rel="stylesheet" type="text/css" href="/home/matt/.doctype/css/main.css" />
      </head>
      <body>
        <xsl:apply-templates select="body"/>
      </body>
    </html>
  </xsl:template>

  <!-- Head -->
  <xsl:template match="head">
    <xsl:apply-templates select="title"/>
    <xsl:apply-templates select="meta"/>
  </xsl:template>

  <xsl:template match="title">
    <title>
      <xsl:value-of select="normalize-space(.)"/>
    </title>
  </xsl:template>

  <xsl:template match="meta">
    <meta>
      <xsl:attribute name="name">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:attribute name="content">
        <xsl:value-of select="@content"/>
      </xsl:attribute>
    </meta>
  </xsl:template>

  <!-- Body -->
  <xsl:template match="body">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Section (recursive with depth parameter) -->
  <xsl:template match="section">
    <xsl:param name="level" select="1"/>
    <!-- Cap header level at 6 -->
    <xsl:variable name="clamped" select="number($level) &gt; 6"/>
    <xsl:variable name="header-level" select="number($clamped) * 6 + (1 - number($clamped)) * $level"/>
    <xsl:element name="{concat('h', $header-level)}">
      <xsl:value-of select="title"/>
    </xsl:element>
    <xsl:apply-templates select="*[not(self::title)]">
      <xsl:with-param name="level" select="$level + 1"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Paragraph -->
  <xsl:template match="par">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <!-- Generic block -->
  <xsl:template match="block">
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select="@type"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- Code block -->
  <xsl:template match="code-block">
    <pre>
      <xsl:choose>
        <xsl:when test="@lang">
          <code class="{@lang}">
            <xsl:value-of select="."/>
          </code>
        </xsl:when>
        <xsl:otherwise>
          <code>
            <xsl:value-of select="."/>
          </code>
        </xsl:otherwise>
      </xsl:choose>
    </pre>
  </xsl:template>

  <!-- Image -->
  <xsl:template match="image">
    <img>
      <xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
      <xsl:if test="@alt">
        <xsl:attribute name="alt"><xsl:value-of select="@alt"/></xsl:attribute>
      </xsl:if>
    </img>
  </xsl:template>

  <!-- List -->
  <xsl:template match="list">
    <xsl:choose>
      <xsl:when test="@type='enum'">
        <ol>
          <xsl:apply-templates select="item"/>
        </ol>
      </xsl:when>
      <xsl:otherwise>
        <ul>
          <xsl:apply-templates select="item"/>
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="item">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <!-- Inline elements -->
  <xsl:template match="code">
    <code>
      <xsl:value-of select="."/>
    </code>
  </xsl:template>

  <xsl:template match="emph">
    <xsl:choose>
      <xsl:when test="@style='b'"><strong><xsl:value-of select="."/></strong></xsl:when>
      <xsl:when test="@style='i'"><em><xsl:value-of select="."/></em></xsl:when>
      <xsl:when test="@style='u'"><u><xsl:value-of select="."/></u></xsl:when>
      <xsl:otherwise><span><xsl:value-of select="."/></span></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="link">
    <a>
      <xsl:attribute name="href"><xsl:value-of select="@to"/></xsl:attribute>
      <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <xsl:template match="foreign">
    <span>
      <xsl:if test="@lang">
        <xsl:attribute name="lang"><xsl:value-of select="@lang"/></xsl:attribute>
      </xsl:if>
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <xsl:template match="date">
    <time>
      <xsl:value-of select="."/>
    </time>
  </xsl:template>

  <xsl:template match="inline">
    <span>
      <xsl:if test="@type">
        <xsl:attribute name="class"><xsl:value-of select="@type"/></xsl:attribute>
      </xsl:if>
      <xsl:value-of select="."/>
    </span>
  </xsl:template>

  <!-- Table -->
  <xsl:template match="table">
    <table>
      <xsl:if test="@title">
        <caption><xsl:value-of select="@title"/></caption>
      </xsl:if>
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="thead">
    <thead>
      <tr>
        <xsl:apply-templates select="cell"/>
      </tr>
    </thead>
  </xsl:template>

  <xsl:template match="row">
    <tr>
      <xsl:apply-templates select="cell"/>
    </tr>
  </xsl:template>

  <xsl:template match="cell">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

</xsl:stylesheet>
