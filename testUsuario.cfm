<!---<cfset senha = hash("1234567admin", 'SHA-256', 'UTF-8')>
<cfquery datasource="cursocf-senac">
	update administrator set
	password = '#senha#'
	,
</cfquery>--->
<cfscript>
	param name="url.id" default="";
	param name="form.firstname" default="Tofinha FCP";
	param name="form.lastname" default="CFDeveloper";
	param name="form.emailaddress" default="cfdeveloper@gmail.com";
	param name="form.password" default="4541235";
	param name="form.id" default="#url.id#";
	
	variables.condicoes = " 0 = 0";
	if(isDefined("url.id") and isNumeric(url.id)){
		variables.condicoes = variables.condicoes & " and id = " & url.id;
	}
	instCFC = createObject("component","cfc.models.Usuario");
	qCons = instCFC.getUsuarios(condicoesFiltros: variables.condicoes);
	writeDump(qCons);
	
	if(isDefined("url.acao")){
		if(qCons.recordCount > 0 and not compareNoCase(url.acao,"atualizar")) {
			instCFC.salvarRegistro(
				acao: url.acao
				,firstname: form.firstname
				, lastname: form.lastname
				, emailaddress: form.emailaddress
				, password: form.password
				, id: url.id
			);
			variables.msg = "Registro atualizado com sucesso";
		} else if(not compareNoCase(url.acao,"novo")) {
			instCFC.salvarRegistro(
				acao: url.acao
				,firstname: form.firstname
				, lastname: form.lastname
				, emailaddress: form.emailaddress
				, password: form.password
				, id: 0
			);
			variables.msg = "Registro cadastrado com sucesso";
		} else if(not compareNoCase(url.acao,"excluir")) {
			instCFC.salvarRegistro(
				acao: url.acao
				,firstname: ""
				, lastname: ""
				, emailaddress: ""
				, password: ""
				, id: url.id
			);
			variables.msg = "Registro EXCLUÍDO com sucesso";
		}
		qCons = instCFC.getUsuarios(condicoesFiltros: variables.condicoes);
		writeDump(qCons);
	}
</cfscript>
<cfif isDefined("url.acao")> 
	<script>alert("<cfoutput>#msg#</cfoutput>")</script>
</cfif>