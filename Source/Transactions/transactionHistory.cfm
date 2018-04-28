<!---
################################################################################
#
# Filename:		transactionHistory.cfm
#
# Description:	Transaction History screen
#
################################################################################
--->

<!--- Set page details --->
<CFSET stPageDetails.Title = stPageDetails.Title & " Transaction History">
<CFSET stPageDetails.CSS = "transactions_transactionHistory.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">


<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.ClientID" DEFAULT="">
<CFPARAM NAME="FORM.LastName" DEFAULT="">


<!--- Page contents --->
<CFOUTPUT>
<SCRIPT LANGUAGE="JavaScript">
<!--
	// Performs a search by LastName
	function clientSearchByName() {
		var lastName = document.dForm.LastName.value;
		if (lastName == '') {
			alert('Please enter a Last Name');
			document.dForm.LastName.focus();
		} else {
			commChannel.document.location.href = '#stSiteDetails.BaseURL#/Transactions/BIZ/BIZ_GetClientByName.cfm?LastName=' + lastName;
		}
	}

	// Performs a search by ClientID based on the LastName selected from the Search Results dialog
	function clientSearchByNameAction(clientID) {
		hideSearchResults();
		document.dForm.ClientID.value = clientID;
	}

	// Displays the Search Results dialog
	function showSearchResults() {
		var obj = document.dForm.btnFillByName;
		var newX = findPosX(obj);
		var newY = findPosY(obj);

		if (document.getElementById) {
			document.getElementById('dlgSearchResults').style.display = 'block';
			document.getElementById('dlgSearchResults').style.top = newY + 'px';
			document.getElementById('dlgSearchResults').style.left = newX + 'px';
		} else {
			document.all.dlgSearchResults.style.display = 'block';
			document.all.dlgSearchResults.style.top = newY + 'px';
			document.all.dlgSearchResults.style.left = newX + 'px';
		}
	}

	// Hides the Search Results dialog
	function hideSearchResults() {
		if (document.getElementById) {
			document.getElementById('dlgSearchResults').style.display = 'none';
		} else {
			document.all.dlgSearchResults.style.display = 'none';
		}
	}

	// Finds x-coordinate for specified object
	function findPosX(obj) {
		var curleft = 0;
		if (obj.offsetParent)
		{
			while (obj.offsetParent)
			{
				curleft += obj.offsetLeft
				obj = obj.offsetParent;
			}
		}
		else if (obj.x)
			curleft += obj.x;
		return curleft;
	}

	// Finds y-coordinate for specified object
	function findPosY(obj) {
		var curtop = 0;
		if (obj.offsetParent)
		{
			while (obj.offsetParent)
			{
				curtop += obj.offsetTop
				obj = obj.offsetParent;
			}
		}
		else if (obj.y)
			curtop += obj.y;
		return curtop;
	}

	// Repurposes the enter key for the ClientID and LastName fields
	function onEnter(obj) {
		if (window.event && window.event.keyCode == 13) {
			var fieldName = obj.name;
	
			if (fieldName == 'ClientID') {
				document.dForm.submit();
				return false;
			} else if (fieldName == 'LastName') {
				clientSearchByName();
				return false;
			} else {
				return true;
			}
		}
	}

// -->
</SCRIPT>


<!--- Check for and display errors --->
<CFINCLUDE TEMPLATE="../Includes/displayErrors.cfm">


<DIV CLASS="Dialog" ID="dlgTransactionHistory">
	<DIV CLASS="Title">Transaction History</DIV>
	<DIV CLASS="Body">
		<FORM NAME="dForm" ID="dForm" ACTION="transactionHistoryAction.cfm" METHOD="Post">
			<P>
				Enter a ClientID in the <EM>Client ID</EM> field.  If unsure of
				the ClientID, you can search by last name by entering a complete
				or partial last name in the <EM>Last Name</EM> field and pressing
				the "..." button.  When ready to view the client's transaction
				history, press the "Submit" button.
			</P>

			<FIELDSET ID="fsClientInformation">
				<LEGEND TITLE="Client Information">Client Information</LEGEND>

				<DIV CLASS="FormControl #UDF_isError("ClientID")#">
					<LABEL FOR="ClientID" ACCESSKEY="C" ID="ClientIDLabel">Client ID:</LABEL>
					<INPUT TYPE="Text" NAME="ClientID" ID="ClientID" MAXLENGTH="10" SIZE="16" VALUE="#FORM.ClientID#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onKeyPress="return onEnter(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("LastName")#">
					<LABEL FOR="LastName" ACCESSKEY="L" ID="LastNameLabel">Last Name:</LABEL>
					<INPUT TYPE="Text" NAME="LastName" ID="LastName" MAXLENGTH="255" SIZE="16" VALUE="#FORM.LastName#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onKeyPress="return onEnter(this);">
					<INPUT TYPE="Button" NAME="btnFillByName" CLASS="Button" ID="btnFillByName" VALUE="..." onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="clientSearchByName();">
				</DIV>
			</FIELDSET>


			<DIV ID="ButtonArray">
				<INPUT TYPE="Button" NAME="btnCancel" CLASS="Button" ID="btnCancel" VALUE="Cancel" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='index.cfm';">
				<INPUT TYPE="Reset" NAME="btnReset" CLASS="Button" ID="btnReset" VALUE="Reset" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);">
				<INPUT TYPE="Submit" NAME="btnSubmit" CLASS="Button" ID="btnSubmit" VALUE="Submit" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);">
			</DIV>
		</FORM>
	</DIV>
</DIV>
</CFOUTPUT>


<DIV CLASS="Dialog" ID="dlgSearchResults">
	<DIV CLASS="Title">
		Search Results
		<SPAN CLASS="closeButton"><A HREF="" onClick="hideSearchResults(); return false;">X</A></SPAN>
	</DIV>
	<DIV CLASS="Body" ID="srBody">
	</DIV>
</DIV>



<DIV CLASS="Hidden">
	<IFRAME NAME="commChannel" FRAMEBORDER="1" HEIGHT="100" WIDTH="600"></IFRAME>
</DIV>


<CFINCLUDE TEMPLATE="../Includes/footer.cfm">
