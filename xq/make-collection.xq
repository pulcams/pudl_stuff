xquery version "3.0";

(:~
 : Generates a Saxon collection catalog of files in the folder defined in $COLLECTION
 : Adjust condition as needed.
 :)

declare namespace mets="http://www.loc.gov/METS/";
declare namespace mods="http://www.loc.gov/mods/v3";

declare variable $COLLECTION as document-node()* := collection("/home/me/Projects/svn/pudl0112/?select=*.mets;recurse=no;on-error=ignore")/doc(document-uri(.));

<collection>{
for $mets in $COLLECTION
let $uri := $mets/document-uri(.)
return
if (not($mets//mets:structMap[@TYPE="Logical"])) then (
<doc href="{replace($uri,'file:','')}" />
) else()
}</collection>