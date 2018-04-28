<!---
################################################################################
#
# Filename:		QRY_AddTransaction.cfm
#
# Description:	Inserts a Transaction into the database
#
################################################################################
--->

<!--- Check for required fields --->
<CFPARAM NAME="FORM.ClientID" TYPE="Numeric">
<CFPARAM NAME="FORM.LastName" TYPE="String">
<CFPARAM NAME="FORM.FirstName" TYPE="String" DEFAULT="">
<CFPARAM NAME="FORM.MiddleInitial" TYPE="String" DEFAULT="">
<CFPARAM NAME="FORM.BusinessName" TYPE="String" DEFAULT="">
<CFPARAM NAME="FORM.Address" TYPE="String">
<CFPARAM NAME="FORM.City" TYPE="String">
<CFPARAM NAME="FORM.StateID" TYPE="Numeric">
<CFPARAM NAME="FORM.CookCountyInd" DEFAULT="0" TYPE="Numeric">
<CFPARAM NAME="FORM.ZipCode" TYPE="String">
<CFPARAM NAME="FORM.ZipCode2" TYPE="String">
<CFPARAM NAME="FORM.FEIN" TYPE="String" DEFAULT="">
<CFPARAM NAME="FORM.TransactionCodeID" TYPE="Numeric">
<CFPARAM NAME="FORM.TransactionEffectiveDate" TYPE="Date">
<CFPARAM NAME="FORM.TransactionExpirationDate" TYPE="Date">
<CFPARAM NAME="FORM.GrossPremium" TYPE="Numeric">
<CFPARAM NAME="FORM.Surcharge" TYPE="Numeric">
<CFPARAM NAME="FORM.KyCollectionFee" TYPE="Numeric">
<CFPARAM NAME="FORM.KyMunicipalTax" TYPE="Numeric">
<CFPARAM NAME="FORM.LimitAmountPerClaim" TYPE="Numeric">
<CFPARAM NAME="FORM.LimitAmountAggregate" TYPE="Numeric">
<CFPARAM NAME="FORM.DeductibleAmountPerClaim" TYPE="Numeric">
<CFPARAM NAME="FORM.DeductibleAmountAggregate" TYPE="Numeric">
<CFPARAM NAME="FORM.CoverageSymbol" TYPE="String">
<CFPARAM NAME="FORM.PolicySymbol" TYPE="String">
<CFPARAM NAME="FORM.PolicyNumber" TYPE="Numeric">
<CFPARAM NAME="FORM.PolicyModuleNumber" TYPE="Numeric">
<CFPARAM NAME="FORM.PreviousPolicyNumber" TYPE="Numeric">
<CFPARAM NAME="FORM.PolicyEffectiveDate" TYPE="Date">
<CFPARAM NAME="FORM.PolicyExpirationDate" TYPE="Date">
<CFPARAM NAME="FORM.PolicyRetroactiveDate" TYPE="Date">
<CFPARAM NAME="FORM.InsuranceCompanyID" TYPE="Numeric">
<CFPARAM NAME="FORM.NjSequenceNumber" DEFAULT="">
<CFPARAM NAME="FORM.RiskLocationCode" TYPE="String">
<CFPARAM NAME="FORM.PremiumCodingExportDateTimeInd" DEFAULT="0">
<CFPARAM NAME="FORM.AccountsCurrentExportDateTimeInd" DEFAULT="0">


<!--- Insert transaction into database --->
<CFQUERY NAME="AddTransaction" DATASOURCE="#stSiteDetails.DataSource#">
	INSERT INTO aig2_Transaction
	(
		ClientID,
		LastName,
		FirstName,
		MiddleInitial,
		BusinessName,
		Address,
		City,
		StateID,
		CookCountyInd,
		ZipCode,
		ZipCode2,
		FEIN,
		TransactionCodeID,
		TransactionEffectiveDate,
		TransactionExpirationDate,
		GrossPremium,
		Surcharge,
		KyCollectionFee,
		KyMunicipalTax,
		LimitAmountPerClaim,
		LimitAmountAggregate,
		DeductibleAmountPerClaim,
		DeductibleAmountAggregate,
		CoverageSymbol,
		PolicySymbol,
		PolicyNumber,
		PolicyModuleNumber,
		PreviousPolicyNumber,
		PolicyEffectiveDate,
		PolicyExpirationDate,
		PolicyRetroactiveDate,
		InsuranceCompanyID,
		NjSequenceNumber,
		RiskLocationCode,
		CreationDateTime,
		PremiumCodingExportDateTime,
		AccountsCurrentExportDateTime
	)
	VALUES
	(
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.ClientID#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.LastName#" MAXLENGTH="255">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.FirstName#" MAXLENGTH="255" NULL="#IIf(Len(Trim(FORM.FirstName)) EQ 0, DE("Yes"), DE("No"))#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.MiddleInitial#" MAXLENGTH="255" NULL="#IIf(Len(Trim(FORM.MiddleInitial)) EQ 0, DE("Yes"), DE("No"))#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.BusinessName#" MAXLENGTH="255" NULL="#IIf(Len(Trim(FORM.BusinessName)) EQ 0, DE("Yes"), DE("No"))#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.Address#" MAXLENGTH="35">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.City#" MAXLENGTH="18">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.StateID#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_BIT" VALUE="#FORM.CookCountyInd#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.ZipCode#" MAXLENGTH="5">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.ZipCode2#" MAXLENGTH="4">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.FEIN#" MAXLENGTH="9">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.TransactionCodeID#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#FORM.TransactionEffectiveDate#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#FORM.TransactionExpirationDate#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#FORM.GrossPremium#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#FORM.Surcharge#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#FORM.KyCollectionFee#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#FORM.KyMunicipalTax#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#FORM.LimitAmountPerClaim#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#FORM.LimitAmountAggregate#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#FORM.DeductibleAmountPerClaim#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_MONEY" VALUE="#FORM.DeductibleAmountAggregate#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.CoverageSymbol#" MAXLENGTH="4">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.PolicySymbol#" MAXLENGTH="3">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.PolicyNumber#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.PolicyModuleNumber#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.PreviousPolicyNumber#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#FORM.PolicyEffectiveDate#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#FORM.PolicyExpirationDate#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#FORM.PolicyRetroactiveDate#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#FORM.InsuranceCompanyID#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.NjSequenceNumber#" MAXLENGTH="5">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" VALUE="#FORM.RiskLocationCode#" MAXLENGTH="6">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#CreateODBCDateTime(Now())#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="1/1/1900" NULL="#IIf(FORM.PremiumCodingExportDateTimeInd EQ 0, DE("Yes"), DE("No"))#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="1/1/1900" NULL="#IIf(FORM.AccountsCurrentExportDateTimeInd EQ 0, DE("Yes"), DE("No"))#">
	)
</CFQUERY>



<!--- Insert transaction into database --->
<cfquery name="GetMaxTransactionID" datasource="#stSiteDetails.DataSource#">
	SELECT Max(TransactionID) AS MaxID
	FROM aig2_Transaction
</cfquery>

<cfset variables.TransactionID = GetMaxTransactionID.MaxID>

