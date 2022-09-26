<cfcomponent displayname="PostBlog">
	
	<cffunction name="getPostsBlog" output="false" access="remote" returntype="query">
		<cfargument name="condicoesFiltros" type="string" required="true">
		<cfquery name="qPosts" datasource="dbcursocf">
			select a.blogpostid as id
				, (select c.name from blogCategory c, blogpostcategory rl 
					where c.blogcategoryid = rl.categoryid and rl.postid = a.blogpostid limit 1)
					 as nomeCategoria
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
	
	<cffunction name="setCadastrar" output="false" access="package" returntype="Any">
		<cfargument name="title" type="string" required="true">
		<cfargument name="summary" type="string" required="true">
		<cfargument name="body" type="string" required="true">
		<cfargument name="dateposted" type="date" required="true">
		
		<cfset variables.dataPostagem = lsDateFormat(now(), 'yyyy-mm-dd') &" "& lsTimeFormat(now(), 'HH:mm:ss') />
		
		<cftry>
			<cfquery datasource="dbcursocf">
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
	
	<cffunction name="setAtualizar" output="false" access="public" returntype="Any">
		<cfargument name="blogpostid" type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="summary" type="string" required="true">
		<cfargument name="body" type="string" required="true">
		
		<cfset variables.dataModificacao = lsDateFormat(now(), 'yyyy-mm-dd') &" "& lsTimeFormat(now(), 'HH:mm:ss') />
		
		<cftry>
			<cfquery datasource="dbcursocf">
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
		<cfargument name="blogpostid" type="numeric" required="true">
		
		<cfset variables.dataModificacao = lsDateFormat(now(), 'yyyy-mm-dd') &" "& lsTimeFormat(now(), 'HH:mm:ss') />
		
		<cftry>
			<cfquery datasource="dbcursocf">
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
	
	
</cfcomponent>
