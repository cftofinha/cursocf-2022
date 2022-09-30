component{

	function configure(){

		route( "/", "home.index" );
		route( "/novo-registro", "home.editblogpost" );
		route( "/alterar-registro/:id?", "home.editblogpost" );
		route( "/excluir-registro/:id?/:acao?", "home.editblogpost" );
	}

}