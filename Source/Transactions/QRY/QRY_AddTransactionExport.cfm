<!---
################################################################################
#
# Filename:		QRY_AddTransactionExport.cfm
#
# Description:	Inserts an association between an Export and a Transaction into
#				the database
#
################################################################################
--->

<!--- Check for required fields --->
<CFPARAM NAME="VARIABLES.TransactionID" TYPE="Numeric">
<CFPARAM NAME="VARIABLES.ExportID" TYPE="Numeric">


<!--- Insert association into database --->
<CFQUERY NAME="AddTransactionExport" DATASOURCE="#stSiteDetails.DataSource#">
	INSERT INTO aig2_TransactionExport
	(
		TransactionID,
		ExportID
	)
	VALUES
	(
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.TransactionID#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.ExportID#">
	)
</CFQUERY>

