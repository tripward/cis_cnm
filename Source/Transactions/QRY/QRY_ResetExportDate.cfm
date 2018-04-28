<!---
################################################################################
#
# Filename:		QRY_ResetExportDate.cfm
#
# Description:	Resets export date of specified transactions
#
################################################################################
--->

<!--- Check for required fields --->
<CFPARAM NAME="VARIABLES.TransactionIDList" TYPE="String">
<CFPARAM NAME="VARIABLES.ExportType" TYPE="String">


<!--- Query database --->
<CFQUERY NAME="ResetExportDate" DATASOURCE="#stSiteDetails.DataSource#">
	UPDATE
		aig2_Transaction
	SET
		#VARIABLES.ExportType#ExportDateTime = NULL
	WHERE
		TransactionID IN (<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.TransactionIDList#" LIST="Yes">)
</CFQUERY>

