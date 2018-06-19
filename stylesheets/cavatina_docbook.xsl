<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://docbook.org/ns/docbook"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:cav="http://cavatina-font.com/docbook"
   version="1.0">
 
   <xsl:template match="cav:musical-term">
      <emphasis role="musical-term">
         <xsl:apply-templates/>
      </emphasis>
   </xsl:template>
   
   <xsl:template match="cav:computer-key">
      <code role="computer-key">
         <xsl:apply-templates/>
      </code>
   </xsl:template>
   
   <xsl:template match="node()|@*">
      <xsl:copy>
         <xsl:apply-templates select="node()|@*"/>
      </xsl:copy>
   </xsl:template>
</xsl:stylesheet>
