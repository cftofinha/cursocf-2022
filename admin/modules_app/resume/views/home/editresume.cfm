<cfscript>
	instModel = createObject("component","resume.models.Resume");
	errorBean = createObject('cursocf.admin.utils.errorBean').init();
	variables.linkListagem = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentModule();
	variables.linkActionForm = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentRoutedURL();
	qTypes = instModel.getTypes();
</cfscript>

<cfif structKeyExists(event.getRoutedStruct(),"id") and isNumeric(event.getRoutedStruct().id)>
	<cfset variables.idRegistro = event.getRoutedStruct().id />
	<cfif structKeyExists(event.getRoutedStruct(),"acao") && not compareNoCase(event.getRoutedStruct().acao,"excluir")>
		<cfset salvarRegistro = instModel.salvarRegistro(
			acao: "excluir"
			, id: event.getRoutedStruct().id
			, title: ""
			, startDate: ""
			, endDate: ""
			, details: ""
			, type: ""
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
	<cfif !len(trim(form.title))>
		<cfset errorBean.addError('Title is required','title') />
	</cfif>
	<cfif !len(trim(form.startDate))>
		<cfset errorBean.addError('startDate is required','startDate') />
	</cfif>
	<cfif !len(trim(form.endDate))>
		<cfset errorBean.addError('endDate is required','endDate') />
	</cfif>
	<cfif !len(trim(form.details))>
		<cfset errorBean.addError('details is required','details') />
	</cfif>
	<cfif !len(trim(form.type))>
		<cfset errorBean.addError('type is required','type') />
	</cfif>
	
	<!--- Only process if there are no errors --->
	<cfif !errorBean.hasErrors()>
		<cfset salvarRegistro = instModel.salvarRegistro(
			acao: form.acao
			, id: form.id
			, title: form.title
			, startDate: form.startDate
			, endDate: form.endDate
			, details: form.details
			, type: form.type
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
			<h2>Edit Record</h2>
			<cfset variables.acao = "atualizar" />
		<cfelse>
			<h2>Add Record</h2>
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
			<input type="hidden" name="acao" value="#variables.acao#">
			<input type="hidden" name="id" value="#variables.idRegistro#" />
			
			<div class="control-group">
				<label class="control-label" for="title">Title</label>
				<div class="controls">
					<input type="text" id="title" name="title" value="#qCons.title#">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="type">Type</label>
				<div class="controls">
					<select name="type" id="type">
						<option value="">Select the Type</option>
						<cfloop query="qTypes">
							<option value="#qTypes.type#" <cfif not compareNoCase(qCons.type, qTypes.type)> selected="selected"</cfif> >#qTypes.type#</option>
						</cfloop>
					</select>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="dates">Dates</label>
				<div class="controls">
					<input type="text" id="startDate" name="startdate" class="input-medium datepicker" value="#qCons.startdate#">
						to 
					<input type="text" id="endDate" name="endDate" class="input-medium datepicker" value="#qCons.endDate#">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="details">Details</label>
				<div class="controls">
					<textarea rows="3" id="details" name="details" class="wysiwyg">#qCons.details#</textarea>
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
