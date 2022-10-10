<cfset ormReload() />
<cfset qAdministrator = entityLoad("Administrator") />
<cfdump var="#qAdministrator#" label="qAdministrator">
<br><hr><br>
<cfset qPortfolio = entityLoad("Portfolio") />
<cfset q = entityToQuery(qPortfolio) />
<cfdump var="#q#" label="q">

<cfscript>
	if(url.id eq 0){
		qSalvar = EntityNew("Administrator");
	} else {
		qSalvar = EntityLoadByPK("Administrator", url.id);
	}
	
	qSalvar.setFirstname("Francisco 2");
	qSalvar.setLastname("Paulino");
	qSalvar.setEmailaddress("testes@gmail.com");
	entitySave(qSalvar);
</cfscript>