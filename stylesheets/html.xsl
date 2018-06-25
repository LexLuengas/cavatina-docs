<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:db="http://docbook.org/ns/docbook" 
    xmlns:cav="http://cavatina-font.com/docbook"
    exclude-result-prefixes="db cav">
    
    <!-- Import docbook HTML tranformation -->
    <xsl:import href="https://cdn.docbook.org/release/xsl/current/html/docbook.xsl"/>
    
    <xsl:output indent="yes"/>
    
    <xsl:template match="cav:computer-key">
        <code class="computer-key">
             <xsl:apply-templates/>  
        </code>
    </xsl:template>
    
    <xsl:template match="cav:musical-term">
        <span class="musical-term">
            <xsl:apply-templates/>  
        </span>
    </xsl:template>
</xsl:stylesheet>