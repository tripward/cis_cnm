<!---
################################################################################
#
# Filename:		importAction.cfm
#
# Description:	Import Action page
#
################################################################################
--->


<!--- Upload file --->
<cffile action="upload" filefield="FileName" nameconflict="MakeUnique" destination="#GetTempDirectory()#">

<!--- Import contents of spreadsheet into query object --->
<cfspreadsheet action="read" src="#file.serverDirectory#\#file.serverFile#" query="qryExcel" headerRow="1" excludeHeaderRow="true" columnnames="LastName,FirstName,MiddleName,BusinessName,Address,City,State,County,Zip,Fein,TransactionCode,TransactionEffectiveDate,TransactionExpirationDate,GrossPremium,KyCollectionFee,KyMunicipalTax,LimitAmountPerClaim,LimitAmountAggregate,DeductibleAmountPerClaim,DeductibleAmountAggregate,PolicyNumber,PreviousPolicyNumber,PolicyEffectiveDate,PolicyExpirationDate,PolicyRetroactiveDate,InsuranceCompany,NjSequenceNumber,SpecialtyCoverages,CoverageSymbol,CoverageBasis,PayPlan">

<!--- Move/rename uploaded file --->
<cffile action="move" source="#file.serverDirectory#\#file.serverFile#" destination="#ExpandPath(".\Uploads\" & DateFormat(Now(), "yyyymmdd") & "_" & TimeFormat(Now(), "HHmmss") & "_Ams360Report.xlsx")#">


<!--- Get lookup values --->
<cfinclude template="QRY/QRY_GetTransactionCodes.cfm">
<cfinclude template="QRY/QRY_GetStates.cfm">
<cfinclude template="QRY/QRY_GetInsuranceCompanies.cfm">


<!--- Build lookup structs --->
<cfset states = StructNew()>
<cfloop query="GetStates">
	<cfset states[GetStates.Abbreviation] = GetStates.StateID>
</cfloop>


<!--- Preset constants --->
<cfset form.ZipCode2 = "0000">
<cfset form.CookCountyInd = 0>
<cfset form.Surcharge = 0>
<cfset form.PolicySymbol = "#stSystemConstants.acPolicySymbol#">
<cfset form.PolicyModuleNumber = 0>
<cfset form.PremiumCodingExportDateTimeInd = 0>
<cfset form.AccountsCurrentExportDateTimeInd = 0>


<!--- Initialize variables --->
<cfset ctr = 0>
<cfset errorInd = false>
<cfset errors = StructNew()>


