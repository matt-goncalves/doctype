<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs">

  <xsl:output method="text" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <!-- Main template -->
  <xsl:template match="/document">
    <!-- YAML Front Matter -->
    <xsl:text>---
</xsl:text>
    <xsl:apply-templates select="head/title"/>
    <xsl:apply-templates select="head/meta"/>
    <xsl:text>---

</xsl:text>
    <xsl:apply-templates select="body"/>
  </xsl:template>

  <!-- Title to YAML -->
  <xsl:template match="title">
    <xsl:text>title: </xsl:text>
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <!-- Metadata to YAML -->
  <xsl:template match="meta">
    <xsl:value-of select="normalize-space(@name)"/>
    <xsl:text>: </xsl:text>
    <xsl:value-of select="normalize-space(@content)"/>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <!-- Section handling with recursive depth control -->
  <xsl:template match="section">
    <xsl:param name="level" select="1"/>
    <xsl:call-template name="print-header">
      <xsl:with-param name="level" select="$level"/>
      <xsl:with-param name="title" select="title"/>
    </xsl:call-template>
    <xsl:apply-templates select="*[not(self::title)]">
      <xsl:with-param name="level" select="$level + 1"/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Header printer -->
  <xsl:template name="print-header">
    <xsl:param name="level"/>
    <xsl:param name="title"/>
    <xsl:variable name="depth" select="number($level) &gt; 6"/>
    <xsl:variable name="actualLevel" select="number($depth) * 6 + (1 - number($depth)) * $level"/>
    <xsl:for-each select="document('')/*[position() &lt;= $actualLevel]">
      <xsl:text>#</xsl:text>
    </xsl:for-each>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$title"/>
    <xsl:text>

</xsl:text>
  </xsl:template>

  <!-- Paragraph -->
  <xsl:template match="par">
    <xsl:apply-templates/>
    <xsl:text>

</xsl:text>
  </xsl:template>

  <!-- Block generic -->
  <xsl:template match="block">
    <xsl:text>
</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <!-- Code block -->
  <xsl:template match="code-block">
    <xsl:text>
```</xsl:text>
    <xsl:value-of select="@lang"/>
    <xsl:text>
</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>
```

</xsl:text>
  </xsl:template>

  <!-- List and items -->
  <xsl:template match="list">
    <xsl:apply-templates select="item">
      <xsl:with-param name="level" select="1"/>
    </xsl:apply-templates>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <xsl:template match="item">
    <xsl:param name="level" select="1"/>
    <xsl:call-template name="indent">
      <xsl:with-param name="level" select="$level - 1"/>
    </xsl:call-template>
    <xsl:text>- </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <!-- Inline elements -->
  <xsl:template match="code">
    <xsl:text>`</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>`</xsl:text>
  </xsl:template>

  <xsl:template match="emphasis">
    <xsl:choose>
      <xsl:when test="@style='b'"><xsl:text>**</xsl:text><xsl:value-of select="."/><xsl:text>**</xsl:text></xsl:when>
      <xsl:when test="@style='i'"><xsl:text>*</xsl:text><xsl:value-of select="."/><xsl:text>*</xsl:text></xsl:when>
      <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="link">
    <xsl:text>[</xsl:text><xsl:value-of select="."/><xsl:text>](</xsl:text><xsl:value-of select="@to"/><xsl:text>)</xsl:text>
  </xsl:template>

  <xsl:template match="foreign | date | inline">
    <xsl:value-of select="."/>
  </xsl:template>

  <!-- Table -->
  <xsl:template match="table">
    <xsl:apply-templates/>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <xsl:template match="row">
    <xsl:text>| </xsl:text>
    <xsl:for-each select="cell">
      <xsl:apply-templates/>
      <xsl:text> | </xsl:text>
    </xsl:for-each>
    <xsl:text>
</xsl:text>
  </xsl:template>

  <!-- Recursive indentation for nested list -->
  <xsl:template name="indent">
    <xsl:param name="level" select="0"/>
    <xsl:if test="$level &gt; 0">
      <xsl:text>  </xsl:text>
      <xsl:call-template name="indent">
        <xsl:with-param name="level" select="$level - 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Normalize text nodes except inside code-block -->
  <xsl:template match="text()[not(ancestor::code-block)]">
    <xsl:value-of select="normalize-space(.)"/>
    <xsl:text> </xsl:text>
  </xsl:template>

</xsl:stylesheet>

