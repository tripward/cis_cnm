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
<CFELSEIF VARIABLES.ExportTypeID EQ 3>
	<CFSET VARIABLES.FileName = "NonCoverAllReport.xls">
<CFELSE>
	<CFSET VARIABLES.FileName = "PremiumCodingReport.xls">
</CFIF>
<!---ListLen(VARIABLES.RawExport, CrLf)--->
<!---<cfdump var="#ListGetAt(VARIABLES.RawExport, 1, CrLf)#" label="cgi" abort="false" top="3" />
<cfdump var="#VARIABLES.ParsedExport.Transaction_1#" label="cgi" abort="true" top="1" />--->


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
			<!---<cfdump var="#currEle#" label="cgi" abort="true" top="3" />--->
			<CFIF FindNoCase("Date", currEle) NEQ 0>
				<CFSET tValue = VARIABLES.ParsedExport["Transaction_#cnt#"][currEle]>
				<TD>#Mid(tValue, listGetAt(request.DateComponentStartPositions,2), 2)#/#Mid(tValue, listGetAt(request.DateComponentStartPositions,3), 2)#/#Mid(tValue, listGetAt(request.DateComponentStartPositions,1), 4)#</TD>
				<!---<TD>#Mid(tValue, 5, 2)#/#Mid(tValue, 7, 2)#/#Mid(tValue, 1, 4)#</TD>--->
			<CFELSEIF CompareNoCase("TransactionCode", currEle) EQ 0>
				<TD>#VARIABLES.stTransactionCodes[Int(VARIABLES.ParsedExport["Transaction_#cnt#"][currEle])]#</TD>
			<CFELSE>
				<!---<cfdump var="#VARIABLES.ParsedExport["Transaction_#cnt#"]#" label="cgi" abort="true" top="3" />--->
				<TD>#VARIABLES.ParsedExport["Transaction_#cnt#"][currEle]#</TD>
			</CFIF>
		</CFLOOP>
	</TR>
	</CFLOOP>
</TABLE>
</CFOUTPUT>

<CFSETTING ENABLECFOUTPUTONLY="Yes">

