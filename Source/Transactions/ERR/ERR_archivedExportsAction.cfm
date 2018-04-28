<!---
################################################################################
#
# Filename:		ERR_archivedExportsAction.cfm
#
# Description:	Archived Exports Action validation
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

<!--- Check that user selected an ActionInd --->
<CFIF FORM.ActionInd EQ -1>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ActionInd">
	<CFSET arrErrors[2][cntErrors] = "Please choose an Action.">
</CFIF>