<!--- Iterate over records --->
<cfloop query="qryExcel">
	<!--- Increment counter --->
	<cfset ctr = ctr + 1>


	<!--- Reset variables --->
	<cfset form.ClientID = "">
	<cfset form.LastName = "">
	<cfset form.FirstName = "">
	<cfset form.MiddleInitial = "">
	<cfset form.BusinessName = "">
	<cfset form.Address = "">
	<cfset form.City = "">
	<cfset form.StateID = "">
	<cfset form.ZipCode = "">
	<cfset form.FEIN = "">
	<cfset form.TransactionCodeID = "">
	<cfset form.TransactionEffectiveDate = "">
	<cfset form.TransactionExpirationDate = "">
	<cfset form.GrossPremium = "">
	<cfset form.KyCollectionFee = "">
	<cfset form.KyMunicipalTax = "">
	<cfset form.LimitAmountPerClaim = "">
	<cfset form.LimitAmountAggregate = "">
	<cfset form.DeductibleAmountPerClaim = "">
	<cfset form.DeductibleAmountAggregate = "">
	<cfset form.CoverageSymbol = "">
	<cfset form.PolicyNumber = "">
	<cfset form.PolicyModuleNumber = "0">
	<cfset form.PreviousPolicyNumber = "">
	<cfset form.PolicyEffectiveDate = "">
	<cfset form.PolicyExpirationDate = "">
	<cfset form.PolicyRetroactiveDate = "">
	<cfset form.InsuranceCompanyID = "">
	<cfset form.NJSequenceNumber = "">


	<!--- Set variables based on contents of current excel record --->
	<cfset form.LastName = Trim(ReplaceNoCase(qryExcel.LastName, ", M.D.", "", "ALL"))>
	<cfset form.FirstName = Trim(qryExcel.FirstName)>
	<cfset form.MiddleInitial = Trim(qryExcel.MiddleName)>
	<cfset form.BusinessName = qryExcel.BusinessName>
	<cfset form.Address = qryExcel.Address>
	<cfset form.City = qryExcel.City>
	<cfset form.StateID = states[qryExcel.State]>
	<cfset form.ZipCode = Replace(qryExcel.Zip, "'", "", "ALL")>
	<cfset form.FEIN = qryExcel.FEIN>

	<cfset form.TransactionCodeID = -2>
	<cfloop query="GetTransactionCodes">
		<cfif CompareNoCase(GetTransactionCodes.AmsCode, Left(qryExcel.TransactionCode, Len(GetTransactionCodes.AmsCode))) EQ 0>
			<cfset form.TransactionCodeID = GetTransactionCodes.TransactionCodeID>
		</cfif>
	</cfloop>

	<cfset form.TransactionEffectiveDate = DateFormat(qryExcel.TransactionEffectiveDate, "mm/dd/yyyy")>
	<cfset form.TransactionExpirationDate = DateFormat(qryExcel.TransactionExpirationDate, "mm/dd/yyyy")>
	<cfset form.GrossPremium = qryExcel.GrossPremium>
	<cfset form.KyCollectionFee = qryExcel.KyCollectionFee>
	<cfset form.KyMunicipalTax = qryExcel.KyMunicipalTax>
	<cfset form.LimitAmountPerClaim = Replace(qryExcel.LimitAmountPerClaim, ",", "", "ALL")>
	<cfset form.LimitAmountAggregate = Replace(qryExcel.LimitAmountAggregate, ",", "", "ALL")>
	<cfset form.DeductibleAmountPerClaim = Replace(DeductibleAmountPerClaim, ",", "", "ALL")>
	<cfset form.DeductibleAmountAggregate = Replace(qryExcel.DeductibleAmountAggregate, ",", "", "ALL")>
	<cfset form.CoverageSymbol = qryExcel.CoverageSymbol>
	<cfset form.PolicyNumber = Replace(qryExcel.PolicyNumber, "'", "", "ALL")>
	<cfset form.PreviousPolicyNumber = Replace(qryExcel.PreviousPolicyNumber, "'", "", "ALL")>
	<cfset form.PolicyEffectiveDate = DateFormat(qryExcel.PolicyEffectiveDate, "mm/dd/yyyy")>
	<cfset form.PolicyExpirationDate = DateFormat(qryExcel.PolicyExpirationDate, "mm/dd/yyyy")>
	<cfset form.PolicyRetroactiveDate = DateFormat(qryExcel.PolicyRetroactiveDate, "mm/dd/yyyy")>
	<cfset form.NJSequenceNumber = qryExcel.NJSequenceNumber>

	<!--- Set defaults --->
	<cfif Len(Trim(form.Surcharge)) EQ 0>
		<cfset form.Surcharge = 0>
	</cfif>
	<cfif Len(Trim(form.KyCollectionFee)) EQ 0>
		<cfset form.KyCollectionFee = 0>
	</cfif>
	<cfif Len(Trim(form.KyMunicipalTax)) EQ 0>
		<cfset form.KyMunicipalTax = 0>
	</cfif>
	<cfif Len(Trim(form.DeductibleAmountPerClaim)) EQ 0>
		<cfset form.DeductibleAmountPerClaim = 0>
	</cfif>
	<cfif Len(Trim(form.DeductibleAmountAggregate)) EQ 0>
		<cfset form.DeductibleAmountAggregate = 0>
	</cfif>
	<cfif Len(Trim(form.PreviousPolicyNumber)) EQ 0>
		<cfset form.PreviousPolicyNumber = "000000000">
	</cfif>

	<!--- Determine ClientID --->
	<cfinclude template="QRY/QRY_GetClientByName.cfm">
	<cfif GetClientByName.RecordCount EQ 1>
		<cfset form.ClientID = GetClientByName.ClientID>
		<cfset variables.ClientID = GetClientByName.ClientID>
	<cfelse>
		<cfset form.ClientID = 0>
		<cfset variables.ClientID = 0>
	</cfif>

	<!--- Determine InsuranceCompanyID --->
	<cfloop query="GetInsuranceCompanies">
		<cfif CompareNoCase(GetInsuranceCompanies.InsuranceCompany, qryExcel.InsuranceCompany) EQ 0>
			<cfset form.InsuranceCompanyID = GetInsuranceCompanies.InsuranceCompanyID>
		</cfif>
	</cfloop>

	<!--- Determine PolicyModuleNumber --->
	<cfinclude template="QRY/QRY_GetTransactionsByClientID.cfm">
	<cfif form.TransactionCodeID EQ 1>
		<cfset form.PolicyModuleNumber = 0>
	<cfelseif form.TransactionCodeID EQ 2>
		<cfif GetTransactionsByClientID.RecordCount EQ 0>
			<cfset form.PolicyModuleNumber = 0>
		<cfelse>
			<cfset form.PolicyModuleNumber = GetTransactionsByClientID.PolicyModuleNumber + 1>
		</cfif>
	<cfelse>
		<cfif GetTransactionsByClientID.RecordCount EQ 0>
			<cfset form.PolicyModuleNumber = 0>
		<cfelse>
			<cfset form.PolicyModuleNumber = GetTransactionsByClientID.PolicyModuleNumber>
		</cfif>
	</cfif>

	<!--- Validate current record --->
	<cfinclude template="ERR/ERR_dataEntryAction.cfm">

	<!--- If errors, add to struct --->
	<cfif cntErrors NEQ 0>
		<cfset errors[ctr] = StructNew()>
		<cfset errors[ctr].cntErrors = cntErrors>
		<cfset errors[ctr].arrErrors = arrErrors>

		<cfset errorInd = true>
	</cfif>
