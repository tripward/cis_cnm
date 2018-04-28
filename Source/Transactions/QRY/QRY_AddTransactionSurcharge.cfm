<!---
################################################################################
#
# Filename:		QRY_AddTransactionSurcharge.cfm
#
# Description:	Inserts an association between a Surcharge and a Transaction into
#				the database
#
################################################################################
--->

<!--- Check for required fields --->
<cfparam name="variables.TransactionID" type="numeric">
<cfparam name="variables.SurchargeID" type="numeric">
<cfparam name="variables.SurchargeAmount" type="numeric">


<!--- Insert association into database --->
<cfquery name="AddTransactionSurcharge" datasource="#stSiteDetails.DataSource#">
	INSERT INTO aig2_TransactionSurcharge
	(
		TransactionID,
		SurchargeID,
		SurchargeAmount
	)
	VALUES
	(
		<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.TransactionID#">,
		<cfqueryparam cfsqltype="cf_sql_integer" value="#variables.SurchargeID#">,
		<cfqueryparam cfsqltype="cf_sql_float" value="#variables.SurchargeAmount#">
	)
</cfquery>

