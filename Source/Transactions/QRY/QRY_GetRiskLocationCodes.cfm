<!---
################################################################################
#
# Filename:		QRY_GetRiskLocationCodes.cfm
#
# Description:	Retrieves all risk location codes from the database
#
################################################################################
--->

<!--- Check for optional variables --->
<CFPARAM NAME="FORM.StateID" DEFAULT="0" TYPE="Numeric">


<!--- Query database for codes --->
<CFQUERY NAME="GetRiskLocationCodes" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		State,
		StateID,
		Abbreviation,
		City,
		County,
		Code
	FROM
		aig2_RiskLocationCode
	WHERE
		0 = 0
		<CFIF FORM.StateID NEQ 0>
			AND StateID = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.StateID#">
		</CFIF>
	ORDER BY
		StateID, County, City
</CFQUERY>

