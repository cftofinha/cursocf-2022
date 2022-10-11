<cfcomponent displayname="Portfolio">
	
	<cffunction name="getPortfolio" output="false" access="remote" returntype="query">
		<cfargument name="condicoesFiltros" type="string" required="true">
		<cfquery name="qPortfolio" datasource="dbcursocf">
			select a.id
				, a.title
				, a.summary
				, a.website
				, a.image
			from portfolio a
			where #preserveSingleQuotes(arguments.condicoesFiltros)#
		</cfquery>
		
		<cfreturn qPortfolio>
		
	</cffunction>
	
	<cffunction name="setCadastrar" output="false" access="private" returntype="struct">
		<cfargument name="title" type="string" required="true">
		<cfargument name="summary" type="string" required="true">
		<cfargument name="website" type="string" required="true">
		<cfargument name="image" type="string" required="false">
		
		<cfset strRetorno = {} />
		
		<cftry>
			<cfquery datasource="dbcursocf">
				insert into portfolio (
					 title
					, summary
					, website
					,image
				)
				values(
					 <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">
					, <cfqueryparam value="#arguments.summary#" cfsqltype="cf_sql_longvarchar">
					, <cfqueryparam value="#arguments.website#" cfsqltype="cf_sql_varchar">
					, <cfqueryparam value="#arguments.image#" cfsqltype="cf_sql_varchar">
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
		<cfargument name="title" type="string" required="true">
		<cfargument name="summary" type="string" required="true">
		<cfargument name="website" type="string" required="true">
		<cfargument name="image" type="string" required="false">
		<cfargument name="id" type="numeric" required="true">
		
		<cfset strRetorno = {} />
		
		<cftry>
			<cfquery datasource="dbcursocf">
				update portfolio set 
					 title = <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">
					, summary = <cfqueryparam value="#arguments.summary#" cfsqltype="cf_sql_longvarchar">
					, website = <cfqueryparam value="#arguments.website#" cfsqltype="cf_sql_char">
					,image = <cfqueryparam value="#arguments.image#" cfsqltype="cf_sql_char">
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
	
	<cffunction name="setAtualizarImagem" output="false" access="package" returntype="struct">
		<cfargument name="image" type="string" required="false">
		<cfargument name="id" type="numeric" required="true">
		
		<cfset strRetorno = {} />
		
		<cftry>
			<cfquery datasource="dbcursocf">
				update portfolio set 
					image = <cfqueryparam value="#arguments.image#" cfsqltype="cf_sql_char">
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
				delete from portfolio
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
	
	<cffunction name="fileUpload" access="public" returntype="string">
		<cfargument name="fileField" required="false" type="string">
		<cfargument name="fileFieldOld" required="false" type="string">
		<cfargument name="destination" required="false" type="string">
		
		<cfif isDefined("arguments.fileField") and len(trim(arguments.fileField))>
			<cfset variables.codUUID = createUUID()>
			
			<cffile action="upload" filefield="#arguments.fileField#" destination="#arguments.destination#" nameconflict="makeunique">
			
			<cfset variables.nomeArquivo = left(variables.codUUID,8) &"_"& lsDateFormat(now(), "ddmmyy") &"T"& lsTimeFormat(now(),"HHmm") &"."& file.serverFileExt>
			<cfset variables.nomeArquivoFinal = lCase(variables.nomeArquivo)>
			
			<cfset variables.arquivoEnviado = arguments.destination &"\"& file.serverFile>
			<cffile action="rename" source="#variables.arquivoEnviado#" destination="#arguments.destination#\#variables.nomeArquivoFinal#">
			<cfset variables.arquivoEnviado = 1/>
		<cfelse>
			<cfset variables.arquivoEnviado = 0/>
			<cfset variables.nomeArquivoFinal = arguments.fileFieldOld />
		</cfif>
		
		<cfreturn variables.nomeArquivoFinal>
		
	</cffunction>
	
	<cffunction name="salvarRegistro" access="remote" output="false" returntype="struct">
		<cfargument name="acao" type="string" required="true">
		<cfargument name="title" type="string" required="true">
		<cfargument name="summary" type="string" required="true">
		<cfargument name="website" type="string" required="true">
		<cfargument name="image" type="string" required="false">
		<cfargument name="id" type="numeric" required="true">
		
		<cfscript>
			strRetorno = {};
			
			if( not compareNoCase(arguments.acao, "novo")){
				setCadastrar(
					arguments.title
					, arguments.summary
					, arguments.website
					, arguments.image
				);
			} else if( not compareNoCase(arguments.acao, "atualizar")){
				setAtualizar(
					arguments.title
					, arguments.summary
					, arguments.website
					, arguments.image
					, arguments.id
				);
			} else if( not compareNoCase(arguments.acao, "atualizarImagem")){
				setAtualizarImagem(
					arguments.image
					, arguments.id
				);
			}
			else if( not compareNoCase(arguments.acao, "excluir")){
				setExcluir(
					arguments.id
				);
			}
		</cfscript>
		<cfreturn strRetorno>
		
	</cffunction>
		
</cfcomponent>