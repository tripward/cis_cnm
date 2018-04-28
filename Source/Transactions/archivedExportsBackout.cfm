<!---
################################################################################
#
# Filename:		archivedExportsBackout.cfm
#
# Description:	Back Out Export confirmation screen
#
################################################################################
--->

<CFSET stPageDetails.Title = stPageDetails.Title & " Backout Export Confirmation">
<CFSET stPageDetails.CSS = "dlgMessageBox.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">


<!--- Check for required variables --->
<CFPARAM NAME="VARIABLES.ExportID" TYPE="Numeric">


<!--- Get export data --->
<CFINCLUDE TEMPLATE="QRY/QRY_GetExport.cfm">


<CFOUTPUT>
<DIV CLASS="Dialog" ID="dlgMessageBox">
	<DIV CLASS="Title">Backout Export Confirmation</DIV>
	<DIV CLASS="Body">
		<P>
			Please confirm that you want to backout the <B>#GetExport.ExportType#</B>
			export dated <B>#DateFormat(GetExport.ExportDateTime, "mm/dd/yyyy")#</B>.
			This will send the backed out export to AIG and will release the
			transactions in the database for another export.
		</P>

		<FORM ACTION="archivedExportsBackoutAction.cfm" METHOD="Post">
			<INPUT TYPE="Hidden" NAME="ExportID" VALUE="#VARIABLES.ExportID#">

			<DIV ID="ButtonArray">
				<INPUT TYPE="Button" NAME="btnCancel" CLASS="Button" ID="btnCancel" VALUE="Cancel" TABINDEX="1" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="history.go(-1);">
				<INPUT TYPE="Submit" NAME="btnSubmit" CLASS="Button" ID="btnSubmit" VALUE="Submit" TABINDEX="2" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);">
			</DIV>
		</FORM>
	</DIV>
</DIV>
</CFOUTPUT>

<CFINCLUDE TEMPLATE="../Includes/footer.cfm">

