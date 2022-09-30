<cfcomponent>
	
	<cffunction name="getMySkillSet" returntype="query" access="public">
		<cfquery name="qMySkillSet" datasource="dbcursocf">
			SELECT
				name
			FROM
				skillset
			ORDER BY
				name DESC
		</cfquery>
		<cfreturn qMySkillSet>
	</cffunction>
	
</cfcomponent>