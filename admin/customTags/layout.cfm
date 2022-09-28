<cfparam name="attributes.urlBase" default="" />
<cfparam name="attributes.urlBaseComIndex" default="" />
<cfparam name="attributes.section" default="" />
<cfparam name="url.message" default="" />
<cfif thisTag.executionMode eq "start">
<cfoutput>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>#attributes.section#: My Personal Website</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">
		
		<link href="#attributes.urlBase#includes/css/bootstrap.min.css" rel="stylesheet">
		<link href="#attributes.urlBase#includes/css/datepicker.css" rel="stylesheet">
		<link href="#attributes.urlBase#includes/css/bootstrap-responsive.min.css" rel="stylesheet">

		<style type="text/css">
			
			
			.sidebar-nav {
				padding: 9px 0;
			}
			
			.text-blue { color:##379BC1; }
			
			.container {
				position: relative;
			}
			.vertical-center {
				margin: 0;
				position: absolute;
				top: 250px;
				left: 50%;
				-ms-transform: translate(-50%, -50%);
				transform: translate(-50%, -50%);
			}
		</style>
		
		<!--[if lt IE 9]>
			<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
	</head>
<body>
	
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</a>
				<a class="brand" href="#attributes.urlBase#/index.cfm">My Website Admin</a>
				<div class="nav-collapse collapse">
					<p class="navbar-text pull-right">
						<cfif structKeyExists(session,'usuario.emailaddress') && len(session.usuario.emailaddress)>
							Logged in as <a href="#attributes.urlBase#/logout" class="navbar-link">
								#session.usuario.emailAddress#</a>
						</cfif>
					</p>
					<ul class="nav">
						<li <cfif attributes.section eq "home">class="active"</cfif> ><a href="#attributes.urlBase#/index.cfm">Home</a></li>
						<li <cfif attributes.section eq "resume">class="active"</cfif> ><a href="#attributes.urlBaseComIndex#/resume">Resume</a></li>
						<li <cfif attributes.section eq "blog">class="active"</cfif> ><a href="#attributes.urlBaseComIndex#/blog">Blog</a></li>
						<li <cfif attributes.section eq "portfolio">class="active"</cfif> ><a href="#attributes.urlBaseComIndex#/portfolio">Portfolio</a></li>
						<li <cfif attributes.section eq "system">class="active"</cfif> ><a href="#attributes.urlBaseComIndex#/system">System</a></li>
					</ul>
				</div><!--/.nav-collapse -->
			</div>
		</div>
	</div>
	
	<div class="container-fluid">
		<div class="row-fluid">
			<cfif len(trim(url.message))>
				<div class="alert alert-success">
					#url.message#
				</div>
			</cfif>
</cfoutput>
<cfelse>

		</div><!--/row-->
		
	</div><!--/.fluid-container-->
	
	<cfoutput>
		<!---js --->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
		<script defer src="https://unpkg.com/alpinejs@3.x.x/dist/cdn.min.js"></script>
	</cfoutput>
	</body>
</html>

</cfif>	