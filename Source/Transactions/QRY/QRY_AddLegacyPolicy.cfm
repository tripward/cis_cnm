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
<CFPARAM NAME="VARIABLES.FirstPolicyDate" DEFAULT="">
<CFPARAM NAME="FORM.LastName" TYPE="String">
<CFPARAM NAME="FORM.FirstName" TYPE="String">
<CFPARAM NAME="VARIABLES.InsuranceCompany" TYPE="String">
<CFPARAM NAME="FORM.PolicyNumber" TYPE="Numeric">
<CFPARAM NAME="FORM.PolicyEffectiveDate" TYPE="Date">
<CFPARAM NAME="VARIABLES.CancelDate" DEFAULT="">
<CFPARAM NAME="VARIABLES.Limits" TYPE="String">
<CFPARAM NAME="FORM.GrossPremium" TYPE="Numeric">
<CFPARAM NAME="VARIABLES.Commission" TYPE="Numeric">


<!--- Insert policy record --->
<CFQUERY NAME="AddLegacyPolicy" DATASOURCE="#stSiteDetails.DataSource#">
	INSERT INTO MALPRAC
	(
		[Client ##],
		[New or Renewal],
		[First Policy Date],
		[Last Name],
		[First Name],
		[Company name],
		[Pol## number],
		[Effective Date],
		[Cancel Date],
		[Coverage limits],
		[Current Premium],
		[Commission]
	)
	VALUES
	(
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.ClientID#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#VARIABLES.NewOrRenewal#" MAXLENGTH="1">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#VARIABLES.FirstPolicyDate#" NULL="#IIf(Len(Trim(VARIABLES.FirstPolicyDate)) EQ 0, DE("Yes"), DE("No"))#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.LastName#" MAXLENGTH="255">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.FirstName#" MAXLENGTH="255">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#VARIABLES.InsuranceCompany#" MAXLENGTH="50">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.PolicyNumber#" MAXLENGTH="20">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#FORM.PolicyEffectiveDate#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#VARIABLES.CancelDate#" NULL="#IIf(Len(Trim(VARIABLES.CancelDate)) EQ 0, DE("Yes"), DE("No"))#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#VARIABLES.Limits#" MAXLENGTH="20">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#FORM.GrossPremium#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#VARIABLES.Commission#">
	)
</CFQUERY>

