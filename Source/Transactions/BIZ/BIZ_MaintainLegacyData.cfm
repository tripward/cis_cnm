<!---
################################################################################
#
# Filename:		BIZ_MaintainLegacyData.cfm
#
# Description:	Inserts/Updates records in the legacy tables
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="FORM.ClientID" TYPE="Numeric">
<CFPARAM NAME="FORM.TransactionCodeID" TYPE="Numeric">


<!--- Check if client exists in legacy tables --->
<CFSET VARIABLES.ClientID = FORM.ClientID>
<CFINCLUDE TEMPLATE="..\QRY\QRY_GetClientData.cfm">


<!--- Get state --->
<CFSET VARIABLES.StateID = FORM.StateID>
<CFINCLUDE TEMPLATE="..\QRY\QRY_GetState.cfm">


<!--- Build insurance company lookup structure --->
<CFINCLUDE TEMPLATE="../QRY/QRY_GetInsuranceCompanies.cfm">
<CFSET VARIABLES.insuranceCompanyLoopkup = StructNew()>
<CFLOOP QUERY="GetInsuranceCompanies">
	<cfif GetInsuranceCompanies.ShowInd EQ 1>
		<CFSET VARIABLES.insuranceCompanyLoopkup[InsuranceCompanyID] = GetInsuranceCompanies.InsuranceCompany>
	</cfif>
</CFLOOP>


<!--- Prepare transformations --->
<CFSET VARIABLES.InsuranceCompany = VARIABLES.insuranceCompanyLoopkup[FORM.InsuranceCompanyID]>
<CFSET VARIABLES.State = GetState.Abbreviation>
<CFSET VARIABLES.Commission = FORM.GrossPremium * 0.175>
<CFSET VARIABLES.Limits = FORM.LimitAmountPerClaim & " / " & FORM.LimitAmountAggregate>


<!--- Check if inserting or updating data --->
<CFIF (GetClientData.RecordCount EQ 0) AND (FORM.TransactionCodeID EQ 1)>
	<!--- Insert new records --->
	<CFSET VARIABLES.NewOrRenewal = "N">
	<CFSET VARIABLES.FirstPolicyDate = FORM.PolicyEffectiveDate>
	<CFINCLUDE TEMPLATE="..\QRY\QRY_AddLegacyClient.cfm">
	<CFINCLUDE TEMPLATE="..\QRY\QRY_AddLegacyPolicy.cfm">
<CFELSEIF (GetClientData.RecordCount NEQ 0) AND (FORM.TransactionCodeID NEQ 1) AND (FORM.TransactionCodeID NEQ 6)>
	<!--- Update client data --->
	<CFIF FORM.TransactionCodeID EQ 2>
		<CFSET VARIABLES.NewOrRenewal = "R">
	<CFELSEIF ListFind("7,8,9,10", FORM.TransactionCodeID) NEQ 0>
		<CFSET VARIABLES.NewOrRenewal = "C">
		<CFSET VARIABLES.CancelDate = FORM.PolicyExpirationDate>
	</CFIF>
	<CFINCLUDE TEMPLATE="..\QRY\QRY_EditLegacyClient.cfm">
	<CFINCLUDE TEMPLATE="..\QRY\QRY_EditLegacyPolicy.cfm">
<CFELSEIF (GetClientData.RecordCount NEQ 0) AND (FORM.TransactionCodeID EQ 6)>
	<!--- Endorsement: only update limits --->
	<CFINCLUDE TEMPLATE="..\QRY\QRY_EditLegacyPolicyLimits.cfm">
</CFIF>

