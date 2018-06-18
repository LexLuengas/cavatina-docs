<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                version="1.0"
                exsl:dummy="dummy">
   <xsl:template match="/" mode="stripNS">
      <xsl:variable name="unspecialized">
         <xsl:apply-templates mode="remap"/>
      </xsl:variable>
      <xsl:apply-templates select="exsl:node-set($unspecialized)/node()" mode="stripNS"/>
   </xsl:template>
   <xsl:template match="*[local-name() = 'musical-term'][namespace-uri() = 'http://docbook.org/ns/docbook']"
                 mode="remap">
      <emphasis xmlns="http://docbook.org/ns/docbook">
         <xsl:apply-templates mode="remap"/>
      </emphasis>
   </xsl:template>
   <xsl:template match="*[local-name() = 'cav-computer-key'][namespace-uri() = 'http://docbook.org/ns/docbook']"
                 mode="remap">
      <code xmlns="http://docbook.org/ns/docbook">
         <xsl:apply-templates mode="remap"/>
      </code>
   </xsl:template>
   <xsl:template match="node()|@*" mode="remap">
      <xsl:copy>
         <xsl:apply-templates select="node()|@*" mode="remap"/>
      </xsl:copy>
   </xsl:template>
</xsl:stylesheet>
