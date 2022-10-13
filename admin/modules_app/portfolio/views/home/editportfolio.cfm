<cfscript>
	param name="form.submitted" default="0";
	errorBean = createObject('cursocf.admin.utils.errorBean').init();
	variables.linkListagem = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentModule();
	variables.linkActionForm = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentRoutedURL();
	variables.pastaBase = expandPath('/') & "cursocf\assets\images\portfolio";
	categorias = entityLoad("PortfolioCategory");
	qCategorias = entityToQuery(categorias);
	//writeDump(qCategorias); 
</cfscript>

<cfif structKeyExists(event.getRoutedStruct(),"id") and isNumeric(event.getRoutedStruct().id)>
	<cfset qDados = entityLoadByPK("Portfolio", event.getRoutedStruct().id) />
	<cfset variables.idRegistro = event.getRoutedStruct().id />
	<cfif structKeyExists(event.getRoutedStruct(),"acao") && not compareNoCase(event.getRoutedStruct().acao,"excluir")>
		<cfset entityDelete(qDados) />
		<cfset ormFlush() />
			<script>
				msg = "\n Sua pagina será redirecionada para a listagem";
				alert("Registro Excluído com sucesso");
				window.location.href = "<cfoutput>#variables.linkListagem#</cfoutput>";
			</script>
	</cfif>
<cfelse>
	<cfset variables.idRegistro = 0 />
</cfif>

<cfif form.submitted>
	<cfif !len(trim(form.title))>
		<cfset errorBean.addError('A Title is required','title') />
	</cfif>	
	
	
	<cfif !errorBean.hasErrors()>
		<!--- Image Upload Process --->
		<cfif len(trim(form.image))>
			<cftry>
				<cffile action="upload" filefield="image" destination="#variables.pastaBase#" nameconflict="makeunique"  />
				
				<cfif listFindNoCase(getReadableImageFormats(),cffile.serverFileExt)>
					<cfset imageObject = imageRead(cffile.serverDirectory & '/' & cffile.serverfile) />
					<cfset imageSCaleToFit(imageObject,'202','131') />
					<cfset imageWrite(imageObject,"#variables.pastaBase#/#cffile.serverfile#") />
					<cfset form.image = cffile.serverfile />
				<cfelse>
					<cfset form.image = form.imageOld />
				</cfif>
				
				<cfcatch type="any">
					<cfdump var="#cfcatch#">
					<cfabort>
				</cfcatch>
			</cftry>
		<cfelse>
			<cfset form.image = form.imageOld />
		</cfif>
		<!--- Save Portfolio --->
			<cftry>
				<cfif form.id eq 0>
					<cfset qDados = entityNew("Portfolio") />
				<cfelse>
					<cfset qDados = entityLoadByPK("Portfolio", form.id) />
				</cfif>
				<cfset categoria = entityLoad("PortfolioCategory", form.categoryId, true) />
				<!---<cfdump var="#categoria#"><cfabort>--->
				<cfset qDados.setTitle(form.title) />
				<cfset qDados.setSummary(form.summary) />
				<cfset qDados.setWebsite(form.website) />
				<cfset qDados.setImage(form.image) />
				<!---<cfset qDados.setCategorias(categoria) />--->
				<cfset entitySave(qDados) />
				<cfset ormFlush() />
			<cfcatch type="any">
				<cfdump var="#cfcatch#"><cfabort>
			</cfcatch>
			</cftry>
		
		<script>
			msg = "\n Sua pagina será redirecionada para a listagem";
			alert("Registro Salvo com sucesso");
			window.location.href = "<cfoutput>#variables.linkListagem#</cfoutput>";
		</script>
		
	</cfif>	
</cfif>

<cfoutput>
		
		<div class="span10">
			<cfif isDefined('qDados')>
				<h2>Edit Portfolio</h2>
			<cfelse>
				<h2>Add Portfolio</h2>
			</cfif>
			<cfdump var="#variables.pastaBase#">
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
			
			<form class="form-horizontal" action="#variables.linkActionForm#" method="post" enctype="multipart/form-data">
				<div class="control-group">
					<label class="control-label" for="title">Title</label>
					<div class="controls">
						<input type="text" id="title" name="title" value="<cfif isDefined('qDados')>#qDados.getTitle()#</cfif>">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="summary">Summary</label>
					<div class="controls">
						<textarea rows="3" id="summary" name="summary"><cfif isDefined('qDados')>#qDados.getSummary()#</cfif></textarea>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="website">Website</label>
					<div class="controls">
						<input type="text" id="website" name="website" value="<cfif isDefined('qDados')>#qDados.getWebsite()#</cfif>">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="website">Categorys</label>
					<div class="controls">
						<select name="categoryId">
							<option value="">Selecione a Categoria</option>
							<cfloop query="qCategorias">
								<option value="#qCategorias.id#" <cfif isDefined('qDados') and not isNull(qDados.getCategorias()) and qDados.getCategorias().getId() eq qCategorias.id> selected="selected"</cfif> >#qCategorias.name#</option>
							</cfloop>
						</select>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="image">Image</label>
					<div class="controls">
						<input type="file" id="image" name="image" value="">
						<input type="hidden" id="imageOld" name="imageOld" value="<cfif isDefined('qDados')>#qDados.getImage()#</cfif>">
					</div>
				</div>
				<div class="control-group">
					<div class="controls">
						<button type="submit" class="btn btn-primary">Save</button>
					</div>
				</div>
				<input type="hidden" name="submitted" value="1" />
				<input type="hidden" name="id" value="#variables.idRegistro#" />
			</form>
		</div>	
</cfoutput>
