<!---
################################################################################
#
# Filename:		QRY_GetTransactionSurcharges.cfm
#
# Description:	Retrieves surcharges associated with the specified transaction
#				from the database.
#
################################################################################
--->

<!--- Check for required variables --->
<cfparam name="variables.TransactionID" type="numeric">


<!--- Query database for surcharges --->
<cfquery name="GetTransactionSurcharges" datasource="#stSiteDetails.DataSource#">
	SELECT
		aig2_TransactionSurcharge.TransactionID,
		aig2_TransactionSurcharge.SurchargeID,
		aig2_Surcharge.AssessmentCode,
		aig2_Surcharge.Surcharge,
		aig2_TransactionSurcharge.SurchargeAmount
	FROM
		aig2_Surcharge
		INNER JOIN aig2_TransactionSurcharge
			ON aig2_Surcharge.SurchargeID = aig2_TransactionSurcharge.SurchargeID
	WHERE
		TransactionID = <cfqueryparam cfsqltype="cf_sql_integer" value="#variables.TransactionID#">
	ORDER BY
		aig2_TransactionSurcharge.SurchargeID ASC
</cfquery>

