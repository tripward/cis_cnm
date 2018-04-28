<!---
################################################################################
#
# Filename:		exportSendToAIGAction.cfm
#
# Description:	Export Preview Action page
#
################################################################################
--->

<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.BuildExport" TYPE="String">
<CFPARAM NAME="FORM.TotalPremium" TYPE="Numeric">


<!--- Get Title Lookup data --->
<CFSET VARIABLES.ExportTypeID = FORM.ExportTypeID>
<CFINCLUDE TEMPLATE="QRY/QRY_GetExportType.cfm">

<CFSET VARIABLES.TransactionCodeID = FORM.TransactionCodeID>
<CFINCLUDE TEMPLATE="QRY/QRY_GetTransactionCodes.cfm">


<!--- Determine transaction types --->
<CFSET VARIABLES.Codes = "">

<CFLOOP FROM="1" TO="#GetTransactionCodes.RecordCount#" INDEX="cnt">
	<CFSET VARIABLES.Codes = VARIABLES.Codes & GetToken(GetTransactionCodes.Transaction[cnt], 1, ",")>

	<CFIF cnt NEQ GetTransactionCodes.RecordCount>
		<CFSET VARIABLES.Codes = VARIABLES.Codes & ", ">
	</CFIF>
</CFLOOP>



<!--- Save export as file --->
<CFIF CompareNoCase(GetExportType.ExportType, "Accounts Current") EQ 0>
	<CFSET VARIABLES.FileName = "ac_CNM_" & DateFormat(Now(), "yyyymmdd") & ".txt">
<CFELSE>
	<CFSET VARIABLES.FileName = "pr_CNM_" & DateFormat(Now(), "yyyymmdd") & ".txt">
</CFIF>
<CFFILE ACTION="Write" FILE="#stSystemConstants.exportAttachmentFileName##VARIABLES.FileName#" OUTPUT="#FORM.BuildExport#" ADDNEWLINE="No">


<!--- Set Title --->
<CFIF CompareNoCase(GetExportType.ExportType, "Accounts Current") EQ 0>
	<CFSET VARIABLES.Title = "CNM account " & DateFormat(Now(), "yyyymmdd")>
<CFELSE>
	<CFSET VARIABLES.Title = "CNM premium " & DateFormat(Now(), "yyyymmdd")>
</CFIF>


<!--- Update database --->
<CFTRANSACTION>
	<!--- Transfer FORM variables to local scope --->
	<CFIF FORM.RangeInd EQ 1>
		<CFSET VARIABLES.RangeStartDate = FORM.RangeStartDate>
		<CFSET VARIABLES.RangeEndDate = FORM.RangeEndDate>
	</CFIF>
	<CFSET VARIABLES.TransactionCodeID = FORM.TransactionCodeID>
	<CFSET VARIABLES.ExportTypeID = FORM.ExportTypeID>
	<CFSET VARIABLES.PositiveOnlyInd = FORM.PositiveOnlyInd>

	<!--- Get Transactions --->
	<CFINCLUDE TEMPLATE="QRY/QRY_GetTransactions.cfm">

	<!--- Set ExportDateTime for exported transactions --->
	<CFINCLUDE TEMPLATE="QRY/QRY_UpdateTransactionExportDates.cfm">

	<!--- Archive export --->
	<CFSET VARIABLES.BuildExport = FORM.BuildExport>
	<CFSET VARIABLES.NumTransactions = GetTransactions.RecordCount>
	<CFINCLUDE TEMPLATE="QRY/QRY_AddExport.cfm">

	<!--- Asociate transactions with export --->
	<CFLOOP QUERY="GetTransactions">
		<CFSET VARIABLES.TransactionID = GetTransactions.TransactionID>
		<CFSET VARIABLES.ExportID = AddExport.ThisID>
		<CFINCLUDE TEMPLATE="QRY/QRY_AddTransactionExport.cfm">
	</CFLOOP>
</CFTRANSACTION>


<!--- Send Export --->
<CFMAIL FROM="#stSystemConstants.exportFromAddress#" TO="#stSystemConstants.exportToAddress#" CC="#stSystemConstants.exportCcAddress#" SUBJECT="#VARIABLES.Title#">
<CFMAILPARAM FILE="#stSystemConstants.exportAttachmentFileName##VARIABLES.FileName#" TYPE="plain/text">
Our #MonthAsString(Month((Now())))# submission for #UCase(VARIABLES.Codes)# Business is attached.

Total Premium: #DollarFormat(FORM.TotalPremium)#

Tito Espina
Contemporary Insurance Services
301-933-3373 or 800-658-8943
fax: 301-933-3651
</CFMAIL>


<!--- Redirect to Success screen --->
<CFLOCATION URL="exportConfirmed.cfm" ADDTOKEN="No">
