<!---
################################################################################
#
# Filename:		QRY_GetExportTypes.cfm
#
# Description:	Retrieves all ExportTypes from the database
#
################################################################################
--->

<!--- Query database for ExportTypes --->
<CFQUERY NAME="GetExportTypes" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		ExportTypeID,
		ExportType
	FROM
		aig2_xExportType
	ORDER BY
		ExportType
</CFQUERY>

