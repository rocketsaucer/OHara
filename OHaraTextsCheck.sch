<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    
    <let name="Prosop" value="doc('OHaraProsopography.xml')//@xml:id"/>
    <let name="ProsopFile" value="doc('OHaraProsopography.xml')"/>
    
    <pattern>
        <rule context="//body//*">
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
        <rule context="//persName | //placeName">
            <report test=".[starts-with(., ' ')] | .[ends-with(., ' ')]">
            The persName and placeName elements must not start with or end with a white space.
            </report>
        </rule>
        
    </pattern>
    
   <pattern>
       <rule context="//placeName/@ref">
           <let name="tokens" value="for $i in tokenize(., '\s+') return substring-after($i,'#')"/>
           <assert test="every $token in $tokens satisfies $token = $ProsopFile//listPlace//@xml:id">
               The @ref attribute value after the hashtag must match an appropriate xml:id on our site's Prosopography file.
           </assert>   
       </rule>
   </pattern>
    
    <pattern>
        <rule context="//placeName">
            <let name="portions" value="for $i in tokenize(., '\s+') return $i"/>
            <let name="prosopMatches" value="$ProsopFile//listPlace//placeName[parent::place/@xml:id = substring-after(current()/@ref, '#')][contains(., current())]"/>
            <let name="prosopMatch" value="for $p in $prosopMatches return $p"/>
    
            <let name="portionMatch" value="for $portion in $portions return $portion[contains($prosopMatch, $portion)]"/>
            
            <assert test="exists($portionMatch)">
                The contents of the placeName element MUST a) match some portion of a placeName defined in the Prosopography file, and  b) hold the appropriate @xml:id for that place!
            </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="//persName/@ref">
            <let name="tokens" value="for $i in tokenize(., '\s+') return substring-after($i,'#')"/>
            <assert test="every $token in $tokens satisfies $token = $ProsopFile//listPerson//@xml:id">
                <!--<assert test="substring-after(., '#') = $siFile//tei:text//tei:listPerson//@xml:id | $siFile//tei:text//tei:listOrg//@xml:id">-->
                The @ref attribute value after the hashtag must match an appropriate xml:id on our site's Prosopography file.
            </assert> 
        </rule>
    </pattern>
    <pattern>
        <rule context="//persName"> 
            <let name="portions" value="for $i in tokenize(., '\s+') return $i"/>
            <let name="prosopName" value="for $pn in $ProsopFile//listPerson//persName[parent::person/@xml:id = substring-after(current()/@ref, '#')] return $pn"/>
            
            <let name="portionMatch" value="for $portion in $portions return $portion[contains($prosopName, $portion)]"/>
            <assert test="exists($portionMatch)">
                The contents of the persName element MUST a) match some portion of a persName defined in the Prosopography file, and  b) hold the appropriate @xml:id for that person!
            </assert>
        </rule>
       
    </pattern>
    
    
    
</schema>