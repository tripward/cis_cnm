<!---
################################################################################
#
# Filename:		QRY_GetTransactions.cfm
#
# Description:	Retrieves transactions from the database
#
################################################################################
--->

<!--- Require VARIABLES.ClientID --->
<CFPARAM NAME="VARIABLES.RangeStartDate" DEFAULT="">
<CFPARAM NAME="VARIABLES.RangeEndDate" DEFAULT="">
<CFPARAM NAME="VARIABLES.TransactionCodeID">
<CFPARAM NAME="VARIABLES.ExportTypeID" TYPE="Numeric">
<CFPARAM NAME="VARIABLES.PositiveOnlyInd" TYPE="Numeric">


<!--- Determine export type --->
<CFINCLUDE TEMPLATE="QRY_GetExportType.cfm">


<!--- Query database for transaction records --->
<CFQUERY NAME="GetTransactions" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		aig2_Transaction.TransactionID,
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
		TransactionCodeID,
		GrossPremium,
		Surcharge,
		KyCollectionFee,
		KyMunicipalTax,
		LimitAmountPerClaim,
		LimitAmountAggregate,
		DeductibleAmountPerClaim,
		DeductibleAmountAggregate,
		CoverageSymbol,
		PolicyRetroactiveDate,
		InsuranceCompanyID,
		NjSequenceNumber,
		RiskLocationCode,
		CreationDateTime,
		Count(aig2_TransactionSurcharge.SurchargeID) AS NumSurcharges
	FROM
		(aig2_Transaction INNER JOIN aig2_xState ON aig2_Transaction.StateID = aig2_xState.StateID) LEFT JOIN aig2_TransactionSurcharge ON aig2_Transaction.TransactionID = aig2_TransactionSurcharge.TransactionID
	WHERE
		TransactionCodeID IN (#VARIABLES.TransactionCodeID#)
		<CFIF (Len(Trim(VARIABLES.RangeStartDate)) NEQ 0) AND (Len(Trim(VARIABLES.RangeEndDate)) NEQ 0)>
			AND (
					(
						PolicyEffectiveDate >= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeStartDate, 'mm/dd/yyyy')#">
						AND PolicyEffectiveDate <= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeEndDate, 'mm/dd/yyyy')#">
						AND TransactionCodeID IN (1,2)
					)
					OR
					(
						TransactionEffectiveDate >= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeStartDate, 'mm/dd/yyyy')#">
						AND TransactionEffectiveDate <= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeEndDate, 'mm/dd/yyyy')#">
						AND TransactionCodeID NOT IN (1,2)
					)
				)
		</CFIF>
		<CFIF CompareNoCase(GetExportType.ExportType, "Accounts Current") EQ 0>
			AND AccountsCurrentExportDateTime IS NULL
		<CFELSE>
			AND PremiumCodingExportDateTime IS NULL
		</CFIF>
		<CFIF VARIABLES.PositiveOnlyInd EQ 1>
			AND GrossPremium > 0
		</CFIF>
	GROUP BY
		aig2_Transaction.TransactionID,
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
		TransactionCodeID,
		GrossPremium,
		Surcharge,
		KyCollectionFee,
		KyMunicipalTax,
		LimitAmountPerClaim,
		LimitAmountAggregate,
		DeductibleAmountPerClaim,
		DeductibleAmountAggregate,
		CoverageSymbol,
		PolicyRetroactiveDate,
		InsuranceCompanyID,
		NjSequenceNumber,
		RiskLocationCode,
		CreationDateTime
	ORDER BY
		InsuranceCompanyID, TransactionEffectiveDate ASC
</CFQUERY>

