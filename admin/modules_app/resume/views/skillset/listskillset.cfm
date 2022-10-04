<cfset qCons = createObject("component","resume.models.SkillSet").getMySkillSet() />
<cfoutput>
<div class="span10">
	<h2>Skillsets</h2>
	<form class="navbar-form pull-right">
		<a class="btn btn-primary" href="#event.getHTMLBaseURL()#index.cfm/resume/skillset/novo-registro">
			<i class="icon-plus icon-white"></i> 
			New Skillset
		</a>
	</form>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>Name</th>
				<th>Actions</th>
			</tr>
		</thead>
		<tbody>
			<cfloop query="qCons">
				<tr>
					<td>
						<!---Name--->
						#qCons.name#
					</td>
					<td>
						<a href="#event.getHTMLBaseURL()#index.cfm/resume/skillset/alterar-registro/#qCons.id#">
							<i class="icon-edit"></i>
							Alterar
						</a>
						<a href="#event.getHTMLBaseURL()#index.cfm/resume/skillset/excluir-registro/#qCons.id#/excluir">
							<i class="icon-edit"></i>
							Excluir
						</a>
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</div>
</cfoutput>