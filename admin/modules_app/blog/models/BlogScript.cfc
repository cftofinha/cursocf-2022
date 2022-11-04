component {

	public query function getPostsBlog(string condicoesFiltros){
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
			where true
			:condicoesFiltros
			order by a.dateposted desc
		");
		qService.addParam(name="condicoesFiltros", value=arguments.condicoesFiltros);

		return qService.execute().getResult();
	}

	public query function getPostBlogDetalhe(required numeric id){
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

	private struct function setCadastrar(required string title, required string summary, required string body, required string dateposted ){

		var dataPostagem = lsDateFormat(arguments.dateposted, 'yyyy-mm-dd');
		var strRetorno = {};

		try {
			qService = new Query();
			qService.addParam(name="paramTitle", value=arguments.title, cfsqltype="cf_sql_varchar");
			qService.addParam(name="paramSummary", value=arguments.summary, cfsqltype="cf_sql_varchar");
			qService.addParam(name="paramBody", value=arguments.body, cfsqltype="cf_sql_varchar");
			qService.addParam(name="paramDateposted", value=dataPostagem, cfsqltype="cf_sql_date");
			qService.addParam(name="paramCreatedDateTime", value=now(), cfsqltype="cf_sql_timestamp");
			qService.addParam(name="paramDeleted", value="0", cfsqltype="cf_sql_varchar");

			qService.setSql("
				insert into blogPost(
					title
					, summary
					, body
					, dateposted
					, createdDateTime
					, deleted
				)
				values(
					:paramTitle
					, :paramSummary
					, :paramBody
					, :paramDateposted
					, :paramCreatedDateTime
					, :paramDeleted
				)
			");
			qService.execute();
			strRetorno.retorno = "sucesso";
			strRetorno.mensagem = "Registro salvo com sucesso";

		} catch(any excpt) {
			//writeDump();
			strRetorno.retorno = "erro";
			strRetorno.mensagem = "Erro ao salvar o registro";
			strRetorno.mensagemDetalhe = cfcatch.detail;
		}

		return strRetorno;
	}

	private struct function setAtualizar(required numeric blogpostid, required string title, required string summary, required string body, required string dateposted ){

		var dataPostagem = lsDateFormat(arguments.dateposted, 'yyyy-mm-dd');
		var strRetorno = {};

		try {
			qService = new Query();
			qService.addParam(name="paramBlogPostId", value=arguments.blogpostid, cfsqltype="cf_sql_integer");
			qService.addParam(name="paramTitle", value=arguments.title, cfsqltype="cf_sql_varchar");
			qService.addParam(name="paramSummary", value=arguments.summary, cfsqltype="cf_sql_varchar");
			qService.addParam(name="paramBody", value=arguments.body, cfsqltype="cf_sql_varchar");
			qService.addParam(name="paramDateposted", value=dataPostagem, cfsqltype="cf_sql_date");
			qService.addParam(name="paramModifiedDateTime", value=now(), cfsqltype="cf_sql_timestamp");
			qService.addParam(name="paramDeleted", value="0", cfsqltype="cf_sql_varchar");

			qService.setSql("
				update blogPost set
					title = :paramTitle
					, summary = :paramSummary
					, body = :paramBody
					, dateposted = :paramDateposted
					, modifieddatetime = :paramModifiedDateTime
					, deleted = :paramDeleted
				where blogpostid = :paramBlogPostId
			");
			qService.execute();
			strRetorno.retorno = "sucesso";
			strRetorno.mensagem = "Registro salvo com sucesso";

		} catch(any excpt) {
			//writeDump();
			strRetorno.retorno = "erro";
			strRetorno.mensagem = "Erro ao salvar o registro";
			strRetorno.mensagemDetalhe = cfcatch.detail;
		}

		return strRetorno;
	}

	private struct function setExcluir(required numeric blogpostid){

		var strRetorno = {};

		try {
			qService = new Query();
			qService.addParam(name="paramBlogPostId", value=arguments.blogpostid, cfsqltype="cf_sql_integer");
			qService.addParam(name="paramModifiedDateTime", value=now(), cfsqltype="cf_sql_timestamp");
			qService.addParam(name="paramDeleted", value="0", cfsqltype="cf_sql_varchar");

			qService.setSql("
				update blogPost set
					modifieddatetime = :paramModifiedDateTime
					, deleted = :paramDeleted
				where blogpostid = :paramBlogPostId
			");
			qService.execute();
			strRetorno.retorno = "sucesso";
			strRetorno.mensagem = "Registro salvo com sucesso";

		} catch(any excpt) {
			//writeDump();
			strRetorno.retorno = "erro";
			strRetorno.mensagem = "Erro ao salvar o registro";
			strRetorno.mensagemDetalhe = cfcatch.detail;
		}

		return strRetorno;
	}

	remote struct function salvarRegistro(required string acao, required numeric blogpostid, required string title, required string summary, required string body, required string dateposted){

		var strRetorno = {};

		if( not compareNoCase(arguments.acao, "novo")){
			retornoMetodo = setCadastrar(
				arguments.title
				, arguments.summary
				, arguments.body
				, arguments.dateposted
			);
			strRetorno.retorno = retornoMetodo.retorno;
			strRetorno.mensagem = retornoMetodo.mensagem;

		} else if( not compareNoCase(arguments.acao, "atualizar")){
			retornoMetodo = setAtualizar(
				arguments.blogpostid
				, arguments.title
				, arguments.summary
				, arguments.body
				, arguments.dateposted
			);
			strRetorno.retorno = retornoMetodo.retorno;
			strRetorno.mensagem = retornoMetodo.mensagem;

		} else if( not compareNoCase(arguments.acao, "excluir")){
			retornoMetodo = setExcluir(
				arguments.blogpostid
			);
			strRetorno.retorno = retornoMetodo.retorno;
			strRetorno.mensagem = retornoMetodo.mensagem;

		}
		return strRetorno;
	}

}