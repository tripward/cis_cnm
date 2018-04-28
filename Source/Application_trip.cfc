<cfcomponent displayname="application" hint="" >

	<cfscript>
		// Either put the framework folder in your webroot or create a mapping for it!
		this.name = 'fff#Right(Replace(GetDirectoryFromPath(GetCurrentTemplatePath()), "\", "_", "ALL"), 64)#';
		this.sessionManagement = true;
		this.sessiontimeout = CreateTimeSpan(0,1,0,0);
	
	</cfscript>

	<cffunction name="onApplicationStart" access="public" returntype="any">

	</cffunction>
	
	<cffunction name="onSessionStart" access="public" returntype="any">

	</cffunction>


	<cffunction name="onRequestStart" access="public" returntype="any">
		<!---<cfset request.includeConfig = 'config.cfm' />--->
		<cfset request.includeConfig = 'tripconfig.cfm' />

		<!--- Include configuration file --->
		<CFINCLUDE TEMPLATE="#request.includeConfig#">
		
	</cffunction>
	
	
	<cffunction name="OnError" access="public" returntype="void" output="true"	hint="Fires when an exception occures that is not caught by a try/catch block">
		<!--- Define arguments. --->
		<cfargument	name="Exception" type="any"	required="true"	/>
		<cfargument	name="EventName" type="string" required="false" default=""	/>
		
		<cfdump var="#arguments#" label="onError Arguments" abort="true" top="3" />
		
		<cfreturn />
	</cffunction>


</cfcomponent>
