<!---
################################################################################
#
# Filename:		QRY_AddExport.cfm
#
# Description:	Inserts an Export into the database
#
################################################################################
--->

<!--- Check for required fields --->
<CFPARAM NAME="VARIABLES.BuildExport" TYPE="String">
<CFPARAM NAME="VARIABLES.NumTransactions" TYPE="Numeric">
<CFPARAM NAME="VARIABLES.ExportTypeID" TYPE="Numeric">
<CFPARAM NAME="VARIABLES.BackoutID" TYPE="Numeric" DEFAULT="0">
<CFPARAM NAME="VARIABLES.BackoutInd" TYPE="Numeric" DEFAULT="0">


<!--- Insert transaction into database --->
<CFQUERY NAME="AddExport" DATASOURCE="#stSiteDetails.DataSource#">
	INSERT INTO aig2_Export
	(
		ExportDateTime,
		NumTransactions,
		ExportTypeID,
		BackoutID,
		BackoutInd,
		Content
	)
	VALUES
	(
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_DATE" VALUE="#CreateODBCDateTime(Now())#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.NumTransactions#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.ExportTypeID#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.BackoutID#" NULL="#IIf(VARIABLES.BackoutID EQ 0, DE("Yes"), DE("No"))#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_INTEGER" VALUE="#VARIABLES.BackoutInd#">,
		<CFQUERYPARAM CFSQLTYPE="CF_SQL_CLOB" VALUE="#VARIABLES.BuildExport#">
	)
</CFQUERY>


<CFQUERY NAME="AddExport" DATASOURCE="#stSiteDetails.DataSource#">
	SELECT
		Max(ExportID) AS ThisID
	FROM
		aig2_Export
</CFQUERY>

