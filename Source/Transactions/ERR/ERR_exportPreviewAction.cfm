<!---
################################################################################
#
# Filename:		ERR_exportPreviewAction.cfm
#
# Description:	Export Preview Action validation
#
################################################################################
--->

<!--- Initialize Error variables --->
<CFSET arrErrors = ArrayNew(2)>
<CFSET cntErrors = 0>


<!--- Check that BuildExport is not blank --->
<CFIF Len(Trim(FORM.BuildExport)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "BuildExport">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Export&quot; field may not be blank.">
</CFIF>


<!--- Check that user selected an ActionInd --->
<CFIF FORM.ActionInd EQ -1>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ActionInd">
	<CFSET arrErrors[2][cntErrors] = "Please choose an Action.">
</CFIF>

