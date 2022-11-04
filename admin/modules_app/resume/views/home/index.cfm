<cfscript>
	variables.linkListagem = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentModule();
	variables.condicoes = " 0 = 0 ";
	param name="form.type" default="";


	if(isDefined("form.type") && compareNoCase(form.type, "")){
		variables.condicoes = variables.condicoes & " and type = '#form.type#' ";
	}
	instModel = createObject("component","resume.models.Resume");
	qCons = instModel.getMyResume(condicoesFiltros: variables.condicoes);
	qTypes = instModel.getTypes();
</cfscript>
<cfoutput>
<div class="span10">
	<h2>Resume</h2>
		<form class="navbar-form pull-right" action="#variables.linkListagem#" method="post">
			<div class="control-group">
				<a class="btn btn-primary" href="#event.getHTMLBaseURL()#index.cfm/resume/novo-registro/">
					<i class="icon-plus icon-white"></i>
					New Resume
				</a>
			</div>
			<div class="control-group">
				<label class="control-label" for="type">Type</label>
				<div class="controls">
					<select name="type" id="type" onchange="this.form.submit()">
						<option value="">Select the Type</option>
						<cfloop query="qTypes">
							<option value="#qTypes.type#" <cfif not compareNoCase(form.type, qTypes.type)> selected="selected"</cfif> >#qTypes.type#</option>
						</cfloop>
					</select>
				</div>
			</div>
		</form>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>Title</th>
				<th>Type</th>
				<th>Dates</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>

			<cfloop query="qCons">
				<tr>
					<td>
						<!---title--->
						#qCons.title#
					</td>
					<td>
						<!---type--->
						#qCons.type#
					</td>
					<td>
						<!---startDate and endDate--->
						#qCons.startDate# to #qCons.endDate#
					</td>
					<td>
						<a href="#event.getHTMLBaseURL()#index.cfm/resume/alterar-registro/#qCons.id#">
							<i class="icon-edit"></i>
							Alterar
						</a>
						<a href="#event.getHTMLBaseURL()#index.cfm/resume/excluir-registro/#qCons.id#/excluir">
							<i class="icon-trash"></i>
							Excluir
						</a>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</div>
</cfoutput>