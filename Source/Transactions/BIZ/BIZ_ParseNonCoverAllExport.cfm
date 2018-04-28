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
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].program_details = Mid(currEle, 1, 20)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Broker_Name = Mid(currEle, 21, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].C_policy_no = Mid(currEle, 31, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].C_Effective_Date = Mid(currEle, 40, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].C_Expiring_Date = Mid(currEle, 49, 9)>	
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Underwriter_Name = Mid(currEle, 58, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Major_Class_Code = Mid(currEle, 68, 4)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Cov_Basis = Mid(currEle, 72, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Retro_Date = Mid(currEle, 74, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].cm_step = Mid(currEle, 83, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].aqi = Mid(currEle, 88, 1)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].GWP = Mid(currEle, 89, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Occurrence_Limit = Mid(currEle, 99, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Occurrence_Limit_Factor = Mid(currEle, 109, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Aggregate_Limit = Mid(currEle, 114, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Deductible = Mid(currEle, 124, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Deductible_Factor = Mid(currEle, 134, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Agg_Deductible = Mid(currEle, 139, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Agg_Deductible_Factor = Mid(currEle, 149, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Attachment = Mid(currEle, 154, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Class_Code = Mid(currEle, 164, 6)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Risk_State = Mid(currEle, 170, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Risk_Territory = Mid(currEle, 172, 3)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Exposure_Base = Mid(currEle, 175, 7)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Exposure_Amount = Mid(currEle, 182, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Pro_Rata_Factor = Mid(currEle, 192, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Status_of_policy = Mid(currEle, 197, 1)>
	
</CFLOOP>

<!---<CFSET timeStamp = UDF_reverseDayOfYear(Mid(currEle, 41, 3), Mid(currEle, 42, 4))>
<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].GenerationTimeStamp = DateFormat(timeStamp, "mm/dd/yyyy") & " - " & Mid(currEle, 42, 2) & ":" & Mid(currEle, 42, 2) & ":" & Mid(currEle, 42, 2)>--->

<!--- Build Trailer Record --->
<cfset variables.lineNum = variables.lineNum + 1>
<cfset cnt = variables.lineNum>
<CFSET currEle = Trim(ListGetAt(VARIABLES.RawExport, TransactionCount, CrLf))>