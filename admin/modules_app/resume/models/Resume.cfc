<cfcomponent>
	
	<cffunction name="getMyResume" returntype="query" access="public">
		<cfargument name="condicoesFiltros" type="string" required="false">
		
		<cfquery name="qMyResume" datasource="dbcursocf">
			SELECT
				title,
				startDate,
				endDate,
				details,
				type
			FROM resume
			WHERE #preserveSingleQuotes(arguments.condicoesFiltros)#
			ORDER BY type, endDate, startDate
		</cfquery>
		<cfreturn qMyResume>
	</cffunction>
	
</cfcomponent>