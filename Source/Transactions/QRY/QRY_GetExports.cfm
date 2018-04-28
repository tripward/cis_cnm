<!---
################################################################################
#
# Filename:		QRY_GetExports.cfm
#
# Description:	Retrieves all archived exports from the database
#
################################################################################
--->

<!--- Query database for exports --->
<CFQUERY NAME="GetExports" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		ExportID,
		BackoutID,
		BackoutInd,
		ExportDateTime,
		NumTransactions,
		aig2_Export.ExportTypeID,
		aig2_xExportType.ExportType,
		aig2_Export.Content
	FROM
		aig2_Export INNER JOIN aig2_xExportType
		ON aig2_Export.ExportTypeID = aig2_xExportType.ExportTypeID
	ORDER BY
		ExportDateTime
</CFQUERY>

