<!---
################################################################################
#
# Filename:		QRY_GetInsuranceCompany.cfm
#
# Description:	Retrieves specified InsuranceCompany record from the database
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="VARIABLES.InsuranceCompanyID" TYPE="Numeric">


<!--- Query database for data --->
<CFQUERY NAME="GetInsuranceCompany" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		InsuranceCompanyID,
		InsuranceCompany
	FROM
		aig2_xInsuranceCompany
	WHERE
		InsuranceCompanyID = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#Variables.InsuranceCompanyID#">
</CFQUERY>

