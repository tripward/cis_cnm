<!---
################################################################################
#
# Filename:		archivedExportsParseAction.cfm
#
# Description:	View decoded transaction
#
################################################################################
--->

<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.ExportID" DEFAULT="-1">
<CFPARAM NAME="FORM.TransactionLineNum" DEFAULT="-1">


<!--- Validate submitted data --->
<CFINCLUDE TEMPLATE="ERR/ERR_archivedExportsParseAction.cfm">


<!--- Display page or redirect user to new page --->
<CFIF cntErrors NEQ 0>
	<!--- Redisplay archived exports form --->
	<CFINCLUDE TEMPLATE="archivedExportsParse.cfm">
<CFELSE>
	<!--- Display decoded transaction screen --->
	<CFINCLUDE TEMPLATE="archivedExportsDecodedTransaction.cfm">
</CFIF>

