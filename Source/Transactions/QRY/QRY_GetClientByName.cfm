<!---
################################################################################
#
# Filename:		QRY_GetClientByName.cfm
#
# Description:	Retrieves client by Name from the database
#
################################################################################
--->

<!--- CHeck for required variables --->
<cfparam name="form.LastName" type="String">
<cfparam name="form.FirstName" type="String">
<cfparam name="form.MiddleName" type="String" default="">


<!--- Query database for client record --->
<cfquery name="GetClientByName" datasource="#stSiteDetails.DataSource#">
	SELECT
		[Client ##] AS ClientID,
		[Last Name] AS LastName,
		[First Name] AS FirstName
	FROM
		Clients
	WHERE
		[Last Name] LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%#form.LastName#%">
		AND [Last Name] NOT LIKE <cfqueryparam cfsqltype="cf_sql_varchar" value="%(ARCHIVED)%">
		AND [First Name] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.FirstName#">
		<cfif Len(Trim(form.MiddleName)) NEQ 0>
			AND [MI] = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.MiddleName#">
		</cfif>
</cfquery>
