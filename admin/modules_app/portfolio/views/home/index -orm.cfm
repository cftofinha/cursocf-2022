<cfscript>
	qCons = entityLoad("Portfolio");
	variables.linkExcluir = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentModule() & "/excluir-registro";
	variables.linkEdicao = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentModule() & "/alterar-registro";
	variables.linkNovo = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentModule() & "/novo-registro";
	//writeDump(qCons);
</cfscript>
<cfoutput>
	<div class="span10">
		    <form class="navbar-form pull-right">
		    	<a class="btn btn-primary" href="#variables.linkNovo#">
					<i class="icon-plus icon-white"></i>
					New Portfolio
				</a>
		    </form>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>Title</th>
					<th>Website</th>
					<th>Category</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<cfloop array="#qCons#" index="p">
					<tr>
						<td>
							#p.getTitle()#
						</td>
						<td>
							#p.getWebsite()#
						</td>
						<td>
							<cfif isNull(p.getCategorias())>
								Sem categoria informada
							<cfelse>
								#p.getCategorias().getName()#
							</cfif>
							<!---<cfdump var="#p.getCategorias()#">--->
						</td>
						<td>
							<a href="#variables.linkEdicao#/#p.getId()#">
								<i class="icon-edit"></i>
								Alterar
							</a>
							<a href="#variables.linkExcluir#/#p.getId()#/excluir">
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