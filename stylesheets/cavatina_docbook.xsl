<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:cav="blahblah" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns="http://docbook.org/ns/docbook">
 
   <xsl:template match="cav:musical-term">
      <emphasis  role="musical-term">
         <xsl:apply-templates/>
      </emphasis>
   </xsl:template>
   
   <xsl:template match="cav:computer-key">
      <code role="cav-computer-key">
         <xsl:apply-templates/>
      </code>
   </xsl:template>
   
   <xsl:template match="node()|@*">
      <xsl:copy>
         <xsl:apply-templates select="node()|@*"/>
      </xsl:copy>
   </xsl:template>
</xsl:stylesheet>
