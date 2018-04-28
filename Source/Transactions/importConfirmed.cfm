<!---
################################################################################
#
# Filename:		importConfirmed.cfm
#
# Description:	Import confirmation screen
#
################################################################################
--->

<cfset stPageDetails.Title = stPageDetails.Title & " Import Successful">
<cfset stPageDetails.CSS = "dlgMessageBox.css">
<cfinclude template="../Includes/header.cfm">

<cfoutput>
<div class="Dialog" id="dlgMessageBox">
	<div class="Title">Import Successful</div>
	<div class="Body">
		<p>
			The import has been successfully saved to the database.  To
			perform another import, press the "Import" button.  To return to the
			Control Panel, press the "Control Panel" button.
		</p>

		<form>
			<div id="ButtonArray">
				<input type="Button" name="btnImport" class="Button" id="btnImport" value="Import" tabindex="1" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='import.cfm';">
				<input type="Button" name="btnControlPanel" class="Button" id="btnControlPanel" value="Control Panel" tabindex="2" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='index.cfm';">
			</div>
		</form>
	</div>
</div>
</cfoutput>

<cfinclude template="../Includes/footer.cfm">

