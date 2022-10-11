<cfscript>
	variables.linkExcluir = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentModule() & "/excluir-registro";
	variables.linkEdicao = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentModule() & "/alterar-registro";
	variables.linkNovo = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentModule() & "/novo-registro";
</cfscript>
<cfoutput>
	<div class="span10">
		    <form class="navbar-form pull-right">
		    	<a class="btn btn-primary" href="#variables.linkNovo#">
					<i class="icon-plus icon-white"></i> 
					New User Admin
				</a>
		    </form>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Nome</th>
					<th>Email</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				
					<tr>
						<td>
							
						</td>
						<td>
							
						</td>
						<td>
							<a href="#variables.linkEdicao#/">
								<i class="icon-edit"></i>
								Alterar
							</a>
							<a href="#variables.linkExcluir#/----/excluir">
								<i class="icon-edit"></i>
								Excluir
							</a>
						</td>
					</tr>
			</tbody>
	    </table>
	</div>	
</cfoutput>