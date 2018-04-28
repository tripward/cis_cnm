<!---
################################################################################
#
# Filename:		index.cfm
#
# Description:	The AIG Transaction system control panel
#
################################################################################
--->

<CFSET stPageDetails.CSS = "dlgMessageBox.css">
<CFINCLUDE TEMPLATE="../Includes/header.cfm">

<CFOUTPUT>
<DIV CLASS="Dialog" ID="dlgMessageBox">
	<DIV CLASS="Title">Control Panel</DIV>
	<DIV CLASS="Body">
		<UL>
			<LI><A HREF="#stSiteDetails.BaseURL#/Transactions/dataEntry.cfm" onMouseOver="setStatusText('Enter new transaction data');" onMouseOut="restoreStatusText();">Data Entry</A> - Enter new transaction data
			<LI><A HREF="#stSiteDetails.BaseURL#/Transactions/import.cfm" onMouseOver="setStatusText('Import MS Excel Report from AMS 360');" onMouseOut="restoreStatusText();">Import from AMS 360</A> - Import MS Excel Report from AMS 360
			<LI><A HREF="#stSiteDetails.BaseURL#/Transactions/transactionHistory.cfm" onMouseOver="setStatusText('View historical client transactions');" onMouseOut="restoreStatusText();">Transaction History</A> - View historical client transactions
			<LI><A HREF="#stSiteDetails.BaseURL#/Transactions/export.cfm" onMouseOver="setStatusText('Export data for transmission to AIG');" onMouseOut="restoreStatusText();">Data Export</A> - Export data for transmission to AIG
			<LI><A HREF="#stSiteDetails.BaseURL#/Transactions/archivedExports.cfm" onMouseOver="setStatusText('View past exports and transmissions');" onMouseOut="restoreStatusText();">Archived Exports</A> - View past exports and transmissions
		</UL>
	</DIV>
</DIV>
</CFOUTPUT>

<CFINCLUDE TEMPLATE="../Includes/footer.cfm">

