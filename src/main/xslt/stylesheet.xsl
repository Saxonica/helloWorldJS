<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 	        xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"
                xmlns:js="http://saxonica.com/ns/globalJS"
                xmlns:saxon="http://saxon.sf.net/"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="ixsl js saxon xs"
                version="3.0">

<!-- add map and array -->

<xsl:output method="html" html-version="5" encoding="utf-8" indent="no"/>

<xsl:template match="/">
  <xsl:result-document href="#hello" method="ixsl:replace-content">
    <xsl:apply-templates/>
  </xsl:result-document>
</xsl:template>

<xsl:template match="doc">
  <main>
    <xsl:apply-templates/>
    <div id="button">
      <sl-button>Click me</sl-button>
    </div>
  </main>

  <xsl:variable name="intro" select="ixsl:page()/id('intro')"/>
  <ixsl:set-style name="display" select="'block'" object="$intro"/>
</xsl:template>

<xsl:template match="title">
  <h1>
    <xsl:apply-templates/>
  </h1>
</xsl:template>

<xsl:template match="para">
  <p>
    <xsl:apply-templates/>
  </p>
</xsl:template>

<xsl:template match="element()">
  <xsl:copy>
    <xsl:apply-templates select="@*,node()"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="attribute()|text()|comment()|processing-instruction()">
  <xsl:copy/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template mode="ixsl:onclick" match="sl-button">
  <xsl:variable name="count" select="count(id('button')//p)"/>
  <xsl:result-document href="#button">
    <xsl:choose>
      <xsl:when test="$count = 0">
        <p>You pushed the button!</p>
      </xsl:when>
      <xsl:when test="$count = 1">
        <p>You pushed the button again!</p>
      </xsl:when>
      <xsl:otherwise>
        <p xsl:expand-text="yes">You pushed the button {$count + 1} times!</p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:result-document>
</xsl:template>

</xsl:stylesheet>
