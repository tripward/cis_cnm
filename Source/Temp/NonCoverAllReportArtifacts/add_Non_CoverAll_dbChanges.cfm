<!--- Include configuration file --->
<!---<CFINCLUDE TEMPLATE="/#request.includeConfig#">--->


<!---############## FIRST ADD ALL COLUMNS ################ --->


<!---addreport date export column--->
<cftry>
	<cfquery name="request.addNCADExportDateColumn" DATASOURCE="#stSiteDetails.DataSource#" maxrows="1">
		Select *
		FROM aig2_Transaction
		
	</cfquery>
	
	<cfif !listFindNoCase(request.addNCADExportDateColumn.columnList, "NonCoverAllExportDateTime")>
		<cfquery name="request.addNCADExportDateColumn" DATASOURCE="#stSiteDetails.DataSource#">
			ALTER TABLE aig2_Transaction
			ADD COLUMN NonCoverAllExportDateTime DateTime;
		</cfquery>
		<div class="">NonCoverAllExportDateTime added.</div>
	<cfelse>
		<div class="">NonCoverAllExportDateTime already exists, I just saved you from yourself.</div>
	</cfif>
	<cfcatch type="any" >
		<cfdump var="#cfcatch.detail#" label="cfcatch" abort="false"  />
	</cfcatch>
</cftry>


<!---add state taxid column  column--->
<cftry>
	<cfquery name="request.stateTableColumns" DATASOURCE="#stSiteDetails.DataSource#" maxrows="1">
		Select *
		FROM aig2_xState
		
	</cfquery>
	
	<cfif !listFindNoCase(request.stateTableColumns.columnList, "stateTaxID")>
		<cfquery name="request.addNCADExportDateColumn" DATASOURCE="#stSiteDetails.DataSource#">
			ALTER TABLE aig2_xState
			ADD COLUMN stateTaxID TEXT(2);
		</cfquery>
		<div class="">stateTaxID added.</div>
	<cfelse>
		<div class="">stateTaxID already exists, I just saved you from yourself.</div>
	</cfif>
	<cfcatch type="any" >
		<cfdump var="#cfcatch.detail#" label="cfcatch" abort="false"  />
	</cfcatch>
</cftry>

<!---############## END ADD ALL COLUMNS ################ --->


<!---############## Add DATA ################ --->

<!---add new export type--->
<cftry>
	<!--- Determine export type --->
	<CFINCLUDE TEMPLATE="/Transactions/QRY/QRY_GetExportTypes.cfm">
	<cfset request.idList = valueList(GetExportTypes.ExportTypeID) />
	<cfif !listFindNoCase(request.idList, 3)>
		<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
			INSERT INTO aig2_xExportType
			(ExportTypeID, ExportType)
			VALUES
			(3, 'Non Cover All Data');
			
		</cfquery>
		<div class="">Non Cover All export type added</div>
	<cfelse>
		<div class="">Non Cover All export type already exists, I just saved you from yourself.</div>
	</cfif>
	<cfcatch type="any" >
		<cfdump var="#cfcatch#" label="cfcatch" abort="true"  />
	</cfcatch>
</cftry>

<!---add taxids--->
<cfinclude template="CreateStateIDInsertQuery.cfm" >


