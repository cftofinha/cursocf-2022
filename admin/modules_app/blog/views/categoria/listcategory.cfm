<cfset qCons = createObject("component","blog.models.Categorias").getCategorias() />
<!--- Pull Categories --->
<cfoutput>
	<div class="span10">
		<h2>Category</h2>
		<form class="navbar-form pull-right">
			<a class="btn btn-primary" href="#event.getHTMLBaseURL()#index.cfm/blog/categorias/novo-registro">
				<i class="icon-plus icon-white"></i> 
				New Category
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
							<!--- Name --->
							#qCons.name#
						</td>
						<td>
							<!--- Edit Category --->
							<a href="#event.getHTMLBaseURL()#index.cfm/blog/categorias/alterar-registro/#qCons.id#">
								<i class="icon-edit"></i>
								Alterar
							</a>
							<!--- Delete Category --->
							<a href="#event.getHTMLBaseURL()#index.cfm/blog/categorias/excluir-registro/#qCons.id#/excluir">
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
