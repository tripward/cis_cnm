<!---
################################################################################
#
# Filename:		exportPreview.cfm
#
# Description:	Export Preview screen.  Allows preview/edit of export contents
#
################################################################################
--->

<!--- Set page details --->
<CFSET stPageDetails.Title = stPageDetails.Title & " Export Preview">
<CFSET stPageDetails.CSS = "transactions_exportPreview.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">


<!--- Determine total premium --->
<CFIF IsDefined("FORM.TotalPremium")>
	<CFSET VARIABLES.TotalPremium = FORM.TotalPremium>
</CFIF>
<CFPARAM NAME="VARIABLES.TotalPremium" TYPE="Numeric">


<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.buildExport" DEFAULT="#VARIABLES.BuildExport#">
<CFPARAM NAME="FORM.ActionInd" DEFAULT="3">


<!--- Page contents --->
<CFOUTPUT>


<!--- Check for and display errors --->
<CFINCLUDE TEMPLATE="../Includes/displayErrors.cfm">


<DIV CLASS="Dialog" ID="dlgExportPreview">
	<DIV CLASS="Title">Preview Export</DIV>
	<DIV CLASS="Body">
		<FORM NAME="dForm" ACTION="exportPreviewAction.cfm" METHOD="Post">
			<INPUT TYPE="Hidden" NAME="RangeInd" VALUE="#FORM.RangeInd#">
			<INPUT TYPE="Hidden" NAME="RangeStartDate" VALUE="#FORM.RangeStartDate#">
			<INPUT TYPE="Hidden" NAME="RangeEndDate" VALUE="#FORM.RangeEndDate#">
			<INPUT TYPE="Hidden" NAME="TransactionCodeID" VALUE="#FORM.TransactionCodeID#">
			<INPUT TYPE="Hidden" NAME="ExportTypeID" VALUE="#FORM.ExportTypeID#">
			<INPUT TYPE="Hidden" NAME="PositiveOnlyInd" VALUE="#FORM.PositiveOnlyInd#">
			<INPUT TYPE="Hidden" NAME="TotalPremium" VALUE="#VARIABLES.TotalPremium#">

			<FIELDSET ID="fsExport">
				<LEGEND TITLE="Export">Export</LEGEND>
				<DIV CLASS="FormControl #UDF_isError("BuildExport")#">
					<LABEL FOR="BuildExport" ACCESSKEY="E" ID="BuildExportLabel">Export:</LABEL>
					<TEXTAREA NAME="BuildExport" ID="BuildExport" TABINDEX="1" ROWS="10" COLS="80" WRAP="off" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">#Replace(FORM.BuildExport, '"', "'", "ALL")#</TEXTAREA>
				</DIV>
			</FIELDSET>

			<FIELDSET ID="fsAction">
				<LEGEND TITLE="Action">Action</LEGEND>

				<DIV CLASS="RadioControl #UDF_isError("ActionInd")#">
					<INPUT TYPE="Radio" NAME="ActionInd" ID="ActionInd3" TABINDEX="2" VALUE="3" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.ActionInd EQ 3, DE("CHECKED"), DE(""))#>
					<LABEL FOR="ActionInd3" ACCESSKEY="D" ID="ActionInd3Label">Download to Excel</LABEL>
				</DIV>

				<DIV CLASS="RadioControl #UDF_isError("ActionInd")#">
					<INPUT TYPE="Radio" NAME="ActionInd" ID="ActionInd1" TABINDEX="3" VALUE="1" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.ActionInd EQ 1, DE("CHECKED"), DE(""))#>
					<LABEL FOR="ActionInd1" ACCESSKEY="D" ID="ActionInd1Label">Download as Text</LABEL>
				</DIV>

				<DIV CLASS="RadioControl #UDF_isError("ActionInd")#">
					<INPUT TYPE="Radio" NAME="ActionInd" ID="ActionInd2" TABINDEX="4" VALUE="2" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.ActionInd EQ 2, DE("CHECKED"), DE(""))#>
					<LABEL FOR="ActionInd2" ACCESSKEY="P" ID="ActionInd2Label">Send to AIG</LABEL>
				</DIV>
			</FIELDSET>

			<DIV ID="ButtonArray">
				<INPUT TYPE="Button" NAME="btnCancel" CLASS="Button" ID="btnCancel" VALUE="Cancel" TABINDEX="5" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='index.cfm';">
				<INPUT TYPE="Reset" NAME="btnReset" CLASS="Button" ID="btnReset" VALUE="Reset" TABINDEX="6" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);">
				<INPUT TYPE="Submit" NAME="btnSubmit" CLASS="Button" ID="btnSubmit" VALUE="Submit" TABINDEX="7" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);">
			</DIV>
		</FORM>
	</DIV>
</DIV>
</CFOUTPUT>


<CFINCLUDE TEMPLATE="../Includes/footer.cfm">
