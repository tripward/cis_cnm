<!---
################################################################################
#
# Filename:		QRY_GetStateSurcharges.cfm
#
# Description:	Retrieves all state surcharges from the database
#
################################################################################
--->

<!--- Query database for state surcharges --->
<cfquery name="GetStateSurcharges" datasource="#stSiteDetails.DataSource#">
	SELECT
		StateID,
		SurchargeID,
		Surcharge
	FROM
		aig2_Surcharge
	WHERE
		(
			EffectiveDate IS NULL
			OR EffectiveDate <= <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), "mm/dd/yyyy")#">
		)
		AND
		(
			ExpirationDate IS NULL
			OR ExpirationDate >= <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), "mm/dd/yyyy")#">
		)
	ORDER BY
		SurchargeID
</cfquery>

