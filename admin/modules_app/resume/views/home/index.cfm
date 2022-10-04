<cfscript>
	variables.condicoes = " 0 = 0 ";
	qCons = createObject("component","resume.models.Resume").getMyResume(condicoesFiltros: variables.condicoes);
</cfscript>
<cfoutput>
<div class="span10">
	<h2>Resume</h2>
		<form class="navbar-form pull-right">
			<a class="btn btn-primary" href="#event.getHTMLBaseURL()#index.cfm/resume/novo-registro/">
				<i class="icon-plus icon-white"></i> 
				New Resume
			</a>
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