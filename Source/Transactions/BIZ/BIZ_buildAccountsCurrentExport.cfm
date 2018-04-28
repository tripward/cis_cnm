<!---
################################################################################
#
# Filename:		BIZ_buildAccountsCurrentExport.cfm
#
# Description:	Builds an Accounts Current export from the GetTransactions QRS
#
################################################################################
--->

<!--- Initialize variables --->
<CFSET VARIABLES.BuildExport = "">
<CFSET currInsuranceCompanyID = 0>
<CFSET accountCurrentSequenceNumber = 0>


<!--- Initialize grand total trailer variables --->
<CFSET grandTotalGrossPremium = 0>
<CFSET grandTotalSurcharge = 0>
<CFSET grandTotalCommission = 0>
<CFSET grandTotalNetPremium = 0>
<CFSET grandTotalRecordCount = 0>


<!--- Determine Account Current Date --->
<CFSET VARIABLES.AccountCurrentDate = VARIABLES.ExportDate>



<!--- Build Data Records --->
<CFLOOP FROM="1" TO="#GetTransactions.RecordCount#" INDEX="idx">
	<!--- Initialize trailer variables for new Insurance Company --->
	<CFIF GetTransactions.InsuranceCompanyID[idx] NEQ currInsuranceCompanyID>
		<CFSET currInsuranceCompanyID = GetTransactions.InsuranceCompanyID[idx]>
		<CFSET totalGrossPremium = 0>
		<CFSET totalSurcharge = 0>
		<CFSET totalCommission = 0>
		<CFSET totalNetPremium = 0>
		<CFSET totalRecordCount = 0>
		<CFSET accountCurrentSequenceNumber = accountCurrentSequenceNumber + 1>
	</CFIF>

	<!--- Build Insured Name - "Last, First MI" --->
	<CFSET InsuredName = Trim(GetTransactions.LastName[idx]) & ", ">
	<CFSET InsuredName = InsuredName & Trim(GetTransactions.FirstName[idx]) & " ">
	<CFIF Len(Trim(GetTransactions.MiddleInitial[idx])) NEQ 0>
		<CFSET InsuredName = InsuredName & Trim(GetTransactions.MiddleInitial[idx])>
	</CFIF>
	<CFSET InsuredName = Left(InsuredName, 35)>

	<!--- Build commission and net  --->
	<CFSET commission = GetTransactions.GrossPremium[idx] * stSystemConstants.commissionRate / 100>
	<CFSET commission = Round(commission * 100) / 100>
	<CFSET netPremium = GetTransactions.GrossPremium[idx] + GetTransactions.Surcharge[idx] - commission>
	<CFSET netPremium = Round(netPremium * 100) / 100>

	<!--- Total trailer and grand trailer record values --->
	<CFSET totalGrossPremium = totalGrossPremium + GetTransactions.GrossPremium[idx]>
	<CFSET grandTotalGrossPremium = grandTotalGrossPremium + GetTransactions.GrossPremium[idx]>
	<CFSET totalSurcharge = totalSurcharge + GetTransactions.Surcharge[idx]>
	<CFSET grandTotalSurcharge = grandTotalSurcharge + GetTransactions.Surcharge[idx]>
	<CFSET totalCommission = totalCommission + commission>
	<CFSET grandTotalCommission = grandTotalCommission + commission>
	<CFSET totalNetPremium = totalNetPremium + netPremium>
	<CFSET grandTotalNetPremium = grandTotalNetPremium + netPremium>
	<CFSET totalRecordCount = totalRecordCount + 1>
	<CFSET grandTotalRecordCount = grandTotalRecordCount + 1>


	<!--- If transaction is a "Tail", change code from 10 to 6 to meet AIG specs --->
	<CFIF GetTransactions.TransactionCodeID[idx] EQ 10>
		<CFSET GetTransactions.TransactionCodeID[idx] = 6>
	</CFIF>


	<!--- Build record --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.acFeedSequenceNumber, "0", "RIGHT", 3)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue("DT", "", "LEFT", 2)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.producerNumber, "0", "RIGHT", 9)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(VARIABLES.AccountCurrentDate, "YYYYMMDD"), "0", "RIGHT", 8)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(accountCurrentSequenceNumber, "0", "RIGHT", 4)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(GetTransactions.TransactionCodeID[idx], "0", "RIGHT", 2)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(GetTransactions.InsuranceCompanyID[idx], "0", "RIGHT", 3)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.acPolicySymbol, " ", "LEFT", 3)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(GetTransactions.PolicyNumber[idx], "0", "RIGHT", 9)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(InsuredName, " ", "LEFT", 35)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(GetTransactions.PolicyEffectiveDate[idx], "YYYYMMDD"), "0", "RIGHT", 8)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.lineOfBusiness, " ", "LEFT", 4)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(GetTransactions.TransactionEffectiveDate[idx], "YYYYMMDD"), "0", "RIGHT", 8)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(GetTransactions.TransactionExpirationDate[idx], "YYYYMMDD"), "0", "RIGHT", 8)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(GetTransactions.GrossPremium[idx] GTE 0, DE("+"), DE("-"))>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(GetTransactions.GrossPremium[idx]), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(GetTransactions.Surcharge[idx] GTE 0, DE("+"), DE("-"))>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(GetTransactions.Surcharge[idx]), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(stSystemConstants.commissionRate GTE 0, DE("+"), DE("-"))>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(stSystemConstants.commissionRate), "__._____"), ".", "", "ALL"), "0", "RIGHT", 7)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(commission GTE 0, DE("+"), DE("-"))>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(commission), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(netPremium GTE 0, DE("+"), DE("-"))>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(netPremium), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.premiumRecordType, " ", "LEFT", 1)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.adjustmentIndicator, " ", "LEFT", 1)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.aicoIndicator, " ", "LEFT", 1)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.aigrmContractNumber, "0", "RIGHT", 10)>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & RepeatString(" ", 97)>	<!--- Comments --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & RepeatString(" ", 20)>	<!--- Filler --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & CrLf>

	<!--- If end of query or new InsuranceCompanyID is coming up, attach trailer record --->
	<CFIF (GetTransactions.RecordCount EQ idx) OR (GetTransactions.InsuranceCompanyID[idx + 1] NEQ currInsuranceCompanyID)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.acfeedSequenceNumber, "0", "RIGHT", 3)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue("TR", "", "LEFT", 2)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.producerNumber, "0", "RIGHT", 9)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.divisionCode, "0", "RIGHT", 3)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(VARIABLES.AccountCurrentDate, "YYYYMMDD"), "0", "RIGHT", 8)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(accountCurrentSequenceNumber, "0", "RIGHT", 4)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.branchNumber, "0", "RIGHT", 3)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(totalGrossPremium GTE 0, DE("+"), DE("-"))>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(totalGrossPremium), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(totalSurcharge GTE 0, DE("+"), DE("-"))>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(totalSurcharge), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(totalCommission GTE 0, DE("+"), DE("-"))>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(totalCommission), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(totalNetPremium GTE 0, DE("+"), DE("-"))>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(totalNetPremium), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(totalRecordCount, "0", "RIGHT", 6)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & RepeatString(" ", 176)>	<!--- Comments --->
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & RepeatString(" ", 30)>	<!--- Filler --->
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & CrLf>
	</CFIF>
