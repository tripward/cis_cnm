<!---
################################################################################
#
# Filename:		displayErrors.cfm
#
# Description:	Checks for errors and displays them, if any
#
################################################################################
--->

<CFOUTPUT>
<CFIF IsDefined("cntErrors") AND (cntErrors GT 0)>
	<UL>
	<CFLOOP FROM="1" TO="#ArrayLen(arrErrors[2])#" INDEX="cnt">
		<LI>#arrErrors[2][cnt]#
	</CFLOOP>
	</UL>
</CFIF>
</CFOUTPUT>

