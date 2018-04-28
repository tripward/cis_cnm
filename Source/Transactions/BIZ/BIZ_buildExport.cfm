<!---
################################################################################
#
# Filename:		BIZ_buildExport.cfm
#
# Description:	Builds an AIG export from the GetTransactions QRS
#
################################################################################
--->

<!--- Initialize variables --->
<CFSET VARIABLES.BuildExport = "">
		
<!--- Determine export type --->
<CFINCLUDE TEMPLATE="../QRY/QRY_GetExportType.cfm">

<!--- Query database --->

<!--- Determine Export Date --->
<CFIF IsDefined("VARIABLES.RangeEndDate") AND IsDate(VARIABLES.RangeEndDate)>
	<CFSET VARIABLES.ExportDate = "#Month(VARIABLES.RangeEndDate)#/#DaysInMonth(VARIABLES.RangeEndDate)#/#Year(VARIABLES.RangeEndDate)#">
<CFELSE>
	<CFSET VARIABLES.ExportDate = "#Month(Now())#/#DaysInMonth(Now())#/#Year(Now())#">
</CFIF>

<!--- Determine type of export to build --->
<CFSET VARIABLES.t_TransactionCodeID = VARIABLES.TransactionCodeID>
<CFSWITCH EXPRESSION="#GetExportType.ExportType#">
	<CFCASE VALUE="Premium Coding">
		<!--- Query database --->
		<CFINCLUDE TEMPLATE="../QRY/QRY_GetTransactions.cfm">
		<CFINCLUDE TEMPLATE="BIZ_buildPremiumCodingExport.cfm">
		<CFSET VARIABLES.TotalPremium = totalGrossPremium>
	</CFCASE>

	<CFCASE VALUE="Accounts Current">
		<!--- Query database --->
		<CFINCLUDE TEMPLATE="../QRY/QRY_GetTransactions.cfm">
		<CFINCLUDE TEMPLATE="BIZ_buildAccountsCurrentExport.cfm">
		<CFSET VARIABLES.TotalPremium = grandTotalGrossPremium>
	</CFCASE>
	
	<CFCASE VALUE="Non Cover All Data">
		<CFINCLUDE TEMPLATE="../QRY/QRY_GetTransactions_nonCoverAll.cfm">
		<!---<cfdump var="#GetTransactions#" label="cgi" abort="true" top="100" />--->
		<CFINCLUDE TEMPLATE="BIZ_buildNonCoverAllExport.cfm">
		
		<!---<cfdump var="#VARIABLES.BuildExport#" label="cgi" abort="true" top="100" />--->
		<!---<CFSET VARIABLES.TotalPremium = grandTotalGrossPremium>--->
	</CFCASE>
</CFSWITCH>
<CFSET VARIABLES.TransactionCodeID = VARIABLES.t_TransactionCodeID>
