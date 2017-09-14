<?xml version="1.0"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:csv="csv:csv">
    <xsl:output method="text" encoding="utf-8"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="delimiter" select="','"/>
    <csv:columns>
        <column>author</column>
        <column>title</column>
        <column>published</column>
    </csv:columns>
    <xsl:template match="/library">
        <xsl:for-each select="document('')/*/csv:columns/*">
            <xsl:value-of select="upper-case(.)"/>
            <xsl:if test="position() != last()">
                <xsl:value-of select="$delimiter"/>
            </xsl:if>
        </xsl:for-each>
        <xsl:text>
</xsl:text>
        <xsl:apply-templates select="*"/>
    </xsl:template>
    <xsl:template match="/library/books/book">
        <xsl:variable name="property" select="."/>
        <xsl:for-each select="document('')/*/csv:columns/*">
            <xsl:variable name="column" select="."/>
            <xsl:variable name="value" select="$property/*[name() = $column]"/>
            <xsl:value-of select="$value"/>
            <xsl:if test="$column = 'type'">
                <xsl:value-of select="$property/@type"/>
            </xsl:if>
                      <xsl:if test="position() != last()">
                <xsl:value-of select="$delimiter"/>
            </xsl:if>
        </xsl:for-each>
        <xsl:text>
</xsl:text>
    </xsl:template>
</xsl:stylesheet>