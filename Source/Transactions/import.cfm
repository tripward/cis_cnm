<!---
################################################################################
#
# Filename:		import.cfm
#
# Description:	Import MS Excel report from AMS 360
#
################################################################################
--->

<!--- Set page details --->
<CFSET stPageDetails.Title = stPageDetails.Title & " Import from AMS 360">
<CFSET stPageDetails.CSS = "transactions_import.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">


<!--- Initialize form variable values --->


<!--- Page contents --->
<CFOUTPUT>
<script type="text/javascript">
<!--
	function validateForm() {
		var ele = document.getElementById('FileName');

		if (ele.value == '') {
			alert('Please specify a file to import before submitting the form.');
			return false;
		} else {
			return true;
		}
	}
// -->
</script>

<DIV CLASS="Dialog" ID="dlgImport">
	<DIV CLASS="Title">Import from AMS 360</DIV>
	<DIV CLASS="Body">
		<form name="dForm" action="importAction.cfm" method="Post" enctype="multipart/form-data">
			<!--- Check for and display errors --->
			<cfif (IsDefined("errorInd")) AND (errorInd)>
				<fieldset id="fsErrors">
					<legend title="Errors">Errors</legend>

					<p class="Error">
						The following errors were found during import.  Please correct the errors in the
						spreadsheet and re-import.
					</p>

					<div style="height: 10em; overflow: auto;">
						<table class="errorList">
							<tr class="header">
								<td>Record</td>
								<td>Error</td>
							</tr>

							<cfloop collection="#errors#" item="ele">
								<cfloop from="1" to="#ArrayLen(errors[ele].arrErrors[2])#" index="cnt">
									<tr>
										<td>#ele + 1#</td>
										<td>#errors[ele].arrErrors[2][cnt]#</td>
									</tr>
								</cfloop>
							</cfloop>
						</table>
					</div>
				</fieldset>
			</cfif>

			<fieldset id="fsFile">
				<legend title="Import File">Import File</legend>

				<div class="FormControl #UDF_isError("FileName")#">
					<label for="FileName" id="FileNameLabel">File:</label>
					<input type="file" name="FileName" ID="FileName" tabindex="1" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" />
				</div>
			</fieldset>


			<DIV ID="ButtonArray">
				<INPUT TYPE="Button" NAME="btnCancel" CLASS="Button" ID="btnCancel" VALUE="Cancel" TABINDEX="14" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='index.cfm';">
				<INPUT TYPE="Reset" NAME="btnReset" CLASS="Button" ID="btnReset" VALUE="Reset" TABINDEX="15" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);">
				<INPUT TYPE="Submit" NAME="btnSubmit" CLASS="Button" ID="btnSubmit" VALUE="Submit" TABINDEX="16" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="return validateForm();">
			</DIV>
		</FORM>
	</DIV>
</DIV>
</CFOUTPUT>


<CFINCLUDE TEMPLATE="../Includes/footer.cfm">

