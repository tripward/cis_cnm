<!---
################################################################################
#
# Filename:		QRY_BackoutExport.cfm
#
# Description:	Backs out specified Export
#
################################################################################
--->

<!--- Check for required fields --->
<CFPARAM NAME="VARIABLES.BackoutExportID" TYPE="Numeric">
<CFPARAM NAME="VARIABLES.ExportID" TYPE="Numeric">


<!--- Update database --->
<CFQUERY NAME="BackoutExport" DATASOURCE="#stSiteDetails.DataSource#">
	UPDATE
		aig2_Export
	SET
		BackoutID = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.BackoutExportID#">
	WHERE
		ExportID = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.ExportID#">
</CFQUERY>

