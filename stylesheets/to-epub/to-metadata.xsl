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
        <item id="content" href="content.xhtml" media-type="application/xhtml+xml"/>
        <item id="toc" href="toc.xhtml" media-type="application/xhtml+xml" properties="nav"/>
        <item id="ncx" href="toc.ncx" media-type="application/x-dtbncx+xml"/>
      </manifest>

      <spine toc="ncx">
        <itemref idref="content"/>
      </spine>
    </package>
  </xsl:template>

</xsl:stylesheet>
