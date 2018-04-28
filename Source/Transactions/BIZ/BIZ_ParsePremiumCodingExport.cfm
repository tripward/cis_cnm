<!---
################################################################################
#
# Filename:		BIZ_ParsePremiumCodingExport.cfm
#
# Description:	Parses an AIG Premium Coding export to extract a set of transactions
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="VARIABLES.RawExport" TYPE="String">
<CFPARAM NAME="VARIABLES.NumTransactions" TYPE="Numeric">


<!--- Initialize variables --->
<CFSET VARIABLES.ParsedExport = StructNew()>
<CFSET TransactionCount = 0>


<!--- Parse Data Records --->
<CFLOOP FROM="1" TO="#VARIABLES.NumTransactions#" INDEX="cnt">
	<CFSET currEle = Trim(ListGetAt(VARIABLES.RawExport, cnt, CrLf))>
	<CFSET TransactionCount = TransactionCount + 1>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"] = StructNew()>

	<!--- Build record --->
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicySymbol = Mid(currEle, 1, 3)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyNumber = Mid(currEle, 4, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyModuleNumber = Mid(currEle, 13, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PreviousPolicyNumber = Mid(currEle, 15, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].aiStartSubmissionNumber = Mid(currEle, 24, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].ascoCompanyNumber = Mid(currEle, 33, 3)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyEffectiveDate = Mid(currEle, 36, 8)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyExpirationDate = Mid(currEle, 44, 8)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].InsuredName = Trim(Mid(currEle, 52, 35))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Address = Trim(Mid(currEle, 87, 35))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].City = Trim(Mid(currEle, 122, 18))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].State = Mid(currEle, 140, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].ZipCode = Mid(currEle, 142, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].ZipCode2 = Mid(currEle, 147, 4)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].TransactionEffectiveDate = Mid(currEle, 151, 8)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].TransactionExpirationDate = Mid(currEle, 159, 8)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].TransactionCode = Mid(currEle, 167, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].CommissionRate = Mid(currEle, 169, 2) & "." & Mid(currEle, 171, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].GrossPremium = DollarFormat(Mid(currEle, 176, 12) & "." & Mid(currEle, 188, 2))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Surcharge = DollarFormat(Mid(currEle, 190, 12) & "." & Mid(currEle, 202, 2))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].KyCollectionFee = DollarFormat(Mid(currEle, 204, 12) & "." & Mid(currEle, 216, 2))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].KyMunicipalTax = DollarFormat(Mid(currEle, 218, 12) & "." & Mid(currEle, 230, 2))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].LimitAmountPerClaim = DollarFormat(Mid(currEle, 232, 9))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].LimitAmountAggregate = DollarFormat(Mid(currEle, 241, 9))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].DeductibleAmountPerClaim = DollarFormat(Mid(currEle, 250, 9))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].DeductibleAmountAggregate = DollarFormat(Mid(currEle, 259, 9))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyRetroactiveDate = Mid(currEle, 268, 8)>
</CFLOOP>


<!--- Build Trailer Record --->
<CFSET currEle = Trim(ListGetAt(VARIABLES.RawExport, TransactionCount + 1, CrLf))>
<CFSET VARIABLES.ParsedExport.Trailer = StructNew()>

<CFSET VARIABLES.ParsedExport.Trailer.ProducerNumber = Mid(currEle, 1, 9)>
<CFSET VARIABLES.ParsedExport.Trailer.TotalRecordCount = Mid(currEle, 10, 6)>
<CFSET VARIABLES.ParsedExport.Trailer.totalGrossPremium = DollarFormat(Mid(currEle, 16, 12) & "." & Mid(currEle, 28, 2))>
<CFSET VARIABLES.ParsedExport.Trailer.totalSurcharge = DollarFormat(Mid(currEle, 30, 12) & "." & Mid(currEle, 42, 2))>
<CFSET VARIABLES.ParsedExport.Trailer.totalKyCollectionFee = DollarFormat(Mid(currEle, 44, 12) & "." & Mid(currEle, 56, 2))>
<CFSET VARIABLES.ParsedExport.Trailer.totalKyMunicipalTax = DollarFormat(Mid(currEle, 58, 12) & "." & Mid(currEle, 70, 2))>

