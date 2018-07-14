<!---
################################################################################
#
# Filename:		UDF_Library.cfm
#
# Description:	Library of UDFs for use throughout the application
#
################################################################################
--->

<!--- UDF_isError(): Specifies whether or not specified field has an error --->
<CFSCRIPT>
	function UDF_isError(field) {
		if ( (IsDefined("arrErrors")) AND (ListFindNoCase(ArrayToList(arrErrors[1]), field) NEQ 0) ) {
			return "Error";
		} else {
			return "";
		}
	}
</CFSCRIPT>


<!--- UDF_padValue(): Returns specified value padded with specified character to --->
<!--- achieve specified lentgh --->
<CFSCRIPT>
	function UDF_padValue(value, padChar, justification, length) {
		if ( Len(Trim(value)) GTE length ) {
			return Left(Trim(value), length);
		} else if ( CompareNoCase(justification, "LEFT") EQ 0 ) {
			return Trim(value) & RepeatString(padChar, length - Len(Trim(value)));
		} else if ( CompareNoCase(justification, "RIGHT") EQ 0 ) {
			return RepeatString(padChar, length - Len(Trim(value))) & Trim(value);
		} else {
			return value;
		}
	}
</CFSCRIPT>


<!--- UDF_reverseDayOfYear(): Returns date based on year and day of the year --->
<CFSCRIPT>
	function UDF_reverseDayOfYear(aDayOfYear, aYear) {
		return DateAdd("d", aDayOfYear-1, CreateDate(aYear, "1", "1"));
	}
</CFSCRIPT>

<!--- UDF_reverseDayOfYear(): Returns int of the age of the polocy with a cap of 5 --->
<cffunction name="UDF_getILF" access="public" returntype="any">
	<cfargument name="occuranceLimit" type="date" required="true">
	<cfargument name="aggLimit" type="date" required="true">

	<cfquery name="local.getCILFRecords" DATASOURCE="#stSiteDetails.DataSource#">
		SELECT factorID,occurance_Limit, agg_limit, factor
		FROM increased_Limits_Factors
		WHERE occurance_Limit = #arguments.occuranceLimit# AND agg_limit = #arguments.aggLimit#;
	</cfquery>
	
	<cfif local.getCILFRecords.recordCount>
		<cfset local.factor = '#local.getCILFRecords.factor#'>
	<cfelse>
		<cfset local.factor = 'refer to company'>
	</cfif>

	<!---<cfdump var="#NumberFormat(local.stepFactor, '_____.__')#" label="cgi" abort="true" top="3" />--->
	<cfreturn local.factor />
</cffunction>

<!--- UDF_reverseDayOfYear(): Returns int of the age of the polocy with a cap of 5 --->
<cffunction name="UDF_getCM_Step" access="public" returntype="any">
	<cfargument name="retroDate" type="date" required="true">
	<cfargument name="expireDate" type="date" required="true">

	<!---get total number of days--->
	<cfset local.totalDays = dateDiff('d', '#arguments.retroDate#', '#arguments.expireDate#') />
	<!---<cfset local.totalDays = 1400 />--->

	<!---Fingure out number of whole years, no rounding--->
	<cfset local.wholeYears = int(local.totalDays / 365) />
	
	<!---local.wholeYears is equal to a whole number however we always want to round up to capture the year you are actually in.
	e.g. if the local.totalDays is less than 1 year - you are in year 1
	if local.totalDays is  1096 (3 years and one day) you are in year 4--->
	<cfset local.calculatedWholeYears = local.wholeYears + 1 />

	<cfquery name="local.getMaxCMStepRecord" DATASOURCE="#stSiteDetails.DataSource#" maxrows="1">
		SELECT factor, year_number, factorID AS MaxID
		FROM CM_Step_Factors
		ORDER BY factorID DESC;
	</cfquery>
	<Cfset local.maxFactor = local.getMaxCMStepRecord.factor />
	
	<cfif local.calculatedWholeYears GT local.getMaxCMStepRecord.year_number>
		<cfset local.stepFactor = 1 />
	<cfelse>
		<cfquery name="local.getCMStepRecords" DATASOURCE="#stSiteDetails.DataSource#">
			SELECT factor
			FROM CM_Step_Factors
			WHERE year_number = #local.calculatedWholeYears#;
		</cfquery>
		<cfset local.stepFactor = local.getCMStepRecords.factor />
	</cfif>
	
	<cfreturn decimalFormat(local.stepFactor) />
</cffunction>

<!--- UDF_reverseDayOfYear(): Returns int of the age of the polocy with a cap of 5 --->
<cffunction name="UDF_getCM_years" access="public" returntype="any">
	<cfargument name="retroDate" type="date" required="true">
	<cfargument name="expireDate" type="date" required="true">

	<cfset local.diffInYears = 0 />
	<!---get total number of days--->
	<cfset local.diffInYears = dateDiff('yyyy', '#arguments.retroDate#', '#arguments.expireDate#') />
	<cfreturn local.diffInYears />
</cffunction>





<!---Keeping this function just in case it is needed for PSY--->
<!---<cffunction name="UDF_getCM_Step" access="public" returntype="any">
	<cfargument name="retroDate" type="date" required="true">
	<cfargument name="expireDate" type="date" required="true">
	<!--- 
		Here are the cm_step rules - 
		
		This is always going to be a single digit between 1 - 5
		length of time the policy has existed, rounded up/down to the nearest year
		calculated by the amount of time between the policy retroactive date and the policy renewal date.
		anything from less than a year to 1 year and 183 days is "1"
		Anything from 1 year and 184 days to 2 years and 183 days is "2"
		Etc. until a maximum value of "5"
		
		ATTENTION - you can't just use round because the actual half of a year(365 days) is 182.5, so 183 rounds up as well, but in this 
		instance 183 should be rounded down.
	 --->

	<!---get total number of days--->
	<cfset local.totalDays = dateDiff('d', '#arguments.retroDate#', '#arguments.expireDate#') />
	<!---<cfset local.totalDays = 654 />--->
	<!---<cfdump var="#local.totalDays#" label="cgi" abort="false" top="3" />--->
	<!---Fingure out number of whole years--->
	<cfset local.wholeYears = int(local.totalDays / 365) />
	<!---<cfdump var="#local.wholeYears#" label="cgi" abort="false" top="3" />--->
	<!---if whole years are not 5 or greater you need to figure out which way to round--->
	<cfif !local.wholeYears GTE 5>
		<!---figure out homany days more than the whole year--->
		<cfset local.daysRemaining = (local.totalDays - (local.wholeYears * 365)) />
		<!---<cfdump var="#local.daysRemaining#" label="cgi" abort="false" top="3" />--->
		<!---if greater than 183, we want to round up--->
		<cfif local.daysRemaining GT 183>
			<cfset local.wholeYears = local.wholeYears + 1 />
		</cfif>
		<!---<cfdump var="--#local.wholeYears#" label="cgi" abort="false" top="3" />--->
	
	<!---the whole years was already a 5 or greater--->	
	<cfelse>
		<cfset local.wholeYears = 5 />
	</cfif>
	<!---<cfdump var="--#local.wholeYears#" label="cgi" abort="true" top="3" />--->
	<cfreturn local.wholeYears />
</cffunction>--->

