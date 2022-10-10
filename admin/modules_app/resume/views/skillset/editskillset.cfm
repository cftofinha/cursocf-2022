<cfscript>
	instModel = createObject("component","resume.models.SkillSet");
	errorBean = createObject('cursocf.admin.utils.errorBean').init();
	variables.linkListagem = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentModule() & "/skillset";
	variables.linkActionForm = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentRoutedURL();
</cfscript>
<cfif structKeyExists(event.getRoutedStruct(),"id") and isNumeric(event.getRoutedStruct().id)>
	<cfset variables.idRegistro = event.getRoutedStruct().id />
	<cfif structKeyExists(event.getRoutedStruct(),"acao") && not compareNoCase(event.getRoutedStruct().acao,"excluir")>
		<cfset salvarRegistro = instModel.salvarRegistro(
			acao: "excluir"
			, id: event.getRoutedStruct().id
			, name: ""
		) />
		<script>
			msg = "\n Sua pagina será redirecionada para a listagem";
			alert("<cfoutput>#salvarRegistro.mensagem#</cfoutput>" + msg);
			window.location.href = "<cfoutput>#variables.linkListagem#</cfoutput>";
		</script>
	</cfif>
<cfelse>
	<cfset variables.idRegistro = 0 />
</cfif> 
<cfparam name="form.submitted" default="0" />
<cfif form.submitted>
	<!--- check if data is valid--->
	<cfif !len(trim(form.name))>
		<cfset errorBean.addError('Name is required','name') />
	</cfif>
	
	<!--- Only process if there are no errors --->
	<cfif !errorBean.hasErrors()>
		<cfset salvarRegistro = instModel.salvarRegistro(
			acao: form.acao
			, id: form.id
			, name: form.name
		) />
		
		<!---<cfdump var="#salvarRegistro#" abort="true" >--->
		<cfif not compareNoCase(salvarRegistro.retorno, "erro")>
			<cfdump var="#salvarRegistro#">
		<cfelse>
			<script>
				msg = "\n Sua pagina será redirecionada para a listagem";
				alert("<cfoutput>#salvarRegistro.mensagem#</cfoutput>" + msg);
				window.location.href = "<cfoutput>#variables.linkListagem#</cfoutput>";
			</script>
		</cfif>
		
	</cfif>	
</cfif>

<cfset qCons = instModel.getDetalharRegistro(id: variables.idRegistro) />
<cfoutput>
	<div class="span10">
		<cfif qCons.recordCount>
			<h2>Edit SkillSet</h2>
			<cfset variables.acao = "atualizar" />
		<cfelse>
			<h2>Add SkillSet</h2>
			<cfset variables.acao = "novo" />
		</cfif>
		
		<cfif errorBean.hasErrors()>
			<div class="alert alert-error">
				<strong>Error</strong><br />
				The following errors occured:
				<ul>
					<cfloop array="#errorBean.getErrors()#" index="error">
						<li>#error.message#</li>
					</cfloop>
				</ul>
			</div>
		</cfif>
		
		<form class="form-horizontal" action="#variables.linkActionForm#" method="post">
			<input type="hidden" name="submitted" value="1" />
			<input type="hidden" name="acao" value="#variables.acao#" />
			<input type="hidden" name="id" value="#variables.idRegistro#" />
			<div class="control-group">
				<label class="control-label" for="title">Name</label>
				<div class="controls">
					<input type="text" id="name" name="name" value="#qCons.name#">
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<button type="submit" class="btn btn-primary">Save</button>
				</div>
			</div>
			
		</form>
	</div>
</cfoutput>
