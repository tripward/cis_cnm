<!---
################################################################################
#
# Filename:		dataEntry.cfm
#
# Description:	Data Entry screen
#
################################################################################
--->

<!--- Set page details --->
<CFSET stPageDetails.Title = stPageDetails.Title & " Data Entry">
<CFSET stPageDetails.CSS = "transactions_dataEntry.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">


<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.ClientID" DEFAULT="">
<CFPARAM NAME="FORM.LastName" DEFAULT="">
<CFPARAM NAME="FORM.FirstName" DEFAULT="">
<CFPARAM NAME="FORM.MiddleInitial" DEFAULT="">
<CFPARAM NAME="FORM.BusinessName" DEFAULT="">
<CFPARAM NAME="FORM.Address" DEFAULT="">
<CFPARAM NAME="FORM.City" DEFAULT="">
<CFPARAM NAME="FORM.StateID" DEFAULT="-1">
<CFPARAM NAME="FORM.CookCountyInd" DEFAULT="0">
<CFPARAM NAME="FORM.ZipCode" DEFAULT="">
<CFPARAM NAME="FORM.ZipCode2" DEFAULT="0000">
<CFPARAM NAME="FORM.FEIN" DEFAULT="">
<CFPARAM NAME="FORM.TransactionCodeID" DEFAULT="-1">
<CFPARAM NAME="FORM.TransactionEffectiveDate" DEFAULT="#DateFormat(Now(), "YYYYMMDD")#">
<CFPARAM NAME="FORM.TransactionExpirationDate" DEFAULT="#DateFormat(DateAdd("YYYY", 1, Now()), "YYYYMMDD")#">
<CFPARAM NAME="FORM.GrossPremium" DEFAULT="">
<CFPARAM NAME="FORM.Surcharge" DEFAULT="$0.00">
<CFPARAM NAME="FORM.KyCollectionFee" DEFAULT="$0.00">
<CFPARAM NAME="FORM.KyMunicipalTax" DEFAULT="$0.00">
<CFPARAM NAME="FORM.NJSequenceNumber" DEFAULT="">
<CFPARAM NAME="FORM.LimitAmountPerClaim" DEFAULT="$1,000,000">
<CFPARAM NAME="FORM.LimitAmountAggregate" DEFAULT="$3,000,000">
<CFPARAM NAME="FORM.DeductibleAmountPerClaim" DEFAULT="$0.00">
<CFPARAM NAME="FORM.DeductibleAmountAggregate" DEFAULT="$0.00">
<CFPARAM NAME="FORM.CoverageSymbol" DEFAULT="">
<CFPARAM NAME="FORM.PolicySymbol" DEFAULT="#stSystemConstants.acPolicySymbol#">
<CFPARAM NAME="FORM.PolicyNumber" DEFAULT="">
<CFPARAM NAME="FORM.PolicyModuleNumber" DEFAULT="0">
<CFPARAM NAME="FORM.PreviousPolicyNumber" DEFAULT="000000000">
<CFPARAM NAME="FORM.PolicyEffectiveDate" DEFAULT="#DateFormat(Now(), "YYYYMMDD")#">
<CFPARAM NAME="FORM.PolicyExpirationDate" DEFAULT="#DateFormat(DateAdd("YYYY", 1, Now()), "YYYYMMDD")#">
<CFPARAM NAME="FORM.PolicyRetroactiveDate" DEFAULT="">
<CFPARAM NAME="FORM.InsuranceCompanyID" DEFAULT="#stSystemConstants.defaultInsuranceCompanyID#">
<CFPARAM NAME="FORM.PremiumCodingExportDateTimeInd" DEFAULT="0">
<CFPARAM NAME="FORM.AccountsCurrentExportDateTimeInd" DEFAULT="0">


<!--- Get look up data --->
<CFINCLUDE TEMPLATE="QRY/QRY_GetTransactionCodes.cfm">
<CFINCLUDE TEMPLATE="QRY/QRY_GetStates.cfm">
<CFINCLUDE TEMPLATE="QRY/QRY_GetInsuranceCompanies.cfm">
<CFINCLUDE TEMPLATE="QRY/QRY_GetCoverageSymbols.cfm">
<cfinclude template="QRY/QRY_GetStateSurcharges.cfm">


