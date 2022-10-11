<cfset ormReload() />
<cfset qAdministrator = entityLoad("Administrator") />
<cfdump var="#qAdministrator#" label="qAdministrator">
<br><hr><br>
<cfset qPortfolio = entityLoad("Portfolio") />
<cfset q = entityToQuery(qPortfolio) />
<cfdump var="#q#" label="q">

