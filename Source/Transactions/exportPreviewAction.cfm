<!---
################################################################################
#
# Filename:		exportPreviewAction.cfm
#
# Description:	Export Preview Action page
#
################################################################################
--->

<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.BuildExport" DEFAULT="">
<CFPARAM NAME="FORM.ActionInd" DEFAULT="-1">
<CFPARAM NAME="FORM.PositiveOnlyInd" DEFAULT="0">


<!--- Validate submitted data --->
<CFINCLUDE TEMPLATE="ERR/ERR_exportPreviewAction.cfm">


<!--- Display page or redirect user to new page --->
<CFIF cntErrors NEQ 0>
	<!--- Redisplay export Preview form --->
	<CFINCLUDE TEMPLATE="exportPreview.cfm">
<CFELSE>
	<!--- Set FORM variables to local scope --->
	<CFSET VARIABLES.BuildExport = FORM.BuildExport>
	<CFSET VARIABLES.ExportTypeID = FORM.ExportTypeID>

	<!--- Determine output mode and/or next step --->
	<CFSWITCH EXPRESSION="#FORM.ActionInd#">
		<!--- Download as text --->
		<CFCASE VALUE="1">
			<CFSET VARIABLES.ExportTypeID = FORM.ExportTypeID>
			<CFINCLUDE TEMPLATE="exportDownloadToText.cfm">
		</CFCASE>

		<!--- Send to AIG --->
		<CFCASE VALUE="2">
			<!--- Display confirmation page --->
			<CFINCLUDE TEMPLATE="exportSendToAIG.cfm">
		</CFCASE>

		<!--- Download to Excel --->
		<CFCASE VALUE="3">
			<!--- Parse raw export --->
			<CFSET VARIABLES.RawExport = VARIABLES.BuildExport>

			<!--- Determine type of export and send to appropriate parser --->
			<CFIF FORM.ExportTypeID EQ 2>
				<CFSET VARIABLES.NumTransactions = ListLen(VARIABLES.RawExport, CrLf)>
				<CFINCLUDE TEMPLATE="BIZ/BIZ_ParseAccountsCurrentExport.cfm">
				<CFSET VARIABLES.NumTransactions = TransactionCount>
				<CFSET columnList = "TransactionCode,PolicyNumber,InsuredName,TransactionEffectiveDate,GrossPremium">
				<CFINCLUDE TEMPLATE="exportDownloadToExcel.cfm">
			<CFELSEIF FORM.ExportTypeID EQ 1>
				<CFSET VARIABLES.NumTransactions = (ListLen(VARIABLES.RawExport, CrLf) - 1) / 3>
				<CFINCLUDE TEMPLATE="BIZ/BIZ_ParseNewPremiumCodingExport.cfm">
				<CFSET VARIABLES.NumTransactions = TransactionCount>
				<CFSET columnList = "TransactionCode,PolicyNumber,InsuredName,TransactionEffectiveDate,GrossPremium">
				<CFINCLUDE TEMPLATE="exportDownloadToExcel.cfm">
			</CFIF>
		</CFCASE>
	</CFSWITCH>
</CFIF>

