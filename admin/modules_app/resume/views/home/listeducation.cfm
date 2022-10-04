<cfscript>
	variables.condicoes = " type = 'Education' ";
	qCons = createObject("component","resume.models.Resume").getMyResume(condicoesFiltros: variables.condicoes);
</cfscript>
<cfoutput>
<div class="span10">
	<h2>Education</h2>
		<form class="navbar-form pull-right">
			<a class="btn btn-primary" href="#event.getHTMLBaseURL()#index.cfm/resume/education/novo-registro/">
				<i class="icon-plus icon-white"></i> 
				New Education
			</a>
		</form>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>School</th>
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
						<a href="#event.getHTMLBaseURL()#index.cfm/resume/education/alterar-registro/#qCons.id#">
							<i class="icon-edit"></i>
							Alterar
						</a>
						<a href="#event.getHTMLBaseURL()#index.cfm/resume/education/excluir-registro/#qCons.id#/excluir">
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