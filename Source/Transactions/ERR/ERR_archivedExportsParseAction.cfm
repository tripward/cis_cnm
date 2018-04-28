<!---
################################################################################
#
# Filename:		ERR_archivedExportsParseAction.cfm
#
# Description:	Archived Exports Parse Action validation
#
################################################################################
--->

<!--- Initialize Error variables --->
<CFSET arrErrors = ArrayNew(2)>
<CFSET cntErrors = 0>


<!--- Check that user selected an ExportID --->
<CFIF FORM.ExportID EQ -1>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ExportID">
	<CFSET arrErrors[2][cntErrors] = "Please select an export.">
</CFIF>

<!--- Check that user selected an TransactionLineNum --->
<CFIF FORM.TransactionLineNum EQ -1>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "TransactionLineNum">
	<CFSET arrErrors[2][cntErrors] = "Please select a Transaction.">
</CFIF>