<!--- Page contents --->
<CFOUTPUT>
<SCRIPT LANGUAGE="JavaScript">
	// Performs a search by ClientID
	function clientSearchByID() {
		var clientID = document.dForm.ClientID.value;
		if (clientID == '') {
			alert('Please enter a Client ID');
			document.dForm.ClientID.focus();
		} else {
			commChannel.document.location.href = '#stSiteDetails.BaseURL#/Transactions/BIZ/BIZ_GetClientByID.cfm?ClientID=' + clientID;
		}
	}

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
		clientSearchByID();
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
				clientSearchByID();
				return false;
			} else if (fieldName == 'LastName') {
				clientSearchByName();
				return false;
			} else {
				return true;
			}
		}
	}

	// Original Policy Module Number
	var originalPolicyModuleNumber = 0;

	// Disable/enable fields based on Transaction Code
	function disableFormFields() {
		// Define which fields are enabled/disabled by TransactionCode
		var arrFieldsByCode = new Array();
		// -- Select --
		arrFieldsByCode[0] = 'TransactionCodeID,btnCancel,btnReset';
		// 1) New Business
		arrFieldsByCode[1] = 'ClientID,btnFillByID,LastName,btnFillByName,FirstName,MiddleInitial,BusinessName,Address,City,StateID,ZipCode,ZipCode2,FEIN,CookCountyIndDiv,TransactionCodeID,TransactionEffectiveDate,TransactionExpirationDate,GrossPremium,Surcharge,KyCollectionFee,KyMunicipalTax,NJSequenceNumber,LimitAmountPerClaim,LimitAmountAggregate,DeductibleAmountPerClaim,DeductibleAmountAggregate,CoverageSymbol,PolicySymbol,PolicyNumber,PreviousPolicyNumber,PolicyEffectiveDate,PolicyExpirationDate,PolicyRetroactiveDate,InsuranceCompanyID,PremiumCodingExportDateTimeInd,AccountsCurrentExportDateTimeInd,btnCancel,btnReset,btnSubmit';
		// 2) Renewal Business
		arrFieldsByCode[2] = 'ClientID,btnFillByID,LastName,btnFillByName,FirstName,MiddleInitial,BusinessName,Address,City,StateID,ZipCode,ZipCode2,FEIN,CookCountyIndDiv,TransactionCodeID,TransactionEffectiveDate,TransactionExpirationDate,GrossPremium,Surcharge,KyCollectionFee,KyMunicipalTax,NJSequenceNumber,LimitAmountPerClaim,LimitAmountAggregate,DeductibleAmountPerClaim,DeductibleAmountAggregate,CoverageSymbol,PolicySymbol,PolicyModuleNumber,PreviousPolicyNumber,PolicyEffectiveDate,PolicyExpirationDate,InsuranceCompanyID,PremiumCodingExportDateTimeInd,AccountsCurrentExportDateTimeInd,btnCancel,btnReset,btnSubmit';
		// 5) Audits
		arrFieldsByCode[3] = 'TransactionCodeID,btnCancel,btnReset';
		// 6) Endorsements
		arrFieldsByCode[4] = 'ClientID,btnFillByID,LastName,btnFillByName,FirstName,MiddleInitial,BusinessName,Address,City,StateID,ZipCode,ZipCode2,FEIN,CookCountyIndDiv,TransactionCodeID,TransactionEffectiveDate,TransactionExpirationDate,GrossPremium,Surcharge,KyCollectionFee,KyMunicipalTax,NJSequenceNumber,LimitAmountPerClaim,LimitAmountAggregate,DeductibleAmountPerClaim,DeductibleAmountAggregate,CoverageSymbol,PolicyModuleNumber,PolicyEffectiveDate,PolicyExpirationDate,InsuranceCompanyID,PremiumCodingExportDateTimeInd,AccountsCurrentExportDateTimeInd,btnCancel,btnReset,btnSubmit';
		// 7) Flat Cancellations
		arrFieldsByCode[5] = 'ClientID,btnFillByID,LastName,btnFillByName,TransactionCodeID,TransactionEffectiveDate,TransactionExpirationDate,GrossPremium,Surcharge,KyCollectionFee,KyMunicipalTax,NJSequenceNumber,LimitAmountPerClaim,LimitAmountAggregate,DeductibleAmountPerClaim,DeductibleAmountAggregate,CoverageSymbol,PolicyModuleNumber,PolicyExpirationDate,PremiumCodingExportDateTimeInd,AccountsCurrentExportDateTimeInd,btnCancel,btnReset,btnSubmit';
		// 8) Short Rate Cancellations
		arrFieldsByCode[6] = 'ClientID,btnFillByID,LastName,btnFillByName,TransactionCodeID,TransactionEffectiveDate,TransactionExpirationDate,GrossPremium,Surcharge,KyCollectionFee,KyMunicipalTax,NJSequenceNumber,LimitAmountPerClaim,LimitAmountAggregate,DeductibleAmountPerClaim,DeductibleAmountAggregate,CoverageSymbol,PolicyModuleNumber,PolicyExpirationDate,InsuranceCompanyID,PremiumCodingExportDateTimeInd,AccountsCurrentExportDateTimeInd,btnCancel,btnReset,btnSubmit';
		// 9) Pro Rata Cancellations
		arrFieldsByCode[7] = 'ClientID,btnFillByID,LastName,btnFillByName,TransactionCodeID,TransactionEffectiveDate,TransactionExpirationDate,GrossPremium,Surcharge,KyCollectionFee,KyMunicipalTax,NJSequenceNumber,LimitAmountPerClaim,LimitAmountAggregate,DeductibleAmountPerClaim,DeductibleAmountAggregate,CoverageSymbol,PolicyModuleNumber,PolicyExpirationDate,PremiumCodingExportDateTimeInd,AccountsCurrentExportDateTimeInd,btnCancel,btnReset,btnSubmit';
		// 10) Tails
		arrFieldsByCode[8] = 'ClientID,btnFillByID,LastName,btnFillByName,TransactionCodeID,TransactionEffectiveDate,TransactionExpirationDate,GrossPremium,Surcharge,KyCollectionFee,KyMunicipalTax,NJSequenceNumber,LimitAmountPerClaim,LimitAmountAggregate,DeductibleAmountPerClaim,DeductibleAmountAggregate,CoverageSymbol,PolicyModuleNumber,PolicyExpirationDate,InsuranceCompanyID,PremiumCodingExportDateTimeInd,AccountsCurrentExportDateTimeInd,btnCancel,btnReset,btnSubmit';


		// Get Transaction Code index
		var tcIndex = document.getElementById('TransactionCodeID').selectedIndex;


		// Loop over form fields.  If field is in array list, enable it.
		if ( document.getElementById ) {
			formRoot = document.getElementById("dForm");
			formElements = formRoot.getElementsByTagName("*");

			for ( i=0; i < formElements.length; i++ ) {
				node = formElements[i];

				if ( (node.nodeName == "INPUT") || (node.nodeName == "SELECT") ) {
					if ( arrFieldsByCode[tcIndex].indexOf(node.id) == -1 ) {
						node.disabled = true;
						node.className += " disabled";
						if ( document.getElementById(node.id + "Label") ) {
							document.getElementById(node.id + "Label").className += " disabled";
						}
					} else {
						node.disabled = false;
						node.className = node.className.replace(" disabled", "");
						if ( document.getElementById(node.id + "Label") ) {
							document.getElementById(node.id + "Label").className = document.getElementById(node.id + "Label").className.replace(" disabled", "");
						}
					}
				}
			}
		}

		// Enable/disable KY and NJ fields
		disableKyFields();
		disableNjFields();
		checkSurcharge();
	}


	// Enable all fields for submission
	function enableFormFields() {
		// Define list of fields
		var fieldList = new Array('ClientID','btnFillByID','LastName','btnFillByName','FirstName','MiddleInitial','BusinessName','Address','City','StateID','ZipCode','ZipCode2','CookCountyIndDiv','FEIN','TransactionCodeID','TransactionEffectiveDate','TransactionExpirationDate','GrossPremium','Surcharge','KyCollectionFee','KyMunicipalTax','LimitAmountPerClaim','LimitAmountAggregate','DeductibleAmountPerClaim','DeductibleAmountAggregate','PolicySymbol','PolicyNumber','PolicyModuleNumber','PreviousPolicyNumber','PolicyEffectiveDate','PolicyExpirationDate','PolicyRetroactiveDate','InsuranceCompanyID','NJSequenceNumber');

		// Loop over form fields and enable
		if ( document.getElementById ) {
			for ( i=0; i < fieldList.length; i++ ) {
				node = fieldList[i];
				document.getElementById(node).disabled = false;
			}
		}
	}


	// Check field select and enable/disable KY fields
	function disableKyFields() {
<!---
		var stateEle = document.getElementById('StateID');
		var stateValue = stateEle[stateEle.selectedIndex].text;

		if ( stateValue != "KY" ) {
			document.getElementById("KyCollectionFee").disabled = true;
			document.getElementById("KyCollectionFee").className = document.getElementById("KyCollectionFee").className.replace(" disabled", "");
			document.getElementById("KyCollectionFee").className += " disabled";
			document.getElementById("KyCollectionFeeLabel").className = document.getElementById("KyCollectionFeeLabel").className.replace(" disabled", "");
			document.getElementById("KyCollectionFeeLabel").className += " disabled";
			document.getElementById("KyMunicipalTax").disabled = true;
			document.getElementById("KyMunicipalTax").className = document.getElementById("KyMunicipalTax").className.replace(" disabled", "");
			document.getElementById("KyMunicipalTax").className += " disabled";
			document.getElementById("KyMunicipalTaxLabel").className = document.getElementById("KyMunicipalTaxLabel").className.replace(" disabled", "");
			document.getElementById("KyMunicipalTaxLabel").className += " disabled";
		} else {
			document.getElementById("KyCollectionFee").disabled = false;
			document.getElementById("KyCollectionFee").className = document.getElementById("KyCollectionFee").className.replace(" disabled", "");
			document.getElementById("KyCollectionFeeLabel").className = document.getElementById("KyCollectionFeeLabel").className.replace(" disabled", "");
			document.getElementById("KyMunicipalTax").disabled = false;
			document.getElementById("KyMunicipalTax").className = document.getElementById("KyMunicipalTax").className.replace(" disabled", "");
			document.getElementById("KyMunicipalTaxLabel").className = document.getElementById("KyMunicipalTaxLabel").className.replace(" disabled", "");
		}
 --->
	}

	// Check field select and enable/disable NJ fields
	function disableNjFields() {
		var stateEle = document.getElementById('StateID');
		var stateValue = stateEle[stateEle.selectedIndex].text;

		if ( stateValue != "NJ" ) {
			document.getElementById("NJSequenceNumber").disabled = true;
			document.getElementById("NJSequenceNumber").className = document.getElementById("NJSequenceNumber").className.replace(" disabled", "");
			document.getElementById("NJSequenceNumber").className += " disabled";
			document.getElementById("NJSequenceNumberLabel").className = document.getElementById("NJSequenceNumberLabel").className.replace(" disabled", "");
			document.getElementById("NJSequenceNumberLabel").className += " disabled";
		} else {
			document.getElementById("NJSequenceNumber").disabled = false;
			document.getElementById("NJSequenceNumber").className = document.getElementById("NJSequenceNumber").className.replace(" disabled", "");
			document.getElementById("NJSequenceNumberLabel").className = document.getElementById("NJSequenceNumberLabel").className.replace(" disabled", "");
		}
	}

	// Check if State is IL and City is not Chicago
	function checkCounty() {
		var stateEle = document.getElementById('StateID');
		var stateValue = stateEle[stateEle.selectedIndex].text;
		var cityValue = document.getElementById('City').value;

		if ( (stateValue == "IL") && (cityValue.toUpperCase() != "CHICAGO") ) {
			document.getElementById("CookCountyIndDiv").className = document.getElementById("CookCountyIndDiv").className.replace(" Hidden", "");
			document.getElementById("fsClientInformation").style.paddingBottom = "0.5em";
		} else {
			document.getElementById("CookCountyInd").checked = false;
			document.getElementById("CookCountyIndDiv").className = document.getElementById("CookCountyIndDiv").className.replace(" Hidden", "");
			document.getElementById("CookCountyIndDiv").className += " Hidden";
			document.getElementById("fsClientInformation").style.paddingBottom = "2.3em";
		}
	}


	// Build array of state surcharges
	var stateSurcharges = new Array(#GetStateSurcharges.RecordCount#);
	<cfloop query="GetStateSurcharges">
		stateSurcharges[#GetStateSurcharges.CurrentRow - 1#] = new Array(2);
		stateSurcharges[#GetStateSurcharges.CurrentRow - 1#][0] = #GetStateSurcharges.StateID#;
		stateSurcharges[#GetStateSurcharges.CurrentRow - 1#][1] = #GetStateSurcharges.SurchargeID#;
	</cfloop>


	// Check field select and enable/disable appropriate surcharge fields
	function checkSurcharge() {
		var stateEle = document.getElementById('StateID');
		var stateValue = stateEle[stateEle.selectedIndex].value;

		// Iterate over state surcharges
		for ( i = 0; i < stateSurcharges.length; i++ ) {
			// Check if current surcharge matches selected state
			if ( stateValue == stateSurcharges[i][0] ) {

				// Match so enable/display appropriate surcharge field
				document.getElementById("Surcharge_" + stateSurcharges[i][1]).disabled = false;
				document.getElementById("Surcharge_" + stateSurcharges[i][1]).className = document.getElementById("Surcharge_" + stateSurcharges[i][1]).className.replace(/ disabled/g, "");
				document.getElementById("Surcharge_" + stateSurcharges[i][1] + "Label").className = document.getElementById("Surcharge_" + stateSurcharges[i][1] + "Label").className.replace(/ disabled/g, "");
				document.getElementById("Surcharge_" + stateSurcharges[i][1] + "Div").className = document.getElementById("Surcharge_" + stateSurcharges[i][1] + "Div").className.replace(" Hidden", "");

			} else {

				// No match so disable/hide appropriate surcharge field
				document.getElementById("Surcharge_" + stateSurcharges[i][1]).disabled = true;
				document.getElementById("Surcharge_" + stateSurcharges[i][1]).className = document.getElementById("Surcharge_" + stateSurcharges[i][1]).className.replace(/ disabled/g, "");
				document.getElementById("Surcharge_" + stateSurcharges[i][1]).className += " disabled";
				document.getElementById("Surcharge_" + stateSurcharges[i][1] + "Label").className = document.getElementById("Surcharge_" + stateSurcharges[i][1] + "Label").className.replace(/ disabled/g, "");
				document.getElementById("Surcharge_" + stateSurcharges[i][1] + "Label").className += " disabled";
				document.getElementById("Surcharge_" + stateSurcharges[i][1] + "Div").className = document.getElementById("Surcharge_" + stateSurcharges[i][1] + "Div").className.replace(" Hidden", "");
				document.getElementById("Surcharge_" + stateSurcharges[i][1] + "Div").className += " Hidden";

			}
		}
	}


	// Update Policy Module Number
	function updatePolicyModuleNumber() {
		var tcIndex = document.getElementById('TransactionCodeID').selectedIndex;
		var tcValue = document.getElementById('TransactionCodeID').options[tcIndex].value;
		var pmnEle = document.getElementById('PolicyModuleNumber');

		if (tcValue == 1) {
			pmnEle.value = 0;
		} else if (tcValue == 2) {
			pmnEle.value = parseInt(originalPolicyModuleNumber) + 1;
		} else {
			pmnEle.value = originalPolicyModuleNumber;
		}
	}

	// Update Liability Limit Aggregate based on Claim amount
	function updateLimits(ele) {
		var claimEle = document.getElementById('LimitAmountPerClaim');
		var claimValue = claimEle.value;
		var aggEle = document.getElementById('LimitAmountAggregate');
		var aggValue = aggEle.value;

		// Build limit combination database
		var limitArray = new Array();
		limitArray[0] = new Array();
		limitArray[0][0] = 100000;
		limitArray[0][1] = 300000;
		limitArray[1] = new Array();
		limitArray[1][0] = 200000;
		limitArray[1][1] = 600000;
		limitArray[2] = new Array();
		limitArray[2][0] = 250000;
		limitArray[2][1] = 750000;
		limitArray[3] = new Array();
		limitArray[3][0] = 300000;
		limitArray[3][1] = 900000;
		limitArray[4] = new Array();
		limitArray[4][0] = 500000;
		limitArray[4][1] = 1500000;
		limitArray[5] = new Array();
		limitArray[5][0] = 1000000;
		limitArray[5][1] = 3000000;
		limitArray[6] = new Array();
		limitArray[6][0] = 2000000;
		limitArray[6][1] = 6000000;


		// Only update claim field if it is changed
		if (ele.id == 'LimitAmountPerClaim') {
			// Update current claim value
			claimValue = claimValue.replace(/[$$\,\.]/g, "");
			claimValue = claimValue.replace(/[kK]/g, "000");
			claimValue = claimValue.replace(/[mM]/g, "000000");
			claimValue = parseInt(claimValue);

			// Update aggValue based on claimValue
			for (var i = 0; i < limitArray.length; i++) {
				if ( claimValue == limitArray[i][0] ) {
					aggValue = limitArray[i][1];
				}
			}

			// Update form field contents
			claimEle.value = dollarFormat(claimValue);
		}


		// Update current aggregate value
		aggValue = aggValue.toString().replace(/[$$\,\.]/g, "");
		aggValue = aggValue.replace(/[kK]/g, "000");
		aggValue = aggValue.replace(/[mM]/g, "000000");
		aggValue = parseInt(aggValue);

		// Update form field contents
		aggEle.value = dollarFormat(aggValue);
	}

	// Format amount with dollar sign and commas
	function dollarFormat(amt) {
		var fAmt = "$";
		var sAmt = amt.toString();
		var amtLen = sAmt.length;
		var pos = 0;

		// Get first few characters
		for ( var i = 0; i < amtLen % 3; i++ ) {
			fAmt = fAmt + sAmt.charAt(i);
			pos = i + 1;
		}

		// Get remaining triplets
		for ( var i = pos; i < amtLen; i = i + 3) {
			if ( i != 0 ) {
				fAmt = fAmt + ",";
			}
			fAmt = fAmt + sAmt.charAt(i) + sAmt.charAt(i + 1) + sAmt.charAt(i + 2);
		}

		return fAmt;
	}
</SCRIPT>


<!--- Check for and display errors --->
<CFINCLUDE TEMPLATE="../Includes/displayErrors.cfm">


<DIV CLASS="Dialog" ID="dlgDataEntry">
	<DIV CLASS="Title">Transaction Data Entry</DIV>
	<DIV CLASS="Body">
		<FORM NAME="dForm" ID="dForm" ACTION="dataEntryAction.cfm" METHOD="Post" onSubmit="enableFormFields();">
			<FIELDSET ID="fsClientInformation">
				<LEGEND TITLE="Client Information">Client Information</LEGEND>

				<DIV CLASS="FormControl #UDF_isError("ClientID")#">
					<LABEL FOR="ClientID" ACCESSKEY="C" ID="ClientIDLabel">Client ID:</LABEL>
					<INPUT TYPE="Text" NAME="ClientID" ID="ClientID" MAXLENGTH="10" SIZE="16" VALUE="#FORM.ClientID#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onKeyPress="return onEnter(this);">
					<INPUT TYPE="Button" NAME="btnFillByID" CLASS="Button" ID="btnFillByID" VALUE="..." onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="clientSearchByID();">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("LastName")#">
					<LABEL FOR="LastName" ACCESSKEY="L" ID="LastNameLabel">Last Name:</LABEL>
					<INPUT TYPE="Text" NAME="LastName" ID="LastName" MAXLENGTH="255" SIZE="16" VALUE="#FORM.LastName#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onKeyPress="return onEnter(this);">
					<INPUT TYPE="Button" NAME="btnFillByName" CLASS="Button" ID="btnFillByName" VALUE="..." onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="clientSearchByName();">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("FirstName")#">
					<LABEL FOR="FirstName" ACCESSKEY="F" ID="FirstNameLabel">First Name:</LABEL>
					<INPUT TYPE="Text" NAME="FirstName" ID="FirstName" MAXLENGTH="255" VALUE="#FORM.FirstName#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("MiddleInitial")#">
					<LABEL FOR="MiddleInitial" ACCESSKEY="I" ID="MiddleInitialLabel">Middle Initial:</LABEL>
					<INPUT TYPE="Text" NAME="MiddleInitial" ID="MiddleInitial" MAXLENGTH="3" VALUE="#FORM.MiddleInitial#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("BusinessName")#">
					<LABEL FOR="BusinessName" ACCESSKEY="B" ID="BusinessNameLabel">Business Name:</LABEL>
					<INPUT TYPE="Text" NAME="BusinessName" ID="BusinessName" MAXLENGTH="255" VALUE="#FORM.BusinessName#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("Address")#">
					<LABEL FOR="Address" ACCESSKEY="A" ID="AddressLabel">Address:</LABEL>
					<INPUT TYPE="Text" NAME="Address" ID="Address" MAXLENGTH="35" VALUE="#FORM.Address#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("City")#">
					<LABEL FOR="City" ACCESSKEY="C" ID="CityLabel">City:</LABEL>
					<INPUT TYPE="Text" NAME="City" ID="City" MAXLENGTH="18" VALUE="#FORM.City#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onChange="checkCounty();">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("StateID")#">
					<LABEL FOR="StateID" ACCESSKEY="S" ID="StateIDLabel">State:</LABEL>
					<SELECT NAME="StateID" ID="StateID" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onChange="disableKyFields(); disableNjFields(); checkCounty(); checkSurcharge();">
						<OPTION VALUE="-1">-- Select --
						<CFLOOP QUERY="GetStates">
							<CFIF GetStates.StateID EQ FORM.StateID>
								<OPTION VALUE="#GetStates.StateID#" SELECTED>#GetStates.Abbreviation#
							<CFELSE>
								<OPTION VALUE="#GetStates.StateID#">#GetStates.Abbreviation#
							</CFIF>
						</CFLOOP>
					</SELECT>
				</DIV>

				<DIV CLASS="RadioControl Hidden" ID="CookCountyIndDiv">
					<INPUT TYPE="Checkbox" NAME="CookCountyInd" ID="CookCountyInd" VALUE="1" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.CookCountyInd EQ 1, DE("Checked"), DE(""))#>
					<LABEL FOR="CookCountyInd" ACCESSKEY="" ID="CookCountyIndLabel">Cook County?</LABEL>
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("ZipCode")#">
					<LABEL FOR="ZipCode" ACCESSKEY="Z" ID="ZipCodeLabel">Zip Code:</LABEL>
					<INPUT TYPE="Text" NAME="ZipCode" ID="ZipCode" MAXLENGTH="5" VALUE="#FORM.ZipCode#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("ZipCode2")# Hidden">
					<LABEL FOR="ZipCode2" ACCESSKEY="2" ID="ZipCode2Label">Zip+4:</LABEL>
					<INPUT TYPE="Text" NAME="ZipCode2" ID="ZipCode2" MAXLENGTH="4" VALUE="#FORM.ZipCode2#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("FEIN")#">
					<LABEL FOR="FEIN" ACCESSKEY="" ID="FEINLabel">FEIN:</LABEL>
					<INPUT TYPE="Text" NAME="FEIN" ID="FEIN" MAXLENGTH="9" VALUE="#FORM.FEIN#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>
			</FIELDSET>

			<FIELDSET ID="fsTransactionInformation">
				<LEGEND TITLE="Transaction Information">Transaction Information</LEGEND>

				<DIV CLASS="FormControl #UDF_isError("TransactionCodeID")#">
					<LABEL FOR="TransactionCodeID" ACCESSKEY="" ID="TransactionCodeIDLabel">Code:</LABEL>
					<SELECT NAME="TransactionCodeID" ID="TransactionCodeID" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onChange="disableFormFields(); updatePolicyModuleNumber();">
						<OPTION VALUE="-1">-- Select --
						<CFLOOP QUERY="GetTransactionCodes">
							<CFIF GetTransactionCodes.TransactionCodeID EQ FORM.TransactionCodeID>
								<OPTION VALUE="#GetTransactionCodes.TransactionCodeID#" SELECTED>#GetTransactionCodes.TransactionCodeID#) #GetTransactionCodes.Transaction#
							<CFELSE>
								<OPTION VALUE="#GetTransactionCodes.TransactionCodeID#">#GetTransactionCodes.TransactionCodeID#) #GetTransactionCodes.Transaction#
							</CFIF>
						</CFLOOP>
					</SELECT>
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("TransactionEffectiveDate")#">
					<LABEL FOR="TransactionEffectiveDate" ACCESSKEY="" ID="TransactionEffectiveDateLabel">Effective Date:</LABEL>
					<INPUT TYPE="Text" NAME="TransactionEffectiveDate" ID="TransactionEffectiveDate" MAXLENGTH="8" VALUE="#FORM.TransactionEffectiveDate#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("TransactionExpirationDate")#">
					<LABEL FOR="TransactionExpirationDate" ACCESSKEY="" ID="TransactionExpirationDateLabel">Expiration Date:</LABEL>
					<INPUT TYPE="Text" NAME="TransactionExpirationDate" ID="TransactionExpirationDate" MAXLENGTH="8" VALUE="#FORM.TransactionExpirationDate#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("GrossPremium")#">
					<LABEL FOR="GrossPremium" ACCESSKEY="" ID="GrossPremiumLabel">Gross Premium:</LABEL>
					<INPUT TYPE="Text" NAME="GrossPremium" ID="GrossPremium" MAXLENGTH="19" VALUE="#FORM.GrossPremium#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("Surcharge")# Hidden">
					<LABEL FOR="Surcharge" ACCESSKEY="" ID="SurchargeLabel">Surcharge:</LABEL>
					<INPUT TYPE="Text" NAME="Surcharge" ID="Surcharge" MAXLENGTH="19" VALUE="#FORM.Surcharge#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("KyCollectionFee")# Hidden" ID="divKyCollectionFee">
					<LABEL FOR="KyCollectionFee" ACCESSKEY="" ID="KyCollectionFeeLabel">KY Collection Fee:</LABEL>
					<INPUT TYPE="Text" NAME="KyCollectionFee" ID="KyCollectionFee" MAXLENGTH="19" VALUE="#FORM.KyCollectionFee#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("KyMunicipalTax")# Hidden" ID="divKyMunicipalTax">
					<LABEL FOR="KyMunicipalTax" ACCESSKEY="" ID="KyMunicipalTaxLabel">KY Municipal Tax:</LABEL>
					<INPUT TYPE="Text" NAME="KyMunicipalTax" ID="KyMunicipalTax" MAXLENGTH="19" VALUE="#FORM.KyMunicipalTax#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>


				<cfloop query="GetStateSurcharges">
					<cfparam name="form.Surcharge_#GetStateSurcharges.SurchargeID#" default="$0.00">
					<div class="FormControl #UDF_isError("Surcharge_#GetStateSurcharges.SurchargeID#")# Hidden" id="Surcharge_#GetStateSurcharges.SurchargeID#Div">
						<label for="Surcharge_#GetStateSurcharges.SurchargeID#" id="Surcharge_#GetStateSurcharges.SurchargeID#Label">#GetStateSurcharges.Surcharge#:</label>
						<input type="Text" name="Surcharge_#GetStateSurcharges.SurchargeID#" id="Surcharge_#GetStateSurcharges.SurchargeID#" value="#form["Surcharge_#GetStateSurcharges.SurchargeID#"]#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
					</div>
				</cfloop>


				<DIV CLASS="FormControl #UDF_isError("LimitAmountPerClaim")#">
					<LABEL FOR="LimitAmountPerClaim" ACCESSKEY="" ID="LimitAmountPerClaimLabel">Limit/Claim:</LABEL>
					<INPUT TYPE="Text" NAME="LimitAmountPerClaim" ID="LimitAmountPerClaim" MAXLENGTH="12" VALUE="#FORM.LimitAmountPerClaim#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onChange="updateLimits(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("LimitAmountAggregate")#">
					<LABEL FOR="LimitAmountAggregate" ACCESSKEY="" ID="LimitAmountAggregateLabel">Limit/Aggregate:</LABEL>
					<INPUT TYPE="Text" NAME="LimitAmountAggregate" ID="LimitAmountAggregate" MAXLENGTH="12" VALUE="#FORM.LimitAmountAggregate#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onChange="updateLimits(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("DeductibleAmountPerClaim")#">
					<LABEL FOR="DeductibleAmountPerClaim" ACCESSKEY="" ID="DeductibleAmountPerClaimLabel">Deductible/Claim:</LABEL>
					<INPUT TYPE="Text" NAME="DeductibleAmountPerClaim" ID="DeductibleAmountPerClaim" MAXLENGTH="12" VALUE="#FORM.DeductibleAmountPerClaim#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("DeductibleAmountAggregate")#">
					<LABEL FOR="DeductibleAmountAggregate" ACCESSKEY="" ID="DeductibleAmountAggregateLabel">Deductible/Aggregate:</LABEL>
					<INPUT TYPE="Text" NAME="DeductibleAmountAggregate" ID="DeductibleAmountAggregate" MAXLENGTH="12" VALUE="#FORM.DeductibleAmountAggregate#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("CoverageSymbol")#">
					<LABEL FOR="CoverageSymbol" ACCESSKEY="" ID="CoverageSymbolLabel">Coverage:</LABEL>
					<SELECT NAME="CoverageSymbol" ID="CoverageSymbol" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
						<OPTION VALUE="">-- Select --
						<CFLOOP QUERY="GetCoverageSymbols">
							<CFIF GetCoverageSymbols.CoverageSymbol EQ FORM.CoverageSymbol>
								<OPTION VALUE="#GetCoverageSymbols.CoverageSymbol#" SELECTED>#GetCoverageSymbols.Coverage#
							<CFELSE>
								<OPTION VALUE="#GetCoverageSymbols.CoverageSymbol#">#GetCoverageSymbols.Coverage#
							</CFIF>
						</CFLOOP>
					</SELECT>
				</DIV>
			</FIELDSET>

			<FIELDSET ID="fsPolicyInformation">
				<LEGEND TITLE="Policy Information">Policy Information</LEGEND>

				<DIV CLASS="FormControl #UDF_isError("PolicySymbol")# Hidden">
					<LABEL FOR="PolicySymbol" ACCESSKEY="S" ID="PolicySymbolLabel">Symbol:</LABEL>
					<INPUT TYPE="Text" NAME="PolicySymbol" ID="PolicySymbol" MAXLENGTH="3" VALUE="#FORM.PolicySymbol#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PolicyNumber")#">
					<LABEL FOR="PolicyNumber" ACCESSKEY="N" ID="PolicyNumberLabel">Number:</LABEL>
					<INPUT TYPE="Text" NAME="PolicyNumber" ID="PolicyNumber" MAXLENGTH="9" VALUE="#FORM.PolicyNumber#" VALUE="" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PolicyModuleNumber")#">
					<LABEL FOR="PolicyModuleNumber" ACCESSKEY="M" ID="PolicyModuleNumberLabel">Module Number:</LABEL>
					<INPUT TYPE="Text" NAME="PolicyModuleNumber" ID="PolicyModuleNumber" MAXLENGTH="2" VALUE="#FORM.PolicyModuleNumber#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PreviousPolicyNumber")# Hidden">
					<LABEL FOR="PreviousPolicyNumber" ACCESSKEY="" ID="PreviousPolicyNumberLabel">Prev. Policy Number:</LABEL>
					<INPUT TYPE="Text" NAME="PreviousPolicyNumber" ID="PreviousPolicyNumber" MAXLENGTH="9" VALUE="#FORM.PreviousPolicyNumber#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PolicyEffectiveDate")#">
					<LABEL FOR="PolicyEffectiveDate" ACCESSKEY="" ID="PolicyEffectiveDateLabel">Effective Date:</LABEL>
					<INPUT TYPE="Text" NAME="PolicyEffectiveDate" ID="PolicyEffectiveDate" MAXLENGTH="8" VALUE="#FORM.PolicyEffectiveDate#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PolicyExpirationDate")#">
					<LABEL FOR="PolicyExpirationDate" ACCESSKEY="" ID="PolicyExpirationDateLabel">Expiration Date:</LABEL>
					<INPUT TYPE="Text" NAME="PolicyExpirationDate" ID="PolicyExpirationDate" MAXLENGTH="8" VALUE="#FORM.PolicyExpirationDate#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PolicyRetroactiveDate")#">
					<LABEL FOR="PolicyRetroactiveDate" ACCESSKEY="" ID="PolicyRetroactiveDateLabel">Retroactive Date:</LABEL>
					<INPUT TYPE="Text" NAME="PolicyRetroactiveDate" ID="PolicyRetroactiveDate" MAXLENGTH="8" VALUE="#FORM.PolicyRetroactiveDate#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("InsuranceCompanyID")#">
					<LABEL FOR="InsuranceCompanyID" ACCESSKEY="F" ID="InsuranceCompanyIDLabel">Insurance Company:</LABEL>
					<SELECT NAME="InsuranceCompanyID" ID="InsuranceCompanyID" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
						<OPTION VALUE="-1">-- Select --
						<CFLOOP QUERY="GetInsuranceCompanies">
							<CFIF (GetInsuranceCompanies.InsuranceCompanyID EQ FORM.InsuranceCompanyID) AND (GetInsuranceCompanies.ShowInd EQ 1)>
								<OPTION VALUE="#GetInsuranceCompanies.InsuranceCompanyID#" SELECTED>#GetInsuranceCompanies.InsuranceCompany#
							<cfelseif GetInsuranceCompanies.ShowInd EQ 1>
								<OPTION VALUE="#GetInsuranceCompanies.InsuranceCompanyID#">#GetInsuranceCompanies.InsuranceCompany#
							</CFIF>
						</CFLOOP>
					</SELECT>
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("NJSequenceNumber")#">
					<LABEL FOR="NJSequenceNumber" ACCESSKEY="" ID="NJSequenceNumberLabel">NJ Sequence Number:</LABEL>
					<INPUT TYPE="Text" NAME="NJSequenceNumber" ID="NJSequenceNumber" MAXLENGTH="5" VALUE="#FORM.NJSequenceNumber#" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>
			</FIELDSET>


			<FIELDSET ID="fsAdvancedOptions">
				<LEGEND TITLE="Advanced Options">Advanced Options</LEGEND>

				<DIV CLASS="RadioControl">
					<INPUT TYPE="Checkbox" NAME="PremiumCodingExportDateTimeInd" ID="PremiumCodingExportDateTimeInd" VALUE="1" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.PremiumCodingExportDateTimeInd EQ 1, DE("Checked"), DE(""))#>
					<LABEL FOR="PremiumCodingExportDateTimeInd" ACCESSKEY="" ID="PremiumCodingExportDateTimeIndLabel">Already Exported for Premium Coding?</LABEL>
				</DIV>

				<DIV CLASS="RadioControl">
					<INPUT TYPE="Checkbox" NAME="AccountsCurrentExportDateTimeInd" ID="AccountsCurrentExportDateTimeInd" VALUE="1" onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" #IIf(FORM.AccountsCurrentExportDateTimeInd EQ 1, DE("Checked"), DE(""))#>
					<LABEL FOR="AccountsCurrentExportDateTimeInd" ACCESSKEY="" ID="AccountsCurrentExportDateTimeIndLabel">Already Exported for Accounts Current?</LABEL>
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


<!--- Disable appropriate fields --->
<SCRIPT LANGUAGE="JavaScript">
<!--
	disableFormFields();
// -->
</SCRIPT>


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
