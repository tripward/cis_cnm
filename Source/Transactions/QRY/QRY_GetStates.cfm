<!---
################################################################################
#
# Filename:		QRY_GetStates.cfm
#
# Description:	Retrieves all States from the database
#
################################################################################
--->

<!--- Query database for states --->
<CFQUERY NAME="GetStates" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		StateID,
		Abbreviation,
		State
	FROM
		aig2_xState
	ORDER BY
		Abbreviation
</CFQUERY>

