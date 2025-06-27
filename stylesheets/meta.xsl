<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- === documentation ===

This stylesheet extracts the metadata from the standard document and generates
YML from it. It's meant to be used with the script `meta`. Generic meta
elements are always used, except in the title metadata.

2025-06-27T15:04:17-0300

=== === -->

  <xsl:output method="text" encoding="UTF-8"/>

  <!-- Match the root document -->
  <xsl:template match="/">

    <!-- Output the title if present -->
    <xsl:if test="//head/title">
      <xsl:text>title: "</xsl:text>
      <xsl:value-of select="normalize-space(//head/title)"/>
      <xsl:text>"&#10;</xsl:text>
    </xsl:if>

    <!-- Output all meta name/content pairs -->
    <xsl:for-each select="//head/meta">
      <xsl:variable name="name" select="@name"/>
      <xsl:variable name="content" select="@content"/>
      <xsl:value-of select="$name"/>
      <xsl:text>: "</xsl:text>
      <xsl:value-of select="normalize-space($content)"/>
      <xsl:text>"&#10;</xsl:text>
    </xsl:for-each>

  </xsl:template>

</xsl:stylesheet>
