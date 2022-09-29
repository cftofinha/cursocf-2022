<cfscript>
	param name="url.id" default="1";
	instModel = createObject("component","cfc.models.BlogScript");
	
	queryExecute2 = instModel.getQueryExecute2(titulo: "ColdFusion scheduled tasks");
	writeDump(queryExecute2);
	
	writeOutput("<br><hr><br>");
	
	queryExecute3 = instModel.getQueryExecute3();
	writeDump(queryExecute3);
	
	writeOutput("<br><hr><br>");
	
	qPostsBlog = instModel.getPostsBlosg(id: url.id);
	writeDump(qPostsBlog);
	
	writeOutput("<br><hr><br>");
	
	queryExecute = instModel.getQueryExecute();
	writeDump(queryExecute);
	
	
</cfscript>