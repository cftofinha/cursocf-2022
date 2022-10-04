<cfcomponent>
	
	<cffunction name="getMySkillSet" returntype="query" access="public">
		<cfquery name="qMySkillSet" datasource="#application.datasource#">
			SELECT
				id, name
			FROM
				skillset
			ORDER BY
				name DESC
		</cfquery>
		<cfreturn qMySkillSet>
	</cffunction>
	
	<cffunction name="getDetalhatRegistro" output="false" access="remote" returntype="query">
		<cfargument name="id" type="numeric" required="true">
		
		<cfquery name="qRegistros" datasource="#application.datasource#">
			select id name 
			from skillset
			where id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" maxlength="4">
		</cfquery>
		
		<cfreturn qRegistros>
		
	</cffunction>
	
	<cffunction name="setCadastrar" output="false" access="package" returntype="struct">
		<cfargument name="name" type="string" required="true">
		
		<cfset strRetorno = {} />
		
		<cftry>
			<cfquery datasource="#application.datasource#">
				insert into skillset (
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
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		
		<cfset strRetorno = {} />
		<cfset variables.dataPostagem = lsDateFormat(arguments.dateposted, 'yyyy-mm-dd') />
		<cftry>
			<cfquery datasource="#application.datasource#">
				update skillset  set 
					 name = <cfqueryparam value="#arguments.name#" cfsqltype="cf_sql_varchar" maxlength="70">
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
			<cfquery datasource="#application.datasource#">
				delete from skillset
				where id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" maxlength="4">
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
		<cfargument name="id" type="numeric" required="true">
		<cfargument name="name" type="string" required="true">
		
		<cfscript>
			strRetorno = {};
			
			if( not compareNoCase(arguments.acao, "novo")){
				this.setCadastrar(
					arguments.name
				);
			} else if( not compareNoCase(arguments.acao, "atualizar")){
				this.setAtualizar(
					arguments.id
					, arguments.name
				);
			} else if( not compareNoCase(arguments.acao, "excluir")){
				this.setExcluir(
					arguments.id
				);
			}
		</cfscript>
		<cfreturn strRetorno>
		
	</cffunction>
	
</cfcomponent>