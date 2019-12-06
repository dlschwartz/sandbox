<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <sch:pattern>
        
        
        <sch:rule context="tei:teiHeader//tei:p">
            <sch:report test="tei:note">
                A &lt;p&gt; element in the &lt;teiHeader&gt; may not 
                contain a &lt;note&gt; element.
            </sch:report>
        </sch:rule>
        
        <sch:rule context="tei:body/tei:note/@resp">
            <sch:assert test=". = '#dls' or . = '#ewb' or . = '#medComp'">
                Preferred values: #dls, #ewb, #medComp
            </sch:assert>
        </sch:rule>    
        
              
        
        <sch:rule context="tei:note/@resp">
            <sch:let name="editorIDs" value="//tei:teiHeader//tei:editor/@xml:id"/>
            <sch:let name="IDValues" value="for $i in $editorIDs return concat('#', $i)"/>
            <sch:assert test=". = $IDValues">
                Acceptable values: <sch:value-of select="string-join($IDValues, ', ')"/>.
            </sch:assert>
        </sch:rule>
        
        
        <sch:rule context="tei:body//tei:persName/@ref" role="warning">
            <sch:let name="indexDoc" value="doc('https://raw.githubusercontent.com/dlschwartz/sandbox/master/SeverusAntiochLettersIndex.xml')"/>
            <sch:let name="personIDs" value="$indexDoc//tei:listPerson/tei:person/@xml:id"/>
            <sch:let name="personRefValues" value="for $i in $personIDs return concat('#', $i)"/>
            <sch:assert test=". = $personRefValues">
                Acceptable values: <sch:value-of select="string-join($personRefValues, ', ')"/>
            </sch:assert>
        </sch:rule>
        
        
    </sch:pattern>
</sch:schema>