component{

	function configure(){

		route( "/", "home.index" );
		route( "/chamadas-ajax/posts", "posts.testes" );
		route( "/chamadas-ajax/portfolio", "portfolio.index" );

	}

}