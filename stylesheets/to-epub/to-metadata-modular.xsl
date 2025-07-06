<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:opf="http://www.idpf.org/2007/opf"
  exclude-result-prefixes="dc opf">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/document">
    <package version="3.0" xmlns="http://www.idpf.org/2007/opf" unique-identifier="bookid">
      <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">
        <dc:identifier id="bookid">
          <xsl:value-of select="concat('urn:uuid:', generate-id())"/>
        </dc:identifier>
        <dc:title>
          <xsl:value-of select="normalize-space(head/title)"/>
        </dc:title>
        <dc:language>
          <xsl:value-of select="head/meta[@name='language']/@content"/>
        </dc:language>
        <dc:creator>
          <xsl:value-of select="head/meta[@name='author']/@content"/>
        </dc:creator>
        <dc:date>
          <xsl:value-of select="head/meta[@name='date']/@content"/>
        </dc:date>
      </metadata>

      <manifest>
        <!-- Static files -->
        <item id="toc" href="toc.xhtml" media-type="application/xhtml+xml" properties="nav"/>
        <item id="ncx" href="toc.ncx" media-type="application/x-dtbncx+xml"/>
        <item id="style" href="styles.css" media-type="text/css"/>
        <item id="cover-image" href="images/cover.jpg" media-type="image/jpeg" properties="cover-image"/>

        <!-- hard-coded title page (frontmatter) -->
        <item id="title-page" href="title-page.xhtml" media-type="application/xhtml+xml"/>

        <!-- One item per section -->
        <xsl:for-each select="body/section">
          <xsl:variable name="index" select="position()" />
          <item>
            <xsl:attribute name="id">sec<xsl:value-of select="$index"/></xsl:attribute>
            <xsl:attribute name="href">section-<xsl:value-of select="$index"/>.xhtml</xsl:attribute>
            <xsl:attribute name="media-type">application/xhtml+xml</xsl:attribute>
          </item>
        </xsl:for-each>
      </manifest>

      <spine toc="ncx">

        <!-- hard-coded title page frontmatter -->
        <itemref idref="title-page" />

        <!-- One itemref per section -->
        <xsl:for-each select="body/section">
          <xsl:variable name="index" select="position()" />
          <itemref idref="sec{$index}"/>
        </xsl:for-each>
      </spine>
    </package>
  </xsl:template>

</xsl:stylesheet>
