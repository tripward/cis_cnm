<!---
################################################################################
#
# Filename:		archivedExportsParse.cfm
#
# Description:	Displays list of transactions in specified export
#
################################################################################
--->

<!--- Set page details --->
<CFSET stPageDetails.Title = stPageDetails.Title & " Archived Export Transactions">
<CFSET stPageDetails.CSS = "transactions_archivedExportsParse.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">


<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.ExportID" DEFAULT="0">
<CFPARAM NAME="FORM.TransactionLineNum" DEFAULT="0">

<CFIF IsDefined("URL.ExportID")>
	<CFSET FORM.ExportID = URL.ExportID>
</CFIF>


<!--- Get specified export --->
<CFSET VARIABLES.ExportID = FORM.ExportID>
<CFINCLUDE TEMPLATE="QRY/QRY_GetExport.cfm">


<!--- Parse raw export --->
<CFSET VARIABLES.RawExport = GetExport.Content>
<CFSET VARIABLES.NumTransactions = GetExport.NumTransactions>
<CFINCLUDE TEMPLATE="BIZ/BIZ_ParseExport.cfm">


<!--- Page contents --->
<CFOUTPUT>


<!--- Check for and display errors --->
<CFINCLUDE TEMPLATE="../Includes/displayErrors.cfm">


<DIV CLASS="Dialog" ID="dlgDialog">
	<DIV CLASS="Title">Archived Export Transactions</DIV>
	<DIV CLASS="Body">
		<FORM NAME="dForm" ACTION="archivedExportsParseAction.cfm" METHOD="Post">
			<INPUT TYPE="Hidden" NAME="ExportID" VALUE="#FORM.ExportID#">

			<FIELDSET ID="fsTransactions">
				<LEGEND TITLE="Transactions">Transactions</LEGEND>
				<DIV CLASS="FormControl #UDF_isError("TransactionLineNum")#">
					<LABEL FOR="TransactionLineNum" ACCESSKEY="T" ID="TransactionLineNumLabel">Select Transaction:</LABEL>
					<SELECT NAME="TransactionLineNum" ID="TransactionLineNum" SIZE="8" TABINDEX="1" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
						<CFLOOP FROM="1" TO="#VARIABLES.NumTransactions#" INDEX="cnt">
							<CFIF cnt EQ FORM.TransactionLineNum>
								<OPTION VALUE="#cnt#" SELECTED>#VARIABLES.ParsedExport["Transaction_#cnt#"].InsuredName#
							<CFELSE>
								<OPTION VALUE="#cnt#">#VARIABLES.ParsedExport["Transaction_#cnt#"].InsuredName#
							</CFIF>
						</CFLOOP>
					</SELECT>
				</DIV>
			</FIELDSET>

			<FIELDSET ID="fsExportTrailer">
				<LEGEND TITLE="Export Trailer">Export Trailer</LEGEND>
				<TABLE>
					<TR CLASS="oddRow">
						<TD CLASS="header">Producer Number:</TD>
						<TD>#VARIABLES.ParsedExport.Trailer.ProducerNumber#</TD>
					</TR>
					<TR CLASS="evenRow">
						<TD CLASS="header">Total Record Count:</TD>
						<TD>#VARIABLES.ParsedExport.Trailer.TotalRecordCount#</TD>
					</TR>
					<TR CLASS="oddRow">
						<TD CLASS="header">Total Gross Premium:</TD>
						<TD>#VARIABLES.ParsedExport.Trailer.TotalGrossPremium#</TD>
					</TR>
					<TR CLASS="evenRow">
						<TD CLASS="header">Total Surcharge:</TD>
						<TD>#VARIABLES.ParsedExport.Trailer.TotalSurcharge#</TD>
					</TR>
					<TR CLASS="oddRow">
						<TD CLASS="header">Total KY Collection Fee:</TD>
						<TD>#VARIABLES.ParsedExport.Trailer.TotalKyCollectionFee#</TD>
					</TR>
					<TR CLASS="evenRow">
						<TD CLASS="header">Total KY Municipal Tax:</TD>
						<TD>#VARIABLES.ParsedExport.Trailer.TotalKyMunicipalTax#</TD>
					</TR>
				</TABLE>
			</FIELDSET>

			<DIV ID="ButtonArray">
				<INPUT TYPE="Button" NAME="btnCancel" CLASS="Button" ID="btnCancel" VALUE="Cancel" TABINDEX="2" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='archivedExports.cfm';">
				<INPUT TYPE="Submit" NAME="btnSubmit" CLASS="Button" ID="btnSubmit" VALUE="Decode" TABINDEX="3" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);">
			</DIV>
		</FORM>
	</DIV>
</DIV>
</CFOUTPUT>


<CFINCLUDE TEMPLATE="../Includes/footer.cfm">

