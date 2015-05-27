xquery version "3.0";

(:~
 :  Template for querying project directories. 
 :)

declare namespace mods="http://www.loc.gov/mods/v3";
declare namespace marc="http://www.loc.gov/MARC21/slim";
declare namespace mets="http://www.loc.gov/METS/";

(: 
 : *******************
 : Fill these in... 
 : *******************
:)
(:declare variable $DIR as xs:string := 'file:///Users/me/svn/pudl0112';:)
declare variable $DIR as xs:string := '/home/me/Projects/svn/pudl0112';
declare variable $TYPE as xs:string := 'mods';

declare variable $FILE as document-node()* := collection(concat($DIR,'?select=*.',$TYPE,';recurse=yes;on-error=ignore'))/doc(document-uri(.));

<root>{
for $t in $FILE//*
return
(: example: catch empties :)
if ($t/not(node())) then 
<value>{$t}</value>
else()
}</root>