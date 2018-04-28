<!---
################################################################################
#
# Filename:		QRY_GetInsuranceCompanies.cfm
#
# Description:	Retrieves all InsuranceCompanies from the database
#
################################################################################
--->

<!--- Query database for InsuranceCompanies --->
<CFQUERY NAME="GetInsuranceCompanies" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		InsuranceCompanyID,
		InsuranceCompany,
		ShowInd
	FROM
		aig2_xInsuranceCompany
	ORDER BY
		InsuranceCompanyID
</CFQUERY>

