<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:fn="custom_function_ns"
    version="2.0">

    <xsl:param name="version"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <meta name="title" content="Clojure from the ground up"/>
                <meta name="author" content="Kyle Kingsbury"/>
                <meta name="version" content="{$version}"/>
            </head>
            <body>
                <xsl:apply-templates select="reverse(.//article[.//h1/a/@href != '/posts/318-clojure-from-the-ground-up-roadmap'])"/>
            </body>
        </html>
    </xsl:template>


    <xsl:template match="article">
        <xsl:copy>
            <a>
                <xsl:attribute name="name" select=".//div[@class='bar']/h1/a/@href"/>
            </a>
            <xsl:apply-templates select=".//div[@class='bar']/node()" />
            <xsl:apply-templates select=".//div[@class='body']/node()" />
        </xsl:copy>

    </xsl:template>

    <xsl:function name="fn:map-url">
        <xsl:param name="url"/>
        <xsl:choose>
            <xsl:when test="$url = '/posts/301-clojure-from-the-ground-up-first-principles'">
                <xsl:value-of select="'/posts/301-clojure-from-the-ground-up-welcome'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$url"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

    <xsl:template match="h1">
        <xsl:variable name="title" select="substring-after(./a/text(), 'Clojure from the ground up: ')" />
        <xsl:variable name="number" select="count(following::article[.//h1/a/@href != '/posts/318-clojure-from-the-ground-up-roadmap']) + 1" />
        <xsl:copy>
        <xsl:value-of
            select="concat('Chapter ', $number, ': ', upper-case(substring($title,1,1)), substring($title, 2))" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="a">
        <!-- Replace links to the chapters of this books by local links -->
        <xsl:choose>
            <xsl:when test="starts-with(@href, 'http://aphyr.com/') or starts-with(@href, '/posts/')">
                <xsl:variable name="local-path">
                    <xsl:variable name="unmapped">
                        <xsl:choose>
                            <xsl:when test="starts-with(@href, 'http://aphyr.com')">
                                <xsl:value-of select="substring-after(@href, 'http://aphyr.com')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="@href"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:value-of select="fn:map-url($unmapped)"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="//article[.//h1/a/@href = $local-path]">
                        <a>
                            <xsl:apply-templates select="@*" />
                            <xsl:attribute name="href" select="concat('#', $local-path)"/>
                            <xsl:apply-templates select="node()" />
                        </a>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:copy>
                            <xsl:apply-templates select="@*|node()" />
                        </xsl:copy>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()" />
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
