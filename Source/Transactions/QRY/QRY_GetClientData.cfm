<!---
################################################################################
#
# Filename:		QRY_GetClientData.cfm
#
# Description:	Retrieves a client record by ClientID from the database
#
################################################################################
--->

<!--- Require VARIABLES.ClientID --->
<CFPARAM NAME="VARIABLES.ClientID" TYPE="Numeric">


<!--- Query database for client record --->
<CFQUERY NAME="GetClientData" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		DISTINCT
		Clients.[Client ##] AS ClientID,
		Clients.[Last Name] AS LastName,
		Clients.[First Name] AS FirstName,
		Clients.MI AS MiddleInitial,
		Clients.[Business Name] AS BusinessName,
		Clients.[Address Business] AS Address,
		Clients.[City##1] AS City,
		Clients.[State##1] AS State,
		Clients.[Zip##1] AS ZipCode,
		Malprac.[Pol## Number] AS PolicyNumber,
		Malprac.[Effective Date] AS PolicyEffectiveDate,
		Malprac.[Prior acts date] AS PolicyRetroactiveDate,
		Malprac.[Effective Date] AS TransactionEffectiveDate,
		aig2_Transaction.CookCountyInd,
		aig2_Transaction.NJSequenceNumber,
		aig2_Transaction.CreationDateTime,
		aig2_Transaction.FEIN,
		aig2_Transaction.PolicyModuleNumber,
		aig2_Transaction.CoverageSymbol
	FROM
		 (Clients LEFT JOIN Malprac ON Clients.[CLIENT ##] = Malprac.[CLIENT ##]) LEFT JOIN aig2_Transaction ON Clients.[CLIENT ##] = aig2_Transaction.ClientID
	WHERE
		Clients.[Client ##] = <CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#Variables.ClientID#">
	ORDER BY
		Clients.[Client ##],
		aig2_Transaction.CreationDateTime DESC
</CFQUERY>

