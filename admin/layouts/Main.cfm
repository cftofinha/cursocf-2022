<cfimport taglib="/cursocf/admin/customTags" prefix="ct">
<ct:securityCheck redirectPage="#event.getHTMLBaseURL()#index.cfm/login" />
<cfoutput>
<cfif compareNocase(event.getCurrentModule(), "")>
	<cfset variables.menu = event.getCurrentModule() />
<cfelse>
	<cfset variables.menu = "home" />
</cfif>
<ct:layout 
	urlBase="#event.getHTMLBaseURL()#" 
	urlBaseComIndex="#event.getHTMLBaseURL()#index.cfm" 
	section="#variables.menu#"></ct:layout>

	<!---Container And Views --->
	<div class="container">
		<div class="vertical-center">
			<main class="flex-shrink-0">
				#renderView()#
				<!---Modulo ==> #event.getCurrentModule()#--->
			</main>
		</div>
	</div>
</cfoutput>
