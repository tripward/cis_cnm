<!---
################################################################################
#
# Filename:		QRY_GetClientsByName.cfm
#
# Description:	Retrieves a list of matching clients by LastName from the database
#
################################################################################
--->

<!--- Require VARIABLES.ClientID --->
<CFPARAM NAME="VARIABLES.LastName" TYPE="String">


<!--- Query database for client record --->
<CFQUERY NAME="GetClientsByName" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		[Client ##] AS ClientID,
		[Last Name] AS LastName,
		[First Name] AS FirstName
	FROM
		Clients
	WHERE
		[Last Name] LIKE <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="%#Variables.LastName#%">
	ORDER BY
		[Last Name],
		[First Name]
</CFQUERY>

