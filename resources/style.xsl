<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="1.0">

    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4-portrait"
                    page-height="29.7cm" page-width="21.0cm" margin="2cm">
                    <fo:region-body/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="A4-portrait">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates select=".//article[last()]"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="article">
        <fo:block font-size="20pt">
            <xsl:value-of select=".//div[@class='bar']/h1/a/text()"/>
        </fo:block>

        <xsl:apply-templates select=".//div[@class='body']/p"/>

        <xsl:apply-templates select="preceding::article[1]"/>
    </xsl:template>

    <xsl:template match="p">
        <fo:block margin-bottom="10pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>


    <xsl:template match="em">
        <fo:inline font-style="italic">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template match="a"><fo:basic-link external-destination="${@href}" color="#00C0FF"><xsl:apply-templates/></fo:basic-link></xsl:template>

    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>


    <xsl:template match="@*|*"/>

</xsl:stylesheet>
