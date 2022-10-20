/**
 * The main module handler
 */
component extends="coldbox.system.EventHandler" {
	//property name="blogService"		inject="BlogService";
	

	/**
	 * Module EntryPoint
	 */
	
	function index(event,rc,prc){
		prc.postList = blogService.list();
		prc.welcomeMessage = "Listagem dos Posts para o Blog!";
		event.setView("home/index");
	}

}
