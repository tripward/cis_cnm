<!---
################################################################################
#
# Filename:		QRY_GetExportType.cfm
#
# Description:	Retrieves specified export type record from the database
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="VARIABLES.ExportTypeID" TYPE="Numeric">


<!--- Query database for client record --->
<CFQUERY NAME="GetExportType" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		ExportTypeID,
		ExportType
	FROM
		aig2_xExportType
	WHERE
		ExportTypeID = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#Variables.ExportTypeID#">
</CFQUERY>

