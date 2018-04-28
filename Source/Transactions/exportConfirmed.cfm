<!---
################################################################################
#
# Filename:		exportConfirmed.cfm
#
# Description:	Export confirmation screen
#
################################################################################
--->

<CFSET stPageDetails.Title = stPageDetails.Title & " Export Successful">
<CFSET stPageDetails.CSS = "dlgMessageBox.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">

<CFOUTPUT>
<DIV CLASS="Dialog" ID="dlgMessageBox">
	<DIV CLASS="Title">Export Successful</DIV>
	<DIV CLASS="Body">
		<P>
			The export has been successfully transmitted.  To compile another
			export, press the "Export" button.  To return to the Control Panel,
			press the "Control Panel" button.
		</P>

		<FORM>
			<DIV ID="ButtonArray">
				<INPUT TYPE="Button" NAME="btnExport" CLASS="Button" ID="btnExport" VALUE="Export" TABINDEX="1" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='export.cfm';">
				<INPUT TYPE="Button" NAME="btnControlPanel" CLASS="Button" ID="btnControlPanel" VALUE="Control Panel" TABINDEX="2" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='index.cfm';">
			</DIV>
		</FORM>
	</DIV>
</DIV>
</CFOUTPUT>

<CFINCLUDE TEMPLATE="../Includes/footer.cfm">

