component {
	public query function getPostsBlosg(required numeric id){
		qService = new Query();
		qService.setSql("
			select a.blogpostid as id
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
			where a.blogpostid = :paramCondicoes
		");
		qService.addParam(name="paramCondicoes", value=arguments.id, cfsqltype="cf_sql_integer");
		
		return qService.execute().getResult();
	}
	
	public query function getQueryExecute(){
		qryResult = queryExecute("
			select a.blogpostid as id
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
		");
		
		return qryResult;
	}
	
	public query function getQueryExecute2(){
		qryResult = queryExecute("
			select * from blogPost
			where title = :titulo ", {titulo="ColdFusion scheduled tasks"});
		
		return qryResult;
	}
	
	public query function getQueryExecute3(){
		qryResult = queryExecute("
		select * from blogPost 
		where blogpostid = :idBlog", {idBlog={value='2', cfsqltype='cf_sql_integer'} });
		
		return qryResult;
	}
}