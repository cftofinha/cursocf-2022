<cfcomponent displayname="Categorias">
	
	<cffunction name="getCategorias" output="false" access="remote" returntype="query">
		<cfquery name="qRegistros" datasource="dbcursocf">
			select blogcategoryid as id, name 
			from blogCategory
			order by name asc 
		</cfquery>
		
		<cfreturn qRegistros>
		
	</cffunction>
	
	<cffunction name="setCadastrar" output="false" access="package" returntype="struct">
		<cfargument name="name" type="string" required="true">
		
		<cfset strRetorno = {} />
		
		<cftry>
			<cfquery datasource="dbcursocf">
				insert into blogCategory (
					 name
				)
				values(
					 <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar" maxlength="70">
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
	
	<cffunction name="setAtualizar" output="false" access="package" returntype="struct">
		<cfargument name="blogcategoryid" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		
		<cfset strRetorno = {} />
		<cfset variables.dataPostagem = lsDateFormat(arguments.dateposted, 'yyyy-mm-dd') />
		<cftry>
			<cfquery datasource="dbcursocf">
				update blogCategory  set 
					 name = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar" maxlength="70">
				where blogcategoryid = <cfqueryparam value="#arguments.blogcategoryid#" cfsqltype="cf_sql_integer" maxlength="4">
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
	
	<cffunction name="setExcluir" output="false" access="package" returntype="struct">
		<cfargument name="blogcategoryid" type="numeric" required="true">
		
		<cfset strRetorno = {} />
		<cftry>
			<cfquery datasource="dbcursocf">
				delete from blogCategory
				where blogcategoryid = <cfqueryparam value="#arguments.blogcategoryid#" cfsqltype="cf_sql_integer" maxlength="4">
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
		<cfargument name="blogcategoryid" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		
		<cfscript>
			strRetorno = {};
			
			if( not compareNoCase(arguments.acao, "novo")){
				this.setCadastrar(
					arguments.name
				);
			} else if( not compareNoCase(arguments.acao, "atualizar")){
				this.setAtualizar(
					arguments.blogcategoryid
					, arguments.name
				);
			} else if( not compareNoCase(arguments.acao, "excluir")){
				this.setExcluir(
					arguments.blogcategoryid
				);
			}
		</cfscript>
		<cfreturn strRetorno>
		
	</cffunction>
	
</cfcomponent>
