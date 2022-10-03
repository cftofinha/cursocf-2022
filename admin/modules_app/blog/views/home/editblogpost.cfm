<cfscript>
	instModelBlog = createObject("component","blog.models.Blog");
	instModelScript = createObject("component","blog.models.BlogScript");
	errorBean = createObject('cursocf.admin.utils.errorBean').init();
</cfscript>
<!---<cfdump var="#event.getRoutedStruct()#">--->
<cfif structKeyExists(event.getRoutedStruct(),"id") and isNumeric(event.getRoutedStruct().id)>
	<cfset variables.idRegistro = event.getRoutedStruct().id />
	<cfif structKeyExists(event.getRoutedStruct(),"acao") && not compareNoCase(event.getRoutedStruct().acao,"excluir")>
		<cfset salvarRegistro = instModelBlog.salvarRegistro(
			acao: "excluir"
			, blogpostid: event.getRoutedStruct().id
			, title: ""
			, summary: ""
			, body: ""
			, dateposted: ""
		) />
		<!---<cflocation url="" addtoken="false" />--->
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
	<cfif !len(trim(form.title))>
		<cfset errorBean.addError('Title is required','title') />
	</cfif>	
	
	<cfif !len(trim(form.summary))>
		<cfset errorBean.addError('A summary is required','startDate') />
	</cfif>	
	
	<cfif !len(trim(form.body))>
		<cfset errorBean.addError('You need to provide a body','details') />
	</cfif>	
	
	<cfif !len(trim(form.datePosted))>
		<cfset errorBean.addError('You need to provide a release date','details') />
	</cfif>			
	
	<!--- Only process if there are no errors --->
	<cfif !errorBean.hasErrors()>
		<cfset salvarRegistro = instModelScript.salvarRegistro(
			acao: form.acao
			, blogpostid: form.id
			, title: form.title
			, summary: form.summary
			, body: form.body
			, dateposted: form.dateposted
		) />
		<cfdump var="#salvarRegistro#">
		<!---<cfif not compareNoCase(salvarRegistro.retorno, "erro")>
			<cfdump var="#salvarRegistro#">
		<cfelse>
			<script>
				msg = "\n Sua pagina será redirecionada para a listagem";
				alert("<cfoutput>#salvarRegistro.mensagem#</cfoutput>" + msg);
				window.location.href = "<cfoutput>#event.getHTMLBaseURL()#index.cfm/#event.getCurrentModule()#</cfoutput>";
			</script>
		</cfif>--->
		
	</cfif>	
</cfif>

<cfset qCons = instModelBlog.getPostBlogDetalhe(idBlog: variables.idRegistro) />

<cfif !qCons.recordCount>
	<cfset variables.acao = "novo" />
	<cfset variables.idRegistro = 0 />
	<cfset variables.tituloForm = "Novo Registro" />
<cfelse>
	<cfset variables.acao = "atualizar" />
	<cfset variables.idRegistro = qCons.id />
	<cfset variables.tituloForm = "Alterar Registro" />
</cfif>

<cfoutput>
		<div class="span10" style="top:150px !important;">
			<cfif qCons.recordCount>
				<h2>Edit Blog Post</h2>
			<cfelse>
				<h2>Add Blog Post</h2>
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
				<div class="control-group">
					<label class="control-label" for="title">Title</label>
					<div class="controls">
						<input type="text" id="title" name="title" value="#qCons.titulo#">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="title">Summary</label>
					<div class="controls">
						<textarea rows="6" id="summary" name="summary" class="input-xlarge">#qCons.resumo#</textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="title">Body</label>
					<div class="controls">
						<textarea rows="3" id="body" name="body" class="wysiwyg">#qCons.conteudo#</textarea>
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="details">Publish Date</label>
					<div class="controls">
						<input type="text" id="datePosted" name="datePosted" class="datepicker" value="#qCons.dataPostagem#">
					</div>
				</div>
				
				<div class="control-group">
					<label class="control-label" for="details">Categories</label>
					<div class="controls">
							<label class="checkbox">
							<!---<cfloop array="#categories#" index="category">
								<input type="checkbox" name="Categories" value="#category.id#" <cfif listfind(form.categories,category.id)>checked</cfif>>#category.name#<br />
							</cfloop>--->
						</label>
					</div>
				</div>
				<div class="control-group">
					<div class="controls">
						<button type="submit" class="btn btn-primary">Save</button>
					</div>
				</div>
				<input type="hidden" name="submitted" value="1" />
				<input type="hidden" name="id" value="#variables.idRegistro#" />
				<input type="hidden" name="acao" value="#variables.acao#" />
			</form>
		</div>	
</cfoutput>
