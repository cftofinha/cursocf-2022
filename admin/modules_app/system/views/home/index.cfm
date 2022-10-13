<cfscript>
	ormReload();
	users = entityLoad("Administrator");
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
				<cfloop array="#users#" index="u">
					<tr>
						<td>
							#u.getFirstname()#
						</td>
						<td>
							#u.getEmailaddress()#
						</td>
						<td>
							<a href="#variables.linkEdicao#/#u.getId()#">
								<i class="icon-edit"></i>
								Alterar
							</a>
							<a href="#variables.linkExcluir#/#u.getId()#/excluir">
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