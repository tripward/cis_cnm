<!---
################################################################################
#
# Filename:		dataEntryConfirmed.cfm
#
# Description:	Data Entry confirmation screen
#
################################################################################
--->

<CFSET stPageDetails.Title = stPageDetails.Title & " Data Entry Successful">
<CFSET stPageDetails.CSS = "dlgMessageBox.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">

<CFOUTPUT>
<DIV CLASS="Dialog" ID="dlgMessageBox">
	<DIV CLASS="Title">Data Entry Successful</DIV>
	<DIV CLASS="Body">
		<P>
			The transaction has been successfully saved to the database.  To
			add another transaction, press the "Data Entry" button.  To return to the
			Control Panel, press the "Control Panel" button.
		</P>

		<FORM>
			<DIV ID="ButtonArray">
				<INPUT TYPE="Button" NAME="btnDataEntry" CLASS="Button" ID="btnDataEntry" VALUE="Data Entry" TABINDEX="1" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='dataEntry.cfm';">
				<INPUT TYPE="Button" NAME="btnControlPanel" CLASS="Button" ID="btnControlPanel" VALUE="Control Panel" TABINDEX="2" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='index.cfm';">
			</DIV>
		</FORM>
	</DIV>
</DIV>
</CFOUTPUT>

<CFINCLUDE TEMPLATE="../Includes/footer.cfm">

