/**
 * Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
 * www.ortussolutions.com
 * ---
 */
component {

	// Application properties
	this.name              = hash( getCurrentTemplatePath() );
	this.sessionManagement = true;
	this.sessionTimeout    = createTimespan( 0, 0, 30, 0 );
	this.setClientCookies  = true;
	this.datasource='dbcursocf';
	
	this.mappings[ '/coldbox' ] = 'C:/curso-cf/ferramentas/ColdFusion/cfusion/wwwroot/cursocf/admin/coldbox/';
	
	this.ormEnabled=true;
	this.ormSettings={
		logsql=true,
		dbcreate="update",
		/*autogenmap=true,
		savemapping = true,*/
		cfclocation="com/entity"
	};

	// Java Integration
	this.javaSettings = {
		loadPaths               : [ expandPath( "./lib" ) ],
		loadColdFusionClassPath : true,
		reloadOnChange          : false
	};

	// COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH = getDirectoryFromPath( getCurrentTemplatePath() );
	// The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   = "";
	// COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE   = "";
	// COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY       = "";

	// application start
	public boolean function onApplicationStart() {
		application.cbBootstrap = new coldbox.system.Bootstrap(
			COLDBOX_CONFIG_FILE,
			COLDBOX_APP_ROOT_PATH,
			COLDBOX_APP_KEY,
			COLDBOX_APP_MAPPING
		);
		application.cbBootstrap.loadColdbox();
		application.datasource = this.datasource;
		
		return true;
	}

	// application end
	public void function onApplicationEnd( struct appScope ) {
		arguments.appScope.cbBootstrap.onApplicationEnd( arguments.appScope );
		application.datasource = this.datasource;
	}

	// request start
	public boolean function onRequestStart( string targetPage ) {
		if(structKeyExists(url, 'reload') && url.reload eq 2022){
			onApplicationStart();
			ormReload();
		}
		// Process ColdBox Request
		application.cbBootstrap.onRequestStart( arguments.targetPage );
		
		return true;
	}

	public void function onSessionStart() {
		application.cbBootStrap.onSessionStart();
	}

	public void function onSessionEnd( struct sessionScope, struct appScope ) {
		arguments.appScope.cbBootStrap.onSessionEnd( argumentCollection = arguments );
	}

	public boolean function onMissingTemplate( template ) {
		return application.cbBootstrap.onMissingTemplate( argumentCollection = arguments );
	}

}
