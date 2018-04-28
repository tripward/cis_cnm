<!---
################################################################################
#
# Filename:		QRY_GetExportsByDateRange.cfm
#
# Description:	Retrieves export done between specified dates from the database
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="VARIABLES.ExportTypeID" TYPE="Numeric" DEFAULT="0">
<CFPARAM NAME="VARIABLES.StartDate" TYPE="Date">
<CFPARAM NAME="VARIABLES.EndDate" TYPE="Date">


<!--- Query database for exports --->
<CFQUERY NAME="GetExportsByDateRange" DATASOURCE="#stSiteDetails.DataSource#">
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
		ExportDateTime  >= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#VARIABLES.StartDate#">
		AND ExportDateTime  <= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#VARIABLES.EndDate#">
		<CFIF VARIABLES.ExportTypeID NEQ 0>
			AND aig2_Export.ExportTypeID = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.ExportTypeID#">
		</CFIF>
</CFQUERY>

