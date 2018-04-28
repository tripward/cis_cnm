<!---
################################################################################
#
# Filename:		BIZ_ParseAccountsCurrentExport.cfm
#
# Description:	Parses an AIG Accounts Current export to extract a set of transactions
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="VARIABLES.RawExport" TYPE="String">
<CFPARAM NAME="VARIABLES.NumTransactions" TYPE="Numeric">


<!--- Initialize variables --->
<CFSET VARIABLES.ParsedExport = StructNew()>
<CFSET TransactionCount = 0>


<!--- Get Insurance Companies and build straucture --->
<CFINCLUDE TEMPLATE="../QRY/QRY_GetInsuranceCompanies.cfm">
<CFSET strInsuranceCompanies = StructNew()>
<CFLOOP QUERY="GetInsuranceCompanies">
	<CFSET strInsuranceCompanies[GetInsuranceCompanies.InsuranceCompanyID] = GetInsuranceCompanies.InsuranceCompany>
</CFLOOP>


<!--- Parse Data Records --->
<CFLOOP FROM="1" TO="#ListLen(VARIABLES.RawExport, CrLf)#" INDEX="cnt">
	<CFSET currEle = Trim(ListGetAt(VARIABLES.RawExport, cnt, CrLf))>

	<!--- Only include Detail Records --->
	<CFIF CompareNoCase(Mid(currEle, 4, 2), "DT") EQ 0>
		<CFSET TransactionCount = TransactionCount + 1>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"] = StructNew()>

		<!--- Build record --->
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].FeedSequenceNumber = Mid(currEle, 1, 3)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].DetailRecordIndicator = Mid(currEle, 4, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].ProducerNumber = Mid(currEle, 6, 9)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].AccountCurrentDate = Mid(currEle, 15, 8)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].AccountCurrentSequenceNumber = Mid(currEle, 23, 4)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].TransactionCode = Mid(currEle, 27, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].CompanyNumber = Mid(currEle, 29, 3)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].CompanyName = strInsuranceCompanies[Int(Mid(currEle, 29, 3))]>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicySymbol = Mid(currEle, 32, 3)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyNumber = Mid(currEle, 35, 9)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].InsuredName = Trim(Mid(currEle, 44, 35))>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyEffectiveDate = Mid(currEle, 79, 8)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].LineOfBusiness = Mid(currEle, 87, 4)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].TransactionEffectiveDate = Mid(currEle, 91, 8)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].TransactionExpirationDate = Mid(currEle, 99, 8)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].GrossPremium = DollarFormat(Mid(currEle, 107, 12) & "." & Mid(currEle, 119, 2))>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Surcharge = DollarFormat(Mid(currEle, 121, 12) & "." & Mid(currEle, 133, 2))>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].CommissionRate = Mid(currEle, 135, 3) & "." & Mid(currEle, 138, 5)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].CommissionAmount = DollarFormat(Mid(currEle, 143, 12) & "." & Mid(currEle, 155, 2))>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].NetTransactionPremium = DollarFormat(Mid(currEle, 157, 12) & "." & Mid(currEle, 169, 2))>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PremiumRecordType = Mid(currEle, 171, 1)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].AdjustmentIndicator = Mid(currEle, 172, 1)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].aicoIndicator = Mid(currEle, 173, 1)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].aigrmContractNumber = Mid(currEle, 174, 10)>
	</CFIF>
</CFLOOP>


<!--- Build Grand Trailer Record --->
<CFSET currEle = Trim(ListGetAt(VARIABLES.RawExport, ListLen(VARIABLES.RawExport, CrLf), CrLf))>
<CFSET VARIABLES.ParsedExport.Trailer = StructNew()>

<CFSET VARIABLES.ParsedExport.Trailer.ProducerNumber = Mid(currEle, 6, 9)>
<CFSET VARIABLES.ParsedExport.Trailer.AccountCurrentDate = Mid(currEle, 18, 8)>
<CFSET VARIABLES.ParsedExport.Trailer.totalGrossPremium = DollarFormat(Mid(currEle, 33, 12) & "." & Mid(currEle, 45, 2))>
<CFSET VARIABLES.ParsedExport.Trailer.totalSurcharge = DollarFormat(Mid(currEle, 47, 12) & "." & Mid(currEle, 59, 2))>
<CFSET VARIABLES.ParsedExport.Trailer.totalCommissionAmount = DollarFormat(Mid(currEle, 61, 12) & "." & Mid(currEle, 73, 2))>
<CFSET VARIABLES.ParsedExport.Trailer.totalNetAmount = DollarFormat(Mid(currEle, 75, 12) & "." & Mid(currEle, 87, 2))>

