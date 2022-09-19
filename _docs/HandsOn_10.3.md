In this hands on, we are going to create a more complex query and output that to the page.

**Tags Used**: [\<cfquery>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfquery.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html), [\<cfcomponent>](https://helpx.adobe.com/coldfusion/developing-applications/building-blocks-of-coldfusion-applications/building-and-using-coldfusion-components.html)


1. Open a component called PostBlog.cfc in folder models

1. Inside the <cfcomponent> tag, create a functions as shown below

    ```cfml
	
		<cffunction name="setAtualizar" output="false" access="public" returntype="Any">
		<cfargument name="blogpostid " type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="summary" type="string" required="true">
		<cfargument name="body" type="string" required="true">
		
		<cfset variables.dataModificacao = lsDateFormat(now(), 'yyyy-mm-dd') &" "& lsTimeFormat(now(), 'HH:mm:ss') />
		
		<cftry>
			<cfquery datasource="#application.config.datasource#">
				update blogPost  set 
					 title = <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar" maxlength="70">
					, summary = <cfqueryparam value="#arguments.summary#" cfsqltype="cf_sql_longvarchar">
					, body = <cfqueryparam value="#arguments.body#" cfsqltype="cf_sql_longvarchar">
					, modifieddatetime = <cfqueryparam value="#variables.dataModificacao#">
				where blogpostid = <cfqueryparam value="#arguments.blogpostid#" cfsqltype="cf_sql_integer" maxlength="4">
			</cfquery>
			
			<cfcatch type="any">
				<cfdump var="#cfcatch#">
			</cfcatch>
		
		</cftry>
		
		<cfreturn >
		
	</cffunction>
	
	<cffunction name="setExcluir" output="false" access="public" returntype="Any">
		<cfargument name="blogpostid " type="numeric" required="true">
		
		<cfset variables.dataModificacao = lsDateFormat(now(), 'yyyy-mm-dd') &" "& lsTimeFormat(now(), 'HH:mm:ss') />
		
		<cftry>
			<cfquery datasource="#application.config.datasource#">
				update blogPost  set 
					 deleted = <cfqueryparam value="1" cfsqltype="cf_sql_varchar" maxlength="1">
				where blogpostid = <cfqueryparam value="#arguments.blogpostid#" cfsqltype="cf_sql_integer" maxlength="4">
			</cfquery>
			
			<cfcatch type="any">
				<cfdump var="#cfcatch#">
			</cfcatch>
		
		</cftry>
		
		<cfreturn >
		
	</cffunction>
    ```


