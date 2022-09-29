<!--- Pull Blog Posts --->
<cfoutput>
		<div class="span10">
			<h2>Blog</h2>
			    <form class="navbar-form pull-right">
			    	<a class="btn btn-primary" href="#event.getHTMLBaseURL()#index.cfm/blog/novo-registro">
						<i class="icon-plus icon-white"></i> 
						New Blog Post
					</a>
			    </form>
			<table class="table table-hover">
				<thead>
					<tr>
						<th>Title</th>
						<th>Publish Date</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					
						<tr>
							<td>
								<!--- Title --->
									
							</td>
							<td>
								<!--- Date Posted --->
								
							</td>
							<td>
								<!--- Edit Post --->
								<a href="#event.getHTMLBaseURL()#index.cfm/blog/alterar-registro/"><i class="icon-edit"></i></a>
							</td>
						</tr>

				</tbody>
		    </table>
		</div>
</cfoutput>
