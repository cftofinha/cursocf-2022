<cfscript>
	param name="form.submitted" default="0";
	errorBean = createObject('cursocf.admin.utils.errorBean').init();
	variables.linkListagem = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentModule();
	variables.linkActionForm = event.getHTMLBaseURL() & "index.cfm/" & event.getCurrentRoutedURL(); 
</cfscript>

<cfif structKeyExists(event.getRoutedStruct(),"id") and isNumeric(event.getRoutedStruct().id)>
	<cfset qDados = entityLoadByPK("Administrator", event.getRoutedStruct().id) />
	<cfset variables.idRegistro = event.getRoutedStruct().id />
	<cfif structKeyExists(event.getRoutedStruct(),"acao") && not compareNoCase(event.getRoutedStruct().acao,"excluir")>
		<cfset entityDelete(qDados) />
		<cfset ormFlush() />
			<script>
				msg = "\n Sua pagina será redirecionada para a listagem";
				alert("Registro Excluído com sucesso");
				window.location.href = "<cfoutput>#variables.linkListagem#</cfoutput>";
			</script>
	</cfif>
<cfelse>
	<cfset variables.idRegistro = 0 />
</cfif>

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
		
		<cftry>
			<cfif form.id eq 0>
				<cfset qDados = entityNew("Administrator") />
			<cfelse>
				<cfset qDados = entityLoadByPK("Administrator", form.id) />
			</cfif>
			<cfset qDados.setFirstname(form.firstname) />
			<cfset qDados.setlastname(form.lastname) />
			<cfset qDados.setEmailaddress(form.emailaddress) />
			
			<cfif len(trim(form.password))>
				<cfset variables.salt = hash(GenerateSecretKey("AES"), "SHA-256", "UTF-8") />
				<cfset variables.password = hash(salt & form.password, "SHA-256", "UTF-8") />
				<cfset qDados.setPassword(variables.password) />
				<cfset qDados.setSalt(variables.salt) />
			</cfif>
			
			<cfset entitySave(qDados) />
			<cfset ormFlush() />
			
			<script>
				msg = "\n Sua pagina será redirecionada para a listagem";
				alert("Registro Salvo com sucesso");
				window.location.href = "<cfoutput>#variables.linkListagem#</cfoutput>";
			</script>
			
			<cfcatch type="any">
				<cfdump var="#cfcatch#"><cfabort>
			</cfcatch>
		</cftry>
			
		
	</cfif>	
</cfif>

<cfoutput>
	<div class="span10">
		<cfif isDefined('qDados')>
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
			<input type="hidden" name="id" value="#variables.idRegistro#" />
			
			<div class="control-group">
				<label class="control-label" for="firstname">First Name</label>
				<div class="controls">
					<input type="text" id="firstname" name="firstname" value="<cfif isDefined('qDados')>#qDados.getFirstname()#</cfif>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="lastname">Last Name</label>
				<div class="controls">
					<input type="text" id="lastname" name="lastname" value="<cfif isDefined('qDados')>#qDados.getLastname()#</cfif>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="emailAddress">Email Address</label>
				<div class="controls">
					<input type="text" id="emailAddress" name="emailAddress" value="<cfif isDefined('qDados')>#qDados.getEmailAddress()#</cfif>">
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
