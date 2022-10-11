<cfscript>
	param name="url.acao" default="";
	param name="url.id" default="";
	ormReload();
	
	/*test = ORMExecuteQuery("select count(*) from Portfolio", [], true);
	writeDump(test);*/
	
	if(not compareNoCase(url.acao, "novo")){
		qSalvar = entityNew("Portfolio");
		
	} else if (not compareNoCase(url.acao, "atualizar") && isNumeric(url.id)){
		qSalvar = entityLoadByPK("Portfolio", url.id);
	}
	
	qSalvar.setTitle("Testes xpto");
	qSalvar.setSummary("Sumary xpto");
	qSalvar.setWebsite("www.xpto.com");
	qSalvar.setImage("");
	
	entitySave(qSalvar);
	
	ormFlush();
	
	
	
/*	portfolios = entityload("Portfolio");
	writeDump(portfolios);
	
	categorias = entityload("PortfolioCategory");
	writeDump(categorias);
	*/
</cfscript>
<cfoutput>
<div class="text-center card shadow-sm bg-light border border-5 border-white">
	<div class="card-body">
		<div class="badge bg-info mb-2">
			<strong>#getColdBoxSetting( "version" )# (#getColdBoxSetting( "suffix" )#)</strong>
		</div>

		<h1 class="display-5 fw-bold">
			#prc.welcomeMessage#
		</h1>
		
		<cfdump var="#session#">

		<div class="col-lg-6 mx-auto">
			<p class="lead mb-4">
				Welcome to modern ColdFusion (CFML) development.  You can now start building your application with ease, we already did the hard work
				for you.
				#event.getHTMLBaseURL()#
			</p>
		</div>
	</div>
</div>

</cfoutput>
