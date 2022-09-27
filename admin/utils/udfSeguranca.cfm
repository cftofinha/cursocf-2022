<cfscript>
	//verifica login
	function logado() {
		return getAuthUser() neq "";
	}
</cfscript>