</CFLOOP>


<!--- Determine Grand Total Trailer Record sequence number --->
<CFIF accountCurrentSequenceNumber EQ 1>
	<CFSET gtAccountCurrentSequenceNumber = 1>
<CFELSE>
	<CFSET gtAccountCurrentSequenceNumber = 0>
</CFIF>

<!--- Build Grand Total Trailer Record --->
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.acfeedSequenceNumber, "0", "RIGHT", 3)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue("GT", "", "LEFT", 2)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.producerNumber, "0", "RIGHT", 9)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.divisionCode, "0", "RIGHT", 3)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(VARIABLES.AccountCurrentDate, "YYYYMMDD"), "0", "RIGHT", 8)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(gtAccountCurrentSequenceNumber, "0", "RIGHT", 4)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.branchNumber, "0", "RIGHT", 3)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(grandTotalGrossPremium GTE 0, DE("+"), DE("-"))>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(grandTotalGrossPremium), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(grandTotalSurcharge GTE 0, DE("+"), DE("-"))>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(grandTotalSurcharge), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(grandTotalCommission GTE 0, DE("+"), DE("-"))>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(grandTotalCommission), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & IIF(grandTotalNetPremium GTE 0, DE("+"), DE("-"))>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(grandTotalNetPremium), "___________.__"), ".", "", "ALL"), "0", "RIGHT", 13)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(grandTotalRecordCount, "0", "RIGHT", 6)>
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & RepeatString(" ", 176)>	<!--- Comments --->
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & RepeatString(" ", 30)>	<!--- Filler --->
<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & CrLf>

