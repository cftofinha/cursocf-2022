<!---<cfset qLoginCheck = createObject("component","login.models.LoginScript")
							.getLogin(
								email: "cftofinha@gmail.com",
								nome: 'Tofinha'
							) />
<cfdump var="#qLoginCheck#"><cfabort>--->

<cfparam name="form.submitted" default="0" />
<cfparam name="form.emailaddress" default="" />
<cfparam name="form.redirectPage" default="#event.getHTMLBaseURL()#index.cfm" />

<cfset errorBean = createObject('cursocf.admin.utils.errorBean').init() />

<cfif form.submitted>
	<cfset qLoginCheck = createObject("component","login.models.LoginService")
							.getLogin(emailAddresss: trim(form.emailaddress)) />
	
	<!---<cfset qLoginCheck = createObject("component","login.models.LoginScript")
							.getLogin(
								emailaddress: "cftofinha@gmail.com",
								firstname: 'Tofinha'
							) />--->
	
	<!---<cfdump var="#qLoginCheck#"><cfabort>--->
	
	<cfif !qLoginCheck.recordcount || qLoginCheck.password NEQ Hash(qLoginCheck.salt & form.password, 'SHA-256', 'UTF-8')>
		<cfset errorBean.addError('Incorrect Login Details','emailaddress') />
	<cfelse>
		<cfset usuario = structNew() />
		<cfset usuario.adminID = qLoginCheck.id />
		<cfset usuario.firstname = qLoginCheck.firstname />
		<cfset usuario.lastname = qLoginCheck.lastname />
		<cfset usuario.emailaddress = qLoginCheck.emailaddress />
		<cfset session.usuario = usuario />
		<cfset sessionRotate() />
		<!---<cfdump var="#session#"><cfabort>--->
		<cflocation url="#form.redirectPage#" addToken="no" />
	</cfif>		
	
</cfif>	
<cfoutput>
	<div class="span6 offset2 well">
		<h2>
			Login
		</h2>
		<cfif errorBean.hasErrors()>
		    <div class="alert alert-error">
		    	<strong>Error</strong><br />
				The following errors occured:
				<ul>
					<cfloop array="#errorBean.getErrors()#" index="error">
						<li>#error.message#</li>
					</cfloop>
				</ul>
		    </div>
		</cfif>
		<form class="form-horizontal" action="#event.getHTMLBaseURL()#index.cfm/login" method="post">
			<div class="control-group">
				<label class="control-label" for="emailaddress">Email Address</label>
				<div class="controls">
					<input type="text" id="emailaddress" name="emailaddress" value="#form.emailaddress#">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="password">Password</label>
				<div class="controls">
					<input type="password" id="Password" name="Password" value="">
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<button type="submit" class="btn btn-primary">Login</button>
				</div>
			</div>
			<input type="hidden" name="submitted" value="1" />
			<input type="hidden" name="redirectPage" value="#redirectPage#" />
		</form>	
	</div>
</cfoutput>