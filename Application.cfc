component{
	this.name='CursoCF-SENAC';
	this.datasource='dbcursocf';
	this.applicationTimeout=CreateTimeSpan(10, 0, 0, 0);
	this.sessionManagement=true;
	this.sessionTimeout=CreateTimeSpan(0, 0, 30, 0);
	
	setlocale("Portuguese (Brazilian)");
	setEncoding("URL", "UTF-8");
	setEncoding("FORM", "UTF-8");
	
	this.ormEnabled=true;
	this.ormSettings={
		logsql=true,
		dbcreate="update",
		cfclocation="com/entity"
		};
	this.invokeImplicitAccessor=true;
	this.sessionCookie.httpOnly=true;
	this.sessionCookie.timeout='10';
	this.sessionCookie.disableupdate=true;
	
	function onApplicationStart(){
		application.myName='Tofinha';
		application.myPosition='ColdFusion Developer';
		application.utilities = CreateObject('component','cfc.utilities');
		application.comments = CreateObject('component','cfc.models.PostComments');
		return true;
	}
	
	function onRequestStart(string targetPage){
		if(structKeyExists(url, 'reload') && url.reload eq 2022){
			onApplicationStart();
			ormReload();
		}
	}
	
	function onError( any Exception, string EventName){
		include 'sorry.cfm';
		writeDump(arguments.exception);
		/*var errorEmail = new mail();
		errorEmail.setTo('you@domain.com');
		errorEmail.setFrom('system@domain.com');
		errorEmail.setSubject('An Error has Occured');
		errorEmail.setBody('
			Message: #arguments.exception.message# <br />
			Details: #arguments.exception.detail# <br />
			Type: #arguments.exception.type# <br />
		');
		errorEmail.setType('html');
		errorEmail.send();*/
	}
}