<!---
################################################################################
#
# Filename:		exportSendToAIG.cfm
#
# Description:	Send Export To AIG confirmation screen
#
################################################################################
--->

<CFSET stPageDetails.Title = stPageDetails.Title & " Export Transmission Confirmation">
<CFSET stPageDetails.CSS = "dlgMessageBox.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">


<!--- Determine total premium --->
<CFIF IsDefined("FORM.TotalPremium")>
	<CFSET VARIABLES.TotalPremium = FORM.TotalPremium>
</CFIF>
<CFPARAM NAME="VARIABLES.TotalPremium" TYPE="Numeric">


<!--- Get Title Lookup data --->
<CFSET VARIABLES.ExportTypeID = FORM.ExportTypeID>
<CFINCLUDE TEMPLATE="QRY/QRY_GetExportType.cfm">

<CFSET VARIABLES.TransactionCodeID = FORM.TransactionCodeID>
<CFINCLUDE TEMPLATE="QRY/QRY_GetTransactionCodes.cfm">


<!--- Set Title --->
<CFIF CompareNoCase(GetExportType.ExportType, "Accounts Current") EQ 0>
	<CFSET VARIABLES.Title = "CNM account " & DateFormat(Now(), "yyyymmdd")>
<CFELSE>
	<CFSET VARIABLES.Title = "CNM premium " & DateFormat(Now(), "yyyymmdd")>
</CFIF>


<CFOUTPUT>
<DIV CLASS="Dialog" ID="dlgMessageBox">
	<DIV CLASS="Title">Export Transmission Confirmation</DIV>
	<DIV CLASS="Body">
		<P>
			Please confirm that you want to transmit the export titled
			"<B>#VARIABLES.Title#</B>" to
			"<B>#stSystemConstants.exportToAddress#</B>".  To
			cancel the transmission, press the "Cancel" button.  To complete the
			transmission, press the "Submit" button.
		</P>

		<FORM ACTION="exportSendToAIGAction.cfm" METHOD="Post">
			<INPUT TYPE="Hidden" NAME="RangeInd" VALUE="#FORM.RangeInd#">
			<INPUT TYPE="Hidden" NAME="RangeStartDate" VALUE="#FORM.RangeStartDate#">
			<INPUT TYPE="Hidden" NAME="RangeEndDate" VALUE="#FORM.RangeEndDate#">
			<INPUT TYPE="Hidden" NAME="TransactionCodeID" VALUE="#FORM.TransactionCodeID#">
			<INPUT TYPE="Hidden" NAME="ExportTypeID" VALUE="#FORM.ExportTypeID#">
			<INPUT TYPE="Hidden" NAME="BuildExport" VALUE="#Replace(VARIABLES.BuildExport, '"', "'", "ALL")#">
			<INPUT TYPE="Hidden" NAME="PositiveOnlyInd" VALUE="#FORM.PositiveOnlyInd#">
			<INPUT TYPE="Hidden" NAME="TotalPremium" VALUE="#VARIABLES.TotalPremium#">

			<DIV ID="ButtonArray">
				<INPUT TYPE="Button" NAME="btnCancel" CLASS="Button" ID="btnCancel" VALUE="Cancel" TABINDEX="1" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="history.go(-1);">
				<INPUT TYPE="Submit" NAME="btnSubmit" CLASS="Button" ID="btnSubmit" VALUE="Submit" TABINDEX="2" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);">
			</DIV>
		</FORM>
	</DIV>
</DIV>
</CFOUTPUT>

<CFINCLUDE TEMPLATE="../Includes/footer.cfm">
