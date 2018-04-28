<!---
################################################################################
#
# Filename:		transactionHistoryDetails.cfm
#
# Description:	Transaction History Details screen
#
################################################################################
--->

<!--- Set page details --->
<CFSET stPageDetails.Title = stPageDetails.Title & " Transaction History Details">
<CFSET stPageDetails.CSS = "transactions_transactionHistoryDetails.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">


<!--- Initialize form variable values --->
<CFPARAM NAME="URL.ClientID" TYPE="Numeric">


<!--- Get client details and transactions --->
<CFSET VARIABLES.ClientID = URL.ClientID>
<CFINCLUDE TEMPLATE="QRY/QRY_GetClientData.cfm">
<CFINCLUDE TEMPLATE="QRY/QRY_GetTransactionsByClientID.cfm">


<!--- Page contents --->
<CFOUTPUT>
<DIV CLASS="Dialog" ID="dlgTransactionHistoryDetails">
	<DIV CLASS="Title">Transaction History Details: #GetClientData.LastName#, #GetClientData.FirstName# (#GetClientData.ClientID#)</DIV>
	<DIV CLASS="Body">
		<TABLE>
			<TR CLASS="Header">
				<TD>Transaction Eff Date</TD>
				<TD>Policy Number</TD>
				<TD>Transaction</TD>
				<TD>Premium</TD>
				<TD>Limits</TD>
				<TD>Entry Date</TD>
			</TR>
			<CFLOOP QUERY="GetTransactionsByClientID">
				<TR>
					<TD>#DateFormat(GetTransactionsByClientID.TransactionEffectiveDate, "mm/dd/yyyy")#</TD>
					<TD>#GetTransactionsByClientID.PolicyNumber#</TD>
					<TD>#GetTransactionsByClientID.Transaction#</TD>
					<TD>#DollarFormat(GetTransactionsByClientID.GrossPremium)#</TD>
					<TD>#Replace(DollarFormat(GetTransactionsByClientID.LimitAmountPerClaim) & "/" & DollarFormat(GetTransactionsByClientID.LimitAmountAggregate), ".00", "", "ALL")#</TD>
					<TD>#DateFormat(GetTransactionsByClientID.CreationDateTime, "mm/dd/yyyy")#</TD>
				</TR>
			</CFLOOP>
			<TR CLASS="Footer">
				<TD COLSPAN="6">#GetTransactionsByClientID.RecordCount# Transactions</TD>
			</TR>
		</TABLE>

		<FORM NAME="dForm" ID="dForm" ACTION="index.cfm" METHOD="Post">
			<DIV ID="ButtonArray">
				<INPUT TYPE="Button" NAME="btnOK" CLASS="Button" ID="btnOK" VALUE="  OK  " onFocus="activateButton(this);" onBlur="deactivateButton(this);" onMouseOver="activateButton(this);" onMouseOut="deactivateButton(this);" onClick="document.location.href='index.cfm';">
			</DIV>
		</FORM>
	</DIV>
</DIV>
</CFOUTPUT>


<CFINCLUDE TEMPLATE="../Includes/footer.cfm">
