<!---
################################################################################
#
# Filename:		ERR_exportAction.cfm
#
# Description:	Export Action validation
#
################################################################################
--->

<!--- Initialize Error variables --->
<CFSET arrErrors = ArrayNew(2)>
<CFSET cntErrors = 0>


<!--- Check that user selected a RangeInd --->
<CFIF FORM.RangeInd EQ -1>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "RangeInd">
	<CFSET arrErrors[2][cntErrors] = "Please choose a Transaction Range.">
</CFIF>

<CFIF FORM.RangeInd EQ 1>
	<!--- Check that user specified a RangeStartDate --->
	<CFIF Len(Trim(FORM.RangeStartDate)) EQ 0>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "RangeStartDate">
		<CFSET arrErrors[2][cntErrors] = "Please specify a Transaction Range Start Date.">
	<CFELSEIF NOT IsDate(FORM.RangeStartDate)>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "RangeStartDate">
		<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Range Start Date&quot; field must be a valid date.">
	</CFIF>

	<!--- Check that user specified a RangeEndDate --->
	<CFIF Len(Trim(FORM.RangeEndDate)) EQ 0>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "RangeEndDate">
		<CFSET arrErrors[2][cntErrors] = "Please specify a Transaction Range End Date.">
	<CFELSEIF NOT IsDate(FORM.RangeEndDate)>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "RangeEndDate">
		<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Range End Date&quot; field must be a valid date.">
	</CFIF>

	<!--- Check that user specified a RangeStartDate --->
	<CFIF (Len(Trim(FORM.RangeStartDate)) NEQ 0) AND (IsDate(FORM.RangeStartDate)) AND (Len(Trim(FORM.RangeEndDate)) NEQ 0) AND (IsDate(FORM.RangeEndDate)) AND (DateCompare(FORM.RangeStartDate, FORM.RangeEndDate) EQ 1)>
		<CFSET cntErrors = cntErrors + 1>
		<CFSET arrErrors[1][cntErrors] = "RangeEndDate">
		<CFSET arrErrors[2][cntErrors] = "Transaction Range End Date may not come before the Start Date.">
	</CFIF>
</CFIF>

<!--- Check that user selected one or more TransactionCodes --->
<CFIF Len(Trim(FORM.TransactionCodeID)) EQ 0>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "TransactionCodeID">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Transaction Code&quot; field is required.">
</CFIF>

<!--- Check that user selected ExportTypeID --->
<CFIF FORM.ExportTypeID EQ -1>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ExportTypeID">
	<CFSET arrErrors[2][cntErrors] = "The &quot;Export Type&quot; field is required.">
</CFIF>

<!--- Check that user selected an ActionInd --->
<CFIF FORM.ActionInd EQ -1>
	<CFSET cntErrors = cntErrors + 1>
	<CFSET arrErrors[1][cntErrors] = "ActionInd">
	<CFSET arrErrors[2][cntErrors] = "Please choose an Action.">
</CFIF>

