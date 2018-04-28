<!---
################################################################################
#
# Filename:		Application.cfm
#
# Description:	Application Definition file
#
################################################################################
--->

<!--- Initialize and name application --->
<CFAPPLICATION NAME="#Right(Replace(GetDirectoryFromPath(GetCurrentTemplatePath()), "\", "_", "ALL"), 64)#"
	SESSIONMANAGEMENT="Yes"
	SESSIONTIMEOUT="#CreateTimeSpan(0, 1, 0, 0)#"
	APPLICATIONTIMEOUT="#CreateTimeSpan(0, 1, 0, 0)#">


<!--- Include configuration file --->
<CFINCLUDE TEMPLATE="config.cfm">


<!--- Include UDF Library --->
<CFINCLUDE TEMPLATE="Includes/UDF_Library.cfm">

