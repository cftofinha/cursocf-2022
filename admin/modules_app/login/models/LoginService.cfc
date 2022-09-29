<cfcomponent>
	<cfset variables.salt = "123789!@" />
	
	<cffunction name="getLogin" access="remote" returntype="query" output="false">
		<cfargument name="emailAddresss" type="string" required="true">
		
		<cfset var qCons = "" />
		<cfquery name="qCons" datasource="dbcursocf">
			select 
				id,
				firstname,
				lastname,
				emailaddress,
				password,
				salt
			from administrator
			where emailaddress = <cfqueryparam value="#arguments.emailAddresss#" cfsqltype="cf_sql_varchar">
			
		</cfquery>
		
		<cfreturn qCons>
	</cffunction>
	
</cfcomponent>