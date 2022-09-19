In this hands on, we are going to create a more complex query and output that to the page.

**Tags Used**: [\<cfquery>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfquery.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html), [\<cfcomponent>](https://helpx.adobe.com/coldfusion/developing-applications/building-blocks-of-coldfusion-applications/building-and-using-coldfusion-components.html)


1. Create a component called PostBlog.cfc in folder models

1. Inside the <cfcomponent> tag, create a functions as shown below

    ```cfml
	
		<cffunction name="getPostsBlog" output="false" access="remote" returntype="query">
			<cfargument name="condicoesFiltros" type="string" required="true">
			<cfquery name="qPosts" datasource="cursocf-senac">
				select a.blogpostid as id
					, (select c.name from blogCategory c, blogpostcategory rl where c.blogcategoryid = rl.categoryid and rl.postid = a.blogpostid limit 1) as nomeCategoria
					, a.title as titulo
					, a.summary as resumo
					, a.body as conteudo
					, to_char(a.dateposted, 'DD/MM/YYYY') as dataPostagem
					, to_char(a.createdDateTime, 'DD/MM/YYYY HH12:MI:SS') as dataHoraSistema
				, (select count(*) from BlogComment bc where a.blogpostid = bc.blogpostid) as qtdComentarios
			 from blogPost a
				 where #preserveSingleQuotes(arguments.condicoesFiltros)#
			</cfquery>
			
			<cfreturn qPosts>
			
		</cffunction>
		
		<cffunction name="setCadastrar" output="false" access="public" returntype="Any">
		<cfargument name="title" type="string" required="true">
		<cfargument name="summary" type="string" required="true">
		<cfargument name="body" type="string" required="true">
		<cfargument name="dateposted" type="date" required="true">
		
		<cfset variables.dataPostagem = lsDateFormat(now(), 'yyyy-mm-dd') &" "& lsTimeFormat(now(), 'HH:mm:ss') />
		
		<cftry>
			<cfquery datasource="#application.config.datasource#">
				insert into blogPost (
					 title
					, summary
					, body
					, dateposted
					, createdDateTime
				)
				values(
					 <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar" maxlength="70">
					, <cfqueryparam value="#arguments.summary#" cfsqltype="cf_sql_longvarchar">
					, <cfqueryparam value="#arguments.body#" cfsqltype="cf_sql_longvarchar">
					, <cfqueryparam value="#arguments.dateposted#">
					, <cfqueryparam value="#variables.dataPostagem#">
				)
			</cfquery>
			
			<cfcatch type="any">
				<cfdump var="#cfcatch#">
			</cfcatch>
		
		</cftry>
		
		<cfreturn >
		
	</cffunction>
    ```

1. Create update and delete functions for blogsPot table

1. Implement on-screen post query blog.cfm and blogpost.cfm

