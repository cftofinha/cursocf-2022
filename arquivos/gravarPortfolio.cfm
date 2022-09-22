<cfprocessingdirective pageencoding="utf-8" >
<cfset instCFC = createObject("component","cfc.models.Portfolio") />
<cfif isDefined("form.submitted") and form.submitted eq 1>
	<cfif len(trim(form.image))>
		<cfset variables.codUUID = createUUID()>
		<cfset variables.pastaBase = expandPath('/') & "cursocf/assets/images/portfolio" />
		
		<cffile action="upload" filefield="form.image" destination="#variables.pastaBase#\" nameconflict="makeunique">
		
		<cfset variables.nomeArquivo = left(variables.codUUID,8) &"_"& lsDateFormat(now(), "ddmmyy") &"T"& lsTimeFormat(now(),"HHmm") &"."& file.serverFileExt>
		<cfset variables.nomeArquivoFinal = lCase(variables.nomeArquivo)>
		
		<cfset variables.arquivoEnviado = variables.pastaBase &"\"& file.serverFile>
		<cffile action="rename" source="#variables.arquivoEnviado#" destination="#variables.pastaBase#\#variables.nomeArquivoFinal#">
		<cfset variables.arquivoEnviado = 1/>
	<cfelse>
		<cfset variables.arquivoEnviado = 0/>
		<cfset variables.nomeArquivoFinal = form.imageOld />
	</cfif>
	<cfset qSalvarPortfolio = instCFC.salvarRegistro(
			acao: "novo"
			, title: form.title
			, summary: form.summary
			, website: form.website
			, image: variables.nomeArquivoFinal
			, id: form.id) />
</cfif>

<cfparam name="url.id" default="">
<cfif isDefined("url.id") and isNumeric(url.id)>
	<cfset variables.condicoes = "a.id = " & url.id />
	<cfset variables.acao = "atualizar" />
	<cfset variables.idRegistro = url.id />
<cfelse>
	<cfset variables.condicoes = "a.id = 0">
	<cfset variables.acao = "novo" />
	<cfset variables.idRegistro = 0 />
</cfif>
<cfset qCons = instCFC.getPortfolio(condicoesFiltros: variables.condicoes) />

<!---<cfscript>
	instCFC = createObject("component","cfc.models.Portifolio");
	fileObj = createObject('component','fileio');
	fileObj.fileUpload('form.something','c:\');
</cfscript>--->
<cfoutput>
<form action="gravarPortfolio.cfm" method="post" id="form" enctype="multipart/form-data">
		<input type="hidden" name="id" id="id" value="#variables.idRegistro#">
		<input type="hidden" name="acao" id="acao" value="#variables.acao#">
		<div>
			<label>Titulo <span class="font-11">(required)</span></label>
			<input name="title" id="title" type="text" class="required" value="#qCons.title#" />
		</div>
		<br />
		<div class="textarea">
			<label>Conteúdo <span class="font-11">(required)</span></label>				
			<textarea name="summary" id="summary" rows="6" cols="60" class="required">#qCons.summary#</textarea>
		</div>
		<br />
		<div>
			<label>Site <span class="font-11">(required)</span></label>
			<input name="website" id="website" type="text" class="required" value="#qCons.website#" />
		</div>
		<br />
		<div>
			<label>Arquivo <span class="font-11">(required)</span></label>
			<input name="image" id="image" type="file" class="required" />
			<input name="imageOld" id="imageOld" type="hidden" value="#qCons.image#" />
		</div>
		<br />
		<div>
			<input id="submitBtn" value="Salvar Dados"  name="submit" type="submit" class="submitBtn" />
		</div>
		<input type="hidden" name="submitted" value="1" />
	</form>
</cfoutput>