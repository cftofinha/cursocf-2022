component{

	function configure(){

		route( "/", "home.index" );
		route( "/novo-registro", "home.editadministrator" );
		route( "/alterar-registro/:id?", "home.editadministrator" );
		route( "/excluir-registro/:id?/:acao?", "home.editadministrator" );

	}

}