<cfparam name="attributes.urlBase" default="" />
<cfparam name="attributes.urlBaseComIndex" default="" />
<cfparam name="attributes.section" default="" />
<cfparam name="attributes.active" default="" />

<cfif thisTag.executionMode eq "end">
	<cfoutput>
		<div class="span2">
		  <div class="well sidebar-nav">
			<cfswitch expression="#attributes.section#" >
				<cfcase value="resume">
					<ul class="nav nav-list">
						<li class="nav-header">Options</li>
						<li <cfif attributes.active eq "workexperience">class="active"</cfif>><a href="#attributes.urlBaseComIndex#/resume/listworkexperience">Work Experience</a></li>
						<li <cfif attributes.active eq "education">class="active"</cfif>><a href="#attributes.urlBaseComIndex#/resume/listeducation">Education</a></li>
						<li <cfif attributes.active eq "skillset">class="active"</cfif>><a href="#attributes.urlBaseComIndex#/resume/listskillset">Skillset</a></li>
					</ul>
				</cfcase>
				
				<cfcase value="blog">
					<ul class="nav nav-list">
						<li class="nav-header">Options</li>
						<li <cfif attributes.active eq "post">class="active"</cfif>><a href="#attributes.urlBaseComIndex#/blog/listblogpost">Blog Posts</a></li>
						<li <cfif attributes.active eq "category">class="active"</cfif>><a href="#attributes.urlBaseComIndex#/blog/listcategory">Category</a></li>
					</ul>
				</cfcase>
				
				<cfcase value="system">
					<ul class="nav nav-list">
						<li class="nav-header">Options</li>
						<li <cfif attributes.active eq "administrator">class="active"</cfif>><a href="#attributes.urlBaseComIndex#/system/listadministrator">Administrators</a></li>
					</ul>
				</cfcase>
			
			</cfswitch>  	
		    
		  </div><!--/.well -->
		</div>
	</cfoutput>
</cfif>
