<!---
################################################################################
#
# Filename:		QRY_GetExport.cfm
#
# Description:	Retrieves specified export from the database
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="VARIABLES.ExportID" TYPE="Numeric">


<!--- Query database for exports --->
<CFQUERY NAME="GetExport" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		aig2_Export.ExportID,
		aig2_Export.ExportDateTime,
		aig2_Export.NumTransactions,
		aig2_Export.ExportTypeID,
		aig2_xExportType.ExportType,
		aig2_Export.Content
	FROM
		aig2_Export INNER JOIN aig2_xExportType
		ON aig2_Export.ExportTypeID = aig2_xExportType.ExportTypeID
	WHERE
		ExportID = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.ExportID#">
</CFQUERY>

