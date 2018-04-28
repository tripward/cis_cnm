<!---
################################################################################
#
# Filename:		archivedExportsAction.cfm
#
# Description:	Archived Exports Action page
#
################################################################################
--->

<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.ExportID" DEFAULT="-1">
<CFPARAM NAME="FORM.ActionInd" DEFAULT="-1">


<!--- Validate submitted data --->
<CFINCLUDE TEMPLATE="ERR/ERR_archivedExportsAction.cfm">


<!--- Display page or redirect user to new page --->
<CFIF cntErrors NEQ 0>
	<!--- Redisplay export form --->
	<CFINCLUDE TEMPLATE="archivedExports.cfm">
<CFELSE>
	<!--- Set FORM variables to local scope and get export data --->
	<CFSET VARIABLES.ExportID = FORM.ExportID>
	<CFINCLUDE TEMPLATE="QRY/QRY_GetExport.cfm">
	<CFSET VARIABLES.ExportTypeID = GetExport.ExportTypeID>

	<!--- Determine output mode and/or next step --->
	<CFSWITCH EXPRESSION="#FORM.ActionInd#">
		<!--- Download as text --->
		<CFCASE VALUE="1">
			<CFSET VARIABLES.BuildExport = GetExport.Content>
			<CFINCLUDE TEMPLATE="exportDownloadToText.cfm">
		</CFCASE>

		<!--- Download as Excel --->
		<CFCASE VALUE="2">
			<!--- Parse raw export --->
			<CFSET VARIABLES.RawExport = GetExport.Content>
			<CFSET VARIABLES.NumTransactions = GetExport.NumTransactions>

			<!--- Determine type of export and send to appropriate parser --->
			<CFIF CompareNoCase(GetExport.ExportType, "Accounts Current") EQ 0>
				<CFINCLUDE TEMPLATE="BIZ/BIZ_ParseAccountsCurrentExport.cfm">
				<CFSET columnList = "TransactionCode,PolicyNumber,InsuredName,TransactionEffectiveDate,GrossPremium,CompanyName">
				<CFINCLUDE TEMPLATE="exportDownloadToExcel.cfm">
			<CFELSEIF DateDiff("d", stSystemConstants.premiumCodingFormatSwitchDate, GetExport.ExportDateTime) GTE 0>
				<CFINCLUDE TEMPLATE="BIZ/BIZ_ParseNewPremiumCodingExport.cfm">
				<CFSET columnList = "TransactionCode,PolicyNumber,InsuredName,TransactionEffectiveDate,GrossPremium,CompanyName">
				<CFINCLUDE TEMPLATE="exportDownloadToExcel.cfm">
			<CFELSE>
				<CFINCLUDE TEMPLATE="BIZ/BIZ_ParsePremiumCodingExport.cfm">
				<CFSET columnList = "TransactionCode,PolicyNumber,InsuredName,TransactionEffectiveDate,GrossPremium">
				<CFINCLUDE TEMPLATE="exportDownloadToExcel.cfm">
			</CFIF>
		</CFCASE>

		<!--- Backout export --->
		<CFCASE VALUE="3">
			<!--- Display confirmation dialog --->
			<CFSET VARIABLES.ExportID = FORM.ExportID>
			<CFINCLUDE TEMPLATE="archivedExportsBackout.cfm">
		</CFCASE>
	</CFSWITCH>
</CFIF>

