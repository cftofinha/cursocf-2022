component{

	function configure(){

		route( "/", "home.index" );
		route( "/novo-registro", "home.editresume" );
		route( "/alterar-registro/:id?", "home.editresume" );
		route( "/excluir-registro/:id?/:acao?", "home.editresume" );
		
		//education
		route( "/education/novo-registro", "home.editeducation" );
		route( "/education/alterar-registro/:id?", "home.editeducation" );
		route( "/education/excluir-registro/:id?/:acao?", "home.editeducation" );
		route( "/education", "home.listeducation" );
		
		//workexperience
		route( "/workexperience/novo-registro", "home.editworkexperience" );
		route( "/workexperience/alterar-registro/:id?", "home.editworkexperience" );
		route( "/workexperience/excluir-registro/:id?/:acao?", "home.editworkexperience" );
		route( "/workexperience", "home.listworkexperience" );
		
		//skillset
		route( "/skillset/novo-registro", "skillset.editskillset" );
		route( "/skillset/alterar-registro/:id?", "skillset.editskillset" );
		route( "/skillset/excluir-registro/:id?/:acao?", "skillset.editskillset" );
		route( "/skillset", "skillset.listskillset" );

	}

}