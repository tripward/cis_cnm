<!---
################################################################################
#
# Filename:		ERR_transactionHistoryAction.cfm
#
# Description:	Transaction History Action validation
#
################################################################################
--->

<!--- Initialize Error variables --->
<CFSET arrErrors = ArrayNew(2)>
<CFSET cntErrors = 0>


<!--- Check that user entered a ClientID --->
<CFIF Len(Trim(FORM.ClientID)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ClientID">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Client ID&quot; field is required.">
<!--- Check that ClientID is numeric and an integer --->
<CFELSEIF (NOT IsNumeric(FORM.ClientID)) OR (FORM.ClientID NEQ Int(FORM.ClientID))>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ClientID">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Client ID&quot; field must be a valid integer.">
</CFIF>


