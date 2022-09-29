<cfscript>
	param name="url.id" default="1";
	instModel = createObject("component","cfc.models.BlogScript");
	
	queryExecute3 = instModel.getQueryExecute3();
	writeDump(queryExecute3);
	
	writeOutput("<br><hr><br>");
	
	qPostsBlog = instModel.getPostsBlosg(id: url.id);
	writeDump(qPostsBlog);
	
	writeOutput("<br><hr><br>");
	
	queryExecute = instModel.getQueryExecute();
	writeDump(queryExecute);
	
	writeOutput("<br><hr><br>");
	
	queryExecute2 = instModel.getQueryExecute2();
	writeDump(queryExecute2);
</cfscript>