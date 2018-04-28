<!---
################################################################################
#
# Filename:		archivedExports.cfm
#
# Description:	Displays list of archived exports
#
################################################################################
--->

<!--- Set page details --->
<CFSET stPageDetails.Title = stPageDetails.Title & " Archived Exports">
<CFSET stPageDetails.CSS = "transactions_archivedExports.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">


<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.ExportID" DEFAULT="0">
<CFPARAM NAME="FORM.ActionInd" DEFAULT="1">


<!--- Get archived exports --->
<CFINCLUDE TEMPLATE="QRY/QRY_GetExports.cfm">


<!--- Page contents --->
<CFOUTPUT>


<!--- JavaScript --->
<SCRIPT LANGUAGE="JavaScript">
<!--
	function setAction(ele) {
//		var idx = ele.selectedIndex;

//		if (idx != -1 ) {
//			var optText = ele.options[idx].text;
//			if ( optText.search(/(.*?)(Accounts Current)(.*?)/) != -1 ) {
//				document.getElementById("ActionInd2").disabled = false;
//				document.getElementById("ActionInd2Label").disabled = false;
//			} else {
//				document.getElementById("ActionInd2").disabled = true;
//				document.getElementById("ActionInd2Label").disabled = true;
//			}
//		}
	}
// -->
</SCRIPT>


<!--- Check for and display errors --->
<CFINCLUDE TEMPLATE="../Includes/displayErrors.cfm">


<DIV CLASS="Dialog" ID="dlgArchivedExports">
	<DIV CLASS="Title">Archived Exports</DIV>
	<DIV CLASS="Body">
		<FORM NAME="dForm" ACTION="archivedExportsAction.cfm" METHOD="Post">
			<P>
				Exports in gray have been backed out.  Exports in red are back
				out exports.
			</P>

			<FIELDSET ID="fsExport">
				<LEGEND TITLE="Export">Export</LEGEND>
				<DIV CLASS="FormControl #UDF_isError("ExportID")#">
					<LABEL FOR="ExportID" ACCESSKEY="E" ID="ExportIDLabel">Select Export:</LABEL>
					<SELECT NAME="ExportID" ID="ExportID" SIZE="8" TABINDEX="1" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onChange="setAction(this);">
						<CFLOOP QUERY="GetExports">
							<!--- Build display string --->
							<CFSET OptionText = "#DateFormat(GetExports.ExportDateTime, "mm/dd/yyyy")# &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; #GetExports.ExportType#">
							<CFIF CompareNoCase(GetExports.ExportType, "Premium Coding") EQ 0>
								<CFSET OptionText = OptionText & " &nbsp;">
							</CFIF>
							<CFSET OptionText = OptionText & " &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;">
							<CFIF GetExports.BackoutInd EQ 0>
								<CFSET OptionText = OptionText & " ">
							<CFELSE>
								<CFSET OptionText = OptionText & "-">
							</CFIF>
							<CFSET OptionText = OptionText & "#GetExports.NumTransactions# Transactions">
							

							<CFIF Len(Trim(GetExports.BackoutID)) NEQ 0>
								<CFSET Class = "disabled">
							<CFELSEIF GetExports.BackoutInd EQ 1>
								<CFSET Class = "negative">
							<CFELSE>
								<CFSET Class = "">
							</CFIF>

							<CFIF GetExports.ExportID EQ FORM.ExportID>
								<OPTION VALUE="#GetExports.ExportID#" CLASS="#Class#" SELECTED>#OptionText#
							<CFELSE>
								<OPTION VALUE="#GetExports.ExportID#" CLASS="#Class#">#OptionText#
							</CFIF>
						</CFLOOP>
					</SELECT>
				</DIV>
			</FIELDSET>

			<FIELDSET ID="fsAction">
				<LEGEND TITLE="Action">Action</LEGEND>

				<DIV CLASS="RadioControl #UDF_isError("ActionInd")#">
					<INPUT TYPE="Radio" NAME="ActionInd" ID="ActionInd1" TABINDEX="2" VALUE="1" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.ActionInd EQ 1, DE("CHECKED"), DE(""))#>
					<LABEL FOR="ActionInd1" ACCESSKEY="T" ID="ActionInd1Label">Download Export to Text</LABEL>
				</DIV>

				<DIV CLASS="RadioControl #UDF_isError("ActionInd")#">
					<INPUT TYPE="Radio" NAME="ActionInd" ID="ActionInd2" TABINDEX="3" VALUE="2" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.ActionInd EQ 2, DE("CHECKED"), DE(""))#>
					<LABEL FOR="ActionInd2" ACCESSKEY="M" ID="ActionInd2Label">Download Export to MS Excel</LABEL>
				</DIV>

				<DIV CLASS="RadioControl #UDF_isError("ActionInd")#">
					<INPUT TYPE="Radio" NAME="ActionInd" ID="ActionInd3" TABINDEX="4" VALUE="3" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.ActionInd EQ 3, DE("CHECKED"), DE(""))#>
					<LABEL FOR="ActionInd3" ACCESSKEY="B" ID="ActionInd3Label">Back Out Export</LABEL>
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


<SCRIPT LANGUAGE="JavaScript">
<!--
	setAction(document.getElementById("ExportID"));
// -->
</SCRIPT>


<CFINCLUDE TEMPLATE="../Includes/footer.cfm">

