/**
 * The main module handler
 */
component {
	objBlog 		= createObject("component","blog.models.Blog");
	objCategoria 	= createObject("component","blog.models.Categorias");
	
	/**
	 * Module EntryPoint
	 */
	
	function index(event,rc,prc){
		prc.lista = objBlog.getPostsBlog(condicoesFiltros:" 1 = 1");
		event.setView("home/index");
	}
	
	/**
	 * New Blog Post
	 */	
	function newblogpost(event, rc, prc) {
		prc.categories = objCategoria.getCategories();
		prc.selectedcategories = [];
		event.setView( "home/editblogpost" );
	}
		
	/**
	 * Edit Blog Post
	 */	
	function editblogpost(event, rc, prc) {
		//ORM Test
		var entity = entityLoadByPK("BlogPost", rc.id);
		//cfdump(var=entity.getBlogPostCategories(), abort="true");
		for (row in entity.getBlogPostCategories()) { 
 			cfdump(var=row.getName(), abort="false");
 		}
		cfabort();
		prc.blogPost = objBlog.getPostsBlog(condicoesFiltros:" a.blogPostId = " & rc.id);
		prc.selectedCategories = objBlog.getSelectedCategories(blogPostId:rc.id);
		prc.categories = objCategoria.getCategories();		
		prc.id = rc.id;
		event.setView( "home/editblogpost" );
	}
	
	/**
	 * Save Blog Post
	 */	
	function saveblogpost(event, rc, prc) {
		//cfdump(var= rc.selectedcategories, abort=true);
		var blogId = 0;
		if (isDefined("rc.id") and rc.id > 0) {
			objBlog.setAtualizar(
				blogpostid:rc.id
				, summary:rc.summary
				, body:rc.body
				, title:rc.title
			)
			blogId = rc.id;			
		} else {
			blogId = objBlog.setCadastrar(
				summary:rc.summary
				, body:rc.body
				, title:rc.title
			)
		}
		objBlog.setBlogPostCategories(
			blogpostid: blogId
			, categories:rc.selectedcategories
		);
		var blogPost = {
			id:rc.id
			, resumo:rc.summary
			,titulo:rc.title
			,conteudo:rc.body
			,dataPostagem:""
			, dataHoraSistema:""
		};
		prc.blogPost = blogPost;
		prc.id = blogId;
		prc.categories = objCategoria.getCategories();
		prc.selectedcategories = listToArray(rc.selectedcategories,",",false,true);
		event.setView( "home/editblogpost" );
	}
	
	/**
	 * Remove Blog Post
	 */	
	function deleteblogpost(event, rc, prc) {
		prc.blogPost = objBlog.setExcluir(blogpostid:rc.id);
		prc.qBlogs = objBlog.getPostsBlog(condicoesFiltros:" 1 = 1");		
		event.setView( "home/index" );
	}	

}
