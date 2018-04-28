<!---
################################################################################
#
# Filename:		QRY_EditLegacyClient.cfm
#
# Description:	Updates a client record
#
################################################################################
--->

<!--- Require VARIABLES.ClientID --->
<CFPARAM NAME="FORM.ClientID" TYPE="Numeric">
<CFPARAM NAME="FORM.LastName" TYPE="String">
<CFPARAM NAME="FORM.FirstName" TYPE="String">
<CFPARAM NAME="FORM.MiddleInitial" TYPE="String">
<CFPARAM NAME="FORM.BusinessName" TYPE="String">
<CFPARAM NAME="FORM.Address" TYPE="String">
<CFPARAM NAME="FORM.City" TYPE="String">
<CFPARAM NAME="VARIABLES.State" TYPE="String">
<CFPARAM NAME="FORM.ZipCode" TYPE="String">


<!--- Update client record --->
<CFQUERY NAME="EditLegacyClient" DATASOURCE="#stSiteDetails.DataSource#">
	UPDATE
		CLIENTS
	SET
		[Last Name] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.LastName#" MAXLENGTH="255">,
		[First Name] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.FirstName#" MAXLENGTH="255">,
		MI = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.MiddleInitial#" MAXLENGTH="255" NULL="#IIf(Len(Trim(FORM.MiddleInitial)) EQ 0, DE("Yes"), DE("No"))#">,
		[Business Name] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.BusinessName#" MAXLENGTH="255" NULL="#IIf(Len(Trim(FORM.BusinessName)) EQ 0, DE("Yes"), DE("No"))#">,
		[Address Business] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.Address#" MAXLENGTH="35">,
		[City##1] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.City#" MAXLENGTH="18">,
		[State##1] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#VARIABLES.State#" MAXLENGTH="15">,
		[Zip##1] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.ZipCode#" MAXLENGTH="5">
	WHERE
		[Client ##] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.ClientID#">
</CFQUERY>

