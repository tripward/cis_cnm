<!---
################################################################################
#
# Filename:		ERR_dataEntryAction.cfm
#
# Description:	Data Entry Action validation
#
################################################################################
--->

<!--- Initialize Error variables --->
<CFSET arrErrors = ArrayNew(2)>
<CFSET cntErrors = 0>


<!--- Initialize date indicator flags --->
<CFSET VARIABLES.tranEffDateInd = false>
<CFSET VARIABLES.tranExpDateInd = false>
<CFSET VARIABLES.polEffDateInd = false>
<CFSET VARIABLES.polExpDateInd = false>
<CFSET VARIABLES.polRetroDateInd = false>


<!--- Check that user entered a ClientID --->
<CFIF Len(Trim(FORM.ClientID)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ClientID">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Client ID&quot; field is required.">
<!--- Check that ClientID is numeric and an integer --->
<CFELSEIF (NOT IsNumeric(FORM.ClientID)) OR (FORM.ClientID NEQ Int(FORM.ClientID))>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ClientID">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Client ID&quot; field must be a valid integer.">
<!--- If valid, check for existing record --->
<CFELSE>
	<CFSET VARIABLES.ClientID = FORM.ClientID>
	<CFINCLUDE TEMPLATE="..\QRY\QRY_GetClientData.cfm">
</CFIF>

<!--- Check that user entered a LastName --->
<CFIF Len(Trim(FORM.LastName)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "LastName">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Last Name&quot; field is required.">
<!--- Check that LastName does not exceed 255 characters --->
<CFELSEIF Len(Trim(FORM.LastName)) GT 255>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "LastName">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Last Name&quot; field may not exceed 255 characters.">
</CFIF>

<!--- Check that FirstName does not exceed 255 characters --->
<CFIF Len(Trim(FORM.FirstName)) GT 255>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "FirstName">
	<CFSET arrErrors[2][cntErrors] = "The &quot;First Name&quot; field may not exceed 255 characters.">
</CFIF>

<!--- Check that MiddleInitial does not exceed 255 characters --->
<CFIF Len(Trim(FORM.MiddleInitial)) GT 255>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "MiddleInitial">
	<CFSET arrErrors[2][cntErrors] = "The &quot;MiddleInitial&quot; field may not exceed 255 characters.">
</CFIF>

<!--- Check that BusinessName does not exceed 255 characters --->
<CFIF Len(Trim(FORM.BusinessName)) GT 255>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "BusinessName">
	<CFSET arrErrors[2][cntErrors] = "The &quot;BusinessName&quot; field may not exceed 255 characters.">
</CFIF>

<!--- Check that user entered a Address --->
<CFIF Len(Trim(FORM.Address)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "Address">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Address&quot; field is required.">
<!--- Check that Address does not exceed 35 characters --->
<CFELSEIF Len(Trim(FORM.Address)) GT 35>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "Address">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Address&quot; field may not exceed 35 characters.">
</CFIF>

<!--- Check that user entered a City --->
<CFIF Len(Trim(FORM.City)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "City">
	<CFSET arrErrors[2][cntErrors] = "The &quot;City&quot; field is required.">
<!--- Check that City does not exceed 18 characters --->
<CFELSEIF Len(Trim(FORM.City)) GT 18>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "City">
	<CFSET arrErrors[2][cntErrors] = "The &quot;City&quot; field may not exceed 255 characters.">
</CFIF>

<!--- Check that user selected a StateID --->
<CFIF FORM.StateID EQ -1>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "StateID">
	<CFSET arrErrors[2][cntErrors] = "The &quot;State&quot; field is required.">
</CFIF>

<!--- Check that user entered a ZipCode --->
<CFIF Len(Trim(FORM.ZipCode)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ZipCode">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Zip Code&quot; field is required.">
<!--- Check that ZipCode has 5 characters --->
<CFELSEIF Len(Trim(FORM.ZipCode)) NEQ 5>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ZipCode">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Zip Code&quot; field must contain 5 characters.">
<!--- Check that ZipCode contains only digits --->
<CFELSEIF NOT IsNumeric(FORM.ZipCode)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ZipCode">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Zip Code&quot; field may only contain digits.">
</CFIF>

<!--- Check that user entered a ZipCode2 --->
<CFIF Len(Trim(FORM.ZipCode2)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ZipCode2">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Zip+4&quot; field is required.">
<!--- Check that ZipCode2 does not exceed 4 characters --->
<CFELSEIF Len(Trim(FORM.ZipCode2)) GT 4>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ZipCode2">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Zip+4&quot; field may not exceed 255 characters.">
</CFIF>

<!--- Check that user selected a TransactionCodeID --->
<CFIF FORM.TransactionCodeID EQ -1>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "TransactionCodeID">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Code&quot; field is required.">
<!--- Check that import is using a valid code --->
<cfelseif form.TransactionCodeID EQ -2>
	<cfset cntErrors = cntErrors + 1>
	<cfset arrErrors[1][cntErrors] = "TransactionCodeID">
	<cfset arrErrors[2][cntErrors] = "The &quot;Transaction Code&quot; field must specify a valid Transaction Code.">
<!--- Check that "New" transaction is only applied to new clients --->
<CFELSEIF (IsDefined("GetClientData")) AND (FORM.TransactionCodeID EQ 1) AND (GetClientData.RecordCount NEQ 0)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "TransactionCodeID">
	<CFSET arrErrors[2][cntErrors] = "The &quot;New Business&quot; Transaction Code cannot be applied to existing clients.">
<!--- Check that non-"New" transactions are only applied to existing clients --->
<CFELSEIF (IsDefined("GetClientData")) AND (FORM.TransactionCodeID NEQ 1) AND (GetClientData.RecordCount EQ 0)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "TransactionCodeID">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Code&quot; field must be set to &quot;New Business&quot; for new clients.">
</CFIF>

<!--- Check that user entered a TransactionEffectiveDate --->
<CFIF Len(Trim(FORM.TransactionEffectiveDate)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "TransactionEffectiveDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Effective Date&quot; field is required.">
<!--- Check that TransactionEffectiveDate is a valid date --->
<CFELSEIF NOT IsDate(FORM.TransactionEffectiveDate)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "TransactionEffectiveDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Effective Date&quot; field must be a valid date.">
<!--- Set indicator specifying that the date is valid --->
<CFELSE>
	<CFSET VARIABLES.tranEffDateInd = true>
</CFIF>

<!--- Check that user entered a TransactionExpirationDate --->
<CFIF Len(Trim(FORM.TransactionExpirationDate)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "TransactionExpirationDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Expiration Date&quot; field is required.">
<!--- Check that TransactionEffectiveDate is a valid date --->
<CFELSEIF NOT IsDate(FORM.TransactionExpirationDate)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "TransactionExpirationDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Expiration Date&quot; field must be a valid date.">
<!--- Set indicator specifying that the date is valid --->
<CFELSE>
	<CFSET VARIABLES.tranExpDateInd = true>
</CFIF>

<!--- Check that user entered a GrossPremium --->
<CFIF Len(Trim(FORM.GrossPremium)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "GrossPremium">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Gross Premium&quot; field is required.">
<!--- Check that GrossPremium is numeric --->
<CFELSEIF NOT IsNumeric(FORM.GrossPremium)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "GrossPremium">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Gross Premium&quot; field must be a valid number.">
</CFIF>

<!---

<!--- Check that user entered a Surcharge --->
<CFIF Len(Trim(FORM.Surcharge)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "Surcharge">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Surcharge&quot; field is required.">
<!--- Check that Surcharge is numeric --->
<CFELSEIF NOT IsNumeric(FORM.Surcharge)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "Surcharge">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Surcharge&quot; field must be a valid number.">
</CFIF>

<!--- Check that user entered a KyCollectionFee --->
<CFIF Len(Trim(FORM.KyCollectionFee)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "KyCollectionFee">
	<CFSET arrErrors[2][cntErrors] = "The &quot;KY Collection Fee&quot; field is required.">
<!--- Check that KyCollectionFee is numeric --->
<CFELSEIF NOT IsNumeric(FORM.KyCollectionFee)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "KyCollectionFee">
	<CFSET arrErrors[2][cntErrors] = "The &quot;KY Collection Fee&quot; field must be a valid number.">
</CFIF>

<!--- Check that user entered a KyMunicipalTax --->
<CFIF Len(Trim(FORM.KyMunicipalTax)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "KyMunicipalTax">
	<CFSET arrErrors[2][cntErrors] = "The &quot;KY Municipal Tax&quot; field is required.">
<!--- Check that KyMunicipalTax is numeric --->
<CFELSEIF NOT IsNumeric(FORM.KyMunicipalTax)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "KyMunicipalTax">
	<CFSET arrErrors[2][cntErrors] = "The &quot;KY Municipal Tax&quot; field must be a valid number.">
</CFIF>
 --->


<!--- Check state surcharges --->
<cfloop query="GetStateSurcharges">
	<!--- If surcharge state equals selected state --->
	<cfif form.StateID EQ GetStateSurcharges.StateID>
		<!--- Check that user entered a surcharge value --->
		<cfif Len(Trim(form["Surcharge_#GetStateSurcharges.SurchargeID#"])) EQ 0>
			<cfset cntErrors = cntErrors + 1>
			<cfset arrErrors[1][cntErrors] = "Surcharge_#GetStateSurcharges.SurchargeID#">
			<cfset arrErrors[2][cntErrors] = "The &quot;#GetStateSurcharges.Surcharge#&quot; field is required.">
		<!--- Check that surcharge value is numeric --->
		<cfelseif NOT IsNumeric(form["Surcharge_#GetStateSurcharges.SurchargeID#"])>
			<cfset cntErrors = cntErrors + 1>
			<cfset arrErrors[1][cntErrors] = "Surcharge_#GetStateSurcharges.SurchargeID#">
			<cfset arrErrors[2][cntErrors] = "The &quot;#GetStateSurcharges.Surcharge#&quot; field must be a valid number.">
		</cfif>
	</cfif>
</cfloop>



<!--- Check that user entered a LimitAmountPerClaim --->
<CFIF Len(Trim(FORM.LimitAmountPerClaim)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "LimitAmountPerClaim">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Limit/Claim&quot; field is required.">
<!--- Check that LimitAmountPerClaim is numeric --->
<CFELSEIF NOT IsNumeric(FORM.LimitAmountPerClaim)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "LimitAmountPerClaim">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Limit/Claim&quot; field must be a valid number.">
</CFIF>

<!--- Check that user entered a LimitAmountAggregate --->
<CFIF Len(Trim(FORM.LimitAmountAggregate)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "LimitAmountAggregate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Limit/Aggregate&quot; field is required.">
<!--- Check that LimitAmountAggregate is numeric --->
<CFELSEIF NOT IsNumeric(FORM.LimitAmountAggregate)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "LimitAmountAggregate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Limit/Aggregate&quot; field must be a valid number.">
</CFIF>

<!--- Check that user entered a DeductibleAmountPerClaim --->
<CFIF Len(Trim(FORM.DeductibleAmountPerClaim)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "DeductibleAmountPerClaim">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Deductible/Claim&quot; field is required.">
<!--- Check that DeductibleAmountPerClaim is numeric --->
<CFELSEIF NOT IsNumeric(FORM.DeductibleAmountPerClaim)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "DeductibleAmountPerClaim">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Deductible/Claim&quot; field must be a valid number.">
</CFIF>

<!--- Check that user entered a DeductibleAmountAggregate --->
<CFIF Len(Trim(FORM.DeductibleAmountAggregate)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "DeductibleAmountAggregate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Deductible/Aggregate&quot; field is required.">
<!--- Check that DeductibleAmountAggregate is numeric --->
<CFELSEIF NOT IsNumeric(FORM.DeductibleAmountAggregate)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "DeductibleAmountAggregate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Deductible/Aggregate&quot; field must be a valid number.">
</CFIF>

<!--- Check that user selected a CoverageSymbol --->
<CFIF Len(Trim(FORM.CoverageSymbol)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "CoverageSymbol">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Coverage&quot; field is required.">
</CFIF>

<!--- Check that user entered a PolicySymbol --->
<CFIF Len(Trim(FORM.PolicySymbol)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicySymbol">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Symbol&quot; field is required.">
<!--- Check that PolicySymbol does not exceed 3 characters --->
<CFELSEIF Len(Trim(FORM.PolicySymbol)) GT 3>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicySymbol">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Symbol&quot; field may not exceed 3 characters.">
</CFIF>

<!--- Check that user entered a PolicyNumber --->
<CFIF Len(Trim(FORM.PolicyNumber)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyNumber">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Number&quot; field is required.">
<!--- Check that PolicyNumber is numeric and an integer --->
<CFELSEIF (NOT IsNumeric(FORM.PolicyNumber)) OR (FORM.PolicyNumber NEQ Int(FORM.PolicyNumber))>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyNumber">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Number&quot; field must be a valid integer.">
</CFIF>

<!--- Check that user entered a PolicyModuleNumber --->
<CFIF Len(Trim(FORM.PolicyModuleNumber)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyModuleNumber">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Module Number&quot; field is required.">
<!--- Check that PolicyModuleNumber is numeric and an integer --->
<CFELSEIF (NOT IsNumeric(FORM.PolicyModuleNumber)) OR (FORM.PolicyModuleNumber NEQ Int(FORM.PolicyModuleNumber))>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyModuleNumber">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Module Number&quot; field must be a valid integer.">
</CFIF>

<!--- Check that user entered a PreviousPolicyNumber --->
<CFIF Len(Trim(FORM.PreviousPolicyNumber)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PreviousPolicyNumber">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Previous Policy Number&quot; field is required.">
<!--- Check that PreviousPolicyNumber is numeric and an integer --->
<CFELSEIF (NOT IsNumeric(FORM.PreviousPolicyNumber)) OR (FORM.PreviousPolicyNumber NEQ Int(FORM.PreviousPolicyNumber))>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PreviousPolicyNumber">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Previous Policy Number&quot; field must be a valid integer.">
</CFIF>

<!--- Check that user entered a PolicyEffectiveDate --->
<CFIF Len(Trim(FORM.PolicyEffectiveDate)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyEffectiveDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Effective Date&quot; field is required.">
<!--- Check that PolicyEffectiveDate is a valid date --->
<CFELSEIF NOT IsDate(FORM.PolicyEffectiveDate)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyEffectiveDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Effective Date&quot; field must be a valid date.">
<!--- Set indicator specifying that the date is valid --->
<CFELSE>
	<CFSET VARIABLES.polEffDateInd = true>
</CFIF>

<!--- Check that user entered a PolicyExpirationDate --->
<CFIF Len(Trim(FORM.PolicyExpirationDate)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyExpirationDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Expiration Date&quot; field is required.">
<!--- Check that PolicyExpirationDate is a valid date --->
<CFELSEIF NOT IsDate(FORM.PolicyExpirationDate)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyExpirationDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Expiration Date&quot; field must be a valid date.">
<!--- Set indicator specifying that the date is valid --->
<CFELSE>
	<CFSET VARIABLES.polExpDateInd = true>
</CFIF>

<!--- Check that user entered a PolicyRetroactiveDate --->
<CFIF Len(Trim(FORM.PolicyRetroactiveDate)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyRetroactiveDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Retroactive Date&quot; field is required.">
<!--- Check that PolicyRetroactiveDate is a valid date --->
<CFELSEIF NOT IsDate(FORM.PolicyRetroactiveDate)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyRetroactiveDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Retroactive Date&quot; field must be a valid date.">
<!--- Set indicator specifying that the date is valid --->
<CFELSE>
	<CFSET VARIABLES.polRetroDateInd = true>
</CFIF>

<!--- Check that user selected a InsuranceCompanyID --->
<CFIF FORM.InsuranceCompanyID EQ -1>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "InsuranceCompanyID">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Insurance Company&quot; field is required.">
</CFIF>

<!--- Check that user entered a NjSequenceNumber --->
<CFIF (Len(Trim(FORM.NjSequenceNumber)) EQ 0) AND (FORM.StateID NEQ 31)>
<CFELSEIF (Len(Trim(FORM.NjSequenceNumber)) EQ 0) AND (FORM.StateID EQ 31)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "NjSequenceNumber">
	<CFSET arrErrors[2][cntErrors] = "The &quot;NJ Sequence Number&quot; field is required for New Jersey transactions.">
<!--- Check that NjSequenceNumber has 5 characters --->
<CFELSEIF Len(Trim(FORM.NjSequenceNumber)) NEQ 5>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "NjSequenceNumber">
	<CFSET arrErrors[2][cntErrors] = "The &quot;NJ Sequence Number&quot; field must contain 5 characters.">
<!--- Check that NjSequenceNumber contains only digits --->
<CFELSEIF NOT IsNumeric(FORM.NjSequenceNumber)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "NjSequenceNumber">
	<CFSET arrErrors[2][cntErrors] = "The &quot;NJ Sequence Number&quot; field may only contain digits.">
</CFIF>




<!--- NEW/RENEWAL/ENDORSEMENT Date Rules --->
<CFIF ListFind("1,2,6", FORM.TransactionCodeID) NEQ 0>
	<!--- Check that TransactionExpirationDate is after TransactionEffectiveDate --->
	<CFIF (VARIABLES.tranEffDateInd) AND (VARIABLES.tranExpDateInd) AND (DateDiff("d", FORM.TransactionEffectiveDate, FORM.TransactionExpirationDate) LT 1)>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "TransactionEffectiveDate,TransactionExpirationDate">
		<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Effective Date&quot; must be before the &quot;Transaction Expiration Date&quot;.">
	</CFIF>

	<!--- Check that PolicyExpirationDate is after PolicyEffectiveDate --->
	<CFIF (VARIABLES.polEffDateInd) AND (VARIABLES.polExpDateInd) AND (DateDiff("d", FORM.PolicyEffectiveDate, FORM.PolicyExpirationDate) LT 1)>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "PolicyEffectiveDate,PolicyExpirationDate">
		<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Effective Date&quot; must be before the &quot;Policy Expiration Date&quot;.">
	</CFIF>

	<!--- Check that TransactionExpirationDate is equal to PolicyExpirationDate --->
	<CFIF (VARIABLES.polExpDateInd) AND (VARIABLES.tranExpDateInd) AND (DateDiff("d", FORM.PolicyExpirationDate, FORM.TransactionExpirationDate) NEQ 0)>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "PolicyExpirationDate,TransactionExpirationDate">
		<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Expiration Date&quot; must be the same as the &quot;Transaction Expiration Date&quot;.">
	</CFIF>
<!--- CANCELLATION Date Rules --->
<CFELSEIF ListFind("7,8,9", FORM.TransactionCodeID) NEQ 0>
	<!--- Check that TransactionExpirationDate is after TransactionEffectiveDate --->
	<CFIF (VARIABLES.tranEffDateInd) AND (VARIABLES.tranExpDateInd) AND (DateDiff("d", FORM.TransactionEffectiveDate, FORM.TransactionExpirationDate) LT 1)>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "TransactionEffectiveDate,TransactionExpirationDate">
		<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Effective Date&quot; must be before the &quot;Transaction Expiration Date&quot;.">
	</CFIF>

	<!--- Check that PolicyExpirationDate is after PolicyEffectiveDate --->
	<CFIF (VARIABLES.polEffDateInd) AND (VARIABLES.polExpDateInd) AND (DateDiff("d", FORM.PolicyEffectiveDate, FORM.PolicyExpirationDate) LT 1)>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "PolicyEffectiveDate,PolicyExpirationDate">
		<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Effective Date&quot; must be before the &quot;Policy Expiration Date&quot;.">
	</CFIF>
<!--- TAIL Date Rules --->
<CFELSEIF ListFind("10", FORM.TransactionCodeID) NEQ 0>
	<!--- Check that TransactionExpirationDate is on or after TransactionEffectiveDate --->
	<CFIF (VARIABLES.tranEffDateInd) AND (VARIABLES.tranExpDateInd) AND (DateDiff("d", FORM.TransactionEffectiveDate, FORM.TransactionExpirationDate) LT 0)>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "TransactionEffectiveDate,TransactionExpirationDate">
		<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Effective Date&quot; must be on or before the &quot;Transaction Expiration Date&quot;.">
	</CFIF>

	<!--- Check that PolicyExpirationDate is after PolicyEffectiveDate --->
	<CFIF (VARIABLES.polEffDateInd) AND (VARIABLES.polExpDateInd) AND (DateDiff("d", FORM.PolicyEffectiveDate, FORM.PolicyExpirationDate) LT 1)>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "PolicyEffectiveDate,PolicyExpirationDate">
		<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Effective Date&quot; must be before the &quot;Policy Expiration Date&quot;.">
	</CFIF>
</CFIF>


<!--- Check that TransactionEffectiveDate is on or after PolicyEffectiveDate --->
<CFIF (VARIABLES.tranEffDateInd) AND (VARIABLES.polEffDateInd) AND (DateDiff("d", FORM.PolicyEffectiveDate, FORM.TransactionEffectiveDate) LT 0)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyEffectiveDate,TransactionEffectiveDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Effective Date&quot; must be the same as or earlier than the &quot;Transaction Effective Date&quot;.">
</CFIF>

<!--- Check that PolicyExpirationDate is on or after TransactionEffectiveDate --->
<CFIF (VARIABLES.tranEffDateInd) AND (VARIABLES.polExpDateInd) AND (DateDiff("d", FORM.TransactionEffectiveDate, FORM.PolicyExpirationDate) LT 0)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "TransactionEffectiveDate,PolicyExpirationDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Effective Date&quot; must be the same as or earlier than the &quot;Policy Expiration Date&quot;.">
</CFIF>

<!--- Check that PolicyRetroactiveDate is less than or equal to PolicyEffectiveDate --->
<CFIF (VARIABLES.polEffDateInd) AND (VARIABLES.polRetroDateInd) AND (DateDiff("d", FORM.PolicyRetroactiveDate, FORM.PolicyEffectiveDate) LT 0)>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "PolicyEffectiveDate,PolicyRetroactiveDate">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Policy Retroactive Date&quot; must be the same as or earlier than the &quot;Policy Effective Date&quot;.">
</CFIF>



