<!--- Pull Blog Posts --->
<cfset qCons = createObject("component","blog.models.Blog").getPostsBlog() />
<!---<cfdump var="#qCons#"><cfabort>--->
<cfoutput>
		<div class="span10">
			<h2>Blog</h2>
			    <form class="navbar-form pull-right">
			    	<a class="btn btn-primary" href="#event.getHTMLBaseURL()#index.cfm/blog/novo-registro">
						<i class="icon-plus icon-white"></i> 
						New Blog Post
					</a>
			    </form>
			<!---<cfdump var="#event#">--->
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Title</th>
						<th>Category</th>
						<th>Publish Date</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<cfloop query="qCons">
						<tr>
							<td>
								<!--- Title --->
								#qCons.titulo#
							</td>
							<td>
								<!--- categoria --->
								#qCons.nomeCategoria#
							</td>
							<td>
								<!--- Date Posted --->
								#qCons.dataPostagem#
							</td>
							<td>
								<!--- Edit Post --->
								<a href="#event.getHTMLBaseURL()#index.cfm/blog/alterar-registro/#qCons.id#">
									<i class="icon-edit"></i>Alterar
								</a>
								<!--- Delete Post --->
								<a href="#event.getHTMLBaseURL()#index.cfm/blog/excluir-registro/#qCons.id#/excluir">
									<i class="icon-edit"></i>Excluir
								</a>
							</td>
						</tr>
					</cfloop>
				</tbody>
		    </table>
		</div>
</cfoutput>
