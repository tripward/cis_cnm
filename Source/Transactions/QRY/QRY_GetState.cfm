<!---
################################################################################
#
# Filename:		QRY_GetState.cfm
#
# Description:	Retrieves a state record from the database
#
################################################################################
--->

<!--- Check for required variables --->
<CFPARAM NAME="VARIABLES.StateID" TYPE="Numeric" DEFAULT="0">
<CFPARAM NAME="VARIABLES.Abbreviation" TYPE="String" DEFAULT="">
<CFPARAM NAME="VARIABLES.State" TYPE="String" DEFAULT="">


<!--- Query database for client record --->
<CFQUERY NAME="GetState" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		StateID,
		Abbreviation,
		State
	FROM
		aig2_xState
	WHERE
		1 = 1
		<CFIF VARIABLES.StateID NEQ 0>
			AND StateID = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#Variables.StateID#">
		</CFIF>
		<CFIF Len(Trim(VARIABLES.Abbreviation)) NEQ 0>
			AND Abbreviation = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" MAXLENGTH="2" VALUE="#Variables.Abbreviation#">
		</CFIF>
		<CFIF Len(Trim(VARIABLES.State)) NEQ 0>
			AND State = <CFQUERYPARAM CFSQLTYPE="CF_SQL_VARCHAR" MAXLENGTH="50" VALUE="#Variables.State#">
		</CFIF>
</CFQUERY>

