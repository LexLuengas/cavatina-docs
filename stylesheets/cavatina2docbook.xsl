<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://docbook.org/ns/docbook"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
   xmlns:cav="http://cavatinafont.com/docbook"
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
   
   <xsl:template match="cav:music-notation">
      <xsl:variable name="isMultipart" select="@multipart" />
      <inlinemediaobject>
         <xsl:choose>
            <xsl:when test="$isMultipart != ''">
               <xsl:attribute name="role">
                  <xsl:value-of select="'multipart'"/>
               </xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
               <xsl:attribute name="role">
                  <xsl:value-of select="'singlepart'"/>
               </xsl:attribute>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:copy-of select="@id|@for"/>
         <imageobject>
            <imagedata>
               <xsl:attribute name="fileref">
                  <xsl:value-of select="@fallback-source"/>
               </xsl:attribute>
            </imagedata>
         </imageobject>
      </inlinemediaobject>
   </xsl:template>
   
   <xsl:template match="cav:figure">
      <figure role="cavatina-figure">
         <xsl:copy-of select="@id"/>
         <xsl:apply-templates/>
      </figure>
   </xsl:template>
   
   <xsl:template match="node()|@*">
      <xsl:copy>
         <xsl:apply-templates select="node()|@*"/>
      </xsl:copy>
   </xsl:template>
</xsl:stylesheet>
