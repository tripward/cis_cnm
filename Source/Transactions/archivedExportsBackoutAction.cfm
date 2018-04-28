<!---
################################################################################
#
# Filename:		archivedExportsBackoutAction.cfm
#
# Description:	Backout specified export
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="FORM.ExportID" TYPE="Numeric">


<!--- Get export data --->
<CFSET VARIABLES.ExportID = FORM.ExportID>
<CFINCLUDE TEMPLATE="QRY/QRY_GetExport.cfm">


<!--- Build backout export --->
<CFSET VARIABLES.backoutExport = ReReplace(GetExport.Content, '-([0-9])', '%\1', "ALL")>
<CFSET VARIABLES.backoutExport = ReReplace(VARIABLES.backoutExport, '\+([0-9])', '-\1', "ALL")>
<CFSET VARIABLES.backoutExport = ReReplace(VARIABLES.backoutExport, '%([0-9])', '+\1', "ALL")>


<!--- Write export to file --->
<CFIF CompareNoCase(GetExport.ExportType, "Accounts Current") EQ 0>
	<CFSET VARIABLES.FileName = "ac_CNM_" & DateFormat(Now(), "yyyymmdd") & ".txt">
<CFELSE>
	<CFSET VARIABLES.FileName = "pr_CNM_" & DateFormat(Now(), "yyyymmdd") & ".txt">
</CFIF>
<CFFILE ACTION="Write" FILE="#stSystemConstants.exportAttachmentFileName##VARIABLES.FileName#" OUTPUT="#VARIABLES.backoutExport#">


<!--- Make changes to database --->
<CFTRANSACTION>
	<!--- Add new export to database --->
	<CFSET VARIABLES.BuildExport = VARIABLES.backoutExport>
	<CFSET VARIABLES.NumTransactions = GetExport.NumTransactions>
	<CFSET VARIABLES.ExportTypeID = GetExport.ExportTypeID>
	<CFSET VARIABLES.ExportType = GetExport.ExportType>
	<CFSET VARIABLES.BackoutID = 0>
	<CFSET VARIABLES.BackoutInd = 1>
	<CFINCLUDE TEMPLATE="QRY/QRY_AddExport.cfm">


	<!--- Get ExportID --->
	<CFINCLUDE TEMPLATE="QRY/QRY_GetMaxExportID.cfm">


	<!--- Update backed out export --->
	<CFSET VARIABLES.BackoutExportID = VARIABLES.MaxExportID>
	<CFINCLUDE TEMPLATE="QRY/QRY_BackoutExport.cfm">


	<!--- Clear previously marked transactions --->
	<CFINCLUDE TEMPLATE="QRY/QRY_GetExportTransactions.cfm">
	<CFSET VARIABLES.TransactionIDList = ValueList(GetExportTransactions.TransactionID)>
	<CFSET VARIABLES.ExportType = Replace(VARIABLES.ExportType, " ", "", "ALL")>
	<CFINCLUDE TEMPLATE="QRY/QRY_ResetExportDate.cfm">
</CFTRANSACTION>


<!--- Set email title --->
<CFIF CompareNoCase(GetExport.ExportType, "Accounts Current") EQ 0>
	<CFSET VARIABLES.Title = "CNM account " & DateFormat(Now(), "yyyymmdd")>
<CFELSE>
	<CFSET VARIABLES.Title = "CNM premium " & DateFormat(Now(), "yyyymmdd")>
</CFIF>


<!--- Send email to AIG --->
<CFMAIL FROM="#stSystemConstants.exportFromAddress#" TO="#stSystemConstants.exportToAddress#" CC="#stSystemConstants.exportCcAddress#" SUBJECT="#VARIABLES.Title#">
<CFMAILPARAM FILE="#stSystemConstants.exportAttachmentFileName##VARIABLES.FileName#" TYPE="plain/text">
The attached submission is submitted to "back out" a previous submission sent
on #DateFormat(GetExport.ExportDateTime, "mmmm d, yyyy")#.  The previous submission included some errors that will be
corrected in an upcoming submission.

Tito Espina
Contemporary Insurance Services
301-933-3373 or 800-658-8943
fax: 301-933-3651
</CFMAIL>


<!--- Redirect to archived exports screen --->
<CFLOCATION URL="archivedExports.cfm" ADDTOKEN="No">


