<cfcomponent displayname="PostBlog">
	
	<cffunction name="getPostsBlog" output="false" access="remote" returntype="query">
		<cfquery name="qPosts" datasource="#application.datasource#">
			select a.blogpostid as id
				, (select c.name from blogCategory c, blogpostcategory rl 
					where c.blogcategoryid = rl.categoryid and rl.postid = a.blogpostid limit 1)
					 as nomeCategoria
				, (select c.blogcategoryid from blogCategory c, blogpostcategory rl 
					where c.blogcategoryid = rl.categoryid and rl.postid = a.blogpostid limit 1)
					 as idCategoria
				, a.title as titulo
				, a.summary as resumo
				, a.body as conteudo
				, to_char(a.dateposted, 'DD/MM/YYYY') as dataPostagem
				, to_char(a.createdDateTime, 'DD/MM/YYYY HH12:MI:SS') as dataHoraSistema
			, (select count(*) from BlogComment bc where a.blogpostid = bc.blogpostid) as qtdComentarios
			from blogPost a
			where a.deleted = '0'
			order by a.dateposted desc 
		</cfquery>
		
		<cfreturn qPosts>
		
	</cffunction>
	
	<cffunction name="getPostBlogDetalhe" output="false" access="remote" returntype="query">
		<cfargument name="idBlog" type="numeric" required="true">
		<cfquery name="qPosts" datasource="#application.datasource#">
			select a.blogpostid as id
				, (select c.name from blogCategory c, blogpostcategory rl 
					where c.blogcategoryid = rl.categoryid and rl.postid = a.blogpostid limit 1)
					 as nomeCategoria
				, (select c.blogcategoryid from blogCategory c, blogpostcategory rl 
					where c.blogcategoryid = rl.categoryid and rl.postid = a.blogpostid limit 1)
					 as idCategoria
				, a.title as titulo
				, a.summary as resumo
				, a.body as conteudo
				, to_char(a.dateposted, 'DD/MM/YYYY') as dataPostagem
				, to_char(a.createdDateTime, 'DD/MM/YYYY HH12:MI:SS') as dataHoraSistema
			, (select count(*) from BlogComment bc where a.blogpostid = bc.blogpostid) as qtdComentarios
			from blogPost a
			where a.blogpostid = <Cfqueryparam  value="#arguments.idBlog#" cfsqltype="cf_sql_integer" maxlength="4">
		</cfquery>
		
		<cfreturn qPosts>
		
	</cffunction>
	
	<cffunction name="setCadastrar" output="false" access="package" returntype="struct">
		<cfargument name="title" type="string" required="true">
		<cfargument name="summary" type="string" required="true">
		<cfargument name="body" type="string" required="true">
		<cfargument name="dateposted" type="string" required="true">
		
		<cfset variables.dataPostagem = lsDateFormat(arguments.dateposted, 'yyyy-mm-dd') />
		
		<cfset strRetorno = {} />
		
		<cftry>
			<cfquery datasource="#application.datasource#">
				insert into blogPost (
					 title
					, summary
					, body
					, dateposted
					, createdDateTime
					,deleted
				)
				values(
					 <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar" maxlength="70">
					, <cfqueryparam value="#arguments.summary#" cfsqltype="cf_sql_longvarchar">
					, <cfqueryparam value="#arguments.body#" cfsqltype="cf_sql_longvarchar">
					, <cfqueryparam value="#variables.dataPostagem#" cfsqltype="cf_sql_date">
					, <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
					, <cfqueryparam value="0" cfsqltype="cf_sql_varchar" maxlength="1">
				)
			</cfquery>
			
			<cfquery name="qIdMax">
				select blogpostid
				from blogPost 
				where title = <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar" maxlength="70">
				<!---and dateposted = <cfqueryparam value="#variables.dataPostagem#" cfsqltype="cf_sql_date">--->
			</cfquery>
			<cfset strRetorno.idRegistroSalvo = qIdMax.blogpostid />
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
	
	<cffunction name="setRelacionarBlogCategoria" output="false" access="package" returntype="struct">
		<cfargument name="blogpostid" type="numeric" required="true">
		<cfargument name="categoryid" type="numeric" required="true">
		
		<cfset strRetorno1 = {} />
		
		<cftry>
			
			<cfquery datasource="#application.datasource#">
				delete from blogpostcategory 
				where postid = <cfqueryparam value="#arguments.blogpostid#" cfsqltype="cf_sql_integer" maxlength="4">
				and categoryid = <cfqueryparam value="#arguments.categoryid#" cfsqltype="cf_sql_integer" maxlength="4">
			</cfquery>
			
			<cfquery datasource="#application.datasource#">
				insert into blogpostcategory (
					 postid
					, categoryid
				)
				values(
					 <cfqueryparam value="#arguments.blogpostid#" cfsqltype="cf_sql_integer" maxlength="4">
					, <cfqueryparam value="#arguments.categoryid#" cfsqltype="cf_sql_integer" maxlength="4">
				)
			</cfquery>
			<cfset strRetorno1.retorno = "sucesso" />
			<cfset strRetorno1.mensagem = "Registro salvo com sucesso" />
			
			<cfcatch type="any">
				<!---<cfdump var="#cfcatch#">--->
				<cfset strRetorno1.retorno = "erro" />
				<cfset strRetorno1.mensagem = "Erro ao salvar o registro" />
				<cfset strRetorno1.mensagemDetalhe = cfcatch.detail />
			</cfcatch>
		
		</cftry>
		
		<cfreturn strRetorno1>
		
	</cffunction>
	
	<cffunction name="setAtualizar" output="false" access="package" returntype="struct">
		<cfargument name="blogpostid" type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="summary" type="string" required="true">
		<cfargument name="body" type="string" required="true">
		<cfargument name="dateposted" type="string" required="true">
		
		<cfset strRetorno = {} />
		<cfset variables.dataPostagem = lsDateFormat(arguments.dateposted, 'yyyy-mm-dd') />
		<cftry>
			<cfquery datasource="#application.datasource#">
				update blogPost  set 
					 title = <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar" maxlength="70">
					, summary = <cfqueryparam value="#arguments.summary#" cfsqltype="cf_sql_longvarchar">
					, body = <cfqueryparam value="#arguments.body#" cfsqltype="cf_sql_longvarchar">
					, dateposted = <cfqueryparam value="#variables.dataPostagem#" cfsqltype="cf_sql_date">
					, modifieddatetime = <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
				where blogpostid = <cfqueryparam value="#arguments.blogpostid#" cfsqltype="cf_sql_integer" maxlength="4">
			</cfquery>
			<cfset strRetorno.retorno = "sucesso" />
			<cfset strRetorno.mensagem = "Registro salvo com sucesso" />
			<cfset strRetorno.idRegistroSalvo = arguments.blogpostid />
			
			<cfcatch type="any">
				<!---<cfdump var="#cfcatch#">--->
				<cfset strRetorno.retorno = "erro" />
				<cfset strRetorno.mensagem = "Erro ao salvar o registro" />
				<cfset strRetorno.mensagemDetalhe = cfcatch.detail />
			</cfcatch>
		
		</cftry>
		
		<cfreturn strRetorno>
		
	</cffunction>
	
	<cffunction name="setExcluir" output="false" access="package" returntype="struct">
		<cfargument name="blogpostid" type="numeric" required="true">
		
		<cfset variables.dataModificacao = lsDateFormat(now(), 'yyyy-mm-dd') &" "& lsTimeFormat(now(), 'HH:mm:ss') />
		
		<cfset strRetorno = {} />
		<cftry>
			<cfquery datasource="#application.datasource#">
				update blogPost  set 
					 deleted = <cfqueryparam value="1" cfsqltype="cf_sql_varchar" maxlength="1">
				where blogpostid = <cfqueryparam value="#arguments.blogpostid#" cfsqltype="cf_sql_integer" maxlength="4">
			</cfquery>
			<cfset strRetorno.retorno = "sucesso" />
			<cfset strRetorno.mensagem = "Registro excluído com sucesso" />
			
			<cfcatch type="any">
				<!---<cfdump var="#cfcatch#">--->
				<cfset strRetorno.retorno = "erro" />
				<cfset strRetorno.mensagem = "Erro ao excluir o registro" />
				<cfset strRetorno.mensagemDetalhe = cfcatch.detail />
			</cfcatch>
		
		</cftry>
		
		<cfreturn strRetorno>
		
	</cffunction>
	
	<cffunction name="salvarRegistro" access="remote" output="false" returntype="struct">
		<cfargument name="acao" type="string" required="true">
		<cfargument name="blogpostid" type="numeric" required="true">
		<cfargument name="categoryid" type="numeric" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="summary" type="string" required="true">
		<cfargument name="body" type="string" required="true">
		<cfargument name="dateposted" type="string" required="true">
		
		<cfscript>
			strRetorno = {};
			
			if( not compareNoCase(arguments.acao, "novo")){
				retornoMetodo = this.setCadastrar(
					arguments.title
					, arguments.summary
					, arguments.body
					, arguments.dateposted
				);
				this.setRelacionarBlogCategoria(
					retornoMetodo.idRegistroSalvo
					, arguments.categoryid
				);
			} else if( not compareNoCase(arguments.acao, "atualizar")){
				retornoMetodo = this.setAtualizar(
					arguments.blogpostid
					, arguments.title
					, arguments.summary
					, arguments.body
					, arguments.dateposted
				);
				this.setRelacionarBlogCategoria(
					retornoMetodo.idRegistroSalvo
					, arguments.categoryid
				);
			} else if( not compareNoCase(arguments.acao, "excluir")){
				this.setExcluir(
					arguments.blogpostid
				);
			}
		</cfscript>
		<cfreturn strRetorno>
		
	</cffunction>
	
</cfcomponent>
