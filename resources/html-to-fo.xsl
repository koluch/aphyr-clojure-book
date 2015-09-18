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
                    <xsl:apply-templates/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>


    <xsl:template match="h1">
        <fo:block font-size="25pt" space-after="10pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="h2">
        <fo:block font-size="16pt" space-after="10pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="p">
        <fo:block space-after="10pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <!-- Lists -->
    <xsl:template match="ul|ol">
        <fo:list-block margin-top="10pt">
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="ul/li">
        <fo:list-item>
            <fo:list-item-label end-indent="0">
                <fo:block>
                    <fo:inline>&#8212;</fo:inline>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block>
                    <xsl:apply-templates />
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <xsl:template match="ol/li">
        <fo:list-item space-after="10pt">
            <fo:list-item-label end-indent="0">
                <fo:block>
                    <fo:inline><xsl:value-of select="count(preceding-sibling::li) + 1"/>. </fo:inline>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="20pt">
                <fo:block>
                    <xsl:apply-templates />
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <xsl:template match="code">
    </xsl:template>

    <xsl:template match="em">
        <fo:inline font-style="italic">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>
    
    <xsl:template match="sup">
        <fo:inline vertical-align="super">
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template match="a">
        <fo:basic-link external-destination="${@href}" color="#00C0FF"><xsl:apply-templates/></fo:basic-link>
    </xsl:template>

    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>

</xsl:stylesheet>
