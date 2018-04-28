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
	<!---<cfdump var='#VARIABLES.ParsedExport["Transaction_#TransactionCount#"]#' label="cgi" abort="false" top="3" />--->
	<!--- Policy Record --->
	<cfset variables.lineNum = variables.lineNum + 1>
	<CFSET cnt = ((transCnt - 1) * 3) + 1>
	<cfset cnt = variables.lineNum>
	<CFSET currEle = Trim(ListGetAt(VARIABLES.RawExport, cnt, CrLf))>
	<!---<cfdump var="#len(currEle)#" label="currEle" abort="true" top="3" />--->
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"]['Program Details'] = Mid(currEle, 1, 20)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Broker_Name = Mid(currEle, 21, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].C_policy_no = Mid(currEle, 31, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].C_Effective_Date = Mid(currEle, 40, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].C_Expiring_Date = Mid(currEle, 49, 9)>	
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Underwriter_Name = Mid(currEle, 58, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Major_Class_Code = Mid(currEle, 68, 4)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Cov_Basis = Mid(currEle, 72, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Retro_Date = Mid(currEle, 74, 9)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].CM_Step = Mid(currEle, 83, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].AQI = Mid(currEle, 88, 1)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].GWP = Mid(currEle, 89, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Occurrence_Limit = Mid(currEle, 99, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].ILF = Mid(currEle, 109, 16)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Aggregate_Limit = Mid(currEle, 125, 16)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Deductible = Mid(currEle, 135, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Deductible_Factor = Mid(currEle, 145, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Agg_Deductible = Mid(currEle, 150, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Agg_Deductible_Factor = Mid(currEle, 160, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].Attachment = Mid(currEle, 165, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"]['Class Code'] = Mid(currEle, 175, 6)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"]['Risk State'] = Mid(currEle, 181, 2)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"]['Risk Territory'] = Mid(currEle, 183, 3)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"]['Exposure Base'] = Mid(currEle, 186, 6)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"]['Exposure Amount'] = Mid(currEle, 193, 10)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"]['Pro Rata Factor'] = Mid(currEle, 202, 5)>
	<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"]['Status of policy'] = Mid(currEle, 207, 1)>
</CFLOOP>

<!---<CFSET timeStamp = UDF_reverseDayOfYear(Mid(currEle, 41, 3), Mid(currEle, 42, 4))>
<CFSET VARIABLES.ParsedExport["Transaction_#TransactionCount#"].GenerationTimeStamp = DateFormat(timeStamp, "mm/dd/yyyy") & " - " & Mid(currEle, 42, 2) & ":" & Mid(currEle, 42, 2) & ":" & Mid(currEle, 42, 2)>--->

<!--- Build Trailer Record --->
<cfset variables.lineNum = variables.lineNum + 1>
<cfset cnt = variables.lineNum>
<CFSET currEle = Trim(ListGetAt(VARIABLES.RawExport, TransactionCount, CrLf))>
