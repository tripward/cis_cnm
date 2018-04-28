<!---
################################################################################
#
# Filename:		dataEntryAction.cfm
#
# Description:	Data Entry Action page
#
################################################################################
--->

<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.ClientID" DEFAULT="">
<CFPARAM NAME="FORM.LastName" DEFAULT="">
<CFPARAM NAME="FORM.FirstName" DEFAULT="">
<CFPARAM NAME="FORM.MiddleInitial" DEFAULT="">
<CFPARAM NAME="FORM.BusinessName" DEFAULT="">
<CFPARAM NAME="FORM.Address" DEFAULT="">
<CFPARAM NAME="FORM.City" DEFAULT="">
<CFPARAM NAME="FORM.StateID" DEFAULT="">
<CFPARAM NAME="FORM.CookCountyInd" DEFAULT="0">
<CFPARAM NAME="FORM.ZipCode" DEFAULT="">
<CFPARAM NAME="FORM.ZipCode2" DEFAULT="0000">
<CFPARAM NAME="FORM.FEIN" DEFAULT="">
<CFPARAM NAME="FORM.TransactionCodeID" DEFAULT="">
<CFPARAM NAME="FORM.TransactionEffectiveDate" DEFAULT="#DateFormat(Now(), "YYYYMMDD")#">
<CFPARAM NAME="FORM.TransactionExpirationDate" DEFAULT="#DateFormat(DateAdd("YYYY", 1, Now()), "YYYYMMDD")#">
<CFPARAM NAME="FORM.GrossPremium" DEFAULT="">
<CFPARAM NAME="FORM.Surcharge" DEFAULT="$0.00">
<CFPARAM NAME="FORM.KyCollectionFee" DEFAULT="$0.00">
<CFPARAM NAME="FORM.KyMunicipalTax" DEFAULT="$0.00">
<CFPARAM NAME="FORM.LimitAmountPerClaim" DEFAULT="$1,000,000">
<CFPARAM NAME="FORM.LimitAmountAggregate" DEFAULT="$3,000,000">
<CFPARAM NAME="FORM.DeductibleAmountPerClaim" DEFAULT="$0.00">
<CFPARAM NAME="FORM.DeductibleAmountAggregate" DEFAULT="$0.00">
<CFPARAM NAME="FORM.CoverageSymbol" DEFAULT="">
<CFPARAM NAME="FORM.PolicySymbol" DEFAULT="#stSystemConstants.acPolicySymbol#">
<CFPARAM NAME="FORM.PolicyNumber" DEFAULT="">
<CFPARAM NAME="FORM.PolicyModuleNumber" DEFAULT="0">
<CFPARAM NAME="FORM.PreviousPolicyNumber" DEFAULT="000000000">
<CFPARAM NAME="FORM.PolicyEffectiveDate" DEFAULT="">
<CFPARAM NAME="FORM.PolicyExpirationDate" DEFAULT="">
<CFPARAM NAME="FORM.PolicyRetroactiveDate" DEFAULT="">
<CFPARAM NAME="FORM.InsuranceCompanyID" DEFAULT="">
<CFPARAM NAME="FORM.NJSequenceNumber" DEFAULT="">
<CFPARAM NAME="FORM.PremiumCodingExportDateTimeInd" DEFAULT="0">
<CFPARAM NAME="FORM.AccountsCurrentExportDateTimeInd" DEFAULT="0">


<cfinclude template="QRY/QRY_GetStateSurcharges.cfm">
<cfloop query="GetStateSurcharges">
	<cfparam name="form.Surcharge_#GetStateSurcharges.SurchargeID#" default="$0.00">
</cfloop>



<!--- Backup Form field values --->
<CFSET formBackup = Duplicate(FORM)>


<!--- Reformat date fields for validation --->
<CFLOOP LIST="TransactionEffectiveDate,TransactionExpirationDate,PolicyEffectiveDate,PolicyExpirationDate,PolicyRetroactiveDate" INDEX="currEle">
	<!--- Remove separator characters --->
	<CFSET tmpValue = ReplaceList(FORM[currEle], "/,-,.", ",,")>

	<!--- If 8 characters, reformat as date --->
	<CFIF Len(tmpValue) EQ 8>
		<CFSET FORM[currEle] = Mid(tmpValue, 5, 2) & "/" & Right(tmpValue, 2) & "/" & Left(tmpValue, 4)>
	</CFIF>
</CFLOOP>


<!--- Reformat currency fields for validation --->
<CFLOOP LIST="GrossPremium,Surcharge,KyCollectionFee,KyMunicipalTax,LimitAmountPerClaim,LimitAmountAggregate,DeductibleAmountPerClaim,DeductibleAmountAggregate" INDEX="currEle">
	<!--- Remove currency and separator characters --->
	<CFSET FORM[currEle] = Replace(FORM[currEle], "$", "", "ALL")>
	<CFSET FORM[currEle] = Replace(FORM[currEle], ",", "", "ALL")>
</CFLOOP>
<cfloop query="GetStateSurcharges">
	<!--- Remove currency and separator characters --->
	<cfset form["Surcharge_#GetStateSurcharges.SurchargeID#"] = Replace(form["Surcharge_#GetStateSurcharges.SurchargeID#"], "$", "", "ALL")>
	<cfset form["Surcharge_#GetStateSurcharges.SurchargeID#"] = Replace(form["Surcharge_#GetStateSurcharges.SurchargeID#"], ",", "", "ALL")>
</cfloop>


<!--- Validate submitted data --->
<CFINCLUDE TEMPLATE="ERR/ERR_dataEntryAction.cfm">


<!--- Display page or redirect user to new page --->
<CFIF cntErrors NEQ 0>
	<!--- Restore original Form field values --->
	<CFLOOP COLLECTION="#formBackup#" ITEM="currEle">
		<CFSET FORM[currEle] = formBackup[currEle]>
	</CFLOOP>

	<!--- Redisplay data entry form --->
	<CFINCLUDE TEMPLATE="dataEntry.cfm">
<CFELSE>
	<!--- Get Risk Location Code --->
	<CFINCLUDE TEMPLATE="BIZ/BIZ_GetRiskLocationCode.cfm">

	<cftransaction>
		<!--- Add transaction to database --->
		<CFINCLUDE TEMPLATE="QRY/QRY_AddTransaction.cfm">

		<!--- Add transaction surcharges to database --->
		<cfloop query="GetStateSurcharges">
			<!--- If surcharge state equals selected state --->
			<cfif form.StateID EQ GetStateSurcharges.StateID>
				<!--- Add to database --->
				<cfset variables.SurchargeID = GetStateSurcharges.SurchargeID>
				<cfset variables.SurchargeAmount = form["Surcharge_#variables.SurchargeID#"]>
				<cfinclude template="QRY/QRY_AddTransactionSurcharge.cfm">
			</cfif>
		</cfloop>

		<!--- Maintain legacy data tables --->
		<CFINCLUDE TEMPLATE="BIZ\BIZ_MaintainLegacyData.cfm">
	</cftransaction>

	<!--- Redirect to confirmation screen --->
	<CFLOCATION URL="dataEntryConfirmed.cfm" ADDTOKEN="No">
</CFIF>

