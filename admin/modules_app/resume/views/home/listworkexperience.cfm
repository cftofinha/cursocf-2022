<cfscript>
	variables.condicoes = " type = 'Work Experience' ";
	qCons = createObject("component","resume.models.Resume").getMyResume(condicoesFiltros: variables.condicoes);
</cfscript>
<cfoutput>
<div class="span10">
	<h2>Work Experience</h2>
	<form class="navbar-form pull-right">
		<a class="btn btn-primary" href="#event.getHTMLBaseURL()#index.cfm/resume/workexperience/novo-registro">
			<i class="icon-plus icon-white"></i> 
			New Work Experience
		</a>
	</form>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>Position</th>
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
						<!---startDate and endDate--->
						#qCons.startDate# to #qCons.endDate#
					</td>
					<td>
						<a href="#event.getHTMLBaseURL()#index.cfm/resume/workexperience/alterar-registro/#qCons.id#">
							<i class="icon-edit"></i>
							Alterar
						</a>
						<a href="#event.getHTMLBaseURL()#index.cfm/resume/workexperience/excluir-registro/#qCons.id#/excluir">
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