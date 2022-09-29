component{

	function configure(){

		route( "/", "home.index" );
		route( "/novo-registro", "home.editblogpost" );
		route( "/alterar-registro/:id?", "home.editblogpost" );

	}

}