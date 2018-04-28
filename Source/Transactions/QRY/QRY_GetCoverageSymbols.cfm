<!---
################################################################################
#
# Filename:		QRY_GetCoverageSymbols.cfm
#
# Description:	Retrieves all Coverage Symbols from the database
#
################################################################################
--->

<!--- Query database for Coverage Symbols --->
<CFQUERY NAME="GetCoverageSymbols" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		CoverageSymbol,
		PUC,
		Coverage
	FROM
		aig2_xCoverageSymbol
	ORDER BY
		Coverage
</CFQUERY>

