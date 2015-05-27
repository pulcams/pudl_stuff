<?xml version="1.0" encoding="UTF-8"?>
<!--+
    | This stylesheet inserts physical and logical structmaps based on the 'default' structmap,
    | as generated by the pudl Object METS script (run-objects.sh).
    |  
    | Supply $PUDLNO, $COLLECTION and $OUT-PATH below. Can use make-collection.xq to generate collection file
    +-->
<xsl:stylesheet
   xsi:schemaLocation="http://www.loc.gov/METS/ http://www.loc.gov/standards/mets/mets.xsd info:lc/xmlns/premis-v2    http://www.loc.gov/standards/premis/premis.xsd"
   xmlns="http://www.loc.gov/METS/" xmlns:mets="http://www.loc.gov/METS/"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink"
   exclude-result-prefixes="xs mets" version="3.0">
   <xsl:strip-space elements="*"/>
   <xsl:output encoding="UTF-8" omit-xml-declaration="no" indent="yes" method="xml"/>
   <!--+
       | ********************************************
       | Variables. Fill these in before each run...
       | ********************************************
       +-->
   <xsl:variable name="PUDLNO" as="xs:integer" select="112"/>
   <xsl:variable name="COLLECTION" as="xs:string" select="'collection.xml'"/>
   <xsl:variable name="OUT-PATH" as="xs:string"
      select="'/home/me/Projects/svn/pudl0112/work/mets/'"/>
   <!--+
       | Loop through directory with METS; initial template needs to be set to 'root' in oXygen scenario 
       | (click the little gear icon next to Transformer)
       +-->
   <xsl:template match="/" as="node()*" name="root">
      <xsl:for-each select="collection($COLLECTION)">
         <xsl:variable name="file_id" select="tokenize(document-uri(.),'/')[last()]"/>
         <xsl:result-document href="{concat($OUT-PATH, $file_id)}"
            exclude-result-prefixes="xs xlink">
            <xsl:apply-templates/>
         </xsl:result-document>
      </xsl:for-each>
   </xsl:template>
   <!--+
       | Add physical and logical structmaps
       +-->
   <xsl:template match="mets:structMap[@ID='default']">
      <xsl:variable name="lastdiv"
         select="replace(tokenize((./ancestor::mets:mets//mets:structMap[@ID='default']//mets:div)[last()]/mets:mptr/@xlink:href,'/')[last()],'.mets','')"/>
      <xsl:variable name="file_id" select="tokenize(document-uri(.),'/')[last()]"/>
      <xsl:copy copy-namespaces="no">
         <xsl:apply-templates select="@*,node()"/>
      </xsl:copy>
      <mets:structMap TYPE="Physical" LABEL="Foliation">
         <mets:div TYPE="TightBoundManuscript" LABEL="" DMDID="object.dmd"> </mets:div>
      </mets:structMap>
      <mets:structMap TYPE="Logical" LABEL="Contents">
         <mets:div LABEL="" DMDID="object.dmd" TYPE="Work">
            <xsl:for-each select="1 to xs:integer($lastdiv)">
               <xsl:variable name="xlinkhref"
                  select="concat('http://diglib.princeton.edu/images/pudl',format-number($PUDLNO,'0000'),'/',$file_id,format-number(position(),'00000000'),'.mets')"/>
               <mets:div TYPE="LogicalMember" ORDER="{position()}">
                  <mets:mptr LOCTYPE="URL" xlink:href="{$xlinkhref}"/>
               </mets:div>
            </xsl:for-each>
         </mets:div>
      </mets:structMap>
   </xsl:template>
   <!--+
       | Change the initial image
       +-->
<!--   <xsl:template match="mets:fileSec//mets:FLocat/@xlink:href">
      <!-\- image 1-3 are usually calibration so skipping to image 4 -\->
      <xsl:attribute name="xlink:href">
         <xsl:value-of select="replace(.,'/00000001\.','/00000004.')" />
      </xsl:attribute>
   </xsl:template>-->
   <!--+
       | Copy the everything else
       +-->
   <xsl:template match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
</xsl:stylesheet>