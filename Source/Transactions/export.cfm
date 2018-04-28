<!---
################################################################################
#
# Filename:		export.cfm
#
# Description:	Export screen
#
################################################################################
--->

<!--- Set page details --->
<CFSET stPageDetails.Title = stPageDetails.Title & " Export">
<CFSET stPageDetails.CSS = "transactions_export.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">


<!--- Get look up data --->
<CFINCLUDE TEMPLATE="QRY/QRY_GetTransactionCodes.cfm">
<CFINCLUDE TEMPLATE="QRY/QRY_GetExportTypes.cfm">


<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.RangeInd" DEFAULT="0">
<CFPARAM NAME="FORM.RangeStartDate" DEFAULT="01/01/2000">
<CFPARAM NAME="FORM.RangeEndDate" DEFAULT="#DateFormat(Now(), "MM/DD/YYYY")#">
<CFPARAM NAME="FORM.TransactionCodeID" DEFAULT="#ValueList(GetTransactionCodes.TransactionCodeID)#">
<CFPARAM NAME="FORM.ExportTypeID" DEFAULT="-1">
<CFPARAM NAME="FORM.ActionInd" DEFAULT="0">
<CFPARAM NAME="FORM.PositiveOnlyInd" DEFAULT="0">


<CFIF Len(Trim(FORM.RangeEndDate)) EQ 0>
	<CFSET FORM.RangeEndDate = DateFormat(Now(), "MM/DD/YYYY")>
</CFIF>


<!--- Page contents --->
<CFOUTPUT>
<SCRIPT LANGUAGE="JavaScript">
<!--
	// Disables date range fields
	function disableDateRangeFields() {
		document.getElementById("RangeStartDate").disabled = true;
		document.getElementById("RangeEndDate").disabled = true;
	}

	// Enables date range fields
	function enableDateRangeFields() {
		document.getElementById("RangeStartDate").disabled = false;
		document.getElementById("RangeEndDate").disabled = false;
	}

	// Enable PositiveOnlyInd
	function enablePositiveOnlyInd() {
		var exportType = document.dForm.ExportTypeID.options[document.dForm.ExportTypeID.selectedIndex].text;

		if ( exportType == 'Premium Coding' ) {
			document.getElementById("PositiveOnlyInd").disabled = false;
			document.getElementById("PositiveOnlyIndLabel").disabled = false;
		} else {
			document.getElementById("PositiveOnlyInd").disabled = true;
			document.getElementById("PositiveOnlyIndLabel").disabled = true;
		}
	}
// -->
</SCRIPT>


<!--- Check for and display errors --->
<CFINCLUDE TEMPLATE="../Includes/displayErrors.cfm">


