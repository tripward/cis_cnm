<!---
################################################################################
#
# Filename:		QRY_GetMaxClientID.cfm
#
# Description:	Get max CLientID from the database
#
################################################################################
--->

<!--- CHeck for required variables --->


<!--- Query database --->
<cfquery name="GetMaxClientID" datasource="#stSiteDetails.DataSource#">
	SELECT
		Max([Client ##]) AS MaxID
	FROM
		Clients
</cfquery>


<cfset variables.MaxClientID = GetMaxClientID.MaxID>


