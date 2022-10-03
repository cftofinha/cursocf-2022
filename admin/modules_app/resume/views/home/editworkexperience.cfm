<cfparam name="url.id" default="0" />
<cfset errorBean = createObject('admin.cfc.errorBean').init() />

<cfoutput>
	<div class="span10">
		<cfif val(url.id)>
			<h2>Edit Work Experience</h2>
		<cfelse>
			<h2>Add Work Experience</h2>
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
			<input type="hidden" name="type" value="workexperience" />
			
			<div class="control-group">
				<label class="control-label" for="title">Position</label>
				<div class="controls">
					<input type="text" id="title" name="title" value="">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="dates">Dates</label>
				<div class="controls">
					<input type="text" id="startDate" name="startdate" class="input-medium datepicker" value=""> to <input type="text" id="endDate" name="endDate" class="input-medium datepicker" value="">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="details">Details</label>
				<div class="controls">
					<textarea rows="3" id="details" name="details" class="wysiwyg"></textarea>
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
