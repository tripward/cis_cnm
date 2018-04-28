<!---
################################################################################
#
# Filename:		exportDownloadToText.cfm
#
# Description:	Download export as text
#
################################################################################
--->

<CFSETTING ENABLECFOUTPUTONLY="Yes" SHOWDEBUGOUTPUT="No">


<!--- Determine filename --->
<CFIF VARIABLES.ExportTypeID EQ 2>
	<CFSET VARIABLES.FileName = "ac_CNM_" & DateFormat(Now(), "yyyymmdd") & ".txt">
<CFELSE>
	<CFSET VARIABLES.FileName = "pr_CNM_" & DateFormat(Now(), "yyyymmdd") & ".txt">
</CFIF>


<!--- Download as text --->
<CFHEADER NAME="content-disposition" VALUE="attachment; filename=#VARIABLES.FileName#">
<CFCONTENT TYPE="text/plain">
<CFOUTPUT>#VARIABLES.BuildExport#</CFOUTPUT>


<CFSETTING ENABLECFOUTPUTONLY="Yes">

