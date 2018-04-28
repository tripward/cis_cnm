<!---
################################################################################
#
# Filename:		exportAction.cfm
#
# Description:	Export Action page
#
################################################################################
--->

<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.RangeInd" DEFAULT="-1">
<CFPARAM NAME="FORM.RangeStartDate" DEFAULT="">
<CFPARAM NAME="FORM.RangeEndDate" DEFAULT="">
<CFPARAM NAME="FORM.TransactionCodeID" DEFAULT="">
<CFPARAM NAME="FORM.ExportTypeID" DEFAULT="-1">
<CFPARAM NAME="FORM.ActionInd" DEFAULT="-1">
<CFPARAM NAME="FORM.PositiveOnlyInd" DEFAULT="0">
<!---Different reports need different date lengths, some 8, and some 9. The value is set if deffirent from default in the export type switch case--->
<!---Position Key First - year, Second - month, Third - day--->
<CFPARAM NAME="request.DateComponentStartPositions" DEFAULT="1,5,7">

<!--- Validate submitted data --->
<CFINCLUDE TEMPLATE="ERR/ERR_exportAction.cfm">

<cftry>
<!--- Display page or redirect user to new page --->
<CFIF cntErrors NEQ 0>
	<!--- Redisplay export form --->
	<CFINCLUDE TEMPLATE="export.cfm">
<CFELSE>
	<!--- Set FORM variables to local scope --->
	<CFSET VARIABLES.RangeInd = FORM.RangeInd>
	<CFIF FORM.RangeInd EQ 1>
		<CFSET VARIABLES.RangeStartDate = FORM.RangeStartDate>
		<CFSET VARIABLES.RangeEndDate = FORM.RangeEndDate>
	</CFIF>


	<CFSET VARIABLES.PositiveOnlyInd = FORM.PositiveOnlyInd>
	<CFSET VARIABLES.TransactionCodeID = FORM.TransactionCodeID>
	<CFSET VARIABLES.ExportTypeID = FORM.ExportTypeID>

	<!--- Build export --->
	<CFINCLUDE TEMPLATE="BIZ/BIZ_buildExport.cfm">


	<!--- Determine output mode and/or next step --->
	<CFSWITCH EXPRESSION="#FORM.ActionInd#">
		<!--- Preview/Edit --->
		<CFCASE VALUE="0">
			<CFSET FORM.ActionInd = 3>
			<CFINCLUDE TEMPLATE="exportPreview.cfm">
		</CFCASE>

		<!--- Download as text --->
		<CFCASE VALUE="1">
			<CFINCLUDE TEMPLATE="exportDownloadToText.cfm">
		</CFCASE>

		<!--- Send to AIG --->
		<CFCASE VALUE="2">
			<!--- Display confirmation page --->
			<CFINCLUDE TEMPLATE="exportSendToAIG.cfm">
		</CFCASE>

		<!--- Download to Excel --->
		<CFCASE VALUE="3">
			<!--- Parse raw export --->
			<CFSET VARIABLES.RawExport = VARIABLES.BuildExport>

			<!--- Determine type of export and send to appropriate parser --->
			<CFIF FORM.ExportTypeID EQ 2>
				<CFSET VARIABLES.NumTransactions = ListLen(VARIABLES.RawExport, CrLf)>
				<CFINCLUDE TEMPLATE="BIZ/BIZ_ParseAccountsCurrentExport.cfm">
				<CFSET VARIABLES.NumTransactions = TransactionCount>
				<CFSET columnList = "TransactionCode,PolicyNumber,InsuredName,TransactionEffectiveDate,GrossPremium">
				<CFINCLUDE TEMPLATE="exportDownloadToExcel.cfm">
			
			<CFELSEIF FORM.ExportTypeID EQ 3>
				
				<cfset request.DateComponentStartPositions = "2,6,8" />
				
				<CFSET VARIABLES.NumTransactions = ListLen(VARIABLES.RawExport, CrLf)>

				<CFINCLUDE TEMPLATE="BIZ/BIZ_ParseNonCoverAllExport.cfm">

				
				<!---<CFSET VARIABLES.NumTransactions = TransactionCount>--->
				<CFSET columnList = "Program_Details,Broker_Name,C_policy_no,C_Effective_Date,C_Expiring_Date,Underwriter_Name,Major_Class_Code,Cov_Basis,Retro_Date,CM_Step,AQI,GWP,Occurrence_Limit,Occurrence_Limit_Factor,Aggregate_Limit,Deductible,Deductible_Factor,Agg_Deductible,Agg_Deductible_Factor,Attachment,Class_Code,Risk_State,Risk_Territory,Exposure_Base,Exposure_Amount,Pro_Rata_Factor,Status_of_policy">
				<CFINCLUDE TEMPLATE="exportDownloadToExcel.cfm">
				
			<CFELSEIF FORM.ExportTypeID EQ 1>
				<cfset variables.NumTransactions = 0 >

				<cfloop list="#variables.RawExport#" index="exportCurrRow" delimiters="#CrLf#">
					<cfif compare(mid(exportCurrRow, 26, 1), "P") eq 0>
						<cfset variables.NumTransactions = variables.NumTransactions + 1>
					</cfif>
				</cfloop>

				<CFINCLUDE TEMPLATE="BIZ/BIZ_ParseNewPremiumCodingExport.cfm">
				<CFSET VARIABLES.NumTransactions = TransactionCount>
				<CFSET columnList = "TransactionCode,PolicyNumber,InsuredName,TransactionEffectiveDate,GrossPremium">
				<CFINCLUDE TEMPLATE="exportDownloadToExcel.cfm">
			</CFIF>
		</CFCASE>
	</CFSWITCH>
</CFIF>


	<cfcatch type="any" >

		<cfdump var="#cfcatch#" label="cfcatch" abort="true"  />
	</cfcatch>
	
</cftry>
