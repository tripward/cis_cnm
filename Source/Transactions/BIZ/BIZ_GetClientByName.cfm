<!---
################################################################################
#
# Filename:		BIZ_GetClientByName.cfm
#
# Description:	Retrieves a list of matching clients by LastName and returns
#				the data via JavaScript commands.
#
################################################################################
--->

<!--- Require URL.ClientID --->
<CFPARAM NAME="URL.LastName" TYPE="String">


<!--- Query database for client record --->
<CFSET VARIABLES.LastName = Trim(URL.LastName)>
<CFINCLUDE TEMPLATE="../QRY/QRY_GetClientsByName.cfm">


<!--- If no match, return error --->
<CFIF GetClientsByName.RecordCount EQ 0>
	<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
	<!--
		<CFOUTPUT>alert('No match found for Last Name "#VARIABLES.LastName#"');</CFOUTPUT>
	// -->
	</SCRIPT>

<!--- If only one match found, load data --->
<CFELSEIF GetClientsByName.RecordCount EQ 1>
	<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
	<!--
		<CFOUTPUT>parent.clientSearchByNameAction(#GetClientsByName.ClientID#);</CFOUTPUT>
	// -->
	</SCRIPT>

<!--- If match found, display results --->
<CFELSE>
	<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
	<!--
		if (document.getElementById) {
			parent.document.getElementById('srBody').innerHTML = '';
			<CFOUTPUT QUERY="GetClientsByName">
				<CFSET name = GetClientsByName.LastName & ", " & GetClientsByName.FirstName>
				<CFIF Len(name) GT 50>
					<CFSET name = Left(name, 47) & "...">
				</CFIF>

				<CFSET result = '<A HREF="" onClick="clientSearchByNameAction(#GetClientsByName.ClientID#); return false;">'>
				<CFSET result = result & '<SPAN CLASS="srClientID">[#GetClientsByName.ClientID#]</SPAN>'>
				<CFSET result = result & '<SPAN CLASS="srClientName">#JSStringFormat(name)#</SPAN>'>
				<CFSET result = result & '</A>'>

				parent.document.getElementById('srBody').innerHTML += '#result#';
			</CFOUTPUT>
		} else {
			parent.document.all['srBody'].innerHTML = '';
			<CFOUTPUT QUERY="GetClientsByName">
				<CFSET name = GetClientsByName.LastName & ", " & GetClientsByName.FirstName>
				<CFIF Len(name) GT 50>
					<CFSET name = Left(name, 47) & "...">
				</CFIF>

				<CFSET result = '<A HREF="" onClick="clientSearchByNameAction(#GetClientsByName.ClientID#); return false;">'>
				<CFSET result = result & '<SPAN CLASS="srClientID">[#GetClientsByName.ClientID#]</SPAN>'>
				<CFSET result = result & '<SPAN CLASS="srClientName">#JSStringFormat(name)#</SPAN>'>
				<CFSET result = result & '</A>'>

				parent.document.all['srBody'].innerHTML += '#result#';
			</CFOUTPUT>
		}

		parent.showSearchResults();
	// -->
	</SCRIPT>
</CFIF>

