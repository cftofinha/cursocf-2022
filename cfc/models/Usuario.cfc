<cfcomponent displayname="CFC do Usuário">
	<cfset variables.salt = "123789!@" />
	
	<cffunction name="getUsuarios" access="remote" returntype="query" output="false">
		<cfargument name="condicoesFiltros" type="string" required="false">
		
		<cfset var qCons = "" />
		<cfquery name="qCons" datasource="dbcursocf">
			select id, firstname, lastname, emailaddress, password, salt
			from administrator
			where #preserveSingleQuotes(arguments.condicoesFiltros)#
		</cfquery>
		
		<cfreturn qCons>
	</cffunction>
	
	<cffunction name="setCadastrar" output="false" access="private" returntype="struct">
		<cfargument name="firstname" type="string" required="true">
		<cfargument name="lastname" type="string" required="true">
		<cfargument name="emailaddress" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		
		<cfset strRetorno = {} />
		<cfset variables.hashPwd = hash(variables.salt & arguments.password, 'SHA-256', 'UTF-8')>
		
		<cftry>
			<cfquery datasource="dbcursocf">
				insert into administrator (
					 firstname
					, lastname
					, emailaddress
					, password
					, salt
				)
				values(
					 <cfqueryparam value="#arguments.firstname#" cfsqltype="cf_sql_varchar">
					, <cfqueryparam value="#arguments.lastname#" cfsqltype="cf_sql_varchar">
					, <cfqueryparam value="#arguments.emailaddress#" cfsqltype="cf_sql_varchar">
					, <cfqueryparam value="#variables.hashPwd#" cfsqltype="cf_sql_varchar">
					, <cfqueryparam value="#variables.salt#" cfsqltype="cf_sql_varchar">
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
	
	<cffunction name="setAtualizar" output="false" access="private" returntype="struct">
		<cfargument name="firstname" type="string" required="true">
		<cfargument name="lastname" type="string" required="true">
		<cfargument name="emailaddress" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfargument name="id" type="numeric" required="true">
		
		<cfset strRetorno = {} />
		<cfset variables.hashPwd = hash(variables.salt & arguments.password, 'SHA-256', 'UTF-8')>
		
		<cftry>
			<cfquery datasource="dbcursocf">
				update administrator set 
					 firstname = <cfqueryparam value="#arguments.firstname#" cfsqltype="cf_sql_varchar">
					, lastname = <cfqueryparam value="#arguments.lastname#" cfsqltype="cf_sql_varchar">
					, emailaddress = <cfqueryparam value="#arguments.emailaddress#" cfsqltype="cf_sql_varchar">
					, password = <cfqueryparam value="#variables.hashPwd#" cfsqltype="cf_sql_varchar">
					, salt= <cfqueryparam value="#variables.salt#" cfsqltype="cf_sql_varchar">
				where id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" maxlength="4">
				
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
		<cfargument name="id" type="numeric" required="true">
		
		<cfset strRetorno = {} />
		
		<cftry>
			<cfquery datasource="dbcursocf">
				delete from administrator
				where id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" maxlength="4">
				
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
		<cfargument name="firstname" type="string" required="true">
		<cfargument name="lastname" type="string" required="true">
		<cfargument name="emailaddress" type="string" required="true">
		<cfargument name="password" type="string" required="true">
		<cfargument name="id" type="numeric" required="true">
		
		<cfscript>
			strRetorno = {};
			
			if( not compareNoCase(arguments.acao, "novo")){
				setCadastrar(
					arguments.firstname
					, arguments.lastname
					, arguments.emailaddress
					, arguments.password
				);
			} else if( not compareNoCase(arguments.acao, "atualizar")){
				setAtualizar(
					arguments.firstname
					, arguments.lastname
					, arguments.emailaddress
					, arguments.password
					, arguments.id
				);
			} else if( not compareNoCase(arguments.acao, "excluir")){
				setExcluir(
					arguments.id
				);
			}
		</cfscript>
		<cfreturn strRetorno>
		
	</cffunction>
	
</cfcomponent>