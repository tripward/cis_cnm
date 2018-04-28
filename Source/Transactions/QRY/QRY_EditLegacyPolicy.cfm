<!---
################################################################################
#
# Filename:		QRY_AddLegacyPolicy.cfm
#
# Description:	Inserts a new MALPRAC record
#
################################################################################
--->

<!--- Require VARIABLES.ClientID --->
<CFPARAM NAME="FORM.ClientID" TYPE="Numeric">
<CFPARAM NAME="VARIABLES.NewOrRenewal" TYPE="String">
<CFPARAM NAME="FORM.LastName" TYPE="String">
<CFPARAM NAME="FORM.FirstName" TYPE="String">
<CFPARAM NAME="VARIABLES.InsuranceCompany" TYPE="String">
<CFPARAM NAME="FORM.PolicyNumber" TYPE="Numeric">
<CFPARAM NAME="FORM.PolicyEffectiveDate" TYPE="Date">
<CFPARAM NAME="VARIABLES.CancelDate" DEFAULT="">
<CFPARAM NAME="VARIABLES.Limits" TYPE="String">
<CFPARAM NAME="FORM.GrossPremium" TYPE="Numeric">
<CFPARAM NAME="VARIABLES.Commission" TYPE="Numeric">


<!--- Update policy record --->
<CFQUERY NAME="EditLegacyPolicy" DATASOURCE="#stSiteDetails.DataSource#">
	UPDATE
		MALPRAC
	SET
		[New or Renewal] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#VARIABLES.NewOrRenewal#" MAXLENGTH="1">,
		[Last Name] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.LastName#" MAXLENGTH="255">,
		[First Name] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.FirstName#" MAXLENGTH="255">,
		[Company name] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#VARIABLES.InsuranceCompany#" MAXLENGTH="50">,
		[Pol## number] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.PolicyNumber#" MAXLENGTH="20">,
		[Effective Date] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#FORM.PolicyEffectiveDate#">,
		[Cancel Date] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#VARIABLES.CancelDate#" NULL="#IIf(Len(Trim(VARIABLES.CancelDate)) EQ 0, DE("Yes"), DE("No"))#">,
		[Coverage limits] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#VARIABLES.Limits#" MAXLENGTH="20">,
		[Current Premium] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#FORM.GrossPremium#">,
		[Commission] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#VARIABLES.Commission#">
	WHERE
		[Client ##] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.ClientID#">
</CFQUERY>

