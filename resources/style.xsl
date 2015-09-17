<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="1.0">
    
    <xsl:template match="/">
        <xsl:apply-templates select="//article"/>
    </xsl:template>
    
    <xml:template match="article">
        <h1><xsl:value-of select="h1/a/text()" /></h1>
    </xml:template>

</xsl:stylesheet>
