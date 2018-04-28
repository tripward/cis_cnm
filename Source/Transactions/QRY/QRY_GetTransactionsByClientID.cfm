<!---
################################################################################
#
# Filename:		QRY_GetTransactionsByClientID.cfm
#
# Description:	Retrieves transactions for specified client from the database
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="VARIABLES.ClientID" TYPE="Numeric">


<!--- Query database for transaction records --->
<CFQUERY NAME="GetTransactionsByClientID" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		TransactionID,
		PolicySymbol,
		PolicyNumber,
		PolicyModuleNumber,
		PreviousPolicyNumber,
		PolicyEffectiveDate,
		PolicyExpirationDate,
		FirstName,
		MiddleInitial,
		LastName,
		Address,
		City,
		aig2_xState.Abbreviation,
		aig2_xState.SurplusLinesLicenseNumber,
		ZipCode,
		ZipCode2,
		FEIN,
		TransactionEffectiveDate,
		TransactionExpirationDate,
		aig2_Transaction.TransactionCodeID,
		aig2_xTransactionCode.Transaction,
		GrossPremium,
		Surcharge,
		KyCollectionFee,
		KyMunicipalTax,
		LimitAmountPerClaim,
		LimitAmountAggregate,
		DeductibleAmountPerClaim,
		DeductibleAmountAggregate,
		PolicyRetroactiveDate,
		aig2_Transaction.InsuranceCompanyID,
		aig2_xInsuranceCompany.InsuranceCompany,
		NjSequenceNumber,
		RiskLocationCode,
		CreationDateTime
	FROM
		(aig2_xTransactionCode INNER JOIN (aig2_Transaction INNER JOIN aig2_xState ON aig2_Transaction.StateID = aig2_xState.StateID) ON aig2_xTransactionCode.TransactionCodeID = aig2_Transaction.TransactionCodeID) INNER JOIN aig2_xInsuranceCompany ON aig2_Transaction.InsuranceCompanyID = aig2_xInsuranceCompany.InsuranceCompanyID
	WHERE
		ClientID = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.ClientID#">
	ORDER BY
		TransactionEffectiveDate DESC
</CFQUERY>

