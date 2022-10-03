<cfparam name="url.id" default="0" />
<cfset errorBean = createObject('admin.cfc.errorBean').init() />

<cfif form.submitted>

	<!--- check if data is valid--->
		
	<cfif !len(trim(form.firstname))>
		<cfset errorBean.addError('First name is required','firstname') />
	</cfif>	
	
	<cfif !len(trim(form.lastname))>
		<cfset errorBean.addError('Last name is required','lastname') />
	</cfif>	
	
	<cfif !len(trim(form.emailaddress))>
		<cfset errorBean.addError('Email Address is required','emailaddress') />
	</cfif>	
	
	<cfif !len(trim(form.password)) && !val(form.id)>
		<cfset errorBean.addError('Password is required','password') />
	</cfif>
	
	<cfif trim(form.password) neq trim(form.password2)>
		<cfset errorBean.addError('Passwords do not match','password') />
	</cfif>				
	
	<cfif !errorBean.hasErrors()>
		<cfif len(trim(form.password))>
			<cfset salt=Hash(GenerateSecretKey("AES"), "SHA-256", "UTF-8") />
			<cfset password = Hash(salt & form.password, "SHA-256", "UTF-8") />
		</cfif>	
		
	</cfif>	
</cfif>

<cfoutput>
	<div class="span10">
		<cfif val(url.id)>
			<h2>Edit Administrator</h2>
		<cfelse>
			<h2>Add Administrator</h2>
		</cfif>
		
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
		
		<form class="form-horizontal" action="" method="post">
			<input type="hidden" name="submitted" value="1" />
			<input type="hidden" name="id" value="#url.id#" />
			
			<div class="control-group">
				<label class="control-label" for="firstname">First Name</label>
				<div class="controls">
					<input type="text" id="firstname" name="firstname" value="">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="lastname">Last Name</label>
				<div class="controls">
					<input type="text" id="lastname" name="lastname" value="">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="emailAddress">Email Address</label>
				<div class="controls">
					<input type="text" id="emailAddress" name="emailAddress" value="">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="password">Password</label>
				<div class="controls">
					<input type="password" id="password" name="password" value="">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="password2">Password (retype)</label>
				<div class="controls">
					<input type="password" id="password2" name="password2" value="">
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<button type="submit" class="btn btn-primary">Save</button>
				</div>
			</div>
			
		</form>
	</div>
</cfoutput>
