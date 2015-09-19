<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:fn="custom_function_ns"
    version="2.0">

    <xsl:template match="/">
        <html>
            <body>
                <xsl:apply-templates select="reverse(.//article[.//h1/a/@href != '/posts/318-clojure-from-the-ground-up-roadmap'])"/>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="article">

        <xsl:copy>
            <xsl:apply-templates select=".//div[@class='bar']/node()" />
            <xsl:apply-templates select=".//div[@class='body']/node()" />
        </xsl:copy>

    </xsl:template>


    <xsl:template match="h1">
        <xsl:variable name="title" select="substring-after(./a/text(), 'Clojure from the ground up: ')" />
        <xsl:variable name="number" select="count(following::article[.//h1/a/@href != '/posts/318-clojure-from-the-ground-up-roadmap']) + 1" />
        <xsl:copy>
        <xsl:value-of
            select="concat('Chapter ', $number, ' :', upper-case(substring($title,1,1)), substring($title, 2))" />
        </xsl:copy>
    </xsl:template>


    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
