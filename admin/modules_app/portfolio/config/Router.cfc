component{

	function configure(){

		route( "/", "home.index" );
		route( "/novo-registro", "home.editportfolio" );
		route( "/alterar-registro/:id?", "home.editportfolio" );
		route( "/excluir-registro/:id?/:acao?", "home.editportfolio" );

	}

}