<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="1.0">

    
    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates select=".//article[last()]"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="article">
        <xsl:copy>
            <xsl:apply-templates select=".//div[@class='bar']/node()"/>
            <xsl:apply-templates select=".//div[@class='body']/node()"/>
        </xsl:copy>
        <xsl:apply-templates select="preceding::article[1]"/>
    </xsl:template>

    
    <xsl:template match="h1/a">
        <xsl:apply-templates/>
    </xsl:template>

        

    <xsl:template match="@*|node()" >
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"  />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
