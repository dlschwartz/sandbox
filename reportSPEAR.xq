xquery version "3.1";
declare namespace xhtml = "http://www.w3.org/1999/xhtml";
declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace rpt = "http://www.oxygenxml.com/ns/report";

let $personIndex := fn:doc("https://raw.githubusercontent.com/srophe/syriaca/master/documentation/indexes/persons.xml")
let $personURIs := $personIndex/tei:listPerson/tei:person/@ref/fn:string()
let $placeIndex := fn:doc("https://raw.githubusercontent.com/srophe/syriaca/master/documentation/indexes/places.xml")
let $placeURIs := $placeIndex/tei:listPlace/tei:place/@ref/fn:string()
let $keywordIndex := fn:doc("https://raw.githubusercontent.com/srophe/syriaca/master/documentation/indexes/taxonomyIndex-old.xml")
let $keywordURIs := $keywordIndex/taxonomy//uri/fn:string()
let $descs := rpt:report/rpt:incident/rpt:description
let $descURIs := for $desc in $descs return fn:tokenize(fn:substring-before($desc, " is not currently in use."), " ")


for $personDescURI in $descURIs  
where fn:contains($personDescURI, "/keyword/")
order by $personDescURI
return $personDescURI