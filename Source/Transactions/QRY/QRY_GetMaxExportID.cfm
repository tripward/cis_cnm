<!---
################################################################################
#
# Filename:		QRY_GetMaxExportID.cfm
#
# Description:	Retrieves most recent ExportID from the database
#
################################################################################
--->

<!--- Query database --->
<CFQUERY NAME="GetMaxExportID" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		Max(ExportID) AS MaxID
	FROM
		aig2_Export
</CFQUERY>


<CFSET VARIABLES.MaxExportID = GetMaxExportID.MaxID>

