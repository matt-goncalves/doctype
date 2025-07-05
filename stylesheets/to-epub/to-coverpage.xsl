<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="#default">

  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:strip-space elements="*"/>

  <!-- ========= Root ========= -->
  <xsl:template match="/document">
    <html>
      <head>
        <title>
          <xsl:value-of select="head/title"/>
        </title>
        <meta charset="UTF-8"/>
        <link rel="stylesheet" type="text/css" href="styles.css"/>
      </head>
      <body>
        <div class="container">

          <div class="header">
            <h1 class="book-title">
              <xsl:value-of select="head/title"/>
            </h1>

            <!-- subtitle -->
            <xsl:if test="head/meta[@name='subtitle']">
              <p class="book-subtitle">
                <xsl:value-of select="head/meta[@name='subtitle']/@content"/>
              </p>
            </xsl:if>

            <!-- author -->
            <xsl:if test="head/meta[@name='author']">
              <p class="book-by">by</p>
              <p class="book-author">
                <xsl:value-of select="head/meta[@name='author']/@content"/>
              </p>
            </xsl:if>
          </div>

          <!-- copyright -->
          <xsl:if test="head/meta[@name='copyright']">
            <div class="copyright">
              <p class="copyright-info">
                <xsl:value-of select="head/meta[@name='copyright']/@content"/>
              </p>
            </div>
          </xsl:if>

          <!-- publisher -->
          <xsl:if test="head/meta[@name='publisher']">
            <div class="publisher">
              <p class="publisher-info">
                <xsl:value-of select="head/meta[@name='publisher']/@content"/>
              </p>
            </div>
          </xsl:if>

        </div>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>
