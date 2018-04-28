<!--- Include configuration file --->
<!---<CFINCLUDE TEMPLATE="/#request.includeConfig#">--->

<cfset request.fileLocationPath = expandPath(getDirectoryFromPath(cgi.scRIPT_NAME)) />
<!---<cfdump var="#request.filePath#" label="cgi" abort="true" top="3" />--->

<cfset request.filePath = request.fileLocationPath & "stateTaxID.xls" />
<!---<cfdump var="#request.filePath#" label="cgi" abort="true" top="3" />--->


<cfspreadsheet action="read" src="#request.filePath#" query="request.StatidQry" columnnames="abbr,taxid,name" />
<!---<cfdump var="#request.StatidQry#" label="cgi" abort="true" top="3" />--->

<cfquery name="request.stateTableQry" DATASOURCE="#stSiteDetails.DataSource#">
		Select *
		FROM aig2_xState
</cfquery>
<!---<cfdump var="#request.stateTableQry#" label="cgi" abort="false" top="60" />--->

<cfloop query="request.StatidQry">
	
	<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
		UPDATE aig2_xState
		SET stateTaxID = '#request.StatidQry.taxid#'
		WHERE abbreviation = '#request.StatidQry.abbr#';
	</cfquery>
	
</cfloop>

<cfquery name="request.stateTableQry" DATASOURCE="#stSiteDetails.DataSource#">
		Select *
		FROM aig2_xState
</cfquery>
<!---<cfdump var="#request.stateTableQry#" label="cgi" abort="false" top="60" />--->