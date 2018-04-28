<!---
################################################################################
#
# Filename:		QRY_GetExportTransactions.cfm
#
# Description:	Gets transactions associated with specified export
#
################################################################################
--->

<!--- Check for required fields --->
<CFPARAM NAME="VARIABLES.ExportID" TYPE="Numeric">


<!--- Query database --->
<CFQUERY NAME="GetExportTransactions" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		TransactionID
	FROM
		aig2_TransactionExport
	WHERE
		ExportID = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.ExportID#">
</CFQUERY>

