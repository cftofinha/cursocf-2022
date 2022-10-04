component{

	function configure(){

		route( "/", "home.index" );
		route( "/novo-registro", "home.editblogpost" );
		route( "/alterar-registro/:id?", "home.editblogpost" );
		route( "/excluir-registro/:id?/:acao?", "home.editblogpost" );
		
		//categorias
		route( "/categorias", "categoria.listcategory" );
		route( "/categorias/novo-registro", "categoria.editblogpost" );
		route( "/categorias/alterar-registro/:id?", "categoria.editcategory" );
		route( "/categorias/excluir-registro/:id?/:acao?", "categoria.editcategory" );
	}

}