<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
  xmlns="http://www.daisy.org/z3986/2005/ncx/"
  exclude-result-prefixes="xsl ncx">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/document">
    <ncx version="2005-1" xmlns="http://www.daisy.org/z3986/2005/ncx/">
      <head>
        <meta name="dtb:uid" content="urn:uuid:12345"/>
        <meta name="dtb:depth" content="6"/>
        <meta name="dtb:totalPageCount" content="0"/>
        <meta name="dtb:maxPageNumber" content="0"/>
      </head>

      <docTitle>
        <text><xsl:value-of select="head/title"/></text>
      </docTitle>

      <navMap>
        <xsl:apply-templates select="body/section">
          <xsl:with-param name="level" select="1"/>
          <xsl:with-param name="playOrder" select="1"/>
        </xsl:apply-templates>
      </navMap>
    </ncx>
  </xsl:template>

  <!-- Section element to navPoint -->
  <xsl:template match="section">
    <xsl:param name="level" select="1"/>
    <xsl:param name="playOrder"/>

    <navPoint id="navPoint{generate-id()}" playOrder="{$playOrder}">
      <navLabel>
        <text><xsl:value-of select="normalize-space(title)"/></text>
      </navLabel>
      <content src="content.xhtml#section{$playOrder}"/>
    </navPoint>

    <xsl:apply-templates select="section">
      <xsl:with-param name="level" select="number($level) + 1"/>
      <xsl:with-param name="playOrder" select="number($playOrder) + position()"/>
    </xsl:apply-templates>
  </xsl:template>
</xsl:stylesheet>
