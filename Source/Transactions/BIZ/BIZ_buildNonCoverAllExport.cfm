<!---
################################################################################
#
# Filename:		BIZ_buildNonCoverAllExport.cfm
#
# Description:	???
#
################################################################################
--->

<!--- Initialize variables --->
<CFSET VARIABLES.BuildExport = "">
<CFSET currInsuranceCompanyID = 0>

<!--- Determine Non Cover All Export Date --->
<CFSET VARIABLES.NonCoverAllExportDateTime = VARIABLES.ExportDate>
<!---<cfdump var="#GetTransactions#" label="cgi" abort="false" top="10" />--->
<!--- Build Data Records --->
<CFLOOP FROM="1" TO="#GetTransactions.RecordCount#" INDEX="idx">

	<!--- If transaction is a "Tail", change code from 10 to 6 to meet AIG specs --->
	<CFIF GetTransactions.newTransactionCodeID[idx] EQ 10>
		<CFSET GetTransactions.newTransactionCodeID[idx] = 6>
	</CFIF>
	
	<!--- Build record --->
	<!--- program details --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('#stSystemConstants.programName#', " ", "LEFT", 20)>
	<!--- broker name --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('#stSystemConstants.brokerName#', " ", "LEFT", 10)>
	<!--- PolicyNumber --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(GetTransactions.newPolicyNumber[idx], "0", "RIGHT", 9)>
	<!--- Policy Effective Date --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(GetTransactions.newPolicyEffectiveDate[idx], "YYYYMMDD"), "0", "RIGHT", 9)>
	<!--- Policy expiration date--->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(GetTransactions.newPolicyExpirationDate[idx], "YYYYMMDD"), "0", "RIGHT", 9)>
	<!--- underwriter --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('#left(stSystemConstants.surplusLinesAgentsName, 10)#', " ", "LEFT", 10)>
	<!--- Coverage Major Class ???? - CNM = 976, PSY & ANES = 978 --->
	<cfif listFind('CNM,ANES',stSystemConstants.acPolicySymbol)>
		<cfset request.classcode = '976'>
	<cfelse>
		<cfset request.classcode = '978'>
	</cfif>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(request.classcode, "0", "RIGHT", 4)>
	<!--- coverage basis ???? - CNM & ANES are always CM. PSY can be either one and is defined as a property of the transaction --->
	<cfif listFind('CNM,ANES',stSystemConstants.acPolicySymbol)>
		<cfset request.cov_basis = 'CM'>
	<cfelse>
		<cfset request.cov_basis = 'OC'>
	</cfif>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(request.cov_basis, " ", "RIGHT", 2)>
	<!--- Retro_Date --->
	<CFIF request.cov_basis IS 'CM'>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(GetTransactions.newPolicyRetroactiveDate[idx], "YYYYMMDD"), "0", "RIGHT", 9)>
	<CFELSE>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 9)>
	</CFIF>
	
	<!--- cm_step Only necessary if Claims-Made. --->
	<CFIF Len(Trim(GetTransactions.newCoverageSymbol)) EQ 0>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.coverageSymbol, " ", "RIGHT", 5)>
	<CFELSE>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(UDF_getCM_Step('#GetTransactions.newPolicyRetroactiveDate[idx]#', '#GetTransactions.newPolicyExpirationDate[idx]#'), " ", "RIGHT", 5)>
	</CFIF>
	
	<!---aqi --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 1)>
	<!---GrossPremium --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(GetTransactions.newGrossPremium[idx]), "_________"), ".", "", "ALL"), "0", "RIGHT", 10)>
	<!--- occurance limit --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(GetTransactions.newLimitAmountPerClaim[idx]), "_________"), ".", "", "ALL"), "0", "RIGHT", 10)>
	<!--- Occurrence_Limit_Factor 16--->
	<cfif listFind('PSY',stSystemConstants.acPolicySymbol)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('1.110', " ", "RIGHT", 16)>
	<cfelse>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(UDF_getILF(Abs(GetTransactions.newLimitAmountPerClaim[idx]),Abs(GetTransactions.newLimitAmountAggregate[idx])), " ", "RIGHT", 16)>
	</cfif>
	<!---Aggregate_Limit --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(GetTransactions.newLimitAmountAggregate[idx]), "_________"), ".", "", "ALL"), "0", "RIGHT", 10)>
	<!--- Deductible--->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 10)>
	<!--- Deductible_Factor --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 5)>
	<!--- Agg_Deductible --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 10)>
	<!--- Agg_Deductible_Factor --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 5)>
	<!--- Attachment --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 10)>
	<!--- Class Code --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('#request.classcode#', " ", "RIGHT", 6)>
	<!--- Risk State - aig2_Transaction.StateId mapped to aig2_xState for the state.  See lookup table on "Data" tab for apporpiate 2-digit code.--->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('#GetTransactions.stateTaxID[idx]#', "0", "RIGHT", 2)>
	<!--- Risk Territory --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 3)>
	<!--- Exposure Base --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('person', " ", "RIGHT", 6)>
	<!--- Exposure Amount --->
	<!---<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(GetTransactions.newLimitAmountAggregate[idx]), "_________.__"), ".", "", "ALL"), "0", "RIGHT", 10)>--->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('1', " ", "RIGHT", 10)>
	<!--- Pro Rata Factor --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 5)>
	<!--- Status of policy - New = N ; Renewal = R - aig2_Transaction.TransactionCodeId mapped to aig2_xTransactionCode for the transaction type.  Report should only include new and renewal policies--->
	<cfif GetTransactions.newtransactioncodeid[idx] IS '1'>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & 'N'>
	<cfelse>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & 'R'>
	</cfif>
	
	<!---<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & RepeatString(" ", 97)>--->	<!--- Comments --->
	<!---<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & RepeatString(" ", 20)>--->	<!--- Filler --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & CrLf>
	
	
	
	<!---START OLD RECORD--->
	<!--- program details --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('#stSystemConstants.programName#', " ", "LEFT", 20)>
	<!--- broker name --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('#stSystemConstants.brokerName#', " ", "LEFT", 10)>
	<!--- PolicyNumber --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(GetTransactions.oldPolicyNumber[idx], "0", "RIGHT", 9)>
	<!--- Policy Effective Date --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(GetTransactions.oldPolicyEffectiveDate[idx], "YYYYMMDD"), "0", "RIGHT", 9)>
	<!--- Policy expiration date--->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(GetTransactions.oldPolicyExpirationDate[idx], "YYYYMMDD"), "0", "RIGHT", 9)>
	<!--- underwriter --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('#left(stSystemConstants.surplusLinesAgentsName, 10)#', " ", "LEFT", 10)>
	<!--- Coverage Major Class ???? - CNM = 976, PSY & ANES = 978 --->
	<cfif listFind('CNM,ANES',stSystemConstants.acPolicySymbol)>
		<cfset request.classcode = '976'>
	<cfelse>
		<cfset request.classcode = '978'>
	</cfif>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(request.classcode, "0", "RIGHT", 4)>
	<!--- coverage basis ???? - CNM & ANES are always CM. PSY can be either one and is defined as a property of the transaction --->
	<cfif listFind('CNM,ANES',stSystemConstants.acPolicySymbol)>
		<cfset request.cov_basis = 'CM'>
	<cfelse>
		<cfset request.cov_basis = 'OC'>
	</cfif>
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(request.cov_basis, " ", "RIGHT", 2)>
	<!--- Retro_Date --->
	<CFIF request.cov_basis IS 'CM'>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(DateFormat(GetTransactions.oldPolicyRetroactiveDate[idx], "YYYYMMDD"), "0", "RIGHT", 9)>
	<CFELSE>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 9)>
	</CFIF>
	
	<!--- cm_step Only necessary if Claims-Made. --->
	<CFIF Len(Trim(GetTransactions.oldCoverageSymbol)) EQ 0>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(stSystemConstants.coverageSymbol, " ", "RIGHT", 5)>
	<CFELSE>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(UDF_getCM_Step('#GetTransactions.oldPolicyRetroactiveDate[idx]#', '#GetTransactions.oldPolicyExpirationDate[idx]#'), " ", "RIGHT", 5)>
	</CFIF>
	
	<!---aqi --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 1)>
	<!---GrossPremium --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(GetTransactions.oldGrossPremium[idx]), "_________"), ".", "", "ALL"), "0", "RIGHT", 10)>
	<!--- occurance limit --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(GetTransactions.oldLimitAmountPerClaim[idx]), "_________"), ".", "", "ALL"), "0", "RIGHT", 10)>
	<!--- Occurrence_Limit_Factor 16--->
	<cfif listFind('PSY',stSystemConstants.acPolicySymbol)>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('1.110', " ", "RIGHT", 16)>
	<cfelse>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(UDF_getILF(Abs(GetTransactions.oldLimitAmountPerClaim[idx]),Abs(GetTransactions.oldLimitAmountAggregate[idx])), " ", "RIGHT", 16)>
	</cfif>
	<!---Aggregate_Limit --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(GetTransactions.oldLimitAmountAggregate[idx]), "_________"), ".", "", "ALL"), "0", "RIGHT", 10)>
	<!--- Deductible--->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 10)>
	<!--- Deductible_Factor --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 5)>
	<!--- Agg_Deductible --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 10)>
	<!--- Agg_Deductible_Factor --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 5)>
	<!--- Attachment --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 10)>
	<!--- Class Code --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('#request.classcode#', " ", "RIGHT", 6)>
	<!--- Risk State - aig2_Transaction.StateId mapped to aig2_xState for the state.  See lookup table on "Data" tab for apporpiate 2-digit code.--->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('#GetTransactions.stateTaxID[idx]#', "0", "RIGHT", 2)>
	<!--- Risk Territory --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 3)>
	<!--- Exposure Base --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('person', " ", "RIGHT", 6)>
	<!--- Exposure Amount --->
	<!---<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue(Replace(NumberFormat(Abs(GetTransactions.oldLimitAmountAggregate[idx]), "_________.__"), ".", "", "ALL"), "0", "RIGHT", 10)>--->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('1', " ", "RIGHT", 10)>
	<!--- Pro Rata Factor --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & UDF_padValue('', " ", "RIGHT", 5)>
	<!--- Status of policy - New = N ; Renewal = R - aig2_Transaction.TransactionCodeId mapped to aig2_xTransactionCode for the transaction type.  Report should only include new and renewal policies--->
	<cfif GetTransactions.oldtransactioncodeid[idx] IS '1'>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & 'N'>
	<cfelse>
		<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & 'R'>
	</cfif>
	
	<!---<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & RepeatString(" ", 97)>--->	<!--- Comments --->
	<!---<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & RepeatString(" ", 20)>--->	<!--- Filler --->
	<CFSET VARIABLES.BuildExport = VARIABLES.BuildExport & CrLf>

</CFLOOP>
