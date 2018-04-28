<!---
################################################################################
#
# Filename:		QRY_GetTransactionCodes.cfm
#
# Description:	Retrieves all Transaction Codes from the database
#
################################################################################
--->

<!--- Initialize variables --->
<CFPARAM NAME="VARIABLES.TransactionCodeID" DEFAULT="">


<!--- Query database for transaction codes --->
<CFQUERY NAME="GetTransactionCodes" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		TransactionCodeID,
		Transaction,
		AmsCode
	FROM
		aig2_xTransactionCode
	WHERE
		1 = 1
		<CFIF Len(Trim(VARIABLES.TransactionCodeID)) NEQ 0>
			AND TransactionCodeID IN (<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" LIST="Yes" VALUE="#VARIABLES.TransactionCodeID#">)
		</CFIF>
	ORDER BY
		TransactionCodeID
</CFQUERY>

