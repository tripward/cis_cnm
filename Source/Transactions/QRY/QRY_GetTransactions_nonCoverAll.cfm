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
		t1.TransactionID AS newTransactionID,
		t1.PolicySymbol AS newTPolicySymbol,
		t1.PolicyNumber AS newPolicyNumber,
		t1.PolicyModuleNumber AS newPolicyModuleNumber,
		t1.PreviousPolicyNumber AS newPreviousPolicyNumber,
		t1.PolicyEffectiveDate AS newPolicyEffectiveDate,
		t1.PolicyExpirationDate AS newPolicyExpirationDate,
		t1.FirstName AS newFirstName,
		t1.MiddleInitial AS newMiddleInitial,
		t1.LastName AS newLastName,
		t1.Address AS newAddress,
		t1.City AS newCity,
		aig2_xState.Abbreviation,
		aig2_xState.stateTaxID,
		aig2_xState.SurplusLinesLicenseNumber,
		t1.ZipCode AS newZipCode,
		t1.ZipCode2 AS newZipCode2,
		t1.FEIN AS newFEIN,
		t1.TransactionEffectiveDate AS newTransactionEffectiveDate,
		t1.TransactionExpirationDate AS newTransactionExpirationDate,
		t1.TransactionCodeID AS newTransactionCodeID,
		aig2_xTransactionCode.transaction,
		t1.GrossPremium AS newGrossPremium,
		t1.Surcharge AS newSurcharge,
		t1.KyCollectionFee AS newKyCollectionFee,
		t1.KyMunicipalTax AS newKyMunicipalTax,
		t1.LimitAmountPerClaim AS newLimitAmountPerClaim,
		t1.LimitAmountAggregate AS newLimitAmountAggregate,
		t1.DeductibleAmountPerClaim AS newDeductibleAmountPerClaim,
		t1.DeductibleAmountAggregate AS newDeductibleAmountAggregate,
		t1.CoverageSymbol AS newCoverageSymbol,
		t1.PolicyRetroactiveDate AS newPolicyRetroactiveDate,
		t1.InsuranceCompanyID AS newInsuranceCompanyID,
		t1.NjSequenceNumber AS newNjSequenceNumber,
		t1.RiskLocationCode AS newRiskLocationCode,
		t1.CreationDateTime AS newCreationDateTime,
		t2.TransactionID AS oldTransactionID,
		t2.PolicySymbol AS oldPolicySymbol,
		t2.PolicyNumber AS oldPolicyNumber,
		t2.PolicyModuleNumber AS oldPolicyModuleNumber,
		t2.PreviousPolicyNumber AS oldPreviousPolicyNumber,
		t2.PolicyEffectiveDate AS oldPolicyEffectiveDate,
		t2.PolicyExpirationDate AS oldPolicyExpirationDate,
		t2.FirstName AS oldFirstName,
		t2.MiddleInitial AS oldMiddleInitial,
		t2.LastName AS oldLastName,
		t2.Address AS oldAddress,
		t2.City AS oldCity,
		t2.ZipCode AS oldZipCode,
		t2.ZipCode2 AS oldZipCode2,
		t2.FEIN AS oldFEIN,
		t2.TransactionEffectiveDate AS oldTransactionEffectiveDate,
		t2.TransactionExpirationDate AS oldTransactionExpirationDate,
		t2.TransactionCodeID AS oldTransactionCodeID,
		t2.GrossPremium AS oldGrossPremium,
		t2.Surcharge AS oldSurcharge,
		t2.KyCollectionFee AS oldKyCollectionFee,
		t2.KyMunicipalTax AS oldKyMunicipalTax,
		t2.LimitAmountPerClaim AS oldLimitAmountPerClaim,
		t2.LimitAmountAggregate AS oldLimitAmountAggregate,
		t2.DeductibleAmountPerClaim AS oldDeductibleAmountPerClaim,
		t2.DeductibleAmountAggregate AS oldDeductibleAmountAggregate,
		t2.CoverageSymbol AS oldCoverageSymbol,
		t2.PolicyRetroactiveDate AS oldPolicyRetroactiveDate,
		t2.InsuranceCompanyID AS oldInsuranceCompanyID,
		t2.NjSequenceNumber AS oldNjSequenceNumber,
		t2.RiskLocationCode AS oldRiskLocationCode,
		t2.CreationDateTime AS oldCreationDateTime,
		Count(aig2_TransactionSurcharge.SurchargeID) AS NumSurcharges
	FROM
		((((aig2_Transaction t1 INNER JOIN aig2_xState ON t1.StateID = aig2_xState.StateID) 
		LEFT JOIN aig2_TransactionSurcharge ON t1.TransactionID = aig2_TransactionSurcharge.TransactionID)
		LEFT JOIN aig2_xTransactionCode ON t1.TransactionCodeID = aig2_xTransactionCode.TransactionCodeID)
		INNER JOIN aig2_Transaction AS t2 ON (t1.PolicyNumber = t2.PolicyNumber) AND (t1.ClientID = t2.ClientID)  AND (t1.PolicyEffectiveDate = t2.PolicyExpirationDate))
	WHERE
		t1.TransactionCodeID IN (#VARIABLES.TransactionCodeID#)
		<CFIF (Len(Trim(VARIABLES.RangeStartDate)) NEQ 0) AND (Len(Trim(VARIABLES.RangeEndDate)) NEQ 0)>
			AND (
					(
						t1.PolicyEffectiveDate >= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeStartDate, 'mm/dd/yyyy')#">
						AND t1.PolicyEffectiveDate <= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeEndDate, 'mm/dd/yyyy')#">
						AND t1.TransactionCodeID IN (1,2)
						AND (t2.TransactionCodeID IN (1,2))
					)
					OR
					(
						t1.TransactionEffectiveDate >= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeStartDate, 'mm/dd/yyyy')#">
						AND t1.TransactionEffectiveDate <= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeEndDate, 'mm/dd/yyyy')#">
						AND t1.TransactionCodeID NOT IN (1,2)
						AND (t2.TransactionCodeID IN (1,2))
					)
				)
		</CFIF>
		
		<CFIF CompareNoCase(GetExportType.ExportType, "Accounts Current") EQ 0>
			AND t1.AccountsCurrentExportDateTime IS NULL
		<CFELSEIF CompareNoCase(GetExportType.ExportType, "Non Cover All Data") EQ 0>
			AND t1.NonCoverAllExportDateTime IS NULL
		<CFELSE>
			AND t1.PremiumCodingExportDateTime IS NULL
		</CFIF>
		<CFIF VARIABLES.PositiveOnlyInd EQ 1>
			AND t1.GrossPremium > 0
		</CFIF>
	GROUP BY
		t1.TransactionID,
		t1.PolicySymbol,
		t1.PolicyNumber,
		t1.PolicyModuleNumber,
		t1.PreviousPolicyNumber,
		t1.PolicyEffectiveDate,
		t1.PolicyExpirationDate,
		t1.FirstName,
		t1.MiddleInitial,
		t1.LastName,
		t1.Address,
		t1.City,
		aig2_xState.Abbreviation,
		aig2_xState.stateTaxID,
		aig2_xState.SurplusLinesLicenseNumber,
		t1.ZipCode,
		t1.ZipCode2,
		t1.FEIN,
		t1.TransactionEffectiveDate,
		t1.TransactionExpirationDate,
		t1.TransactionCodeID,
		aig2_xTransactionCode.transaction,
		t1.GrossPremium,
		t1.Surcharge,
		t1.KyCollectionFee,
		t1.KyMunicipalTax,
		t1.LimitAmountPerClaim,
		t1.LimitAmountAggregate,
		t1.DeductibleAmountPerClaim,
		t1.DeductibleAmountAggregate,
		t1.CoverageSymbol,
		t1.PolicyRetroactiveDate,
		t1.InsuranceCompanyID,
		t1.NjSequenceNumber,
		t1.RiskLocationCode,
		t1.CreationDateTime,
		t2.TransactionID,
		t2.PolicySymbol,
		t2.PolicyNumber,
		t2.PolicyModuleNumber,
		t2.PreviousPolicyNumber,
		t2.PolicyEffectiveDate,
		t2.PolicyExpirationDate,
		t2.FirstName,
		t2.MiddleInitial,
		t2.LastName,
		t2.Address,
		t2.City,
		t2.ZipCode,
		t2.ZipCode2,
		t2.FEIN,
		t2.TransactionEffectiveDate,
		t2.TransactionExpirationDate,
		t2.TransactionCodeID,
		t2.GrossPremium,
		t2.Surcharge,
		t2.KyCollectionFee,
		t2.KyMunicipalTax,
		t2.LimitAmountPerClaim,
		t2.LimitAmountAggregate,
		t2.DeductibleAmountPerClaim,
		t2.DeductibleAmountAggregate,
		t2.CoverageSymbol,
		t2.PolicyRetroactiveDate,
		t2.InsuranceCompanyID ,
		t2.NjSequenceNumber,
		t2.RiskLocationCode,
		t2.CreationDateTime
		
	ORDER BY
		<!---t1.InsuranceCompanyID, t1.TransactionEffectiveDate ASC--->
		t1.policyNumber ASC
</CFQUERY>

