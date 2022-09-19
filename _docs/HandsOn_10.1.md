In this hands on, we are going to create a more complex query and output that to the page.

**Tags Used**: [\<cfquery>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfquery.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html), [\<cfcomponent>](https://helpx.adobe.com/coldfusion/developing-applications/building-blocks-of-coldfusion-applications/building-and-using-coldfusion-components.html)


1. Create a folder called models inside the cfc folder.

1. Create a component called Resume.cfc

1. Inside the <cfcomponent> tag, create a function as shown below

    ```cfml
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
    ```

1. Open the resume.cfm file and replace the cfquery calls with the new calls below:

    ```cfml
    <cfset instCFC = createObject("component","cfc.models.Resume") />
	<cfset mySkillSet = instCFC.getMySkillSet()>
	<cfset variables.condicoes = " 0 = 0" />
	<cfset myResume = instCFC.getMyResume(condicoesFiltros: variables.condicoes) />
    ```

1. Reload the `resume.cfm` page in your browser.

