In this hands on, we are going to create a more complex query and output that to the page.

**Tags Used**: [\<cfquery>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-p-q/cfquery.html), [\<cfoutput>](https://helpx.adobe.com/coldfusion/cfml-reference/coldfusion-tags/tags-m-o/cfoutput.html), [\<cfcomponent>](https://helpx.adobe.com/coldfusion/developing-applications/building-blocks-of-coldfusion-applications/building-and-using-coldfusion-components.html)


1. Create a component called PostBlogComment.cfc in folder models

1. Inside the <cfcomponent> tag, create a functions as shown below

    ```cfml
		<cffunction name="getCommentsBlog" output="false" access="remote" returntype="query">
			<cfargument name="condicoesFiltros" type="string" required="true">
			<cfquery name="qComments" datasource="dbcursocf">
				select a.blogpostid as id
					, a.author
					, a.comment
					, to_char(a.createdDateTime, 'DD/MM/YYYY HH12:MI:SS') as dataHoraSistema
				from blogcomment a
				where #preserveSingleQuotes(arguments.condicoesFiltros)#
			</cfquery>
			
			<cfreturn qComments>
			
		</cffunction>
		
		<cffunction name="setCadastrar" output="false" access="package" returntype="struct">
			<cfargument name="blogpostid" type="numeric" required="true">
			<cfargument name="author" type="string" required="true">
			<cfargument name="comment" type="string" required="true">
			
			<cfset variables.dataPostagem = lsDateFormat(now(), 'yyyy-mm-dd') &" "& lsTimeFormat(now(), 'HH:mm:ss') />
			<cfset strRetorno = {} />
			
			<cftry>
				<cfquery datasource="dbcursocf">
					insert into blogcomment (
						 blogpostid
						, author
						, comment
					)
					values(
						 <cfqueryparam value="#arguments.blogpostid#" cfsqltype="cf_sql_integer" maxlength="4">
						, <cfqueryparam value="#arguments.author#" cfsqltype="cf_sql_longvarchar">
						, <cfqueryparam value="#arguments.comment#" cfsqltype="cf_sql_longvarchar">
					)
				</cfquery>
				<cfset strRetorno.retorno = "sucesso" />
				<cfset strRetorno.mensagem = "Registro salvo com sucesso" />
				
				<cfcatch type="any">
					<!---<cfdump var="#cfcatch#">--->
					<cfset strRetorno.retorno = "erro" />
					<cfset strRetorno.mensagem = "Erro ao salvar o registro" />
					<cfset strRetorno.mensagemDetalhe = cfcatch.detail />
				</cfcatch>
			
			</cftry>
			
			<cfreturn strRetorno>
			
		</cffunction>
		
		<cffunction name="salvarRegistro" access="remote" output="false" returntype="struct">
			<cfargument name="acao" type="string" required="true">
			<cfargument name="blogpostid" type="numeric" required="true">
			<cfargument name="author" type="string" required="true">
			<cfargument name="comment" type="string" required="true">
			
			<cfscript>
				strRetorno = {};
				
				if( not compareNoCase(arguments.acao, "novo")){
					this.setCadastrar(
						arguments.blogpostid
						,arguments.author
						,arguments.comment
					);
				} 
				
			</cfscript>
			<cfreturn strRetorno>
			
		</cffunction>
    ```

1. Open the blogpost.cfm file and paste the code below on top of page:

    ```cfml
    <cfset instModelComentarios = createObject("component","cfc.models.PostComments") />
	<cfif isDefined("form.blogpostid") and form.submitted eq 1>
		<cfscript>
			qGravaComentarios = instModelComentarios.salvarRegistro(
				"novo"
				,form.blogpostid
				,form.author
				,form.comment
			);
			writeDump(qGravaComentarios);
			abort;
		</cfscript>
	</cfif>

	<cfparam name="url.id" default="">
	<cfif isNumeric(url.id)>
		<cfset variables.condicoes = " a.blogpostid = " & url.id />
		<cfset blogPost = createObject("component","cfc.models.PostBlog" ).getPostsBlog(condicoesFiltros: variables.condicoes) />
		<cfset qComentarios = instModelComentarios.getCommentsBlog(condicoesFiltros: variables.condicoes) />
	<cfelse>
		<cflocation url="index.cfm">
	</cfif>
    ```

1. Reload the `blogpost.cfm` page in your browser.
