/**
 * I am a new Model Object
 */
component singleton accessors="true"{

	// Properties
	

	/**
	 * Constructor
	 */
	BlogService function init(){

		return this;
	}
	
	/*function list(){
		return queryExecute( "select * from blogPost", {}, {datasource="dbcursocf", returntype = "array" } );
	}*/
	
	function list(){
		//qService = new Query();
		//qService.setSql("
		var sql = "select a.blogpostid as id
				, (select c.name from blogCategory c, blogpostcategory rl 
					where c.blogcategoryid = rl.categoryid and rl.postid = a.blogpostid limit 1)
					 as nomeCategoria
				, a.title as titulo
				, a.summary as resumo
				, a.body as conteudo
				, to_char(a.dateposted, 'DD/MM/YYYY') as dataPostagem
				, to_char(a.createdDateTime, 'DD/MM/YYYY HH12:MI:SS') as dataHoraSistema
				, (select count(*) from BlogComment bc where a.blogpostid = bc.blogpostid) as qtdComentarios
			from blogPost a 
			order by a.dateposted desc 
		";
		return queryExecute( sql, {}, {datasource="dbcursocf", returntype = "array" } );
		//return qService.execute().getResult();
	}


}