<DIV CLASS="Dialog" ID="dlgExport">
	<DIV CLASS="Title">Transaction Export</DIV>
	<DIV CLASS="Body">
		<FORM NAME="dForm" ACTION="exportAction.cfm" METHOD="Post">
			<FIELDSET ID="fsExportType">
				<LEGEND TITLE="Export Type">Export Type</LEGEND>

				<DIV CLASS="FormControl #UDF_isError("ExportTypeID")#">
					<LABEL FOR="ExportTypeID" ACCESSKEY="E" ID="ExportTypeIDLabel">Export Type:</LABEL>
					<SELECT NAME="ExportTypeID" ID="ExportTypeID" TABINDEX="1" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onChange="enablePositiveOnlyInd();">
						<OPTION VALUE="-1">-- Select --
						<CFLOOP QUERY="GetExportTypes">
							<CFIF GetExportTypes.ExportTypeID EQ FORM.ExportTypeID>
								<OPTION VALUE="#GetExportTypes.ExportTypeID#" SELECTED>#GetExportTypes.ExportType#
							<CFELSE>
								<OPTION VALUE="#GetExportTypes.ExportTypeID#">#GetExportTypes.ExportType#
							</CFIF>
						</CFLOOP>
					</SELECT>
				</DIV>
			</FIELDSET>

			<FIELDSET ID="fsTransactionRange">
				<LEGEND TITLE="Transaction Range">Transaction Range</LEGEND>

				<DIV CLASS="RadioControl #UDF_isError("RangeInd0")#">
					<INPUT TYPE="Radio" NAME="RangeInd" ID="RangeInd0" TABINDEX="2" VALUE="0" onFocus="activateLabel(this); disableDateRangeFields();" onBlur="deactivateLabel(this);" #IIf(FORM.RangeInd EQ 0, DE("CHECKED"), DE(""))#>
					<LABEL FOR="RangeInd0" ACCESSKEY="A" ID="RangeInd0Label">All new transactions</LABEL>
				</DIV>

				<DIV CLASS="RadioControl #UDF_isError("RangeInd1")#">
					<INPUT TYPE="Radio" NAME="RangeInd" ID="RangeInd1" TABINDEX="3" VALUE="1" onFocus="activateLabel(this); enableDateRangeFields();" onBlur="deactivateLabel(this);" #IIf(FORM.RangeInd EQ 1, DE("CHECKED"), DE(""))#>
					<LABEL FOR="RangeInd1" ACCESSKEY="D" ID="RangeInd1Label">New transactions effective between:</LABEL>

					<DIV CLASS="FormControl #UDF_isError("RangeStartDate")#">
						<LABEL FOR="RangeStartDate" ACCESSKEY="S" ID="RangeStartDateLabel">Start Date:</LABEL>
						<INPUT TYPE="Text" NAME="RangeStartDate" ID="RangeStartDate" MAXLENGTH="10" TABINDEX="4" VALUE="#FORM.RangeStartDate#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
					</DIV>

					<DIV CLASS="FormControl #UDF_isError("RangeEndDate")#">
						<LABEL FOR="RangeEndDate" ACCESSKEY="E" ID="RangeEndDateLabel">End Date:</LABEL>
						<INPUT TYPE="Text" NAME="RangeEndDate" ID="RangeEndDate" MAXLENGTH="10" TABINDEX="5" VALUE="#FORM.RangeEndDate#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
					</DIV>
				</DIV>

				<BR><BR><BR>

				<DIV CLASS="RadioControl #UDF_isError("PositiveOnlyInd")#">
					<INPUT TYPE="Checkbox" NAME="PositiveOnlyInd" ID="PositiveOnlyInd" TABINDEX="3" VALUE="1" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.PositiveOnlyInd EQ 1, DE("CHECKED"), DE(""))#>
					<LABEL FOR="PositiveOnlyInd" ACCESSKEY="P" ID="PositiveOnlyIndLabel" DISABLED>Only include transactions with positive premiums</LABEL>
				</DIV>
			</FIELDSET>

			<FIELDSET ID="fsTransactionCodes">
				<LEGEND TITLE="Transaction Codes">Transaction Code(s)</LEGEND>

				<DIV CLASS="FormControl #UDF_isError("TransactionCodeID")#">
					<LABEL FOR="TransactionCodeID" ACCESSKEY="C" ID="TransactionCodeIDLabel">Code(s):</LABEL>
					<SELECT NAME="TransactionCodeID" ID="TransactionCodeID" MULTIPLE SIZE="#GetTransactionCodes.RecordCount#" TABINDEX="9" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
						<CFLOOP QUERY="GetTransactionCodes">
							<CFIF GetTransactionCodes.TransactionCodeID EQ FORM.TransactionCodeID>
								<OPTION VALUE="#GetTransactionCodes.TransactionCodeID#" SELECTED>#GetTransactionCodes.TransactionCodeID#) #GetTransactionCodes.Transaction#
							<CFELSE>
								<OPTION VALUE="#GetTransactionCodes.TransactionCodeID#">#GetTransactionCodes.TransactionCodeID#) #GetTransactionCodes.Transaction#
							</CFIF>
						</CFLOOP>
					</SELECT>
				</DIV>
			</FIELDSET>

			<FIELDSET ID="fsAction">
				<LEGEND TITLE="Action">Action</LEGEND>

				<DIV CLASS="RadioControl #UDF_isError("ActionInd")#">
					<INPUT TYPE="Radio" NAME="ActionInd" ID="ActionInd0" TABINDEX="10" VALUE="0" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.ActionInd EQ 0, DE("CHECKED"), DE(""))#>
					<LABEL FOR="ActionInd0" ACCESSKEY="P" ID="ActionInd0Label">Preview/Edit Export</LABEL>
				</DIV>

				<DIV CLASS="RadioControl #UDF_isError("ActionInd")#">
					<INPUT TYPE="Radio" NAME="ActionInd" ID="ActionInd3" TABINDEX="11" VALUE="3" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.ActionInd EQ 3, DE("CHECKED"), DE(""))#>
					<LABEL FOR="ActionInd3" ACCESSKEY="D" ID="ActionInd3Label">Download to Excel</LABEL>
				</DIV>

				<DIV CLASS="RadioControl #UDF_isError("ActionInd")#">
					<INPUT TYPE="Radio" NAME="ActionInd" ID="ActionInd1" TABINDEX="12" VALUE="1" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.ActionInd EQ 1, DE("CHECKED"), DE(""))#>
					<LABEL FOR="ActionInd1" ACCESSKEY="D" ID="ActionInd1Label">Download as Text</LABEL>
				</DIV>

				<DIV CLASS="RadioControl #UDF_isError("ActionInd")#">
					<INPUT TYPE="Radio" NAME="ActionInd" ID="ActionInd2" TABINDEX="13" VALUE="2" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.ActionInd EQ 2, DE("CHECKED"), DE(""))#>
					<LABEL FOR="ActionInd2" ACCESSKEY="P" ID="ActionInd2Label">Send to AIG</LABEL>
				</DIV>
			</FIELDSET>

			<DIV ID="ButtonArray">
				<INPUT TYPE="Button" NAME="btnCancel" CLASS="Button" ID="btnCancel" VALUE="Cancel" TABINDEX="14" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='index.cfm';">
				<INPUT TYPE="Reset" NAME="btnReset" CLASS="Button" ID="btnReset" VALUE="Reset" TABINDEX="15" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);">
				<INPUT TYPE="Submit" NAME="btnSubmit" CLASS="Button" ID="btnSubmit" VALUE="Submit" TABINDEX="16" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);">
			</DIV>
		</FORM>
	</DIV>
</DIV>
</CFOUTPUT>


<!--- Ensure date fields are enabled/disabled as appropriate --->
<SCRIPT TYPE="text/javascript">
<!--
	var val = -1;

	for (i = 0; i < document.dForm.RangeInd.length; i++) {
		if (document.dForm.RangeInd[i].checked == true) {
			val = document.dForm.RangeInd[i].value;
		}
	}

	if (val == 0) {
		disableDateRangeFields();
	} else if (val == 1) {
		enableDateRangeFields();
	}

	enablePositiveOnlyInd();
// -->
</SCRIPT>


<CFINCLUDE TEMPLATE="../Includes/footer.cfm">

