<!---
################################################################################
#
# Filename:		archivedExportsDecodedTransaction.cfm
#
# Description:	View decoded transaction
#
################################################################################
--->

<!--- Set page details --->
<CFSET stPageDetails.Title = stPageDetails.Title & " Decoded Transaction">
<CFSET stPageDetails.CSS = "transactions_archivedExportsParseAction.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">


<!--- Get specified export --->
<CFSET VARIABLES.ExportID = FORM.ExportID>
<CFINCLUDE TEMPLATE="QRY/QRY_GetExport.cfm">


<!--- Parse raw export --->
<CFSET VARIABLES.RawExport = GetExport.Content>
<CFSET VARIABLES.NumTransactions = GetExport.NumTransactions>
<CFINCLUDE TEMPLATE="BIZ/BIZ_ParseExport.cfm">


<!--- Initialize form variable values --->
<CFPARAM NAME="FORM.ClientID" DEFAULT="">
<CFSET InsuredName = #VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].InsuredName#>
<CFPARAM NAME="FORM.LastName" DEFAULT="#ListGetAt(InsuredName, ListLen(InsuredName, " "), " ")#">
<CFPARAM NAME="FORM.FirstName" DEFAULT="#ListGetAt(InsuredName, 1, " ")#">
<CFPARAM NAME="FORM.MiddleInitial" DEFAULT="#IIf(ListLen(InsuredName, " ") EQ 2, DE(""), DE(ListGetAt(InsuredName, 2, " ")))#">
<CFPARAM NAME="FORM.BusinessName" DEFAULT="">
<CFPARAM NAME="FORM.Address" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].Address#">
<CFPARAM NAME="FORM.City" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].City#">
<CFPARAM NAME="FORM.State" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].State#">
<CFPARAM NAME="FORM.ZipCode" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].ZipCode#">
<CFPARAM NAME="FORM.ZipCode2" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].ZipCode2#">
<CFPARAM NAME="FORM.TransactionCode" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].TransactionCode#">
<CFPARAM NAME="FORM.TransactionEffectiveDate" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].TransactionEffectiveDate#">
<CFPARAM NAME="FORM.TransactionExpirationDate" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].TransactionExpirationDate#">
<CFPARAM NAME="FORM.GrossPremium" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].GrossPremium#">
<CFPARAM NAME="FORM.Surcharge" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].Surcharge#">
<CFPARAM NAME="FORM.KyCollectionFee" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].KyCollectionFee#">
<CFPARAM NAME="FORM.KyMunicipalTax" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].KyMunicipalTax#">
<CFPARAM NAME="FORM.LimitAmountPerClaim" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].LimitAmountPerClaim#">
<CFPARAM NAME="FORM.LimitAmountAggregate" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].LimitAmountAggregate#">
<CFPARAM NAME="FORM.DeductibleAmountPerClaim" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].DeductibleAmountPerClaim#">
<CFPARAM NAME="FORM.DeductibleAmountAggregate" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].DeductibleAmountAggregate#">
<CFPARAM NAME="FORM.PolicySymbol" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].PolicySymbol#">
<CFPARAM NAME="FORM.PolicyNumber" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].PolicyNumber#">
<CFPARAM NAME="FORM.PolicyModuleNumber" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].PolicyModuleNumber#">
<CFPARAM NAME="FORM.PreviousPolicyNumber" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].PreviousPolicyNumber#">
<CFPARAM NAME="FORM.PolicyEffectiveDate" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].PolicyEffectiveDate#">
<CFPARAM NAME="FORM.PolicyExpirationDate" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].PolicyExpirationDate#">
<CFPARAM NAME="FORM.PolicyRetroactiveDate" DEFAULT="#VARIABLES.ParsedExport["Transaction_#FORM.TransactionLineNum#"].PolicyRetroactiveDate#">


<!--- Get look up data --->
<CFSET VARIABLES.TransactionCode = FORM.TransactionCode>
<CFINCLUDE TEMPLATE="QRY/QRY_GetTransactionCodes.cfm">


