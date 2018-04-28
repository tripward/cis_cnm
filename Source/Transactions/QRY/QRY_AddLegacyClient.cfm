<!---
################################################################################
#
# Filename:		QRY_AddLegacyClient.cfm
#
# Description:	Inserts a new client record
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


<!--- Insert client record --->
<CFQUERY NAME="AddLegacyClient" DATASOURCE="#stSiteDetails.DataSource#">
	INSERT INTO CLIENTS
	(
		[Client ##],
		[Last Name],
		[First Name],
		MI,
		[Business Name],
		[Address Business],
		[City##1],
		[State##1],
		[Zip##1]
	)
	VALUES
	(
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.ClientID#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.LastName#" MAXLENGTH="255">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.FirstName#" MAXLENGTH="255">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.MiddleInitial#" MAXLENGTH="255" NULL="#IIf(Len(Trim(FORM.MiddleInitial)) EQ 0, DE("Yes"), DE("No"))#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.BusinessName#" MAXLENGTH="255" NULL="#IIf(Len(Trim(FORM.BusinessName)) EQ 0, DE("Yes"), DE("No"))#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.Address#" MAXLENGTH="35">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.City#" MAXLENGTH="18">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#VARIABLES.State#" MAXLENGTH="15">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.ZipCode#" MAXLENGTH="5">
	)
</CFQUERY>

