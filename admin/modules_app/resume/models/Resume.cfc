<cfcomponent>
	
	<cffunction name="getMyResume" returntype="query" access="public">
		<cfargument name="condicoesFiltros" type="string" required="true">
		<cfquery name="qMyResume" datasource="#application.datasource#">
			select 
				id,
				title,
				to_char(startDate, 'DD/MM/YYYY') as startDate,
				to_char(endDate, 'DD/MM/YYYY') as endDate,
				details,
				type
			from resume
			where #preserveSingleQuotes(arguments.condicoesFiltros)#
			order by title asc 
		</cfquery>
		<cfreturn qMyResume>
	</cffunction>
	
	<cffunction name="getTypes" returntype="query" access="public">
		<cfquery name="qTypes" datasource="#application.datasource#">
			select 
				distinct type
			from resume
			order by type asc 
		</cfquery>
		<cfreturn qTypes>
	</cffunction>
	
	<cffunction name="getDetalharRegistro" output="false" access="remote" returntype="query">
		<cfargument name="id" type="numeric" required="true">
		
		<cfquery name="qRegistros" datasource="#application.datasource#">
			select 
				id,
				title,
				to_char(startDate, 'DD/MM/YYYY') as startDate,
				to_char(endDate, 'DD/MM/YYYY') as endDate,
				details,
				type
			from resume
			where id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" maxlength="4">
		</cfquery>
		
		<cfreturn qRegistros>
		
	</cffunction>
	
	<cffunction name="setCadastrar" output="false" access="package" returntype="struct">
		<cfargument name="title" type="string" required="true">
		<cfargument name="startDate" type="string" required="true">
		<cfargument name="endDate" type="string" required="true">
		<cfargument name="details" type="string" required="true">
		<cfargument name="type" type="string" required="true">
		
		<cfset strRetorno = {} />
		<cfset variables.dataStart = lsDateFormat(arguments.startDate, 'yyyy-mm-dd') />
		<cfset variables.dataEnd = lsDateFormat(arguments.endDate, 'yyyy-mm-dd') />
		
		<cftry>
			<cfquery datasource="#application.datasource#">
				insert into resume (
					title
					,startDate
					,endDate
					,details
					,type
				)
				values(
					<cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar" maxlength="70">
					,<cfqueryparam value="#variables.dataStart#" cfsqltype="cf_sql_date">
					,<cfqueryparam value="#variables.dataEnd#" cfsqltype="cf_sql_date">
					,<cfqueryparam value="#arguments.details#" cfsqltype="cf_sql_longvarchar">
					,<cfqueryparam value="#arguments.type#" cfsqltype="cf_sql_varchar" maxlength="70">
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
		<cfargument name="title" type="string" required="true">
		<cfargument name="startDate" type="string" required="true">
		<cfargument name="endDate" type="string" required="true">
		<cfargument name="details" type="string" required="true">
		<cfargument name="type" type="string" required="true">
		
		<cfset strRetorno = {} />
		<cfset variables.dataStart = lsDateFormat(arguments.startDate, 'yyyy-mm-dd') />
		<cfset variables.dataEnd = lsDateFormat(arguments.endDate, 'yyyy-mm-dd') />
		<cftry>
			<cfquery datasource="#application.datasource#">
				update resume set 
					 title = <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar" maxlength="70">
					,startDate = <cfqueryparam value="#variables.dataStart#" cfsqltype="cf_sql_date">
					,endDate = <cfqueryparam value="#variables.dataEnd#" cfsqltype="cf_sql_date">
					,details = <cfqueryparam value="#arguments.details#" cfsqltype="cf_sql_longvarchar">
					,type = <cfqueryparam value="#arguments.type#" cfsqltype="cf_sql_varchar" maxlength="70">
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
				delete from resume
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
		<cfargument name="title" type="string" required="true">
		<cfargument name="startDate" type="string" required="true">
		<cfargument name="endDate" type="string" required="true">
		<cfargument name="details" type="string" required="true">
		<cfargument name="type" type="string" required="true">
		
		<cfscript>
			strRetorno = {};
			
			if( not compareNoCase(arguments.acao, "novo")){
				this.setCadastrar(
					arguments.title
					, arguments.startDate
					, arguments.endDate
					, arguments.details
					, arguments.type
				);
			} else if( not compareNoCase(arguments.acao, "atualizar")){
				this.setAtualizar(
					arguments.id
					, arguments.title
					, arguments.startDate
					, arguments.endDate
					, arguments.details
					, arguments.type
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