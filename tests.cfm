<cfprocessingdirective pageencoding="utf-8">
<cfscript>
	formatar = createObject("component","cfc.utilities");
	
	limparTexto = formatar.LimpaTexto(texto: "Acentuação");
	writeDump(limparTexto);
</cfscript>