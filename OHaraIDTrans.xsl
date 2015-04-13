<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    
    <xsl:output method="xml" indent="no"/>
    <!--ebb: note on xsl:output: In this identity transformation stylesheet, the indent="no" setting should preserve the editor's original line indentation and stop the transformation from "pretty-printing" the output. It might have unexpected consequences, such that we may need to add some returns and white spaces, etc. -->
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <!--ebb: The above template rule makes this an Identity Transformation, exactly reproducing the entire XML file. We can now write rules to add or alter things in the XML document, such as to number lines. -->
    
   
   <xsl:template match="l">
     
             <l n="{count(preceding::l) + 1}"/>
   </xsl:template>
   
    
</xsl:stylesheet>