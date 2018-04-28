<!---
################################################################################
#
# Filename:		QRY_UpdateTransactionExportDates.cfm
#
# Description:	Updates transactions to set ExportDateTime in the database
#
################################################################################
--->

<!--- Require VARIABLES.ClientID --->
<CFPARAM NAME="VARIABLES.RangeStartDate" DEFAULT="">
<CFPARAM NAME="VARIABLES.RangeEndDate" DEFAULT="">
<CFPARAM NAME="VARIABLES.TransactionCodeID">
<CFPARAM NAME="VARIABLES.ExportTypeID" TYPE="Numeric">


<!--- Determine export type --->
<CFINCLUDE TEMPLATE="QRY_GetExportType.cfm">


<!--- Query database for transaction records --->
<CFQUERY NAME="UpdateTransactionExportDates" DATASOURCE="#stSiteDetails.DataSource#">
	UPDATE
		aig2_Transaction
	SET
		<CFIF CompareNoCase(GetExportType.ExportType, "Accounts Current") EQ 0>
			AccountsCurrentExportDateTime = <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(Now(), 'mm/dd/yyyy')#">
		<CFELSE>
			PremiumCodingExportDateTime = <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(Now(), 'mm/dd/yyyy')#">
		</CFIF>
	WHERE
		TransactionCodeID IN (#VARIABLES.TransactionCodeID#)
		<CFIF (Len(Trim(VARIABLES.RangeStartDate)) NEQ 0) AND (Len(Trim(VARIABLES.RangeEndDate)) NEQ 0)>
			AND (
					(
						PolicyEffectiveDate >= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeStartDate, 'mm/dd/yyyy')#">
						AND PolicyEffectiveDate <= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeEndDate, 'mm/dd/yyyy')#">
						AND TransactionCodeID IN (1,2)
					)
					OR
					(
						TransactionEffectiveDate >= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeStartDate, 'mm/dd/yyyy')#">
						AND TransactionEffectiveDate <= <CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#DateFormat(VARIABLES.RangeEndDate, 'mm/dd/yyyy')#">
						AND TransactionCodeID NOT IN (1,2)
					)
				)
		</CFIF>
		<CFIF CompareNoCase(GetExportType.ExportType, "Accounts Current") EQ 0>
			AND AccountsCurrentExportDateTime IS NULL
		<CFELSE>
			AND PremiumCodingExportDateTime IS NULL
		</CFIF>
</CFQUERY>