</cfloop>


<!--- If errors, redisplay form --->
<cfif errorInd>
	<cfinclude template="import.cfm">
<cfelse>
	<cftransaction>
	<cfloop query="qryExcel">
		<!--- Reset variables --->
		<cfset form.ClientID = "">
		<cfset form.LastName = "">
		<cfset form.FirstName = "">
		<cfset form.MiddleInitial = "">
		<cfset form.BusinessName = "">
		<cfset form.Address = "">
		<cfset form.City = "">
		<cfset form.StateID = "">
		<cfset variables.Abbreviation = qryExcel.State>
		<cfset variables.State = "">
		<cfset form.ZipCode = "">
		<cfset form.FEIN = "">
		<cfset form.TransactionCodeID = "">
		<cfset form.TransactionEffectiveDate = "">
		<cfset form.TransactionExpirationDate = "">
		<cfset form.GrossPremium = "">
		<cfset form.KyCollectionFee = "">
		<cfset form.KyMunicipalTax = "">
		<cfset form.LimitAmountPerClaim = "">
		<cfset form.LimitAmountAggregate = "">
		<cfset form.DeductibleAmountPerClaim = "">
		<cfset form.DeductibleAmountAggregate = "">
		<cfset form.CoverageSymbol = "">
		<cfset form.PolicyNumber = "">
		<cfset form.PolicyModuleNumber = "0">
		<cfset form.PreviousPolicyNumber = "">
		<cfset form.PolicyEffectiveDate = "">
		<cfset form.PolicyExpirationDate = "">
		<cfset form.PolicyRetroactiveDate = "">
		<cfset form.InsuranceCompanyID = "">
		<cfset form.NJSequenceNumber = "">

	
		<!--- Set variables based on contents of current excel record --->
		<cfset form.LastName = Trim(ReplaceNoCase(qryExcel.LastName, ", M.D.", "", "ALL"))>
		<cfset form.FirstName = Trim(qryExcel.FirstName)>
		<cfset form.MiddleInitial = Trim(qryExcel.MiddleName)>
		<cfset form.BusinessName = qryExcel.BusinessName>
		<cfset form.Address = qryExcel.Address>
		<cfset form.City = qryExcel.City>
		<cfset form.StateID = states[qryExcel.State]>
		<cfset variables.Abbreviation = qryExcel.State>
		<cfset variables.State = "">
		<cfset form.ZipCode = Replace(qryExcel.Zip, "'", "", "ALL")>
		<cfset form.FEIN = qryExcel.FEIN>
		<cfloop query="GetTransactionCodes">
			<cfif CompareNoCase(GetTransactionCodes.AmsCode, Left(qryExcel.TransactionCode, Len(GetTransactionCodes.AmsCode))) EQ 0>
				<cfset form.TransactionCodeID = GetTransactionCodes.TransactionCodeID>
			</cfif>
		</cfloop>
		<cfset form.TransactionEffectiveDate = DateFormat(qryExcel.TransactionEffectiveDate, "mm/dd/yyyy")>
		<cfset form.TransactionExpirationDate = DateFormat(qryExcel.TransactionExpirationDate, "mm/dd/yyyy")>
		<cfset form.GrossPremium = qryExcel.GrossPremium>
		<cfset form.KyCollectionFee = qryExcel.KyCollectionFee>
		<cfset form.KyMunicipalTax = qryExcel.KyMunicipalTax>
		<cfset form.LimitAmountPerClaim = Replace(qryExcel.LimitAmountPerClaim, ",", "", "ALL")>
		<cfset form.LimitAmountAggregate = Replace(qryExcel.LimitAmountAggregate, ",", "", "ALL")>
		<cfset form.DeductibleAmountPerClaim = Replace(DeductibleAmountPerClaim, ",", "", "ALL")>
		<cfset form.DeductibleAmountAggregate = Replace(qryExcel.DeductibleAmountAggregate, ",", "", "ALL")>
		<cfset form.CoverageSymbol = qryExcel.CoverageSymbol>
		<cfset form.PolicyNumber = Replace(qryExcel.PolicyNumber, "'", "", "ALL")>
		<cfset form.PreviousPolicyNumber = Replace(qryExcel.PreviousPolicyNumber, "'", "", "ALL")>
		<cfset form.PolicyEffectiveDate = DateFormat(qryExcel.PolicyEffectiveDate, "mm/dd/yyyy")>
		<cfset form.PolicyExpirationDate = DateFormat(qryExcel.PolicyExpirationDate, "mm/dd/yyyy")>
		<cfset form.PolicyRetroactiveDate = DateFormat(qryExcel.PolicyRetroactiveDate, "mm/dd/yyyy")>
		<cfset form.NJSequenceNumber = qryExcel.NJSequenceNumber>

		<!--- Check for Cook County --->
		<cfif ( (CompareNoCase(qryExcel.State, "IL") EQ 0) AND (CompareNoCase(form.City, "Chicago") EQ 0) ) AND ( (CompareNoCase(qryExcel.County, "Cook") EQ 0) OR (CompareNoCase(qryExcel.County, "Cook County") EQ 0) )>
			<cfset form.CookCountyInd = 1>
		<cfelse>
			<cfset form.CookCountyInd = 0>
		</cfif>

		<!--- Set defaults --->
		<cfif Len(Trim(form.Surcharge)) EQ 0>
			<cfset form.Surcharge = 0>
		</cfif>
		<cfif Len(Trim(form.KyCollectionFee)) EQ 0>
			<cfset form.KyCollectionFee = 0>
		</cfif>
		<cfif Len(Trim(form.KyMunicipalTax)) EQ 0>
			<cfset form.KyMunicipalTax = 0>
		</cfif>
		<cfif Len(Trim(form.DeductibleAmountPerClaim)) EQ 0>
			<cfset form.DeductibleAmountPerClaim = 0>
		</cfif>
		<cfif Len(Trim(form.DeductibleAmountAggregate)) EQ 0>
			<cfset form.DeductibleAmountAggregate = 0>
		</cfif>
		<cfif Len(Trim(form.PreviousPolicyNumber)) EQ 0>
			<cfset form.PreviousPolicyNumber = "000000000">
		</cfif>

		<!--- Determine ClientID --->
		<cfinclude template="QRY/QRY_GetClientByName.cfm">
		<cfif GetClientByName.RecordCount EQ 1>
			<cfset form.ClientID = GetClientByName.ClientID>
		<cfset variables.ClientID = GetClientByName.ClientID>
		<cfelse>
			<cfinclude template="QRY/QRY_GetMaxClientID.cfm">
			<cfset form.ClientID = variables.MaxClientID + 1>
			<cfset variables.ClientID = variables.MaxClientID + 1>
		</cfif>

		<!--- Determine InsuranceCompanyID --->
		<cfloop query="GetInsuranceCompanies">
			<cfif CompareNoCase(GetInsuranceCompanies.InsuranceCompany, qryExcel.InsuranceCompany) EQ 0>
				<cfset form.InsuranceCompanyID = GetInsuranceCompanies.InsuranceCompanyID>
			</cfif>
		</cfloop>

		<!--- Determine PolicyModuleNumber --->
		<cfinclude template="QRY/QRY_GetTransactionsByClientID.cfm">
		<cfif form.TransactionCodeID EQ 1>
			<cfset form.PolicyModuleNumber = 0>
		<cfelseif form.TransactionCodeID EQ 2>
			<cfif GetTransactionsByClientID.RecordCount EQ 0>
				<cfset form.PolicyModuleNumber = 0>
			<cfelse>
				<cfset form.PolicyModuleNumber = GetTransactionsByClientID.PolicyModuleNumber + 1>
			</cfif>
		<cfelse>
			<cfif GetTransactionsByClientID.RecordCount EQ 0>
				<cfset form.PolicyModuleNumber = 0>
			<cfelse>
				<cfset form.PolicyModuleNumber = GetTransactionsByClientID.PolicyModuleNumber>
			</cfif>
		</cfif>

		<!--- Get Risk Location Code --->
		<cfinclude template="BIZ/BIZ_GetRiskLocationCode.cfm">

		<!--- Add transaction to database --->
		<cfinclude template="QRY/QRY_AddTransaction.cfm">

		<!--- Maintain legacy data tables --->
		<cfinclude template="BIZ/BIZ_MaintainLegacyData.cfm">
	</cfloop>
	</cftransaction>

	<!--- Redirect to confirmation screen --->
	<cflocation url="importConfirmed.cfm" addtoken="No">
</cfif>




