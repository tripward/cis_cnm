<!---
################################################################################
#
# Filename:		BIZ_ParseNewPremiumCodingExport.cfm
#
# Description:	Parses an AIG Premium Coding export, in the new format, to
#				extract a set of transactions
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="VARIABLES.RawExport" TYPE="String">
<CFPARAM NAME="VARIABLES.NumTransactions" TYPE="Numeric">


<!--- Initialize variables --->
<CFSET VARIABLES.ParsedExport = StructNew()>
<CFSET TransactionCount = 0>


<!--- Build structure of all insurance companies --->
<CFINCLUDE TEMPLATE="../QRY/QRY_GetInsuranceCompanies.cfm">
<CFSET VARIABLES.InsuranceCompanies = StructNew()>
<CFLOOP QUERY="GetInsuranceCompanies">
	<CFSET VARIABLES.InsuranceCompanies[Int(GetInsuranceCompanies.InsuranceCompanyID)] = GetInsuranceCompanies.InsuranceCompany>
</CFLOOP>


<!--- Parse Data Records --->
<cfset variables.lineNum = 0>
<CFLOOP FROM="1" TO="#VARIABLES.NumTransactions#" INDEX="transCnt">
	<!--- Begin new record --->
	<CFSET TransactionCount = TransactionCount + 1>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"] = StructNew()>


	<!--- Policy Record --->
	<cfset variables.lineNum = variables.lineNum + 1>
	<CFSET cnt = ((transCnt - 1) * 3) + 1>
	<cfset cnt = variables.lineNum>
	<CFSET currEle = Trim(ListGetAt(VARIABLES.RawExport, cnt, CrLf))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].FeedSequenceNumber = Mid(currEle, 1, 3)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].ProducerNumber = Mid(currEle, 4, 9)>
	<CFSET timeStamp = UDF_reverseDayOfYear(Mid(currEle, 17, 3), Mid(currEle, 13, 4))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].GenerationTimeStamp = DateFormat(timeStamp, "mm/dd/yyyy") & " - " & Mid(currEle, 20, 2) & ":" & Mid(currEle, 22, 2) & ":" & Mid(currEle, 24, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicySymbol = Mid(currEle, 27, 3)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyNumber = Mid(currEle, 30, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].MasterCertAndDecNumber = Mid(currEle, 39, 11)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].LocationNumber = Mid(currEle, 50, 3)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyModuleNumber = Mid(currEle, 53, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].IssuingCompanyNumber = Mid(currEle, 55, 3)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].CompanyName = VARIABLES.InsuranceCompanies[Int(VARIABLES.ParsedExport["Transaction_#TransactionCount#"].IssuingCompanyNumber)]>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PreviousPolicyNumber = Mid(currEle, 58, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PreviousCertNumber = Mid(currEle, 67, 11)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyEffectiveDate = Mid(currEle, 78, 8)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyExpirationDate = Mid(currEle, 86, 8)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].InsuredName = Mid(currEle, 94, 35)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Address = Trim(Mid(currEle, 129, 35))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].City = Trim(Mid(currEle, 164, 18))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].State = Mid(currEle, 182, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].ZipCode = Mid(currEle, 184, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].ZipCode2 = Mid(currEle, 189, 4)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].EStartSubmissionNumber = Mid(currEle, 193, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].GrossPremium = DollarFormat(Mid(currEle, 202, 12) & "." & Mid(currEle, 214, 2))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].KyMunicipalTax = DollarFormat(Mid(currEle, 216, 12) & "." & Mid(currEle, 228, 2))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].KyStateSurcharge = DollarFormat(Mid(currEle, 230, 12) & "." & Mid(currEle, 242, 2))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Surcharge = DollarFormat(Mid(currEle, 244, 12) & "." & Mid(currEle, 256, 2))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].DirectBillAgencyBillIndicator = Mid(currEle, 258, 1)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].BranchNumber = Mid(currEle, 259, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].NjSurplusLinesLicenseNumber = Mid(currEle, 261, 14)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].NjSurplusLinesAgentsName = Mid(currEle, 275, 35)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].NjSurplusLinesAgentsAddress = Mid(currEle, 310, 35)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].NjSurplusLinesAgentsCity = Mid(currEle, 345, 18)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PayPlanCode = Mid(currEle, 363, 2)>


	<!--- Location Record --->
	<cfset variables.lineNum = variables.lineNum + 1>
	<CFSET cnt = ((transCnt - 1) * 3) + 2>
	<cfset cnt = variables.lineNum>
	<CFSET currEle = Trim(ListGetAt(VARIABLES.RawExport, cnt, CrLf))>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RiskLocationCode = Mid(currEle, 53, 6)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RiskStreetAddress = Mid(currEle, 59, 35)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RiskCity = Mid(currEle, 94, 18)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RiskState = Mid(currEle, 112, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RiskZipCode = Mid(currEle, 114, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RiskZipCode2 = Mid(currEle, 119, 4)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].NonNjSurplusLinesLicenseNumber = Mid(currEle, 123, 15)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].NonNjSurplusLinesLicenseState = Mid(currEle, 138, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].FEIN = Mid(currEle, 140, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].NonNjSurplusLinesAgentsName = Mid(currEle, 149, 35)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].NonNjSurplusLinesAgentsAddress = Mid(currEle, 184, 35)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].NonNjSurplusLinesAgentsCity = Mid(currEle, 219, 18)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].NonNjSurplusLinesAgentsState = Mid(currEle, 237, 2)>


	<!--- Coverage Record(s) --->
	<cfloop condition="#CompareNoCase(Mid(Trim(ListGetAt(VARIABLES.RawExport, variables.lineNum + 1, CrLf)), 26, 1), "C")# EQ 0">
		<!--- Adding support for multiple coverage records --->
		<cfset variables.lineNum = variables.lineNum + 1>
		<CFSET cnt = ((transCnt - 1) * 3) + 3>
		<cfset cnt = variables.lineNum>

		<CFSET currEle = Trim(ListGetAt(VARIABLES.RawExport, cnt, CrLf))>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].CoverageNumber = Mid(currEle, 53, 3)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].CoverageSymbol = Mid(currEle, 56, 4)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].CoverageMajorClass = Mid(currEle, 60, 3)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].TransactionEffectiveDate = Mid(currEle, 63, 8)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].TransactionExpirationDate = Mid(currEle, 71, 8)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].TransactionCode = Mid(currEle, 79, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].CommissionRate = Mid(currEle, 95, 2) & "." & Mid(currEle, 97, 5)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].LimitAmountPerClaim = Mid(currEle, 144, 9)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].LimitAmmountAggregate = Mid(currEle, 153, 9)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].DeductibleAmountPerClaim = Mid(currEle, 162, 9)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].DeductibleAmountAggregate = Mid(currEle, 171, 9)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyFormCode = Mid(currEle, 180, 1)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].TailDate = Mid(currEle, 181, 8)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RetroactiveDate = Mid(currEle, 189, 8)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].StatPlanNumber = Mid(currEle, 197, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RatingMonth = Mid(currEle, 199, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RatingYear = Mid(currEle, 201, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].TerrorismTypeCode = Mid(currEle, 203, 1)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].MgaTransaction = Mid(currEle, 204, 1)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].PolicyType = Mid(currEle, 206, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].BiLimitCode = Mid(currEle, 224, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].BiDeductibleCode = Mid(currEle, 226, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].MajorClass = Mid(currEle, 228, 4)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].ExposureBase = Mid(currEle, 232, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].ExposureAmount = Mid(currEle, 234, 7)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RateExperience = Mid(currEle, 253, 3)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RateSchedule = Mid(currEle, 256, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RatePackage = Mid(currEle, 258, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RateExpense = Mid(currEle, 260, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RateCommission = Mid(currEle, 262, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].RateDeductible = Mid(currEle, 264, 2)>
		<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].LimitedCoding = Mid(currEle, 271, 1)>
	</cfloop>
</CFLOOP>


<!--- Build Trailer Record --->
<cfset variables.lineNum = variables.lineNum + 1>
<CFSET cnt = (TransactionCount * 3) + 1>
<cfset cnt = variables.lineNum>
<CFSET currEle = Trim(ListGetAt(VARIABLES.RawExport, cnt, CrLf))>
<CFSET VARIABLES.ParsedExport.Trailer = StructNew()>

<CFSET VARIABLES.ParsedExport.Trailer.FeedSequenceNumber = Mid(currEle, 1, 3)>
<CFSET VARIABLES.ParsedExport.Trailer.ProducerNumber = Mid(currEle, 4, 9)>
<CFSET timeStamp = UDF_reverseDayOfYear(Mid(currEle, 17, 3), Mid(currEle, 13, 4))>
<CFSET VARIABLES.ParsedExport.Trailer.GenerationTimeStamp = DateFormat(timeStamp, "mm/dd/yyyy") & " - " & Mid(currEle, 20, 2) & ":" & Mid(currEle, 22, 2) & ":" & Mid(currEle, 24, 2)>
<CFSET VARIABLES.ParsedExport.Trailer.TotalRecordCount = Mid(currEle, 53, 6)>
<CFSET VARIABLES.ParsedExport.Trailer.totalGrossPremium = DollarFormat(Mid(currEle, 59, 12) & "." & Mid(currEle, 71, 2))>
<CFSET VARIABLES.ParsedExport.Trailer.totalKyMunicipalTax = DollarFormat(Mid(currEle, 73, 12) & "." & Mid(currEle, 85, 2))>
<CFSET VARIABLES.ParsedExport.Trailer.totalKyStateSurcharge = DollarFormat(Mid(currEle, 87, 12) & "." & Mid(currEle, 99, 2))>
<CFSET VARIABLES.ParsedExport.Trailer.totalSurcharge = DollarFormat(Mid(currEle, 101, 12) & "." & Mid(currEle, 113, 2))>

