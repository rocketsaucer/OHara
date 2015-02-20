<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    
    <let name="Prosop" value="doc('OHaraProsopography.xml')//@xml:id"/>
    <let name="ProsopFile" value="doc('OHaraProsopography.xml')"/>
    
    <pattern>
        <rule context="//text//*">
           <report test="@xml:id | @xmlid">               
               NEVER, NEVER, NEVER use an @xml:id in the elements in a poem!!!!!!!! 
           </report>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="//@ref">
            <assert test="starts-with(., '#')">
                The @ref attribute must always begin with a hashtag (#)!
            </assert>
        </rule>     
    </pattern>
    
   <pattern>
       <rule context="//placeName/@ref">
           <let name="tokens" value="for $i in tokenize(., '\s+') return substring-after($i,'#')"/>
           <assert test="every $token in $tokens satisfies $token = $ProsopFile//listPlace//@xml:id">
               <!--<assert test="substring-after(., '#') = $siFile//tei:text//tei:listPerson//@xml:id | $siFile//tei:text//tei:listOrg//@xml:id">-->
               The @ref attribute value after the hashtag must match an appropriate xml:id on our site's Prosopography file.
           </assert>   
       </rule>
   </pattern>
    
    <pattern>
        <rule context="//placeName">
            <let name="tokens" value="for $i in @ref/tokenize(., '\s+') return substring-after($i,'#')"/>
            <assert test="every $token in $tokens satisfies $token = $ProsopFile//listPlace//@xml:id">
                <!--<assert test="substring-after(., '#') = $siFile//tei:text//tei:listPerson//@xml:id | $siFile//tei:text//tei:listOrg//@xml:id">-->
                The @ref attribute value after the hashtag must match an appropriate xml:id on our site's Prosopography file.
            </assert> 
            <assert test=". = $ProsopFile//listPlace//placeName[parent::place/@xml:id = substring-after(current()/@ref, '#')]">
                The contents of the placeName element MUST match a placeName defined, *with the appropriate @xml:id* in the listPlace.
            </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="//persName">
            <let name="tokens" value="for $i in @ref/tokenize(., '\s+') return substring-after($i,'#')"/>
            <assert test="every $token in $tokens satisfies $token = $ProsopFile//listPerson//@xml:id">
                <!--<assert test="substring-after(., '#') = $siFile//tei:text//tei:listPerson//@xml:id | $siFile//tei:text//tei:listOrg//@xml:id">-->
                The @ref attribute value after the hashtag must match an appropriate xml:id on our site's Prosopography file.
            </assert> 
            <assert test="$ProsopFile//listPerson//persName[parent::person/@xml:id = substring-after(current()/@ref, '#')][contains(., current())]">
                The contents of the persName element MUST a) match some portion of a persName defined in the Prosopography file, and  b) hold the appropriate @xml:id for that person!
            </assert>
        </rule>
    </pattern>
    
    
    
</schema>