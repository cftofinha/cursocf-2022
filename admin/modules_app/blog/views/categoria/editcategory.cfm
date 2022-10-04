<cfscript>
	instModelBaseCategorias = createObject("component","blog.models.Categorias");
	errorBean = createObject('cursocf.admin.utils.errorBean').init();
</cfscript>

<cfif structKeyExists(event.getRoutedStruct(),"id") and isNumeric(event.getRoutedStruct().id)>
	<cfset variables.idRegistro = event.getRoutedStruct().id />
	<cfif structKeyExists(event.getRoutedStruct(),"acao") && not compareNoCase(event.getRoutedStruct().acao,"excluir")>
		<cfset salvarRegistro = instModelCategorias.salvarRegistro(
			acao: "excluir"
			, blogcategoryid: event.getRoutedStruct().id
			, name: ""
		) />
		<script>
			msg = "\n Sua pagina será redirecionada para a listagem";
			alert("<cfoutput>#salvarRegistro.mensagem#</cfoutput>" + msg);
			window.location.href = "<cfoutput>#event.getHTMLBaseURL()#index.cfm/#event.getCurrentModule()#</cfoutput>";
		</script>
	</cfif>
<cfelse>
	<cfset variables.idRegistro = 0 />
</cfif> 
<cfparam name="form.submitted" default="0" />
<cfif form.submitted>
	<!--- check if data is valid--->
	<cfif !len(trim(form.name))>
		<cfset errorBean.addError('Name is required','title') />
	</cfif>	
	
	<!--- Only process if there are no errors --->
	<cfif !errorBean.hasErrors()>
		<cfset salvarRegistro = instModelCategorias.salvarRegistro(
			acao: form.acao
			, blogcategoryid: form.id
			, name: form.name
		) />
		
		<!---<cfdump var="#salvarRegistro#" abort="true" >--->
		<cfif not compareNoCase(salvarRegistro.retorno, "erro")>
			<cfdump var="#salvarRegistro#">
		<cfelse>
			
			<script>
				msg = "\n Sua pagina será redirecionada para a listagem";
				alert("<cfoutput>#salvarRegistro.mensagem#</cfoutput>" + msg);
				window.location.href = "<cfoutput>#event.getHTMLBaseURL()#index.cfm/#event.getCurrentModule()#</cfoutput>";
			</script>
		</cfif>
		
	</cfif>	
</cfif>

<cfset qCons = instModelCategorias.getDetalgarRegistro(id: variables.idRegistro) />
<cfoutput>
	<div class="span10">
		<cfif qCons.recordCount>
			<h2>Edit Category</h2>
		<cfelse>
			<h2>Add Category</h2>
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
		
		<form class="form-horizontal" action="#event.getHTMLBaseURL()#index.cfm/#event.getCurrentRoutedURL()#" method="post">
			<input type="hidden" name="submitted" value="1" />
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
