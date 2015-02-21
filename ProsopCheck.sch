<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
   <!-- <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>-->  
    <!--2015-02-21: ebb NOTE: If you convert your Prosopography file to TEI, remove the comments to activate the namespace line above, and add tei: in front of each element name in the Schematron rules here.--> 
   
    <pattern>   
        <rule context="//@ref | //@corresp ">
            <assert test="starts-with(., '#')">
                @ref or @corresp attributes MUST begin with a hashtag! 
            </assert>
        </rule>       
    </pattern>
    
    <pattern>   
        <rule context="//@ref | //@corresp ">
            <assert test="substring-after(., '#') = //@xml:id">
                The attribute of @ref or @corresp (after the hashtag, #) must match a defined @xml:id in this file. 
            </assert>
        </rule>       
    </pattern>
    
    <pattern>
        <rule context="//@xml:id">     
            <report test="matches(., '\s+')">
                @xml:id values may NOT contain white spaces!
            </report>
            
            <report test="starts-with(., '#')">
                @xml:id values may NOT begin with a hashtag!
            </report>
        </rule>
        
    </pattern>
    
    
    
    
    
</schema>