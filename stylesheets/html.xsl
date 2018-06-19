<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    
    <xsl:import href="https://cdn.docbook.org/release/xsl/current/html/docbook.xsl"/>
    
    <xsl:param name="emphasis.propagates.style" select="1"/>
    
    <xsl:template match="*[@role='cav:computer-key']" mode="class.value">
        <code class="{@role}">
             <xsl:apply-templates/>        
        </code>
    </xsl:template>
    
</xsl:stylesheet>