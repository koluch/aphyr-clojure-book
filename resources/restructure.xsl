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

        <xsl:choose>
            <!-- Skip roadmap post -->
            <xsl:when test="count(.//a[@href = '/posts/318-clojure-from-the-ground-up-roadmap']) > 0"/>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select=".//div[@class='bar']/node()"/>
                    <xsl:apply-templates select=".//div[@class='body']/node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="preceding-sibling::article[1]"/>

    </xsl:template>

    
    <xsl:template match="h1/a">
        <xsl:variable name="title" select="substring-after( ., 'Clojure from the ground up: ')"/>
        <xsl:value-of select="concat(upper-case(substring($title,1,1)), substring($title, 2))"/>
    </xsl:template>
        

    <xsl:template match="@*|node()" >
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"  />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
