<cfparam name="form.submitted" default="0" />
<cfparam name="form.token" default="" />
<cfset instModelComentarios = createObject("component","cfc.models.PostComments") />
<cfif isDefined("form.blogpostid")>
	<cfscript>
		qGravaComentarios = instModelComentarios.salvarRegistro(
			"novo"
			,form.blogpostid
			,form.author
			,form.comment
		);
		writeDump(qGravaComentarios);
		abort;
	</cfscript>
</cfif>

<cfparam name="url.id" default="">
<cfif isNumeric(url.id)>
	<cfset variables.condicoes = " a.blogpostid = " & url.id />
	<cfset blogPost = createObject("component","cfc.models.PostBlog" ).getPostsBlog(condicoesFiltros: variables.condicoes) />
	<cfset qComentarios = instModelComentarios.getCommentsBlog(condicoesFiltros: variables.condicoes) />
<cfelse>
	<cflocation url="index.cfm">
</cfif>
<!---<cfdump var="#qComentarios#" label="qComentarios" abort="true">--->
<cfimport taglib="customTags/" prefix="layout" />
<layout:page section="blog"> 
		
		<!-- Content Start -->
    
		<!--Card  -->
		<div id="content">
			<div class="card-pattern">
				<!-- blog -->
				<div id="blog">
					<div class="clr">
						<div class="top-bg1">
							<div class="top-left">
								<div><h1>Blog</h1></div>
							</div> 
						</div>
						<div class="clr">
							<div class="pat-bottomleft">&nbsp;</div>
							<div class="pat-bottomright">&nbsp;</div>
						</div>
					</div>
					<div class="blog-top">	
						<div class="clr">
							<cfoutput>
							<div class="left">
								<!-- Blog Title -->
								<h2 class="big">
									#blogPost.titulo#
								</h2>
								<!-- Date Published -->
								<h5>
									<strong>Date Posted</strong>: #blogPost.dataPostagem#
								</h5>
								<!-- Blog Body -->
								#blogPost.conteudo#
								<!-- Blog Export -->
								<p>
									<a href="exportToPDF.cfm?id=#blogPost.id#" target="_new"><img src="assets/images/export_pdf.png" border="0"/></a>
								</p>
								<!-- Blog Comments Section -->
								<h3>
									Comments (#blogPost.qtdComentarios#)
								</h3>
								<div class="clr hline">&nbsp;</div>
		
								<div class="clr comments">
									<ul>
										<!-- Start Comment -->
										<cfif qComentarios.recordCount gt 0>
											<cfloop query="qComentarios">
											<li>
												<p>
													<strong>Posted On:</strong> #qComentarios.dataHoraSistema#
												</p>
												<p>
													#encodeForHTML(qComentarios.comment)#
												</p>
												<div class="clr hline">&nbsp;</div>
											</li>
											</cfloop>
										<cfelse>
											<p>
												<strong>Nenhum comentário ainda
											</p>
										</cfif>
									</ul>
								</div>
								<h3>
									Post Comment
								</h3>
								<div class="clr hline">&nbsp;</div>
		
								<div class="clr postComment">
									<form action="blogpost.cfm?id=#blogPost.id#" method="post" id="form">
										<input type="hidden" name="blogpostid" id="blogpostid" value="#url.id#">
										<div>
											<label>Name <span class="font-11">(required)</span></label>
											<input name="author" id="author" type="text" class="required" />
										</div>
										<div class="textarea">
											<label>Comment <span class="font-11">(required)</span></label>				
											<textarea name="comment" id="comment" rows="6" cols="60" class="required"></textarea>		
										</div>
										<div>
											<input id="submitBtn" value="Submit"  name="submit" type="submit" class="submitBtn" />
										</div>
										<input type="hidden" name="submitted" value="1" />
										<input type="hidden" name="token" value="#CSRFGenerateToken()#" />
									</form>
								</div>	
							</div>
							</cfoutput>
							<div class="right" >
								<h2>Categories</h2>
								<!-- Blog Specific Categories -->
								<div id="categories" align="center">
									<ul>
										<li><a href="#">ColdFusion</a></li>
										<li><a href="#">Development</a></li>
									</ul>
								</div>
							</div>
						</div>
					</div>
					<div class="clr"></div>
				</div> <!--blog end -->
</layout:page>
