<cfcomponent displayname="Portfolio">
	<cfset objPortfolio = createObject("component","cfc.models.Portfolio") />
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
				objPortfolio.setCadastrar(
					arguments.title
					, arguments.summary
					, arguments.website
					, arguments.image
				);
			} else if( not compareNoCase(arguments.acao, "atualizar")){
				this.setAtualizar(
					arguments.title
					, arguments.summary
					, arguments.website
					, arguments.image
					, arguments.id
				);
			} else if( not compareNoCase(arguments.acao, "atualizarImagem")){
				this.setAtualizarImagem(
					arguments.image
					, arguments.id
				);
			}
		</cfscript>
		<cfreturn strRetorno>
		
	</cffunction>
		
</cfcomponent>
