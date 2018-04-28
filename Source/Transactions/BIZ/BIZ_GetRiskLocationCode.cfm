<!---
################################################################################
#
# Filename:		BIZ_GetRiskLocationCode.cfm
#
# Description:	Determines RickLocationCode based on state, city, and county
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="FORM.StateID" TYPE="Numeric">
<CFPARAM NAME="FORM.City" TYPE="String">
<CFPARAM NAME="FORM.CookCountyInd" TYPE="Numeric">


<!--- Query database for data --->
<CFINCLUDE TEMPLATE="../QRY/QRY_GetRiskLocationCodes.cfm">


<!--- Determine code --->
<CFIF GetRiskLocationCodes.RecordCount EQ 1>
	<!--- If only 1 record --->
	<CFSET FORM.RiskLocationCode = GetRiskLocationCodes.Code>
<CFELSE>
	<!--- Set to default/first value --->
	<CFSET FORM.RiskLocationCode = GetRiskLocationCodes.Code[1]>

	<!--- Iterate over results and compare city/county --->
	<CFLOOP QUERY="GetRiskLocationCodes">
		<CFIF CompareNoCase(FORM.City, GetRiskLocationCodes.City) EQ 0>
			<CFSET FORM.RiskLocationCode = GetRiskLocationCodes.Code>
		<CFELSEIF (FORM.CookCountyInd EQ 1) AND (CompareNoCase(GetRiskLocationCodes.County, "Cook County") EQ 0)>
			<CFSET FORM.RiskLocationCode = GetRiskLocationCodes.Code>
		</CFIF>
	</CFLOOP>
</CFIF>

