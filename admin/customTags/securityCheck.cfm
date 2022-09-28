<cfparam name="attributes.redirectPage" default="index.cfm/login">
<cfif thisTag.executionMode eq "start">
	<cfif !structKeyExists(session,"usuario") || !val(session.usuario.adminID)>
		<cflocation 
			url="#attributes.redirectPage#" 
			addtoken="false">
	</cfif>
</cfif>