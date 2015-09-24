<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    version="2.0">


    <xsl:preserve-space elements="code"/>

    <xsl:template match="/">

        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4-portrait"
                    page-height="29.7cm"
                    page-width="21.0cm"
                    margin="1.5cm 1.5cm 0.5cm 1.5cm"
                    padding-bottom="2cm">
                    <fo:region-body space-after="30pt"/>
                    <fo:region-after region-name="footer"  extent="20pt" />
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="A4-portrait">
                <fo:flow flow-name="xsl-region-body">
                    <xsl:call-template name="cover-page"/>
                </fo:flow>
            </fo:page-sequence>
            <fo:page-sequence master-reference="A4-portrait">
                <fo:static-content flow-name="footer" >
                    <fo:block text-align="center" font-size="8pt" vertical-align="bottom" height="1cm"><fo:page-number/></fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <xsl:call-template name="toc"/>
                    <xsl:apply-templates/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <!-- Attribute templates -->
    <xsl:template name="common-text-attributes">
        <xsl:attribute name="space-before">5pt</xsl:attribute>
        <xsl:attribute name="space-after">5pt</xsl:attribute>
        <xsl:attribute name="line-height">17pt</xsl:attribute>
    </xsl:template>
    <xsl:template name="h1-attributes">
        <xsl:call-template name="common-text-attributes"/>
        <xsl:attribute name="font-size">25pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="space-after">10pt</xsl:attribute>
    </xsl:template>
    <xsl:template name="h2-attributes">
        <xsl:call-template name="common-text-attributes"/>
        <xsl:attribute name="space-before">20pt</xsl:attribute>
        <xsl:attribute name="font-size">16pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:template>
    <xsl:template name="link-attributes">
        <xsl:attribute name="color">#008FBF</xsl:attribute>
    </xsl:template>

    <!-- Cover page -->
    <xsl:template name="cover-page">
        <fo:block vertical-align="middle" margin-top="340pt">
            <fo:block font-size="35pt" text-align="center" >
                <xsl:value-of select="//head/meta[@name='title']/@content"/>
            </fo:block>
            <fo:block font-size="16pt" margin-top="10pt" text-align="center" >
                by <xsl:value-of select="//head/meta[@name='author']/@content"/>
            </fo:block>
            <fo:block font-size="8pt" margin-top="320pt" text-align="center" font-style="italic" >
                version <xsl:value-of select="//head/meta[@name='version']/@content"/>
            </fo:block>
        </fo:block>

    </xsl:template>

    <!-- TOC -->
    <xsl:template name="toc">
        <fo:block page-break-before="always">
            <fo:block font-size="25pt">
                <xsl:call-template name="h1-attributes"/>
                Table of content
            </fo:block>
            <fo:list-block >
                <xsl:for-each select="//article/h1">
                    <fo:list-item>
                        <fo:list-item-label end-indent="10cm">
                            <fo:block width="500px">
                                <fo:basic-link internal-destination="{generate-id(.)}">
                                    <xsl:call-template name="link-attributes"/>
                                    <xsl:value-of select=".//text()"/>
                                </fo:basic-link>
                            </fo:block>
                        </fo:list-item-label>
                        <fo:list-item-body start-indent="body-start()">
                            <fo:block text-align="right">
                                <fo:page-number-citation ref-id="{generate-id(.)}" />
                            </fo:block>
                        </fo:list-item-body>
                    </fo:list-item>
                </xsl:for-each>
            </fo:list-block>
        </fo:block>
    </xsl:template>

    <!-- Article -->
    <xsl:template match="article">
        <fo:block page-break-before="always">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <!-- Headers -->
    <xsl:template match="h1">
        <fo:block id="{generate-id(.)}">
            <xsl:call-template name="h1-attributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="h2">
        <fo:block >
            <xsl:call-template name="h2-attributes"/>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <!-- Para -->
    <xsl:template match="p">
        <fo:block>
            <xsl:call-template name="common-text-attributes"/>
            <xsl:apply-templates/>
        </fo:block>
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

    <xsl:template match="a[@name]">
        <fo:inline id="{@name}"/>
    </xsl:template>
    <xsl:template match="a[starts-with(@href, '#')]">
        <xsl:variable name="href" select="@href"/>
        <fo:basic-link internal-destination="{substring-after($href, '#')}">
            <xsl:call-template name="link-attributes"/>
            <xsl:apply-templates/>
        </fo:basic-link>
    </xsl:template>
    <xsl:template match="a">
        <fo:basic-link external-destination="{@href}">
            <xsl:call-template name="link-attributes"/>
            <xsl:apply-templates/>
        </fo:basic-link>
    </xsl:template>


    <!-- Lists -->
    <xsl:template match="ul|ol">
        <fo:list-block>
            <xsl:call-template name="common-text-attributes"/>
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

    <!-- Code block -->
    <xsl:template match="code[@class='block']">
        <fo:block background-color="#333"
            color="white"
            font-size="9pt"
            font-family="monospace"
            white-space="pre"
            wrap-option="wrap"
            padding="5pt"
            space-after="10pt"
            >
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="code[@class='block']/text()">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="code[@class='block']/span[@class='hll']"><fo:inline background-color="#ffffcc"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='hll']"><fo:inline background-color="#ffffcc"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='c']"><fo:inline color="#586e75"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='err']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='g']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='k']"><fo:inline color="#4192e8" font-weight="bolder"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='l']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='n']"><fo:inline color="white"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='o']"><fo:inline color="white"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='x']"><fo:inline color="#cb4b16"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='p']"><fo:inline color="#ef2929" font-weight="bolder"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='cm']"><fo:inline color="#c7c7c7"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='cp']"><fo:inline color="#c7c7c7"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='c1']"><fo:inline color="#c7c7c7"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='cs']"><fo:inline color="#c7c7c7"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='gd']"><fo:inline color="#34e2e2"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='ge']"><fo:inline color="#d0d0d0" font-style="italic"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='gr']"><fo:inline color="#ef2929"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='gh']"><fo:inline color="#cb4b16"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='gi']"><fo:inline color="#8ae234"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='go']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='gp']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='gs']"><fo:inline color="#d0d0d0" font-weight="bold"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='gu']"><fo:inline color="#cb4b16"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='gt']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='kc']"><fo:inline color="#cb4b16"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='kd']"><fo:inline color="#4192e8" font-weight="bold"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='kn']"><fo:inline color="#8ae234"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='kp']"><fo:inline color="#ad7fa8" font-weight="bolder"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='kr']"><fo:inline color="#4192e8"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='kt']"><fo:inline color="#ef2929"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='ld']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='m']"><fo:inline color="#ad7fa8" font-weight="bolder"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='s']"><fo:inline color="#ad7fa8" font-weight="bolder"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='na']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='nb']"><fo:inline color="#34e2e2" font-weight="bolder"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='nc']"><fo:inline color="#4192e8"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='no']"><fo:inline color="#8ae234" font-weight="bolder"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='nd']"><fo:inline color="#4192e8"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='ni']"><fo:inline color="#cb4b16"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='ne']"><fo:inline color="#cb4b16"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='nf']"><fo:inline color="#34e2e2" font-weight="bolder"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='nl']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='nn']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='nx']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='py']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='nt']"><fo:inline color="#4192e8"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='nv']"><fo:inline color="white"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='ow']"><fo:inline color="#8ae234"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='w']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='mf']"><fo:inline color="#34e2e2"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='mh']"><fo:inline color="#34e2e2"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='mi']"><fo:inline color="#34e2e2"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='mo']"><fo:inline color="#34e2e2"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='sb']"><fo:inline color="#586e75"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='sc']"><fo:inline color="#34e2e2"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='sd']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='s2']"><fo:inline color="#ef2929"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='se']"><fo:inline color="#cb4b16"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='sh']"><fo:inline color="#d0d0d0"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='si']"><fo:inline color="#ef2929" font-weight="bolder"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='sx']"><fo:inline color="#34e2e2"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='sr']"><fo:inline color="#ef2929"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='s1']"><fo:inline color="#34e2e2"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='ss']"><fo:inline color="#fce94f" font-weight="bolder"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='bp']"><fo:inline color="#4192e8"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='vc']"><fo:inline color="#4192e8"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='vg']"><fo:inline color="#4192e8"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='vi']"><fo:inline color="#34e2e2" font-weight="bolder"><xsl:apply-templates/></fo:inline></xsl:template>
    <xsl:template match="code[@class='block']/span[@class='il']"><fo:inline color="#34e2e2"><xsl:apply-templates/></fo:inline></xsl:template>





    <xsl:template match="blockquote">
        <fo:block background-color="#e8e6e3"
            space-before="5pt"
            space-after="5pt"
            padding-left="10pt"
            padding-right="0pt"
            padding-top="5pt"
            padding-bottom="5pt"
            margin="5pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <!-- Code inline -->
    <xsl:template match="code">
        <fo:inline background-color="#e8e6e3"
            padding-top="2pt"
            padding-bottom="1pt"
            padding-right="2pt"
            padding-left="2pt"
            font-family="monospace"
            >
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>



    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>

</xsl:stylesheet>
