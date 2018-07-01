<?xml version="1.0" encoding="UTF-8"?>
<!--
    
Oxygen Webhelp plugin
Copyright (c) 1998-2017 Syncro Soft SRL, Romania.  All rights reserved.

-->
<!-- Used to expand Webhelp components that are common to all templates: topic, search, main.  -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:oxy="http://www.oxygenxml.com/functions"
    xmlns:relpath="http://dita2indesign/functions/relpath"
    xmlns:whc="http://www.oxygenxml.com/webhelp/components"
    xmlns:toc="http://www.oxygenxml.com/ns/webhelp/toc"
    xmlns:oxygen="http://www.oxygenxml.com/functions"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:index="http://www.oxygenxml.com/ns/webhelp/index"
    exclude-result-prefixes="#all"
    version="2.0">
    
    <xsl:import href="../../toc_common.xsl"/>    
    
    <!-- The path of index.xml -->
    <xsl:param name="INDEX_XML_FILEPATH" select="'index.xml'"/>
    <!-- Loads the additional XML documents. -->
    <xsl:variable name="index" select="document(oxygen:makeURL($INDEX_XML_FILEPATH))/index:index"/>
    
    <!-- Map title -->
    <xsl:variable name="mapTitle" as="item()*">
        <xsl:choose>
            <xsl:when test="exists($toc/toc:title) or exists($toc/@title)">
                <xsl:choose>
                    <xsl:when test="$toc/toc:title">
                        <xsl:apply-templates select="$toc/toc:title/node()" mode="copy-xhtml-without-links"/>
                    </xsl:when>
                    <xsl:when test="$toc/@title">
                        <xsl:value-of select="$toc/@title"/>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>*** Unable to determine the map title</xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
    
    
    <!-- Merge the content of the template head element with the head element generated by DITA-OT -->
    <xsl:template match="html:head" mode="copy_template">
        <xsl:param name="ditaot_topicContent" tunnel="yes" as="node()*"/>
        <xsl:copy>
            <!-- EXM-36084 generate linkf for favicon -->
            <xsl:call-template name="generateFaviconLink"/>
            
            <xsl:choose>
                <xsl:when test="exists($ditaot_topicContent)">
                    <!-- head element from dita-ot document -->
                    <xsl:variable name="ditaot_head" select="$ditaot_topicContent//html:head"/>
                    
                    <!-- Merge the attributes from the template head element with attributes from the head element produced by DITA-OT-->
                    <xsl:variable name="mergedAttributes"
                        select="oxy:mergeHTMLAttributes('head', @*, $ditaot_head/@*)"/>
                    <xsl:copy-of select="$mergedAttributes"/>               
                  
                    <!-- EXM-36084 - Move the custom CSS at end -->
                    <xsl:variable name="customCssLink" as="element()?">
                        <xsl:if test="string-length($CSS) > 0">
                            <xsl:variable name="cssFileName" select="relpath:getName($CSS)"/>
                            <xsl:copy-of select="$ditaot_head/html:link[contains(@href, $cssFileName)]"/>
                        </xsl:if>
                    </xsl:variable>
                    
                    
                    <!-- Copy all node from the head element generated by DITA-OT except custom CSS-->
                    <xsl:copy-of select="$ditaot_head/node()[local-name() ne 'link'][local-name() ne 'script']"/>

                    <xsl:call-template name="generatePathToRootMeta"/>

                    <!-- Copy template head content -->
                    <xsl:apply-templates select="node()" mode="#current"/>
                    
                    <!-- 
                        EXM-37429 - Maintain backwards compatibility: Generate links to skin resources 
                        for older templates that do not include the dedicated component.
                    -->
                    <xsl:if test="not(whc:webhelp_skin_resources)">
                        <xsl:call-template name="addLinksToSkinResources"/>
                    </xsl:if>
                    
                    <!-- EXM-36084 - Move custom CSS at end -->
                    <xsl:if test="exists($customCssLink)">                      
                      <xsl:copy-of select="$customCssLink"/>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="generatePathToRootMeta"/>
                    <!-- Copy template head content -->
                    <xsl:apply-templates select="@* | node()" mode="#current"/>
                    
                    <!-- Page title -->
                    <title>
                        <xsl:variable 
                            name="mainBookTitle" 
                            select="$mapTitle[contains(@class, 'booktitle')]/*[contains(@class, 'mainbooktitle')]"/>                        
                        <xsl:choose>
                            <xsl:when test="exists($mainBookTitle)">
                                <xsl:value-of select="$mainBookTitle"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$mapTitle"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </title>

                    <!-- 
                        EXM-37429 - Maintain backwards compatibility: Generate links to skin resources 
                        for older templates that do not include the dedicated component.
                    -->
                    <xsl:if test="not(whc:webhelp_skin_resources)">
                        <xsl:call-template name="addLinksToSkinResources"/>
                    </xsl:if>
                    
                    <!-- EXM-36084 generate user custom CSS for main page  -->
                    <xsl:call-template name="generateCustomCSSLink"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:copy>
    </xsl:template>

    <!--
        Generate a meta element with path to the index.html located in the WH output root.
    -->
    <xsl:template name="generatePathToRootMeta">
        <xsl:choose>            
            <xsl:when test="exists($PATH2PROJ)">                                
                <meta name="wh-path2root" content="{concat($PATH2PROJ, 'index.html')}"/>
            </xsl:when>
            <xsl:otherwise>
                <meta name="wh-path2root" content="index.html"/>
            </xsl:otherwise>
        </xsl:choose>
        
        
    </xsl:template>    
    
    <!-- Generate links to CSSs and JavaScript that are custom to all Responsive pages. -->
    <xsl:template match="whc:webhelp_skin_resources" mode="copy_template">
        <xsl:call-template name="addLinksToSkinResources"/>
    </xsl:template>
    <xsl:template name="addLinksToSkinResources">
        <xsl:variable name="webhelp_skin_css_name">
            <xsl:choose>
                <xsl:when test="string-length(oxygen:getParameter('webhelp.responsive.custom.skin')) > 0">
                    <xsl:value-of select="'custom'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="oxygen:getParameter('webhelp.responsive.skin.name')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <link rel="stylesheet" type="text/css" href="{
            concat($PATH2PROJ,
                'oxygen-webhelp/template/variants/',
                oxygen:getParameter('webhelp.responsive.variant.name'),
                '/',
                $webhelp_skin_css_name,
                '/skin.css?buildId=', 
                $WEBHELP_BUILD_NUMBER)
         }"/>
    </xsl:template>
    
    
    <!-- 
        Generate links to JavaScript resources used to implement search function. 
    -->
    <xsl:template match="whc:webhelp_search_scripts" mode="copy_template">
        <!-- Search JS engine-->        
        <script type="text/javascript" src="{concat($PATH2PROJ, 'oxygen-webhelp/search/nwSearchFnt.js?buildId=', $WEBHELP_BUILD_NUMBER)}"><!----></script>
        <script type="text/javascript" src="{concat($PATH2PROJ, 'oxygen-webhelp/search/searchCommon.js?buildId=', $WEBHELP_BUILD_NUMBER)}"><!----></script>
        <script type="text/javascript" src="{concat($PATH2PROJ, 'oxygen-webhelp/search/responsive/search.js?buildId=', $WEBHELP_BUILD_NUMBER)}"><!----></script>
        <script type="text/javascript" src="{concat($PATH2PROJ, 'oxygen-webhelp/search/searchOptions.js?uniqueId=', $WEBHELP_UNIQUE_ID)}"><!----></script>
        
        <!-- Search indexer data -->
        <script type="text/javascript" src="{concat($PATH2PROJ, 'oxygen-webhelp/search/htmlFileInfoList.js?uniqueId=', $WEBHELP_UNIQUE_ID)}"><!----></script>        
        <script type="text/javascript" src="{concat($PATH2PROJ, 'oxygen-webhelp/search/index-1.js?uniqueId=', $WEBHELP_UNIQUE_ID)}"><!----></script>
        <script type="text/javascript" src="{concat($PATH2PROJ, 'oxygen-webhelp/search/index-2.js?uniqueId=', $WEBHELP_UNIQUE_ID)}"><!----></script>
        <script type="text/javascript" src="{concat($PATH2PROJ, 'oxygen-webhelp/search/index-3.js?uniqueId=', $WEBHELP_UNIQUE_ID)}"><!----></script>                
		
		<!-- Stemming -->
        <xsl:if test="string-length(normalize-space($DEFAULTLANG)) >= 2 and oxygen:getParameter('use.stemming') eq 'true' ">
            <xsl:variable name="LANG" select="lower-case(substring(normalize-space($DEFAULTLANG), 1, 2))"/>
            <xsl:if test="$LANG = 'en' or $LANG = 'fr' or $LANG = 'de'">
                <script 
                    type="text/javascript" 
                    src="{concat(
                        $PATH2PROJ, 
                        'oxygen-webhelp/search/stemmers/', 
                        $LANG, 
                        '_stemmer.js',
                        '?buildId=', 
                        $WEBHELP_BUILD_NUMBER)}"><xsl:comment/></script>
            </xsl:if>            
        </xsl:if>
    </xsl:template>
    
    <!-- 
        Expand the 'webhelp_search_input' place holder. 
    -->
    <xsl:template match="whc:webhelp_search_input" mode="copy_template">
        <!-- EXM-36737 - Context node used for messages localization -->
        <xsl:param name="initial_context_node" tunnel="yes" as="element()*"/>
        <div>
            <xsl:call-template name="generateComponentClassAttribute">
                <xsl:with-param name="compClass">wh_search_input</xsl:with-param>
            </xsl:call-template>
            <!-- Copy attributes -->
            <xsl:copy-of select="@* except @class"/>
            
            <xsl:variable name="placeHolderText">
                <xsl:choose>
                    <xsl:when test="exists($initial_context_node)">
                        <xsl:for-each select="$initial_context_node[1]">
                            <xsl:call-template name="getWebhelpString">
                                <xsl:with-param name="stringName" select="'webhelp.search'"/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>Search</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            <xsl:variable name="search_comp_output">
                        <form id="searchForm"
                            method="get"                            
                            action="{concat($PATH2PROJ, 'search', $OUTEXT)}">
                            <div>
                                <input type="search" placeholder="{$placeHolderText} " class="wh_search_textfield"
                                    id="textToSearch" name="searchQuery"/>
                                <button type="submit" class="wh_search_button"><span>Search</span></button>
                            </div>
                        </form>
            </xsl:variable>
            
            <xsl:call-template name="outputComponentContent">
                <xsl:with-param name="compContent" select="$search_comp_output"/>
                <xsl:with-param name="compName" select="local-name()"/>
            </xsl:call-template>
        </div>
    </xsl:template>
    
    <!--
        Template used to emit the component content. 
        It is aware if the a place holder is set for its content, whc:component_content.
    -->
    <xsl:template name="outputComponentContent">
        <xsl:param name="compContent"/>
        <xsl:param name="compName"/>
        
        <xsl:choose>
            <xsl:when test="count(*) = 0">
                <!-- The component has no children. Output its content -->
                <xsl:copy-of select="$compContent"/>
            </xsl:when>
            <xsl:when test="descendant::whc:component_content[ancestor::whc:*[1][local-name() = $compName]]">
                <!-- The component has set a place holder where to emit the content -->
                <xsl:apply-templates mode="#current">
                    <xsl:with-param name="compContent" select="$compContent" tunnel="yes"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <!-- 
                    There is no place holder for the content content. So, emit it here 
                -->
                <xsl:copy-of select="$compContent"/> 
                <xsl:apply-templates mode="#current"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!--
        Emit the component content.
    -->
    <xsl:template match="whc:component_content" mode="copy_template">
        <xsl:param name="compContent" tunnel="yes"/>
        <xsl:if test="exists($compContent)">
            <xsl:copy-of select="$compContent"/>            
        </xsl:if>
    </xsl:template>
    
    <!--
        WebHelp logo component
    -->
    <xsl:template match="whc:webhelp_logo" mode="copy_template">
        <!-- If the target of the logo is not specified, use the relative path to the index.html page. -->
        <xsl:variable name="href">
            <xsl:choose>
                <xsl:when test="$WEBHELP_LOGO_IMAGE_TARGET_URL"><xsl:value-of select="$WEBHELP_LOGO_IMAGE_TARGET_URL"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="concat($PATH2PROJ, 'index', $OUTEXT)"/></xsl:otherwise>                
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="logoComp">
            <a href="{$href}">          
                <xsl:call-template name="generateComponentClassAttribute">
                    <xsl:with-param name="compClass">wh_logo</xsl:with-param>
                </xsl:call-template>
                <!-- Copy attributes -->
                <xsl:copy-of select="@* except @class"/>
                
                <xsl:choose>
                   <xsl:when test="string-length($WEBHELP_LOGO_IMAGE) > 0 
                        and contains($WEBHELP_LOGO_IMAGE, ':/')">
                        <img src="{$WEBHELP_LOGO_IMAGE}" alt="{$mapTitle}"/>
                    </xsl:when>
                
                    <xsl:when
                        test="string-length($WEBHELP_LOGO_IMAGE) > 0">
                        <img src="{concat($PATH2PROJ, $WEBHELP_LOGO_IMAGE)}" alt="{$mapTitle}"/>
                    </xsl:when>
                </xsl:choose>        
            </a>
        </xsl:variable>
       
        <xsl:call-template name="outputComponentContent">
            <xsl:with-param name="compContent" select="$logoComp"/>
            <xsl:with-param name="compName" select="local-name()"/>
        </xsl:call-template>
       
    </xsl:template>
    
    
    <!-- 
        Expand 'webhelp_publication_title' place holder. 
    -->                     
    <xsl:template match="whc:webhelp_publication_title" mode="copy_template">
        <!-- If true then generate link to main page when generate the product title -->
        <xsl:variable name="publication_title">
            <div>
                <xsl:call-template name="generateComponentClassAttribute">
                    <xsl:with-param name="compClass">wh_publication_title</xsl:with-param>
                </xsl:call-template>
                <!-- Copy attributes -->
                <xsl:copy-of select="@* except @class"/>
                
                <xsl:choose>
                    <xsl:when test="exists($mapTitle)">
                        <xsl:choose>
                            <xsl:when test="exists($PATH2PROJ)">                                
                                <a href="{concat($PATH2PROJ,'index', $OUTEXT)}">
                                    <xsl:copy-of select="$mapTitle"/>
                                </a>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy-of select="$mapTitle"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message>Warn: Cannot get the map title.</xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </xsl:variable>
        
        <xsl:call-template name="outputComponentContent">
            <xsl:with-param name="compContent" select="$publication_title"/>
            <xsl:with-param name="compName" select="local-name()"/>
        </xsl:call-template>
    </xsl:template>
    
    
    <xsl:template match="whc:webhelp_search_results" mode="copy_template">
        <xsl:variable name="webhelp_search_results">
            <xsl:choose>
                <xsl:when test="string-length($WEBHELP_SEARCH_SCRIPT) > 0 and string-length($WEBHELP_SEARCH_RESULT) > 0">
                    <xsl:copy-of select="doc($WEBHELP_SEARCH_RESULT)"/>
                </xsl:when>
                <xsl:when test="string-length($WEBHELP_SEARCH_SCRIPT) > 0">
                    <div class="gcse-searchresults-only" data-autoSearchOnLoad="true" data-queryParameterName="searchQuery"></div>
                </xsl:when>
                <xsl:otherwise>
                    <div>
                        <xsl:call-template name="generateComponentClassAttribute">
                            <xsl:with-param name="compClass">wh_search_results</xsl:with-param>
                        </xsl:call-template>
                        <xsl:copy-of select="@* except @class"/>
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:call-template name="outputComponentContent">
            <xsl:with-param name="compContent" select="$webhelp_search_results"/>
            <xsl:with-param name="compName" select="local-name()"/>
        </xsl:call-template>
    </xsl:template>
    
    <!-- Utility functions -->
    <!-- 
        Merge two sequences of HTML attributes. 
        If class or style attributes are present in both sequences then the value of these attributes is merged.   
    -->
    <xsl:function name="oxy:mergeHTMLAttributes" as="attribute()*">
        <xsl:param name="parentElementName" as="xs:string"/>
        <xsl:param name="templateAttributes" as="attribute()*"/>
        <xsl:param name="ditaotAttributes" as="attribute()*"/>
        
        <xsl:choose>
            <xsl:when test="empty($templateAttributes)">
                <xsl:copy-of select="$ditaotAttributes"/>
            </xsl:when>
            
            <xsl:when test="empty($ditaotAttributes)">
                <xsl:copy-of select="$templateAttributes"/>
            </xsl:when>
            
            <xsl:otherwise>
                <xsl:variable name="mergedAttributes" as="attribute()*">
                    <xsl:for-each select="$templateAttributes">
                        <!-- Test if the attribute is also included in the DITA-OT element. -->
                        <xsl:variable name="cAttrName" select="name(.)"/>
                        
                        <xsl:variable name="ditaotAttr"
                            select="$ditaotAttributes[name() = $cAttrName]" as="attribute()*"/>
                        <xsl:choose>
                            <xsl:when test="exists($ditaotAttr)">                                
                                <xsl:choose>
                                    <!-- Union the value of class attributes -->
                                    <xsl:when test="$cAttrName = 'class'">
                                        <xsl:variable name="newClassAttr" select="concat(., ' ', $ditaotAttr)"/>
                                        <xsl:attribute 
                                            name="{$cAttrName}" 
                                            select="$newClassAttr"/>                                            
                                    </xsl:when>
                                    
                                    <!-- Union the value of style attributes -->
                                    <xsl:when test="$cAttrName = 'style'">
                                        <xsl:attribute name="{$cAttrName}" select="concat(., ';', $ditaotAttr)"/>
                                    </xsl:when>
                                    
                                    <!-- Prefer the ID from the template -->
                                    <xsl:when test="$cAttrName = 'id'">
                                        <xsl:copy-of select="."/>                                        
                                    </xsl:when>
                                    
                                    <xsl:otherwise>
                                        <xsl:copy/>
                                        <xsl:message> Warning: The attribute <xsl:value-of
                                            select="$cAttrName"/> is present on '<xsl:value-of
                                                select="$parentElementName"/>' element in template
                                            HTML document and in the HTML document generated by
                                            DITA-OT. </xsl:message>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </xsl:variable>
                <xsl:sequence select="$mergedAttributes union ($ditaotAttributes except $templateAttributes)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:template match="node() | @*" mode="copy_template">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Fix the href location for link elements when href value starts with {$oxygen-webhelp-assets-dir} -->
    <xsl:template
        match="@*[contains(., '${oxygen-webhelp')]"
        mode="copy_template" priority="10">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="oxy:expandMacros(.)"/>
        </xsl:attribute>
    </xsl:template>
    
    <!-- 
        Templates for 'create-topics-menu' mode are used to generate the menu
    -->
    <xsl:template match="whc:webhelp_top_menu" mode="copy_template">
        <xsl:if test="oxy:getParameter('webhelp.show.top.menu') = 'yes'">
            <xsl:variable name="top_menu">
            <div>
                <xsl:call-template name="generateComponentClassAttribute">
                    <xsl:with-param name="compClass">wh_top_menu</xsl:with-param>
                </xsl:call-template>
                <xsl:copy-of select="@* except @class"/>
                <ul>
                    <xsl:apply-templates select="$toc" mode="create-top-menu">
                        <xsl:with-param name="cDepth" select="1"/>
                        <xsl:with-param name="maxDepth" select="oxygen:getParameter('webhelp.top.menu.depth')"/>
                    </xsl:apply-templates>
                </ul>
            </div>
            </xsl:variable>
            
            <xsl:call-template name="outputComponentContent">
                <xsl:with-param name="compContent" select="$top_menu"/>
                <xsl:with-param name="compName" select="local-name()"/>
            </xsl:call-template>
        </xsl:if>
        
    </xsl:template>
    
    
    <!-- 
        Expand the 'webhelp_indexterms_link' to a link to the indexterms.html page.
    -->
    <xsl:template match="whc:webhelp_indexterms_link" mode="copy_template">
        <xsl:if test="oxy:getParameter('webhelp.show.indexterms.link') = 'yes'">
            <xsl:if test="count($index/*)">
                <xsl:variable name="indexterms_link">
                    <div>
                        <xsl:call-template name="generateComponentClassAttribute">
                            <xsl:with-param name="compClass">wh_indexterms_link</xsl:with-param>                
                        </xsl:call-template>
                        <xsl:copy-of select="@* except @class"/>                        
                        <a href="{concat($PATH2PROJ, 'indexTerms', $OUTEXT)}" title="Index"><span>Index</span></a>            
                    </div>        
                </xsl:variable>
                
                <xsl:call-template name="outputComponentContent">
                    <xsl:with-param name="compContent" select="$indexterms_link"/>
                    <xsl:with-param name="compName" select="local-name()"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <!-- Generate the class attribute for a WH component. -->
    <xsl:template name="generateComponentClassAttribute">
        <xsl:param name="compClass"/>
        <xsl:choose>
            <xsl:when test="@class">
                <xsl:attribute name="class" select="concat(' ', $compClass, ' ', @class, ' ')"/>
                <xsl:apply-templates select="@* except @class" mode="#current"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="class" select="concat(' ', $compClass, ' ')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Inhibit output of text in the navigation tree. -->
    <xsl:template match="text()" mode="create-top-menu"/>
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            Used to output a menu entry for each topic.
        </xd:desc>
    </xd:doc>
    <xsl:template match="toc:topic" mode="create-top-menu">
        <xsl:param name="cDepth" as="xs:integer"/>
        <xsl:param name="maxDepth" as="xs:integer"/>
        
        <xsl:if test="($cDepth le $maxDepth) and oxygen:shouldDisplayMenuItem(.)">
            <xsl:variable name="title" select="oxygen:getTopicTitle(.)"/>
            
            <li>
                <xsl:variable name="hasChildren" select="count(toc:topic) > 0 and ($cDepth + 1 le $maxDepth)"/>                
                <!-- Class attribute: -->
                <!-- Copy the output class from wh-menu to the generated li element. -->
				<!-- Mark the item as having children if this is the case. -->
                <xsl:variable name="class">
                    <xsl:if test="toc:topicmeta/toc:data[@name='wh-menu']/@outputclass">
                        <xsl:value-of select="toc:topicmeta/toc:data[@name='wh-menu']/@outputclass"/>
                    </xsl:if>
                    <xsl:if test="$hasChildren">
                        <xsl:value-of select="' has-children '"/>
                    </xsl:if>
                </xsl:variable>                
                <xsl:if test="string-length($class) > 0">
                    <xsl:attribute name="class" select="$class"/>
                </xsl:if>                                         
                <!-- Set the menu item image -->
                <xsl:call-template name="generateMenuItemImage">
                    <xsl:with-param name="cTopic" select="."/>
                    <xsl:with-param name="title" select="$title"/>
                </xsl:call-template>
                
                <xsl:call-template name="createTOCContent">
                    <xsl:with-param name="cTopic" select="."/>
                    <xsl:with-param name="title" select="$title"/>
                </xsl:call-template>
                <xsl:if test="$hasChildren">
                    <ul>
                        <xsl:apply-templates mode="#current">
                            <xsl:with-param name="cDepth" select="$cDepth + 1"/>
                            <xsl:with-param name="maxDepth" select="$maxDepth"/>
                        </xsl:apply-templates>
                    </ul>
                </xsl:if>            
            </li>
        </xsl:if>
    </xsl:template>
    
    <!--
        Template used to generate the image for a menu item. 
    -->
    <xsl:template name="generateMenuItemImage">
        <xsl:param name="title"/>
        <xsl:param name="cTopic"/>
        
        <xsl:variable 
            name="dataImage" 
            select="$cTopic/toc:topicmeta/toc:data[@name='wh-menu']/toc:data[@name='image'][@href]"/>
        
        <xsl:if test="$dataImage">
            <span class="topicImg">                                
                <img src="{concat($PATH2PROJ, $dataImage/@href)}" alt="{$title}">
                    <xsl:variable name="attrWidth" select="$dataImage/toc:data[@name = 'attr-width'][@value]"/>
                    <xsl:if test="$attrWidth">
                        <xsl:attribute name="width" select="$attrWidth/@value"/>
                    </xsl:if>
                    
                    <xsl:variable name="attrHeight" select="$dataImage/toc:data[@name = 'attr-height'][@value]"/>
                    <xsl:if test="$attrHeight">
                        <xsl:attribute name="height" select="$attrHeight/@value"/>
                    </xsl:if>
                </img>
            </span>
        </xsl:if>
    </xsl:template>
    
    <!-- Expand 'include_html' component. -->
    <xsl:template match="whc:include_html[@href]" mode="copy_template create-tiles">
        <xsl:call-template name="extractFileContent">
            <xsl:with-param name="href" select="@href"/>
        </xsl:call-template>
    </xsl:template>
    
    
    <!-- Expands file path macros -->
    <xsl:function name="oxygen:expandHrefMacros" as="xs:string">
        <xsl:param name="href" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="starts-with($href, '${oxygen-webhelp-template-dir}/')">
                <!-- The file is relative to the template directory -->
                <xsl:variable name="path_to_html" select="concat(
                    oxygen:getParameter('webhelp.responsive.template.dir'),
                    '/',
                    substring-after($href, '${oxygen-webhelp-template-dir}/'))"/>                    
                <xsl:value-of select="oxygen:makeURL($path_to_html)"/>
            </xsl:when>
            <xsl:when test="starts-with($href, '${')">
                <!-- The file is specified through a parameter -->
                <xsl:variable name="paramName" select="substring($href, 3, string-length($href) - 3)"/>
                <xsl:variable name="paramName"
                    select="substring($href, 3, string-length($href) - 3)"/>
                <xsl:variable name="pValue"
                    select="normalize-space(oxygen:getParameter($paramName))"/>
                <xsl:value-of select="$pValue" disable-output-escaping="yes"/>
            </xsl:when>                
            <xsl:otherwise>
                <xsl:value-of select="$href"/>                        
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <!-- Template used to extract the content of a file passed as parameter -->
  <xsl:template name="extractFileContent">
    <xsl:param name="href"/>
    
      <!-- Expand macros -->
      <xsl:variable name="expandedHref" select="oxy:expandHrefMacros($href)"/>   
    
    <xsl:if test="string-length(normalize-space($expandedHref)) != 0">
      <!-- Convert to URL -->
      <xsl:choose>
        <xsl:when test="(doc-available($expandedHref))">
          <!-- It is an URL -->            
          <xsl:call-template name="includeCustomHTMLContent">
            <xsl:with-param name="hrefURL" select="$expandedHref"/>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <!-- Maybe it is a filepath -->
          <xsl:variable name="fileToURL" select="oxygen:makeURL($expandedHref)"/>
          <xsl:choose>
            <!-- Test if document is available -->
            <xsl:when test="doc-available(string($fileToURL))">
              <!-- It is an URL -->            
              <xsl:call-template name="includeCustomHTMLContent">
                <xsl:with-param name="hrefURL" select="$fileToURL"/>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <!-- Copy the @href value as is to the output -->
              <xsl:value-of select="$expandedHref" disable-output-escaping="yes"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  
    <xsl:template name="copyExternalScript">
        <xsl:param name="scriptContent"/>
        <xsl:apply-templates select="$scriptContent" mode="copy_template"/>
    </xsl:template>
  
    <xsl:template match="whc:*" priority="-10">
        <xsl:message>Component not processed: <xsl:copy-of select="."></xsl:copy-of></xsl:message>
    </xsl:template>
  
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Webhelp parameters with default values..</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:variable 
        name="plugin.default.parameters" 
        select="doc('plugin:com.oxygenxml.dita-ot.plugin.webhelp:plugin.xml')//param[val[@default='true']]"/>
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Webhelp parameters with assigned values.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:variable 
        name="plugin.declared.parameters" 
        select="doc($WEBHELP_PARAMETERS_URL)/properties"/>
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Test if a parameter is specified or not.</xd:p>
        </xd:desc>
        <xd:param name="parameterName">The name of the parameter.</xd:param>
    </xd:doc>
    <xsl:function name="oxygen:isParameterSpecified" as="xs:boolean">
        <xsl:param name="parameterName"/>
        
        <xsl:value-of select="
            if (exists($plugin.declared.parameters/property[@name=$parameterName]/@value)) 
                then true() 
                else false()"/>
    </xsl:function>
    
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
        <xd:desc>
            <xd:p>Retrieves the value for the given parameter.</xd:p>
        </xd:desc>
        <xd:param name="parameterName">The name of the parameter.</xd:param>
    </xd:doc>
    <xsl:function name="oxygen:getParameter">
        <xsl:param name="parameterName"/>
        <xsl:choose>
            <!-- Look for an assigne value. -->
            <xsl:when test="$plugin.declared.parameters/property[@name=$parameterName]">
                <xsl:value-of select="$plugin.declared.parameters/property[@name=$parameterName]/@value"/>
            </xsl:when>
            <!-- Otherwise look for a default value. -->
            <xsl:when test="$plugin.default.parameters[@name=$parameterName]">
                <xsl:value-of select="$plugin.default.parameters[@name=$parameterName]/val[@default='true']/node()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="''"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
	
    <xsl:template match="whc:*" mode="copy_template" priority="-10"/>
    
    <!-- Function used to test if a topic will be included in the menu -->
    <xsl:function name="oxygen:shouldDisplayMenuItem" as="xs:boolean">
        <xsl:param name="cTopic"/>
        
        <xsl:value-of select="not($cTopic/toc:topicmeta/toc:data[@name='wh-menu']/toc:data[@name='hide']/@value = 'yes')"/>
    </xsl:function>
    
    <!-- Generate link to custom CSS -->
    <xsl:template name="generateCustomCSSLink">
        <xsl:if test="string-length($CSS) > 0">
            <xsl:variable name="urltest">
                <!-- test for URL -->
                <xsl:call-template name="url-string-oxy-internal">
                    <xsl:with-param name="urltext">
                        <xsl:value-of select="concat($CSSPATH, $CSS)"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="$urltest = 'url'">
                    <link rel="stylesheet" type="text/css" href="{$CSSPATH}{$CSS}"
                        data-css-role="args.css">
                        <xsl:comment/>
                    </link>
                </xsl:when>
                <xsl:otherwise>
                    <link rel="stylesheet" type="text/css" href="{$PATH2PROJ}{$CSSPATH}{$CSS}"
                        data-css-role="args.css">
                        <xsl:comment/>
                    </link>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>
    
    <!-- Generate link to favicon -->
    <xsl:template name="generateFaviconLink">
        <xsl:variable name="favIcon" select="oxygen:getParameter('webhelp.favicon')"/>
        <xsl:if test="string-length($favIcon) > 0">
            <xsl:variable name="favIconName" select="relpath:getName(oxygen:makeURL($favIcon))"/>
            <xsl:variable name="favIconUrl" select="concat($PATH2PROJ, $favIconName)"/>
            <link rel="shortcut icon">
                <xsl:attribute name="href">
                    <xsl:value-of select="$favIconUrl"/>
                </xsl:attribute>
                <xsl:comment/>
            </link>
            <link rel="icon">
                <xsl:attribute name="href">
                    <xsl:value-of select="$favIconUrl"/>
                </xsl:attribute>
                <xsl:comment/>
            </link>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="url-string-oxy-internal">
        <xsl:param name="urltext"/>
        <xsl:choose>
            <xsl:when test="contains($urltext, 'http://')">url</xsl:when>
            <xsl:when test="contains($urltext, 'https://')">url</xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="*" mode="copy-xhtml copy-xhtml-without-links">
        <xsl:element name="{local-name()}" namespace="{namespace-uri()}">
            <xsl:apply-templates select="@* | node()" mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="@*" mode="copy-xhtml copy-xhtml-without-links">
        <xsl:attribute name="{local-name()}" select="."/>
    </xsl:template>
    
    <!-- Skip HTML 'a' elements from output -->
    <xsl:template match="*:a" mode="copy-xhtml-without-links">
        <xsl:apply-templates select="node()" mode="#current"/>
    </xsl:template>
</xsl:stylesheet>