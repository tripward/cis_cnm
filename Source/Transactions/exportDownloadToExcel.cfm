<!---
################################################################################
#
# Filename:		exportDownloadToExcel.cfm
#
# Description:	Download export as Excel Spreadsheet
#
################################################################################
--->

<CFSETTING ENABLECFOUTPUTONLY="Yes" SHOWDEBUGOUTPUT="No">


<!--- Get list of all transactions codes and convert to structure --->
<CFINCLUDE TEMPLATE="QRY/QRY_GetTransactionCodes.cfm">
<CFSET VARIABLES.stTransactionCodes = StructNew()>
<CFLOOP QUERY="GetTransactionCodes">
	<CFSET VARIABLES.stTransactionCodes[GetTransactionCodes.TransactionCodeID] = GetTransactionCodes.Transaction>
</CFLOOP>


<!--- Determine filename --->
<CFIF VARIABLES.ExportTypeID EQ 2>
	<CFSET VARIABLES.FileName = "AccountsCurrentReport.xls">
<CFELSE>
	<CFSET VARIABLES.FileName = "PremiumCodingReport.xls">
</CFIF>


<!--- Download as Excel --->
<CFHEADER NAME="content-disposition" VALUE="attachment; filename=#VARIABLES.FileName#">
<CFCONTENT TYPE="application/vnd.ms-excel">


<CFOUTPUT>
<TABLE BORDER="1" BORDERCOLOR="##000000" CELLSPACING="0">
	<TR>
		<CFLOOP LIST="#columnList#" INDEX="currEle">
			<TD BGCOLOR="##DDDDDD"><B>#REReplace(currEle, "([A-Z])", " \1", "ALL")#</B></TD>
		</CFLOOP>
	</TR>
	<CFLOOP FROM="1" TO="#VARIABLES.NumTransactions#" INDEX="cnt">
	<TR>
		<CFLOOP LIST="#columnList#" INDEX="currEle">
			<CFIF FindNoCase("Date", currEle) NEQ 0>
				<CFSET tValue = VARIABLES.ParsedExport["Transaction_#cnt#"][currEle]>
				<TD>#Mid(tValue, 5, 2)#/#Mid(tValue, 7, 2)#/#Mid(tValue, 1, 4)#</TD>
			<CFELSEIF CompareNoCase("TransactionCode", currEle) EQ 0>
				<TD>#VARIABLES.stTransactionCodes[Int(VARIABLES.ParsedExport["Transaction_#cnt#"][currEle])]#</TD>
			<CFELSE>
				<TD>#VARIABLES.ParsedExport["Transaction_#cnt#"][currEle]#</TD>
			</CFIF>
		</CFLOOP>
	</TR>
	</CFLOOP>
</TABLE>
</CFOUTPUT>

<CFSETTING ENABLECFOUTPUTONLY="Yes">

