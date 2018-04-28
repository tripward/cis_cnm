<!---
################################################################################
#
# Filename:		BIZ_GetClientByID.cfm
#
# Description:	Retrieves a client record by ClientID and returns the data via
#				JavaScript commands used to populate the dataEntry form.
#
################################################################################
--->

<!--- Require URL.ClientID --->
<CFPARAM NAME="URL.ClientID" TYPE="Numeric">


<!--- Query database for client record --->
<CFSET VARIABLES.ClientID = URL.ClientID>
<CFINCLUDE TEMPLATE="../QRY/QRY_GetClientData.cfm">


<!--- If no match, return error --->
<CFIF GetClientData.RecordCount EQ 0>
	<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
	<!--
		<CFOUTPUT>alert('No match found for ClientID #VARIABLES.ClientID#');</CFOUTPUT>
	// -->
	</SCRIPT>

<!--- If match found, populate form fields --->
<CFELSE>
	<!--- Get StateID --->
	<CFSET VARIABLES.Abbreviation = GetClientData.State>
	<CFINCLUDE TEMPLATE="../QRY/QRY_GetState.cfm">


	<CFOUTPUT QUERY="GetClientData">
	<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
	<!--
		// Client Information
		parent.document.dForm.LastName.value = '#JSStringFormat(GetClientData.LastName)#';
		parent.document.dForm.FirstName.value = '#JSStringFormat(GetClientData.FirstName)#';
		parent.document.dForm.MiddleInitial.value = '#JSStringFormat(GetClientData.MiddleInitial)#';
		parent.document.dForm.BusinessName.value = '#JSStringFormat(GetClientData.BusinessName)#';
		parent.document.dForm.Address.value = '#JSStringFormat(GetClientData.Address)#';
		parent.document.dForm.City.value = '#JSStringFormat(GetClientData.City)#';
		for (i = 0; i < parent.document.dForm.StateID.options.length; i++) {
			if (parent.document.dForm.StateID.options[i].value == #GetState.StateID#) {
				parent.document.dForm.StateID.selectedIndex = i;
			}
		}
		parent.document.dForm.ZipCode.value = '#JSStringFormat(GetClientData.ZipCode)#';
		<CFIF GetClientData.CookCountyInd IS "Yes">
			parent.document.dForm.CookCountyInd.checked = true;
		<CFELSE>
			parent.document.dForm.CookCountyInd.checked = false;
		</CFIF>
		parent.document.dForm.FEIN.value = '#JSStringFormat(GetClientData.FEIN)#';

		// Transaction Information
		parent.document.dForm.TransactionEffectiveDate.value = '#JSStringFormat(DateFormat(GetClientData.TransactionEffectiveDate, "YYYYMMDD"))#';
		parent.document.dForm.TransactionExpirationDate.value = '#JSStringFormat(DateFormat(DateAdd("yyyy", 1, GetClientData.TransactionEffectiveDate), "YYYYMMDD"))#';
		for (i = 0; i < parent.document.dForm.CoverageSymbol.options.length; i++) {
			if (parent.document.dForm.CoverageSymbol.options[i].value == '#GetClientData.CoverageSymbol#') {
				parent.document.dForm.CoverageSymbol.selectedIndex = i;
			}
		}

		// Policy Information
		parent.document.dForm.PolicyNumber.value = '#JSStringFormat(GetClientData.PolicyNumber)#';
		<CFIF Len(Trim(GetClientData.PolicyModuleNumber)) EQ 0>
			parent.originalPolicyModuleNumber = '#JSStringFormat(0)#';
		<CFELSE>
			parent.originalPolicyModuleNumber = '#JSStringFormat(GetClientData.PolicyModuleNumber)#';
		</CFIF>
		parent.document.dForm.PolicyModuleNumber.value = '#JSStringFormat(GetClientData.PolicyModuleNumber)#';
		parent.document.dForm.PolicyEffectiveDate.value = '#JSStringFormat(DateFormat(GetClientData.PolicyEffectiveDate, "YYYYMMDD"))#';
		parent.document.dForm.PolicyExpirationDate.value = '#JSStringFormat(DateFormat(DateAdd("yyyy", 1, GetClientData.PolicyEffectiveDate), "YYYYMMDD"))#';
		parent.document.dForm.PolicyRetroactiveDate.value = '#JSStringFormat(DateFormat(GetClientData.PolicyRetroactiveDate, "YYYYMMDD"))#';
		parent.document.dForm.NJSequenceNumber.value = '#JSStringFormat(GetClientData.NjSequenceNumber)#';

		// Enable/disable KY fields
		parent.disableKyFields();
		parent.disableNjFields();
		parent.checkCounty();
		parent.updatePolicyModuleNumber();
	// -->
	</SCRIPT>
	</CFOUTPUT>
</CFIF>

