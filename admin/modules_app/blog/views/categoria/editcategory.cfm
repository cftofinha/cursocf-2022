<cfparam name="url.id" default="">
<cfset errorBean = createObject('admin.cfc.errorBean').init() />
<cfoutput>
	<div class="span10">
		<cfif val(url.id)>
			<h2>Edit Category</h2>
		<cfelse>
			<h2>Add Category</h2>
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
				<label class="control-label" for="title">Name</label>
				<div class="controls">
					<input type="text" id="name" name="name" value="">
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
