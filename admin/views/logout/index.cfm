<!---<cflock timeout="10" scope="session" type="exclusive">
	<cflogout />
</cflock>--->
<cfscript>
	structClear(SESSION);
</cfscript>
<cflocation addtoken="false" url="#event.getHTMLBaseURL()#index.cfm/login">