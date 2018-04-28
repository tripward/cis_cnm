<!---
################################################################################
#
# Filename:		QRY_EditLegacyPolicyLimits.cfm
#
# Description:	Edits a MALPRAC record
#
################################################################################
--->

<!--- Require VARIABLES.ClientID --->
<CFPARAM NAME="FORM.ClientID" TYPE="Numeric">
<CFPARAM NAME="VARIABLES.Limits" TYPE="String">


<!--- Update policy record --->
<CFQUERY NAME="EditLegacyPolicyLimits" DATASOURCE="#stSiteDetails.DataSource#">
	UPDATE
		MALPRAC
	SET
		[Coverage limits] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#VARIABLES.Limits#" MAXLENGTH="20">
	WHERE
		[Client ##] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.ClientID#">
</CFQUERY>

