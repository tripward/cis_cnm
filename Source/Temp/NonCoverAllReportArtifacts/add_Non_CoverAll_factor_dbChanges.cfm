<!--- Include configuration file --->


<!---############## Add DATA ################ --->

<!---add and poplate cm step factor table--->
<cftry>
	
	<cfquery name="test" datasource="#stSiteDetails.DataSource#">
		create table CM_Step_Factors
		(
		factorID counter PRIMARY KEY,
		year_number Integer,
		factor Double
		);
	</cfquery>
	
	<cfcatch type="any">
		
		<cfif cfcatch.detail CONTAINS 'already exists'>
			CM_Step_Factors already exists
			<cfquery name="request.getCMStepRecords2" DATASOURCE="#stSiteDetails.DataSource#">
				SELECT *
				FROM CM_Step_Factors;
			</cfquery>
			<cfdump var="#request.getCMStepRecords2#" label="request.getCMStepRecords2" abort="false" />
		<cfelse>
			<cfdump var="#cfcatch#" label="cgi" abort="true" />
		</cfif>
		
	</cfcatch>
	
</cftry>
	
	<cfquery name="request.getCMStepRecords" DATASOURCE="#stSiteDetails.DataSource#">
		DELETE 
		FROM CM_Step_Factors;
	</cfquery>
	
	<cfquery name="request.getCMStepRecords" DATASOURCE="#stSiteDetails.DataSource#">
		SELECT *
		FROM CM_Step_Factors;
	</cfquery>
	<cfdump var="#request.getCMStepRecords#" label="cgi" abort="false" top="3" />
	
	<cftry>
		
		<cfif !request.getCMStepRecords.recordCount>
	
		<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
			INSERT INTO CM_Step_Factors
			(year_number, factor)
			VALUES
			(1, #NumberFormat('0.53', '_____.__')#);
		</cfquery>
		
		<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
			INSERT INTO CM_Step_Factors
			(year_number, factor)
			VALUES
			(2, #NumberFormat('0.63', '_____.__')#);
		</cfquery>
		
		<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
			INSERT INTO CM_Step_Factors
			(year_number, factor)
			VALUES
			(3, #NumberFormat('0.79', '_____.__')#);
		</cfquery>
		
		<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
			INSERT INTO CM_Step_Factors
			(year_number, factor)
			VALUES
			(4, #NumberFormat('0.90', '_____.__')#);
		</cfquery>
		
		<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
			INSERT INTO CM_Step_Factors
			(year_number, factor)
			VALUES
			(5, #NumberFormat('1.00', '_____.99')#);
		</cfquery>
	
	</cfif>
	
	<cfquery name="request.getCMStepRecords2" DATASOURCE="#stSiteDetails.DataSource#">
		SELECT *
		FROM CM_Step_Factors;
	</cfquery>
	<cfdump var="#request.getCMStepRecords2#" label="request.getCMStepRecords2" abort="false" />

      <cfcatch type="any" >

		<cfdump var="#cfcatch.detail#" label="cfcatch" abort="false"  />
	</cfcatch>
</cftry>

<!---add and poplate cm step factor table--->
<cftry>
	
	<cfquery name="test" datasource="#stSiteDetails.DataSource#">
		create table increased_Limits_Factors
		(
		factorID counter PRIMARY KEY,
		occurance_Limit Double,
		agg_limit Double,
		factor Double
		);
	</cfquery>
	
	<cfquery name="request.getIncreasedLimitsRecords" DATASOURCE="#stSiteDetails.DataSource#">
		SELECT *
		FROM increased_Limits_Factors;
	</cfquery>
	
	<cfif !request.getIncreasedLimitsRecords.recordCount>

		<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
			INSERT INTO increased_Limits_Factors
			(occurance_Limit, agg_limit, factor)
			VALUES
			('100,000', '300,000', 0.82);
		</cfquery>
		
		
		<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
			INSERT INTO increased_Limits_Factors
			(occurance_Limit, agg_limit, factor)
			VALUES
			('200,000 ', '600,000', 1.00);
		</cfquery>
		
		<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
			INSERT INTO increased_Limits_Factors
			(occurance_Limit, agg_limit, factor)
			VALUES
			('300,000', '900,000', 1.09);
		</cfquery>
		
		<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
			INSERT INTO increased_Limits_Factors
			(occurance_Limit, agg_limit, factor)
			VALUES
			('500,000', '1,500,000', 1.23);
		</cfquery>
		
		<cfquery name="request.addNCADExportType" DATASOURCE="#stSiteDetails.DataSource#">
			INSERT INTO increased_Limits_Factors
			(occurance_Limit, agg_limit, factor)
			VALUES
			('1,000,000', '3,000,000', 1.48);
		</cfquery>
	
	</cfif>
	
	<cfquery name="request.getIncreasedLimitsRecords2" DATASOURCE="#stSiteDetails.DataSource#">
		SELECT *
		FROM increased_Limits_Factors;
	</cfquery>
	<cfdump var="#request.getIncreasedLimitsRecords2#" label="request.getIncreasedLimitsRecords2" abort="false" />
	
	<cfcatch type="any">
		
		<cfif cfcatch.detail CONTAINS 'already exists'>
			increased_Limits_Factors already exists
			<cfquery name="request.getIncreasedLimitsRecords2" DATASOURCE="#stSiteDetails.DataSource#">
				SELECT *
				FROM increased_Limits_Factors;
			</cfquery>
			<cfdump var="#request.getIncreasedLimitsRecords2#" label="this table is in the cfcatch" abort="false" />
		<cfelse>
			<cfdump var="#cfcatch#" label="cfcatch" abort="false" top="3" />
		</cfif>
		
	</cfcatch>
	
</cftry>