<!--- Page contents --->
<CFOUTPUT>
<DIV CLASS="Dialog" ID="dlgDialog">
	<DIV CLASS="Title">Decoded Transaction</DIV>
	<DIV CLASS="Body">
		<FORM NAME="dForm" ACTION="archivedExportsParseAction.cfm" METHOD="Post">
			<FIELDSET ID="fsClientInformation">
				<LEGEND TITLE="Client Information">Client Information</LEGEND>

				<DIV CLASS="FormControl #UDF_isError("ClientID")#">
					<LABEL FOR="ClientID" ACCESSKEY="C" ID="ClientIDLabel">Client ID:</LABEL>
					<INPUT TYPE="Text" NAME="ClientID" ID="ClientID" MAXLENGTH="10" TABINDEX="1" VALUE="#FORM.ClientID#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onKeyPress="return onEnter(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("LastName")#">
					<LABEL FOR="LastName" ACCESSKEY="L" ID="LastNameLabel">Last Name:</LABEL>
					<INPUT TYPE="Text" NAME="LastName" ID="LastName" MAXLENGTH="255" TABINDEX="3" VALUE="#FORM.LastName#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);" onKeyPress="return onEnter(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("FirstName")#">
					<LABEL FOR="FirstName" ACCESSKEY="F" ID="FirstNameLabel">First Name:</LABEL>
					<INPUT TYPE="Text" NAME="FirstName" ID="FirstName" MAXLENGTH="255" TABINDEX="5" VALUE="#FORM.FirstName#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("MiddleInitial")#">
					<LABEL FOR="MiddleInitial" ACCESSKEY="I" ID="MiddleInitialLabel">Middle Initial:</LABEL>
					<INPUT TYPE="Text" NAME="MiddleInitial" ID="MiddleInitial" MAXLENGTH="3" TABINDEX="6" VALUE="#FORM.MiddleInitial#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("BusinessName")#">
					<LABEL FOR="BusinessName" ACCESSKEY="B" ID="BusinessNameLabel">Business Name:</LABEL>
					<INPUT TYPE="Text" NAME="BusinessName" ID="BusinessName" MAXLENGTH="255" TABINDEX="7" VALUE="#FORM.BusinessName#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("Address")#">
					<LABEL FOR="Address" ACCESSKEY="A" ID="AddressLabel">Address:</LABEL>
					<INPUT TYPE="Text" NAME="Address" ID="Address" MAXLENGTH="35" TABINDEX="8" VALUE="#FORM.Address#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("City")#">
					<LABEL FOR="City" ACCESSKEY="C" ID="CityLabel">City:</LABEL>
					<INPUT TYPE="Text" NAME="City" ID="City" MAXLENGTH="18" TABINDEX="9" VALUE="#FORM.City#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("StateID")#">
					<LABEL FOR="State" ACCESSKEY="S" ID="StateLabel">State:</LABEL>
					<INPUT TYPE="Text" NAME="State" ID="State" TABINDEX="10" VALUE="#FORM.State#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("ZipCode")#">
					<LABEL FOR="ZipCode" ACCESSKEY="Z" ID="ZipCodeLabel">Zip Code:</LABEL>
					<INPUT TYPE="Text" NAME="ZipCode" ID="ZipCode" MAXLENGTH="5" TABINDEX="11" VALUE="#FORM.ZipCode#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("ZipCode2")#">
					<LABEL FOR="ZipCode2" ACCESSKEY="2" ID="ZipCode2Label">Zip+4:</LABEL>
					<INPUT TYPE="Text" NAME="ZipCode2" ID="ZipCode2" MAXLENGTH="4" TABINDEX="12" VALUE="#FORM.ZipCode2#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>
			</FIELDSET>

			<FIELDSET ID="fsTransactionInformation">
				<LEGEND TITLE="Transaction Information">Transaction Information</LEGEND>

				<DIV CLASS="FormControl #UDF_isError("TransactionCode")#">
					<LABEL FOR="TransactionCode" ACCESSKEY="" ID="TransactionCodeLabel">Code:</LABEL>
					<INPUT TYPE="Text" NAME="TransactionCode" ID="TransactionCode" TABINDEX="13" VALUE="#GetTransactionCodes.TransactionCode#) #GetTransactionCodes.Transaction#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("TransactionEffectiveDate")#">
					<LABEL FOR="TransactionEffectiveDate" ACCESSKEY="" ID="TransactionEffectiveDateLabel">Effective Date:</LABEL>
					<INPUT TYPE="Text" NAME="TransactionEffectiveDate" ID="TransactionEffectiveDate" MAXLENGTH="8" TABINDEX="14" VALUE="#FORM.TransactionEffectiveDate#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("TransactionExpirationDate")#">
					<LABEL FOR="TransactionExpirationDate" ACCESSKEY="" ID="TransactionExpirationDateLabel">Expiration Date:</LABEL>
					<INPUT TYPE="Text" NAME="TransactionExpirationDate" ID="TransactionExpirationDate" MAXLENGTH="8" TABINDEX="15" VALUE="#FORM.TransactionExpirationDate#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("GrossPremium")#">
					<LABEL FOR="GrossPremium" ACCESSKEY="" ID="GrossPremiumLabel">Gross Premium:</LABEL>
					<INPUT TYPE="Text" NAME="GrossPremium" ID="GrossPremium" MAXLENGTH="19" TABINDEX="16" VALUE="#FORM.GrossPremium#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("Surcharge")#">
					<LABEL FOR="Surcharge" ACCESSKEY="" ID="SurchargeLabel">Surcharge:</LABEL>
					<INPUT TYPE="Text" NAME="Surcharge" ID="Surcharge" MAXLENGTH="19" TABINDEX="17" VALUE="#FORM.Surcharge#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("KyCollectionFee")#">
					<LABEL FOR="KyCollectionFee" ACCESSKEY="" ID="KyCollectionFeeLabel">KY Collection Fee:</LABEL>
					<INPUT TYPE="Text" NAME="KyCollectionFee" ID="KyCollectionFee" MAXLENGTH="19" TABINDEX="18" VALUE="#FORM.KyCollectionFee#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("KyMunicipalTax")#">
					<LABEL FOR="KyMunicipalTax" ACCESSKEY="" ID="KyMunicipalTaxLabel">KY Municipal Tax:</LABEL>
					<INPUT TYPE="Text" NAME="KyMunicipalTax" ID="KyMunicipalTax" MAXLENGTH="19" TABINDEX="19" VALUE="#FORM.KyMunicipalTax#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("LimitAmountPerClaim")#">
					<LABEL FOR="LimitAmountPerClaim" ACCESSKEY="" ID="LimitAmountPerClaimLabel">Limit/Claim:</LABEL>
					<INPUT TYPE="Text" NAME="LimitAmountPerClaim" ID="LimitAmountPerClaim" MAXLENGTH="12" TABINDEX="20" VALUE="#FORM.LimitAmountPerClaim#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("LimitAmountAggregate")#">
					<LABEL FOR="LimitAmountAggregate" ACCESSKEY="" ID="LimitAmountAggregateLabel">Limit/Aggregate:</LABEL>
					<INPUT TYPE="Text" NAME="LimitAmountAggregate" ID="LimitAmountAggregate" MAXLENGTH="12" TABINDEX="21" VALUE="#FORM.LimitAmountAggregate#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("DeductibleAmountPerClaim")#">
					<LABEL FOR="DeductibleAmountPerClaim" ACCESSKEY="" ID="DeductibleAmountPerClaimLabel">Deductible/Claim:</LABEL>
					<INPUT TYPE="Text" NAME="DeductibleAmountPerClaim" ID="DeductibleAmountPerClaim" MAXLENGTH="12" TABINDEX="22" VALUE="#FORM.DeductibleAmountPerClaim#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("DeductibleAmountAggregate")#">
					<LABEL FOR="DeductibleAmountAggregate" ACCESSKEY="" ID="DeductibleAmountAggregateLabel">Deductible/Aggregate:</LABEL>
					<INPUT TYPE="Text" NAME="DeductibleAmountAggregate" ID="DeductibleAmountAggregate" MAXLENGTH="12" TABINDEX="23" VALUE="#FORM.DeductibleAmountAggregate#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>
			</FIELDSET>

			<FIELDSET ID="fsPolicyInformation">
				<LEGEND TITLE="Policy Information">Policy Information</LEGEND>

				<DIV CLASS="FormControl #UDF_isError("PolicySymbol")#">
					<LABEL FOR="PolicySymbol" ACCESSKEY="S" ID="PolicySymbolLabel">Symbol:</LABEL>
					<INPUT TYPE="Text" NAME="PolicySymbol" ID="PolicySymbol" MAXLENGTH="3" TABINDEX="24" VALUE="#FORM.PolicySymbol#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PolicyNumber")#">
					<LABEL FOR="PolicyNumber" ACCESSKEY="N" ID="PolicyNumberLabel">Number:</LABEL>
					<INPUT TYPE="Text" NAME="PolicyNumber" ID="PolicyNumber" MAXLENGTH="9" TABINDEX="25" VALUE="#FORM.PolicyNumber#" VALUE="" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PolicyModuleNumber")#">
					<LABEL FOR="PolicyModuleNumber" ACCESSKEY="M" ID="PolicyModuleNumberLabel">Module Number:</LABEL>
					<INPUT TYPE="Text" NAME="PolicyModuleNumber" ID="PolicyModuleNumber" MAXLENGTH="2" TABINDEX="26" VALUE="#FORM.PolicyModuleNumber#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PreviousPolicyNumber")#">
					<LABEL FOR="PreviousPolicyNumber" ACCESSKEY="" ID="PreviousPolicyNumberLabel">Prev. Policy Number:</LABEL>
					<INPUT TYPE="Text" NAME="PreviousPolicyNumber" ID="PreviousPolicyNumber" MAXLENGTH="9" TABINDEX="27" VALUE="#FORM.PreviousPolicyNumber#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PolicyEffectiveDate")#">
					<LABEL FOR="PolicyEffectiveDate" ACCESSKEY="" ID="PolicyEffectiveDateLabel">Effective Date:</LABEL>
					<INPUT TYPE="Text" NAME="PolicyEffectiveDate" ID="PolicyEffectiveDate" MAXLENGTH="8" TABINDEX="28" VALUE="#FORM.PolicyEffectiveDate#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PolicyExpirationDate")#">
					<LABEL FOR="PolicyExpirationDate" ACCESSKEY="" ID="PolicyExpirationDateLabel">Expiration Date:</LABEL>
					<INPUT TYPE="Text" NAME="PolicyExpirationDate" ID="PolicyExpirationDate" MAXLENGTH="8" TABINDEX="29" VALUE="#FORM.PolicyExpirationDate#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>

				<DIV CLASS="FormControl #UDF_isError("PolicyRetroactiveDate")#">
					<LABEL FOR="PolicyRetroactiveDate" ACCESSKEY="" ID="PolicyRetroactiveDateLabel">Retroactive Date:</LABEL>
					<INPUT TYPE="Text" NAME="PolicyRetroactiveDate" ID="PolicyRetroactiveDate" MAXLENGTH="8" TABINDEX="30" VALUE="#FORM.PolicyRetroactiveDate#" DISABLED onFocus="activateLabel(this);" onBlur="deactivateLabel(this);">
				</DIV>
			</FIELDSET>

			<DIV ID="ButtonArray">
				<INPUT TYPE="Button" NAME="btnOK" CLASS="Button" ID="btnOK" VALUE="   OK   " TABINDEX="31" onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='archivedExportsParse.cfm?ExportID=#FORM.ExportID#';">
			</DIV>
		</FORM>
	</DIV>
</DIV>
</CFOUTPUT>


<CFINCLUDE TEMPLATE="../Includes/footer.cfm">

