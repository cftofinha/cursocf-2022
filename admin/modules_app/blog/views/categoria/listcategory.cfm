<!--- Pull Categories --->
<cfoutput>
	<div class="span10">
		<h2>Category</h2>
		<form class="navbar-form pull-right">
			<a class="btn btn-primary" href="">
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
				
					<tr>
						<td>
							<!--- Name --->
						</td>
						<td>
							<!--- Edit Category --->
							<a href=""><i class="icon-edit"></i></a>
							<!--- Delete Category --->
							<a href=""><i class="icon-trash"></i></a>
						</td>
					</tr>
			</tbody>
		</table>
	</div>
</cfoutput>
